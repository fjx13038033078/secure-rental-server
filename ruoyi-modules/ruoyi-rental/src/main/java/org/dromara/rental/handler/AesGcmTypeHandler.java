package org.dromara.rental.handler;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.dromara.rental.config.AesKeyConfig;

import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;

/**
 * MyBatis-Plus 自定义 TypeHandler：AES-256-GCM 加解密
 * <p>
 * <b>加解密原理（答辩可参考）：</b>
 * </p>
 * <ul>
 *   <li><b>算法</b>：AES-256-GCM（高级加密标准，256位密钥，GCM 认证加密模式）</li>
 *   <li><b>入库加密</b>：明文 → AES-GCM 加密 → Base64 编码 → 存入数据库</li>
 *   <li><b>出库解密</b>：数据库 Base64 字符串 → Base64 解码 → AES-GCM 解密 → 明文</li>
 *   <li><b>IV（初始化向量）</b>：每次加密生成随机 12 字节 IV，与密文一起存储，保证同一明文多次加密结果不同</li>
 *   <li><b>认证标签</b>：GCM 模式自动生成 128 位认证标签，防止密文被篡改</li>
 * </ul>
 * <p>
 * <b>使用方式</b>：在实体类字段上添加 <code>@TableField(typeHandler = AesGcmTypeHandler.class)</code>
 * </p>
 *
 * @author ruoyi
 */
@Slf4j
public class AesGcmTypeHandler extends BaseTypeHandler<String> {

    /**
     * AES-256-GCM 算法名称
     */
    private static final String TRANSFORMATION = "AES/GCM/NoPadding";

    /**
     * GCM 认证标签长度（位）
     */
    private static final int GCM_TAG_LENGTH = 128;

    /**
     * GCM 推荐 IV 长度（字节）
     */
    private static final int GCM_IV_LENGTH = 12;

