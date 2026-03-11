package org.dromara.rental.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.rental.domain.BusCustomer;

/**
 * 客户信息业务对象 bus_customer
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BusCustomer.class, reverseConvertGenerate = false)
public class BusCustomerBo extends BaseEntity {

    /**
     * 客户ID
     */
    private Long customerId;

    /**
     * 客户真实姓名
     */
    @NotBlank(message = "客户姓名不能为空", groups = {AddGroup.class, EditGroup.class})
    private String customerName;

    /**
     * 手机号码(需AES加密存储)
     */
    @NotBlank(message = "手机号码不能为空", groups = {AddGroup.class, EditGroup.class})
    private String phone;

    /**
     * 身份证号(需AES加密存储)
     */
    @NotBlank(message = "身份证号不能为空", groups = {AddGroup.class, EditGroup.class})
    private String idCard;

    /**
     * 账号状态(0正常 1冻结)
     */
    private String accountStatus;
}
