package org.dromara.rental.service.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.dromara.common.core.exception.ServiceException;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.rental.domain.BusCar;
import org.dromara.rental.domain.BusRentalOrder;
import org.dromara.rental.domain.bo.BusRentalOrderBo;
import org.dromara.rental.domain.bo.CreateOrderBo;
import org.dromara.rental.domain.vo.BusRentalOrderVo;
import org.dromara.rental.mapper.BusCarMapper;
import org.dromara.rental.mapper.BusRentalOrderMapper;
import org.dromara.rental.service.IBusRentalOrderService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.List;

/**
 * 租赁订单Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class BusRentalOrderServiceImpl implements IBusRentalOrderService {

    private final BusRentalOrderMapper baseMapper;
    private final BusCarMapper busCarMapper;

    @Override
    public BusRentalOrderVo queryById(Long orderId) {
        return baseMapper.selectVoById(orderId);
    }

    @Override
    public TableDataInfo<BusRentalOrderVo> queryPageList(BusRentalOrderBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BusRentalOrder> lqw = buildQueryWrapper(bo);
        Page<BusRentalOrderVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BusRentalOrderVo> queryList(BusRentalOrderBo bo) {
        LambdaQueryWrapper<BusRentalOrder> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BusRentalOrder> buildQueryWrapper(BusRentalOrderBo bo) {
        LambdaQueryWrapper<BusRentalOrder> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getOrderNo()), BusRentalOrder::getOrderNo, bo.getOrderNo());
        lqw.eq(bo.getCustomerId() != null, BusRentalOrder::getCustomerId, bo.getCustomerId());
        lqw.eq(bo.getCarId() != null, BusRentalOrder::getCarId, bo.getCarId());
        lqw.eq(StringUtils.isNotBlank(bo.getOrderStatus()), BusRentalOrder::getOrderStatus, bo.getOrderStatus());
        lqw.orderByDesc(BaseEntity::getCreateTime);
        return lqw;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public BusRentalOrderVo createOrder(CreateOrderBo bo) {
        // 1. 校验车辆状态是否为待租(0)
        BusCar car = busCarMapper.selectById(bo.getCarId());
        if (car == null) {
            throw new ServiceException("车辆不存在");
        }
        if (!"0".equals(car.getCarStatus())) {
            throw new ServiceException("车辆状态非待租，当前状态：" + getCarStatusDesc(car.getCarStatus()));
        }
        // 2. 根据日期计算总金额
        BigDecimal totalAmount = calculateTotalAmount(bo.getCarId(), bo.getRentStartDate(), bo.getRentEndDate());
        // 3. 生成唯一订单号并插入订单
        BusRentalOrder order = new BusRentalOrder();
        order.setOrderNo("RO" + IdUtil.getSnowflakeNextIdStr());
        order.setCustomerId(bo.getCustomerId());
        order.setCarId(bo.getCarId());
        order.setRentStartDate(bo.getRentStartDate());
        order.setRentEndDate(bo.getRentEndDate());
        order.setTotalAmount(totalAmount);
        order.setOrderStatus("0"); // 0租用中
        baseMapper.insert(order);
        // 4. 联动更新：车辆状态改为已租出(1)
        updateCarStatus(bo.getCarId(), "1");
        return baseMapper.selectVoById(order.getOrderId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public BusRentalOrderVo returnCar(Long orderId) {
        BusRentalOrder order = baseMapper.selectById(orderId);
        if (order == null) {
            throw new ServiceException("订单不存在");
        }
        if ("1".equals(order.getOrderStatus())) {
            throw new ServiceException("订单已还车，无需重复操作");
        }
        if ("2".equals(order.getOrderStatus())) {
            throw new ServiceException("订单已取消，无法还车");
        }
        // 1. 更新订单状态为已还车(1)
        BusRentalOrder update = new BusRentalOrder();
        update.setOrderId(orderId);
        update.setOrderStatus("1");
        baseMapper.updateById(update);
        // 2. 联动更新：车辆状态恢复为待租(0)
        updateCarStatus(order.getCarId(), "0");
        return baseMapper.selectVoById(orderId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(BusRentalOrderBo bo) {
        BusRentalOrder add = MapstructUtils.convert(bo, BusRentalOrder.class);
        if (StringUtils.isBlank(add.getOrderNo())) {
            add.setOrderNo("RO" + IdUtil.getSnowflakeNextIdStr());
        }
        if (add.getTotalAmount() == null && add.getRentStartDate() != null && add.getRentEndDate() != null) {
            add.setTotalAmount(calculateTotalAmount(add.getCarId(), add.getRentStartDate(), add.getRentEndDate()));
        }
        if (StringUtils.isBlank(add.getOrderStatus())) {
            add.setOrderStatus("0"); // 0租用中
        }
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setOrderId(add.getOrderId());
            // 更新车辆状态为已租出
            updateCarStatus(add.getCarId(), "1");
        }
        return flag;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(BusRentalOrderBo bo) {
        BusRentalOrder update = MapstructUtils.convert(bo, BusRentalOrder.class);
        if (update.getTotalAmount() == null && update.getRentStartDate() != null && update.getRentEndDate() != null) {
            update.setTotalAmount(calculateTotalAmount(update.getCarId(), update.getRentStartDate(), update.getRentEndDate()));
        }
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteWithValidByIds(List<Long> ids) {
        for (Long id : ids) {
            BusRentalOrder order = baseMapper.selectById(id);
            if (order != null && "0".equals(order.getOrderStatus())) {
                // 还车：更新车辆状态为待租
                updateCarStatus(order.getCarId(), "0");
            }
        }
        return baseMapper.deleteByIds(ids) > 0;
    }

    /**
     * 根据日租金计算订单总金额
     */
    private BigDecimal calculateTotalAmount(Long carId, Date rentStartDate, Date rentEndDate) {
        if (carId == null || rentStartDate == null || rentEndDate == null) {
            return BigDecimal.ZERO;
        }
        BusCar car = busCarMapper.selectById(carId);
        if (car == null || car.getDailyRate() == null) {
            return BigDecimal.ZERO;
        }
        long days = DateUtil.betweenDay(rentStartDate, rentEndDate, true) + 1;
        return car.getDailyRate().multiply(BigDecimal.valueOf(days)).setScale(2, RoundingMode.HALF_UP);
    }

    /**
     * 更新车辆状态
     */
    private void updateCarStatus(Long carId, String status) {
        if (carId != null) {
            BusCar car = new BusCar();
            car.setCarId(carId);
            car.setCarStatus(status);
            busCarMapper.updateById(car);
        }
    }

    /**
     * 车辆状态描述
     */
    private String getCarStatusDesc(String status) {
        if (status == null) return "未知";
        return switch (status) {
            case "0" -> "待租";
            case "1" -> "已租出";
            case "2" -> "维护中";
            default -> status;
        };
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BusRentalOrder entity) {
        // 可在此做业务校验，如日期校验、车辆可用性等
    }
}
