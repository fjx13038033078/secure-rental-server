package org.dromara.rental.domain.bo;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 租车创建订单业务对象
 *
 * @author ruoyi
 */
@Data
public class CreateOrderBo {

    /**
     * 租车客户ID
     */
    @NotNull(message = "客户ID不能为空")
    private Long customerId;

    /**
     * 租赁车辆ID
     */
    @NotNull(message = "车辆ID不能为空")
    private Long carId;

    /**
     * 起租日期
     */
    @NotNull(message = "起租日期不能为空")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date rentStartDate;

    /**
     * 结束日期（预计还车日期）
     */
    @NotNull(message = "结束日期不能为空")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date rentEndDate;
}
