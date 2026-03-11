package org.dromara.rental.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.rental.handler.AesGcmTypeHandler;

import java.io.Serial;

/**
 * 客户信息对象 bus_customer
 * 安全存储亮点：AES加密存储手机号、身份证号
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("bus_customer")
public class BusCustomer extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 客户ID
     */
    @TableId(value = "customer_id", type = IdType.AUTO)
    private Long customerId;

    /**
     * 客户真实姓名
     */
    private String customerName;

    /**
     * 手机号码(AES-256-GCM 加密存储，使用 AesGcmTypeHandler，需配置 ruoyi.aes.key)
     */
    @TableField(typeHandler = AesGcmTypeHandler.class)
    private String phone;

    /**
     * 身份证号(AES-256-GCM 加密存储)
     */
    @TableField(typeHandler = AesGcmTypeHandler.class)
    private String idCard;

    /**
     * 账号状态(0正常 1冻结)
     */
    private String accountStatus;
}
