package org.dromara.rental.domain.bo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.rental.domain.BusRentalOrder;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 租赁订单业务对象 bus_rental_order
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BusRentalOrder.class, reverseConvertGenerate = false)
public class BusRentalOrderBo extends BaseEntity {

    /**
     * 订单ID
     */
    private Long orderId;

    /**
     * 订单流水号
     */
    private String orderNo;

    /**
     * 租车客户ID
     */
    @NotNull(message = "客户不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long customerId;

    /**
     * 租赁车辆ID
     */
    @NotNull(message = "车辆不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long carId;

    /**
     * 起租日期
     */
    @NotNull(message = "起租日期不能为空", groups = {AddGroup.class, EditGroup.class})
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date rentStartDate;

    /**
     * 预计还车日期
     */
    @NotNull(message = "还车日期不能为空", groups = {AddGroup.class, EditGroup.class})
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
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
