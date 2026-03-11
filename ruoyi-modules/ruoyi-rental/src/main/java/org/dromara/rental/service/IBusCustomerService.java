package org.dromara.rental.service;

import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.rental.domain.bo.BusCustomerBo;
import org.dromara.rental.domain.vo.BusCustomerVo;

import java.util.List;

/**
 * 客户信息Service接口
 *
 * @author ruoyi
 */
public interface IBusCustomerService {

    /**
     * 查询客户信息
     */
    BusCustomerVo queryById(Long customerId);

    /**
     * 分页查询客户信息列表
     */
    TableDataInfo<BusCustomerVo> queryPageList(BusCustomerBo bo, PageQuery pageQuery);

    /**
     * 查询客户信息列表
     */
    List<BusCustomerVo> queryList(BusCustomerBo bo);

    /**
     * 新增客户信息
     */
    Boolean insertByBo(BusCustomerBo bo);

    /**
     * 修改客户信息
     */
    Boolean updateByBo(BusCustomerBo bo);

    /**
     * 校验并批量删除客户信息
     */
    Boolean deleteWithValidByIds(List<Long> ids);
}
