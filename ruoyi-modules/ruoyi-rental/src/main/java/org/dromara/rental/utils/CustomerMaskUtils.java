package org.dromara.rental.utils;

import cn.hutool.core.util.DesensitizedUtil;
import cn.hutool.core.util.StrUtil;
import org.dromara.rental.handler.AesGcmTypeHandler;

/**
 * 客户敏感信息脱敏工具
 * <p>
 * 当 TypeHandler 未生效导致返回加密串时，在此解密并脱敏：
 * 手机号前3后2（如 130******78），身份证前6后4（如 110101********1234）
 * </p>
 *
 * @author ruoyi
 */
public final class CustomerMaskUtils {

    private CustomerMaskUtils() {
    }

    /**
     * 判断字符串是否像 AES-GCM 加密后的 Base64（含 +、/ 等）
     */
    public static boolean isLikelyEncrypted(String value) {
        if (StrUtil.isBlank(value) || value.length() < 20) {
            return false;
        }
        return value.contains("+") || value.contains("/") || value.contains("=");
    }

    /**
     * 解密（若为加密串）并脱敏手机号：前3后2，如 130******78
     */
    public static String maskPhone(String value) {
        if (StrUtil.isBlank(value)) {
            return value;
        }
        String plain = isLikelyEncrypted(value) ? AesGcmTypeHandler.decryptValue(value) : value;
        if (StrUtil.isBlank(plain)) {
            return value;
        }
        return DesensitizedUtil.idCardNum(plain, 3, 2);
    }

    /**
     * 解密（若为加密串）并脱敏身份证号：前6后4，如 110101********1234
     */
    public static String maskIdCard(String value) {
        if (StrUtil.isBlank(value)) {
            return value;
        }
        String plain = isLikelyEncrypted(value) ? AesGcmTypeHandler.decryptValue(value) : value;
        if (StrUtil.isBlank(plain)) {
            return value;
        }
        return DesensitizedUtil.idCardNum(plain, 6, 4);
    }
}
