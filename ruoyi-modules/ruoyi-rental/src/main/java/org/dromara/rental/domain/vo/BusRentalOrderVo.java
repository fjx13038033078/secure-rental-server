package org.dromara.rental.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.dromara.rental.domain.BusRentalOrder;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 租赁订单视图对象 bus_rental_order
 *
 * @author ruoyi
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BusRentalOrder.class)
public class BusRentalOrderVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 订单ID
     */
    @ExcelProperty(value = "订单ID")
    private Long orderId;

    /**
     * 订单流水号
     */
    @ExcelProperty(value = "订单流水号")
    private String orderNo;

    /**
     * 租车客户ID
     */
    @ExcelProperty(value = "客户ID")
    private Long customerId;

    /**
     * 租赁车辆ID
     */
    @ExcelProperty(value = "车辆ID")
    private Long carId;

    /**
     * 起租日期
     */
    @ExcelProperty(value = "起租日期")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date rentStartDate;

    /**
     * 预计还车日期
     */
    @ExcelProperty(value = "预计还车日期")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date rentEndDate;

    /**
     * 订单总金额
     */
    @ExcelProperty(value = "订单总金额")
    private BigDecimal totalAmount;

    /**
     * 订单状态(0租用中 1已还车 2已取消)
     */
    @ExcelProperty(value = "订单状态")
    private String orderStatus;

    /**
     * 创建时间
     */
    @ExcelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
}