    /**
     * 入库时：将明文加密为 Base64 字符串后写入数据库
     * <p>
     * 流程：明文 → UTF-8 字节 → AES-GCM 加密（含随机 IV）→ IV+密文 拼接 → Base64 编码 → 写入 PreparedStatement
     * </p>
     *
     * @param ps        PreparedStatement
     * @param i         参数索引（从 1 开始）
     * @param parameter 明文字符串（非 null）
     * @param jdbcType  JDBC 类型（可为 null）
     */
    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, String parameter, JdbcType jdbcType) throws SQLException {
        try {
            String valueToSet = encrypt(parameter);
            ps.setString(i, valueToSet);
        } catch (Exception e) {
            log.error("[AES-GCM] 入库加密失败，参数索引: {}, 将原样存储。错误: {}", i, e.getMessage());
            // 加密失败时原样存储，避免业务中断
            ps.setString(i, parameter);
        }
    }

    /**
     * 出库时：从 ResultSet 按列名读取 Base64 密文，解密后返回明文
     *
     * @param rs         结果集
     * @param columnName 列名
     * @return 解密后的明文，解密失败或密钥未配置时返回原值
     */
    @Override
    public String getNullableResult(ResultSet rs, String columnName) throws SQLException {
        String encrypted = rs.getString(columnName);
        return decrypt(encrypted);
    }

    /**
     * 出库时：从 ResultSet 按列索引读取 Base64 密文，解密后返回明文
     *
     * @param rs          结果集
     * @param columnIndex 列索引（从 1 开始）
     * @return 解密后的明文
     */
    @Override
    public String getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        String encrypted = rs.getString(columnIndex);
        return decrypt(encrypted);
    }

    /**
     * 出库时：从 CallableStatement 按索引读取 Base64 密文，解密后返回明文
     *
     * @param cs          CallableStatement
     * @param columnIndex 列索引（从 1 开始）
     * @return 解密后的明文
     */
    @Override
    public String getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        String encrypted = cs.getString(columnIndex);
        return decrypt(encrypted);
    }

    /**
     * 静态解密方法，供 Service 等非 MyBatis 场景使用
     *
     * @param encryptedBase64 Base64 编码的密文（可为 null）
     * @return 解密后的明文，解密失败时返回原值
     */
    public static String decryptValue(String encryptedBase64) {
        if (encryptedBase64 == null || encryptedBase64.isEmpty()) {
            return encryptedBase64;
        }
        if (!AesKeyConfig.isKeyAvailable()) {
            return encryptedBase64;
        }
        try {
            byte[] combined = Base64.getDecoder().decode(encryptedBase64.trim());
            if (combined.length <= GCM_IV_LENGTH) {
                return encryptedBase64;
            }
            byte[] iv = new byte[GCM_IV_LENGTH];
            byte[] ciphertext = new byte[combined.length - GCM_IV_LENGTH];
            System.arraycopy(combined, 0, iv, 0, GCM_IV_LENGTH);
            System.arraycopy(combined, GCM_IV_LENGTH, ciphertext, 0, ciphertext.length);

            byte[] keyBytes = AesKeyConfig.getAesKeyBytes();
            SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");

            Cipher cipher = Cipher.getInstance(TRANSFORMATION);
            GCMParameterSpec gcmSpec = new GCMParameterSpec(GCM_TAG_LENGTH, iv);
            cipher.init(Cipher.DECRYPT_MODE, keySpec, gcmSpec);

            byte[] decrypted = cipher.doFinal(ciphertext);
            return new String(decrypted, StandardCharsets.UTF_8);
        } catch (Exception e) {
            return encryptedBase64;
        }
    }

    /**
     * AES-256-GCM 加密：明文 → Base64 密文
     * <p>
     * 存储格式：Base64( IV(12字节) + 密文+认证标签 )
     * </p>
     *
     * @param plaintext 明文
     * @return Base64 编码的密文，密钥未配置时返回原明文
     */
    private String encrypt(String plaintext) {
        if (plaintext == null || plaintext.isEmpty()) {
            return plaintext;
        }
        if (!AesKeyConfig.isKeyAvailable()) {
            log.warn("[AES-GCM] 密钥未配置，明文原样返回");
            return plaintext;
        }
        try {
            byte[] keyBytes = AesKeyConfig.getAesKeyBytes();
            SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");

            // 生成随机 IV，每次加密结果不同，增强安全性
            byte[] iv = new byte[GCM_IV_LENGTH];
            SecureRandom random = new SecureRandom();
            random.nextBytes(iv);

            Cipher cipher = Cipher.getInstance(TRANSFORMATION);
            GCMParameterSpec gcmSpec = new GCMParameterSpec(GCM_TAG_LENGTH, iv);
            cipher.init(Cipher.ENCRYPT_MODE, keySpec, gcmSpec);

            byte[] plainBytes = plaintext.getBytes(StandardCharsets.UTF_8);
            byte[] encrypted = cipher.doFinal(plainBytes);

            // 将 IV 与密文拼接，解密时先取前 12 字节作为 IV
            byte[] combined = new byte[iv.length + encrypted.length];
            System.arraycopy(iv, 0, combined, 0, iv.length);
            System.arraycopy(encrypted, 0, combined, iv.length, encrypted.length);

            return Base64.getEncoder().encodeToString(combined);
        } catch (Exception e) {
            log.error("[AES-GCM] 加密异常: {}", e.getMessage());
            throw new RuntimeException("AES-GCM 加密失败", e);
        }
    }

    /**
     * AES-256-GCM 解密：Base64 密文 → 明文
     * <p>
     * 解析格式：Base64 解码 → 前 12 字节为 IV → 剩余为密文+认证标签
     * </p>
     *
     * @param encryptedBase64 Base64 编码的密文（可为 null）
     * @return 解密后的明文，解密失败时返回原值
     */
    private String decrypt(String encryptedBase64) {
        if (encryptedBase64 == null || encryptedBase64.isEmpty()) {
            return encryptedBase64;
        }
        if (!AesKeyConfig.isKeyAvailable()) {
            log.warn("[AES-GCM] 密钥未配置，密文原样返回");
            return encryptedBase64;
        }
        try {
            byte[] combined = Base64.getDecoder().decode(encryptedBase64.trim());
            if (combined.length <= GCM_IV_LENGTH) {
                log.warn("[AES-GCM] 密文长度异常，可能非加密数据，原样返回");
                return encryptedBase64;
            }

            // 拆分 IV 与密文
            byte[] iv = new byte[GCM_IV_LENGTH];
            byte[] ciphertext = new byte[combined.length - GCM_IV_LENGTH];
            System.arraycopy(combined, 0, iv, 0, GCM_IV_LENGTH);
            System.arraycopy(combined, GCM_IV_LENGTH, ciphertext, 0, ciphertext.length);

            byte[] keyBytes = AesKeyConfig.getAesKeyBytes();
            SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");

            Cipher cipher = Cipher.getInstance(TRANSFORMATION);
            GCMParameterSpec gcmSpec = new GCMParameterSpec(GCM_TAG_LENGTH, iv);
            cipher.init(Cipher.DECRYPT_MODE, keySpec, gcmSpec);

            byte[] decrypted = cipher.doFinal(ciphertext);
            return new String(decrypted, StandardCharsets.UTF_8);
        } catch (IllegalArgumentException e) {
            log.warn("[AES-GCM] Base64 解码失败，可能为历史明文数据，原样返回: {}", e.getMessage());
            return encryptedBase64;
        } catch (Exception e) {
            log.warn("[AES-GCM] 解密失败，原样返回。错误: {}", e.getMessage());
            return encryptedBase64;
        }
    }
}
