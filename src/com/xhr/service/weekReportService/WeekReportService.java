package com.xhr.service.weekReportService;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface WeekReportService {
    /**
     * 周报审核-查询（已提交）
     * @param page
     * @param stuffid
     * @return
     * @throws Exception
     */
    PageEntity selectAudit(PageEntity page, String stuffid) throws Exception;

    /**
     * 周报查阅（所有）
     * @param page
     * @param stuffid
     * @return
     * @throws Exception
     */
    PageEntity selectWeekReport(PageEntity page, String stuffid) throws Exception;

    /**
     * 周报统计
     * @param map
     * @return
     * @throws SQLException
     */
    List<Map> selectForTab(Map map) throws SQLException;

    /**
     * 周报统计-图
     * @param map
     * @return
     * @throws SQLException
     */
    List<Map> selectChart(Map map) throws SQLException;

    /**
     * 查找我的周报
     * @param map
     * @param page
     * @param stuffid
     * @return
     * @throws Exception
     */
    PageEntity selectMyWeekReport(Map map,PageEntity page, String stuffid) throws Exception;

    /**
     * 查看周报详情
     * @param reportid
     * @return
     * @throws Exception
     */
    Map selectWeekById(String reportid) throws Exception;

    /**
     * 新增或修改周报
     * @param map
     * @return
     * @throws Exception
     */
    int insertOrUpdateReport(Map map) throws Exception;

    /**
     * 提交后修改状态
     * @param writeState
     * @param reportid
     * @return
     * @throws Exception
     */
    int updateWriteState(String writeState,String reportid) throws Exception;

    /**
     * 新增审核
     * @param map
     * @return
     * @throws Exception
     */
    Message insertAudit(Map map) throws Exception;

    /**
     * 根据周报id查看审核意见
     * @param reportid
     * @return
     * @throws Exception
     */
    List<Map> selectAuditByReport(String reportid) throws Exception;
}
