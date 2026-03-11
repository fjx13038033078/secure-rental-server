package org.dromara.rental.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.dromara.rental.domain.BusCar;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 车辆信息视图对象 bus_car
 *
 * @author ruoyi
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BusCar.class)
public class BusCarVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 车辆ID
     */
    @ExcelProperty(value = "车辆ID")
    private Long carId;

    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号")
    private String plateNumber;

    /**
     * 品牌与车型(如：丰田卡罗拉)
     */
    @ExcelProperty(value = "品牌车型")
    private String brandModel;

    /**
     * 车辆主图(存储MinIO返回的OSS链接)
     */
    @ExcelProperty(value = "车辆主图")
    private String carImageUrl;

    /**
     * 日租金(元)
     */
    @ExcelProperty(value = "日租金")
    private BigDecimal dailyRate;

    /**
     * 车辆状态(0待租 1已租出 2维护中)
     */
    @ExcelProperty(value = "车辆状态")
    private String carStatus;

    /**
     * 入库时间
     */
    @ExcelProperty(value = "入库时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
}
