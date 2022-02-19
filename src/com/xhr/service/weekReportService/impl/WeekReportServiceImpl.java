package com.xhr.service.weekReportService.impl;

import com.xhr.dao.weekReportDao.WeekReportDao;
import com.xhr.dao.weekReportDao.impl.WeekReportDaoImpl;
import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.weekReportService.WeekReportService;
import com.xhr.util.BaseUtil;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class WeekReportServiceImpl implements WeekReportService {
    WeekReportDao weekReportDao = new WeekReportDaoImpl();

    @Override
    public PageEntity selectAudit(PageEntity page, String stuffid) throws Exception {
        return weekReportDao.selectAudit(page,stuffid);
    }

    @Override
    public PageEntity selectWeekReport(PageEntity page, String stuffid) throws Exception {
        return weekReportDao.selectWeekReport(page,stuffid);
    }

    @Override
    public List<Map> selectForTab(Map map) throws SQLException {
        return weekReportDao.selectForTab(map);
    }

    @Override
    public List<Map> selectChart(Map map) throws SQLException {
        return weekReportDao.selectChart(map);
    }

    @Override
    public PageEntity selectMyWeekReport(Map map, PageEntity page, String stuffid) throws Exception {
        return weekReportDao.selectMyWeekReport(map,page,stuffid);
    }

    @Override
    public Map selectWeekById(String reportid) throws Exception {
        return weekReportDao.selectWeekById(reportid);
    }

    @Override
    public int insertOrUpdateReport(Map map) throws Exception {
        int i=0;
        if(BaseUtil.checkNull(map.get("reportid"))){
           weekReportDao.insertWeek(map);
        }else{
            weekReportDao.updateWeek(map);
        }
        return i;
    }

    @Override
    public int updateWriteState(String writeState, String reportid) throws Exception {
        return weekReportDao.updateWriteState(writeState, reportid);
    }

    @Override
    public Message insertAudit(Map map) throws Exception {
        int i=weekReportDao.insertAudit(map);
        if (i>0){
            return new Message(true,"新增成功");
        }
        return new Message(false,"新增失败");
    }

    @Override
    public List<Map> selectAuditByReport(String reportid) throws Exception {
        return weekReportDao.selectAuditByReport(reportid);
    }
}
