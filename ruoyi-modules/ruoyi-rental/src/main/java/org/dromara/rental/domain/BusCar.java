package org.dromara.rental.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.mybatis.core.domain.BaseEntity;

import java.io.Serial;
import java.math.BigDecimal;

/**
 * 车辆信息对象 bus_car
 * 业务与OSS结合点：车辆主图存储MinIO返回的OSS链接
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("bus_car")
public class BusCar extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 车辆ID
     */
    @TableId(value = "car_id", type = IdType.AUTO)
    private Long carId;

    /**
     * 车牌号
     */
    private String plateNumber;

    /**
     * 品牌与车型(如：丰田卡罗拉)
     */
    private String brandModel;

    /**
     * 车辆主图(存储MinIO返回的OSS链接)
     */
    private String carImageUrl;

    /**
     * 日租金(元)
     */
    private BigDecimal dailyRate;

    /**
     * 车辆状态(0待租 1已租出 2维护中)
     */
    private String carStatus;
}
