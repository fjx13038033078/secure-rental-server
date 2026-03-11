package org.dromara.rental.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.mybatis.core.domain.BaseEntity;

import java.io.Serial;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 租赁订单对象 bus_rental_order
 * 核心业务：租车与还车闭环
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("bus_rental_order")
public class BusRentalOrder extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 订单ID
     */
    @TableId(value = "order_id", type = IdType.AUTO)
    private Long orderId;

    /**
     * 订单流水号
     */
    private String orderNo;

    /**
     * 租车客户ID
     */
    private Long customerId;

    /**
     * 租赁车辆ID
     */
    private Long carId;

    /**
     * 起租日期
     */
    private Date rentStartDate;

    /**
     * 预计还车日期
     */
    private Date rentEndDate;

    /**
     * 订单总金额
     */
    private BigDecimal totalAmount;

    /**
     * 订单状态(0租用中 1已还车 2已取消)
     */
    private String orderStatus;
}
