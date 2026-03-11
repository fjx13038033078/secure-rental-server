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
import org.dromara.rental.domain.bo.BusCarBo;
import org.dromara.rental.domain.vo.BusCarVo;
import org.dromara.rental.service.IBusCarService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 车辆管理 Controller
 * <p>
 * 表 bus_car，carImageUrl 用于接收前端 MinIO 上传后返回的 OSS 链接字符串，
 * 后端仅保存 URL 到数据库，不处理具体文件上传逻辑。
 * </p>
 *
 * @author ruoyi
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/rental/car")
public class BusCarController extends BaseController {

    private final IBusCarService carService;

    /**
     * 分页查询车辆列表
     */
    @SaCheckPermission("rental:car:list")
    @GetMapping("/list")
    public TableDataInfo<BusCarVo> list(BusCarBo bo, PageQuery pageQuery) {
        return carService.queryPageList(bo, pageQuery);
    }

    /**
     * 根据车辆ID获取详情
     */
    @SaCheckPermission("rental:car:query")
    @GetMapping("/{carId}")
    public R<BusCarVo> getInfo(@NotNull(message = "车辆ID不能为空") @PathVariable Long carId) {
        return R.ok(carService.queryById(carId));
    }

    /**
     * 新增车辆
     */
    @SaCheckPermission("rental:car:add")
    @Log(title = "车辆管理", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BusCarBo bo) {
        return toAjax(carService.insertByBo(bo));
    }

    /**
     * 修改车辆
     */
    @SaCheckPermission("rental:car:edit")
    @Log(title = "车辆管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BusCarBo bo) {
        return toAjax(carService.updateByBo(bo));
    }

    /**
     * 批量删除车辆
     */
    @SaCheckPermission("rental:car:remove")
    @Log(title = "车辆管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{carIds}")
    public R<Void> remove(@PathVariable Long[] carIds) {
        return toAjax(carService.deleteWithValidByIds(Arrays.asList(carIds)));
    }

    /**
     * 导出车辆列表
     */
    @SaCheckPermission("rental:car:export")
    @Log(title = "车辆管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BusCarBo bo, HttpServletResponse response) {
        List<BusCarVo> list = carService.queryList(bo);
        org.dromara.common.excel.utils.ExcelUtil.exportExcel(list, "车辆数据", BusCarVo.class, response);
    }
}
