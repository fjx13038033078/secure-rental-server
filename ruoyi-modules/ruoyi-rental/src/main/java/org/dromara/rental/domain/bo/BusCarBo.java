package org.dromara.rental.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.rental.domain.BusCar;

import java.math.BigDecimal;

/**
 * 车辆信息业务对象 bus_car
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BusCar.class, reverseConvertGenerate = false)
public class BusCarBo extends BaseEntity {

    /**
     * 车辆ID
     */
    private Long carId;

    /**
     * 车牌号
     */
    @NotBlank(message = "车牌号不能为空", groups = {AddGroup.class, EditGroup.class})
    private String plateNumber;

    /**
     * 品牌与车型(如：丰田卡罗拉)
     */
    @NotBlank(message = "品牌车型不能为空", groups = {AddGroup.class, EditGroup.class})
    private String brandModel;

    /**
     * 车辆主图(存储MinIO返回的OSS链接)
     */
    private String carImageUrl;

    /**
     * 日租金(元)
     */
    @NotNull(message = "日租金不能为空", groups = {AddGroup.class, EditGroup.class})
    @DecimalMin(value = "0", message = "日租金不能小于0", groups = {AddGroup.class, EditGroup.class})
    private BigDecimal dailyRate;

    /**
     * 车辆状态(0待租 1已租出 2维护中)
     */
    private String carStatus;
}
