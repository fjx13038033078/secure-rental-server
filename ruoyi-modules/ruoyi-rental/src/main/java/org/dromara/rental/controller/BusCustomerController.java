package org.dromara.rental.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.domain.R;
import org.dromara.common.log.annotation.Log;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.web.core.BaseController;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.rental.domain.bo.BusCustomerBo;
import org.dromara.rental.domain.vo.BusCustomerVo;
import org.dromara.rental.service.IBusCustomerService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 客户管理 Controller
 * <p>
 * 表 bus_customer，phone、idCard 使用 AesGcmTypeHandler 透明加密存储，
 * 返回 Vo 时通过 @Sensitive 脱敏展示（idCard 前6后4，phone 前3后4）
 * </p>
 *
 * @author ruoyi
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/rental/customer")
public class BusCustomerController extends BaseController {

    private final IBusCustomerService customerService;

    /**
     * 分页查询客户列表
     */
    @SaCheckPermission("rental:customer:list")
    @GetMapping("/list")
    public TableDataInfo<BusCustomerVo> list(BusCustomerBo bo, PageQuery pageQuery) {
        return customerService.queryPageList(bo, pageQuery);
    }

    /**
     * 根据客户ID获取详情
     */
    @SaCheckPermission("rental:customer:query")
    @GetMapping("/{customerId}")
    public R<BusCustomerVo> getInfo(@NotNull(message = "客户ID不能为空") @PathVariable Long customerId) {
        return R.ok(customerService.queryById(customerId));
    }

    /**
     * 新增客户
     */
    @SaCheckPermission("rental:customer:add")
    @Log(title = "客户管理", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BusCustomerBo bo) {
        return toAjax(customerService.insertByBo(bo));
    }

    /**
     * 修改客户
     */
    @SaCheckPermission("rental:customer:edit")
    @Log(title = "客户管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BusCustomerBo bo) {
        return toAjax(customerService.updateByBo(bo));
    }

    /**
     * 批量删除客户
     */
    @SaCheckPermission("rental:customer:remove")
    @Log(title = "客户管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{customerIds}")
    public R<Void> remove(@PathVariable Long[] customerIds) {
        return toAjax(customerService.deleteWithValidByIds(Arrays.asList(customerIds)));
    }

    /**
     * 导出客户列表
     */
    @SaCheckPermission("rental:customer:export")
    @Log(title = "客户管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BusCustomerBo bo, HttpServletResponse response) {
        List<BusCustomerVo> list = customerService.queryList(bo);
        org.dromara.common.excel.utils.ExcelUtil.exportExcel(list, "客户数据", BusCustomerVo.class, response);
    }
}
