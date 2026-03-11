package org.dromara.rental.service;

import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.rental.domain.bo.BusCarBo;
import org.dromara.rental.domain.vo.BusCarVo;

import java.util.List;

/**
 * 车辆信息Service接口
 *
 * @author ruoyi
 */
public interface IBusCarService {

    /**
     * 查询车辆信息
     */
    BusCarVo queryById(Long carId);

    /**
     * 分页查询车辆信息列表
     */
    TableDataInfo<BusCarVo> queryPageList(BusCarBo bo, PageQuery pageQuery);

    /**
     * 查询车辆信息列表
     */
    List<BusCarVo> queryList(BusCarBo bo);

    /**
     * 新增车辆信息
     */
    Boolean insertByBo(BusCarBo bo);

    /**
     * 修改车辆信息
     */
    Boolean updateByBo(BusCarBo bo);

    /**
     * 校验并批量删除车辆信息
     */
    Boolean deleteWithValidByIds(List<Long> ids);
}
