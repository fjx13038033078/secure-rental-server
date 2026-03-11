package org.dromara.rental.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.exception.ServiceException;
import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.rental.domain.BusCar;
import org.dromara.rental.domain.bo.BusCarBo;
import org.dromara.rental.domain.vo.BusCarVo;
import org.dromara.rental.mapper.BusCarMapper;
import org.dromara.rental.service.IBusCarService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 车辆信息Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class BusCarServiceImpl implements IBusCarService {

    private final BusCarMapper baseMapper;

    @Override
    public BusCarVo queryById(Long carId) {
        return baseMapper.selectVoById(carId);
    }

    @Override
    public TableDataInfo<BusCarVo> queryPageList(BusCarBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BusCar> lqw = buildQueryWrapper(bo);
        Page<BusCarVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BusCarVo> queryList(BusCarBo bo) {
        LambdaQueryWrapper<BusCar> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BusCar> buildQueryWrapper(BusCarBo bo) {
        LambdaQueryWrapper<BusCar> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getPlateNumber()), BusCar::getPlateNumber, bo.getPlateNumber());
        lqw.like(StringUtils.isNotBlank(bo.getBrandModel()), BusCar::getBrandModel, bo.getBrandModel());
        lqw.eq(StringUtils.isNotBlank(bo.getCarStatus()), BusCar::getCarStatus, bo.getCarStatus());
        lqw.orderByDesc(BaseEntity::getCreateTime);
        return lqw;
    }

    @Override
    public Boolean insertByBo(BusCarBo bo) {
        checkPlateNumberUnique(null, bo.getPlateNumber());
        BusCar add = MapstructUtils.convert(bo, BusCar.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setCarId(add.getCarId());
        }
        return flag;
    }

    @Override
    public Boolean updateByBo(BusCarBo bo) {
        checkPlateNumberUnique(bo.getCarId(), bo.getPlateNumber());
        BusCar update = MapstructUtils.convert(bo, BusCar.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    @Override
    public Boolean deleteWithValidByIds(List<Long> ids) {
        return baseMapper.deleteByIds(ids) > 0;
    }

    /**
     * 校验车牌号唯一性
     *
     * @param carId       车辆ID（新增时为null，修改时排除自身）
     * @param plateNumber 车牌号
     */
    private void checkPlateNumberUnique(Long carId, String plateNumber) {
        if (StringUtils.isBlank(plateNumber)) {
            return;
        }
        LambdaQueryWrapper<BusCar> lqw = Wrappers.lambdaQuery();
        lqw.eq(BusCar::getPlateNumber, plateNumber);
        lqw.ne(carId != null, BusCar::getCarId, carId);
        if (baseMapper.exists(lqw)) {
            throw new ServiceException("车牌号【" + plateNumber + "】已存在");
        }
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BusCar entity) {
        // 车牌号唯一性已在 checkPlateNumberUnique 中校验
    }
}
