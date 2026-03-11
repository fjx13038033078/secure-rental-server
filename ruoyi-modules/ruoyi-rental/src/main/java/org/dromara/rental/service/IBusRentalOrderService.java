package org.dromara.rental.service;

import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.rental.domain.bo.BusRentalOrderBo;
import org.dromara.rental.domain.bo.CreateOrderBo;
import org.dromara.rental.domain.vo.BusRentalOrderVo;

import java.util.List;

/**
 * 租赁订单Service接口
 *
 * @author ruoyi
 */
public interface IBusRentalOrderService {

    /**
     * 查询租赁订单
     */
    BusRentalOrderVo queryById(Long orderId);

    /**
     * 分页查询租赁订单列表
     */
    TableDataInfo<BusRentalOrderVo> queryPageList(BusRentalOrderBo bo, PageQuery pageQuery);

    /**
     * 查询租赁订单列表
     */
    List<BusRentalOrderVo> queryList(BusRentalOrderBo bo);

    /**
     * 租车：创建订单并联动更新车辆状态
     *
     * @param bo 租车参数（客户ID、车辆ID、起租日期、结束日期）
     * @return 订单详情
     */
    BusRentalOrderVo createOrder(CreateOrderBo bo);

    /**
     * 还车：更新订单状态并联动恢复车辆状态
     *
     * @param orderId 订单ID
     * @return 订单详情
     */
    BusRentalOrderVo returnCar(Long orderId);

    /**
     * 新增租赁订单
     */
    Boolean insertByBo(BusRentalOrderBo bo);

    /**
     * 修改租赁订单
     */
    Boolean updateByBo(BusRentalOrderBo bo);

    /**
     * 校验并批量删除租赁订单
     */
    Boolean deleteWithValidByIds(List<Long> ids);
}
