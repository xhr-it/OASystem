package com.xhr.service.dayReportService.impl;

import com.xhr.dao.dayReportDao.DayReportDao;
import com.xhr.dao.dayReportDao.impl.DayReportDaoImpl;
import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.dayReportService.DayReportService;
import com.xhr.util.BaseUtil;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class DayReportServiceImpl implements DayReportService {
    DayReportDao dayReportDao = new DayReportDaoImpl();

    @Override
    public PageEntity selectReportForStuff(Map map, PageEntity page, String stuffid) throws SQLException {
        return dayReportDao.selectReportForStuff(map,page,stuffid);
    }

    @Override
    public PageEntity selectReportView(PageEntity page, String stuffid) throws Exception {
        return dayReportDao.selectReportView(page,stuffid);
    }

    @Override
    public Map selectReportById(String dayreportid) throws Exception {
        return dayReportDao.selectReportById(dayreportid);
    }

    @Override
    public PageEntity selectAudit(PageEntity page, String stuffid) throws Exception {
        return dayReportDao.selectAudit(page,stuffid);
    }

    @Override
    public Map selectDayReportById(String dayreportid) throws Exception {
        return dayReportDao.selectReportById(dayreportid);
    }

    @Override
    public int insertOrUpdateReport(Map map) throws Exception {
        int i=0;
        if(BaseUtil.checkNull(map.get("dayreportid"))){
            i = dayReportDao.insertDayReport(map);
        }else{
            i = dayReportDao.updateDayReport(map);
        }
        return i;
    }

    @Override
    public int updateWriteState(String writeState, String dayreportid) throws Exception {
        return dayReportDao.updateWriteState(writeState, dayreportid);
    }

    @Override
    public Message insertAudit(Map map) throws SQLException {
        int i=dayReportDao.insertAudit(map);
        if (i>0){
            return new Message(true,"新增成功");
        }
        return new Message(false,"新增失败");
    }

    @Override
    public List<Map> selectAuditByReport(String dayreportid) throws Exception {
        return dayReportDao.selectAuditByReport(dayreportid);
    }

    @Override
    public List calendarForDayReport(String stuffid, String date) throws SQLException {
        return dayReportDao.calendarForDayReport(stuffid, date);
    }


}
