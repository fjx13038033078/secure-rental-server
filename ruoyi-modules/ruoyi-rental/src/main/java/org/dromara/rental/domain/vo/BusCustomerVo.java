package org.dromara.rental.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.dromara.rental.domain.BusCustomer;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 客户信息视图对象 bus_customer
 * 数据脱敏：手机号、身份证号展示时脱敏
 *
 * @author ruoyi
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BusCustomer.class)
public class BusCustomerVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 客户ID
     */
    @ExcelProperty(value = "客户ID")
    private Long customerId;

    /**
     * 客户真实姓名
     */
    @ExcelProperty(value = "客户姓名")
    private String customerName;

    /**
     * 手机号码(Service 层脱敏：前3后2，如 130******78)
     */
    @ExcelProperty(value = "手机号码")
    private String phone;

    /**
     * 身份证号(Service 层脱敏：前6后4，如 110101********1234)
     */
    @ExcelProperty(value = "身份证号")
    private String idCard;

    /**
     * 账号状态(0正常 1冻结)
     */
    @ExcelProperty(value = "账号状态")
    private String accountStatus;

    /**
     * 注册时间
     */
    @ExcelProperty(value = "注册时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
}
