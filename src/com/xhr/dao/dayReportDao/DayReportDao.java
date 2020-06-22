package com.xhr.dao.dayReportDao;

import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/***
 * @author xhr
 * @date 2020/3/25
 *  日报Dao接口
**/
public interface DayReportDao {
    /**
     * 根据员工id查询日报（为填报做准备）
     * @param map
     * @param page
     * @param stuffid
     * @return
     * @throws SQLException
     */
    public PageEntity selectReportForStuff(Map map, PageEntity page, String stuffid) throws SQLException;

    /**
     * 查询已提交日报
     * @param page
     * @param stuffid
     * @return
     * @throws Exception
     */
    PageEntity selectReportView(PageEntity page,String stuffid) throws Exception;

    /**
     * 根据日报id查询日报内容
     * @param dayreportid
     * @return
     * @throws Exception
     */
    Map selectReportById(String dayreportid) throws Exception;

    /**
     * 日报审核-查询
     * @param page
     * @param stuffid
     * @return
     * @throws Exception
     */
    PageEntity selectAudit(PageEntity page, String stuffid) throws Exception;

    /**
     * 根据日报id查询日报
     * @param dayreportid
     * @return
     * @throws Exception
     */
    Map selectDayReportById(String dayreportid) throws Exception;

    /**
     * 新增日报
     * @param map
     * @return
     * @throws Exception
     */
    int insertDayReport(Map map) throws Exception;

    /**
     * 修改日报
     * @param map
     * @return
     * @throws Exception
     */
    int updateDayReport(Map map) throws Exception;

    /**
     * 更新填报状态
     * @param writeState
     * @param dayreportid
     * @return
     * @throws Exception
     */
    int updateWriteState(String writeState,String dayreportid) throws Exception;

    /**
     * 新增审核意见
     * @param map
     * @return
     * @throws SQLException
     */
    int insertAudit(Map map) throws SQLException;

    /**
     * 根据日报id查看审核意见
     * @param dayreportid
     * @return
     * @throws Exception
     */
    List<Map> selectAuditByReport(String dayreportid) throws Exception;

    /**
     * 日历-日报填写情况
     * @param stuffid
     * @param date
     * @return
     * @throws SQLException
     */
    List calendarForDayReport(String stuffid, String date) throws SQLException;
}
