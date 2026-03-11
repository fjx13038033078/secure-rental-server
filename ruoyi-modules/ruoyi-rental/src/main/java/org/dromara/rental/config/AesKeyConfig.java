package org.dromara.rental.config;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import java.util.Base64;

/**
 * AES-256-GCM 密钥配置类
 * <p>
 * 用于将 application.yml 中配置的 Base64 密钥注入到静态变量，
 * 供 AesGcmTypeHandler 在加解密时使用。
 * </p>
 * <p>
 * 设计说明：MyBatis TypeHandler 由 MyBatis 实例化，无法直接使用 @Value 注入，
 * 因此通过本配置类在 Spring 启动时加载密钥到静态变量。
 * </p>
 *
 * @author ruoyi
 */
@Slf4j
@Configuration
public class AesKeyConfig {

    /**
     * 静态存储的 Base64 编码密钥（32字节解码后用于 AES-256）
     */
    private static byte[] aesKeyBytes;

    /**
     * 从配置文件注入的 Base64 密钥
     * 示例：MDEyMzQ1Njc4OWFiY2RlZjAxMjM0NTY3ODlhYmNkZWY=
     */
    @Value("${ruoyi.aes.key:}")
    private String aesKeyBase64;

    /**
     * Spring 容器启动后执行，将 Base64 密钥解码并存入静态变量
     */
    @PostConstruct
    public void init() {
        try {
            if (aesKeyBase64 == null || aesKeyBase64.isBlank()) {
                log.warn("[AES密钥] 未配置 ruoyi.aes.key，AesGcmTypeHandler 加解密功能将不可用");
                return;
            }
            aesKeyBytes = Base64.getDecoder().decode(aesKeyBase64.trim());
            if (aesKeyBytes.length != 32) {
                log.error("[AES密钥] ruoyi.aes.key 解码后必须为 32 字节(AES-256)，当前为 {} 字节", aesKeyBytes.length);
                throw new IllegalArgumentException("AES-256 密钥必须为 32 字节");
            }
            log.info("[AES密钥] 已成功加载，密钥长度: {} 字节", aesKeyBytes.length);
        } catch (IllegalArgumentException e) {
            log.error("[AES密钥] 初始化失败: {}", e.getMessage());
            throw e;
        }
    }

    /**
     * 获取 AES 密钥字节数组（供 TypeHandler 使用）
     *
     * @return 32 字节密钥，未配置时返回 null
     */
    public static byte[] getAesKeyBytes() {
        return aesKeyBytes;
    }

    /**
     * 检查密钥是否已正确加载
     */
    public static boolean isKeyAvailable() {
        return aesKeyBytes != null && aesKeyBytes.length == 32;
    }
}
