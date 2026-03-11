package org.dromara.rental.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.rental.domain.BusCustomer;
import org.dromara.rental.domain.bo.BusCustomerBo;
import org.dromara.rental.domain.vo.BusCustomerVo;
import org.dromara.rental.mapper.BusCustomerMapper;
import org.dromara.rental.service.IBusCustomerService;
import org.dromara.rental.utils.CustomerMaskUtils;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 客户信息Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class BusCustomerServiceImpl implements IBusCustomerService {

    private final BusCustomerMapper baseMapper;

    @Override
    public BusCustomerVo queryById(Long customerId) {
        BusCustomerVo vo = baseMapper.selectVoById(customerId);
        applyMask(vo);
        return vo;
    }

    @Override
    public TableDataInfo<BusCustomerVo> queryPageList(BusCustomerBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BusCustomer> lqw = buildQueryWrapper(bo);
        Page<BusCustomerVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        result.getRecords().forEach(this::applyMask);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BusCustomerVo> queryList(BusCustomerBo bo) {
        LambdaQueryWrapper<BusCustomer> lqw = buildQueryWrapper(bo);
        List<BusCustomerVo> list = baseMapper.selectVoList(lqw);
        list.forEach(this::applyMask);
        return list;
    }

    /**
     * 对 Vo 的 phone、idCard 解密并脱敏（手机号前3后2，身份证前6后4）
     */
    private void applyMask(BusCustomerVo vo) {
        if (vo == null) {
            return;
        }
        if (vo.getPhone() != null) {
            vo.setPhone(CustomerMaskUtils.maskPhone(vo.getPhone()));
        }
        if (vo.getIdCard() != null) {
            vo.setIdCard(CustomerMaskUtils.maskIdCard(vo.getIdCard()));
        }
    }

    private LambdaQueryWrapper<BusCustomer> buildQueryWrapper(BusCustomerBo bo) {
        LambdaQueryWrapper<BusCustomer> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getCustomerName()), BusCustomer::getCustomerName, bo.getCustomerName());
        lqw.eq(StringUtils.isNotBlank(bo.getAccountStatus()), BusCustomer::getAccountStatus, bo.getAccountStatus());
        lqw.orderByDesc(BaseEntity::getCreateTime);
        return lqw;
    }

    @Override
    public Boolean insertByBo(BusCustomerBo bo) {
        BusCustomer add = MapstructUtils.convert(bo, BusCustomer.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setCustomerId(add.getCustomerId());
        }
        return flag;
    }

    @Override
    public Boolean updateByBo(BusCustomerBo bo) {
        BusCustomer update = MapstructUtils.convert(bo, BusCustomer.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    @Override
    public Boolean deleteWithValidByIds(List<Long> ids) {
        return baseMapper.deleteByIds(ids) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BusCustomer entity) {
        // 可在此做业务校验，如账号状态等
    }
}
