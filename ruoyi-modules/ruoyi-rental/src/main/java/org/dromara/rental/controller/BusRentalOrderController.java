package org.dromara.rental.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.domain.R;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.log.annotation.Log;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.web.core.BaseController;
import org.dromara.rental.domain.bo.BusRentalOrderBo;
import org.dromara.rental.domain.bo.CreateOrderBo;
import org.dromara.rental.domain.vo.BusRentalOrderVo;
import org.dromara.rental.service.IBusRentalOrderService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 租赁订单 Controller
 * <p>
 * 核心业务：租车(createOrder)、还车(returnCar) 闭环
 * </p>
 *
 * @author ruoyi
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/rental/order")
public class BusRentalOrderController extends BaseController {

    private final IBusRentalOrderService orderService;

    /**
     * 分页查询租赁订单列表
     */
    @SaCheckPermission("rental:order:list")
    @GetMapping("/list")
    public TableDataInfo<BusRentalOrderVo> list(BusRentalOrderBo bo, PageQuery pageQuery) {
        return orderService.queryPageList(bo, pageQuery);
    }

    /**
     * 根据订单ID获取详情
     */
    @SaCheckPermission("rental:order:query")
    @GetMapping("/{orderId}")
    public R<BusRentalOrderVo> getInfo(@NotNull(message = "订单ID不能为空") @PathVariable Long orderId) {
        return R.ok(orderService.queryById(orderId));
    }

    /**
     * 租车：创建订单
     * <p>
     * 校验车辆待租 → 计算金额 → 生成订单号 → 插入订单 → 联动更新车辆为已租出
     * </p>
     */
    @SaCheckPermission("rental:order:add")
    @Log(title = "租赁订单", businessType = BusinessType.INSERT)
    @PostMapping("/create")
    public R<BusRentalOrderVo> createOrder(@Validated @RequestBody CreateOrderBo bo) {
        return R.ok(orderService.createOrder(bo));
    }

    /**
     * 还车：完成订单
     * <p>
     * 更新订单状态为已还车 → 联动恢复车辆为待租
     * </p>
     */
    @SaCheckPermission("rental:order:edit")
    @Log(title = "租赁订单", businessType = BusinessType.UPDATE)
    @PutMapping("/return/{orderId}")
    public R<BusRentalOrderVo> returnCar(@NotNull(message = "订单ID不能为空") @PathVariable Long orderId) {
        return R.ok(orderService.returnCar(orderId));
    }

    /**
     * 新增租赁订单（通用）
     */
    @SaCheckPermission("rental:order:add")
    @Log(title = "租赁订单", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BusRentalOrderBo bo) {
        return toAjax(orderService.insertByBo(bo));
    }

    /**
     * 修改租赁订单
     */
    @SaCheckPermission("rental:order:edit")
    @Log(title = "租赁订单", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BusRentalOrderBo bo) {
        return toAjax(orderService.updateByBo(bo));
    }

    /**
     * 批量删除租赁订单
     */
    @SaCheckPermission("rental:order:remove")
    @Log(title = "租赁订单", businessType = BusinessType.DELETE)
    @DeleteMapping("/{orderIds}")
    public R<Void> remove(@PathVariable Long[] orderIds) {
        return toAjax(orderService.deleteWithValidByIds(Arrays.asList(orderIds)));
    }

    /**
     * 导出租赁订单列表
     */
    @SaCheckPermission("rental:order:export")
    @Log(title = "租赁订单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BusRentalOrderBo bo, HttpServletResponse response) {
        List<BusRentalOrderVo> list = orderService.queryList(bo);
        org.dromara.common.excel.utils.ExcelUtil.exportExcel(list, "租赁订单数据", BusRentalOrderVo.class, response);
    }
}
