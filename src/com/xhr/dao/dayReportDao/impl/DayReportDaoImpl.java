package com.xhr.dao.dayReportDao.impl;

import com.xhr.dao.dayReportDao.DayReportDao;
import com.xhr.entity.PageEntity;
import com.xhr.util.BaseUtil;
import com.xhr.util.DBAgent;
import com.xhr.util.PageUtil;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DayReportDaoImpl implements DayReportDao {
    DBAgent dbAgent = new DBAgent();

    @Override
    public PageEntity selectReportForStuff(Map map, PageEntity page, String stuffid) throws SQLException {
        String beginDate=(String) map.get("begindate");
        String endDate=(String) map.get("enddate");
        String sql="select * from(" +
                "select a.stuffid,a.name,date_format(c.submitdate,'%Y-%m-%d %h:%i:%s') as submitdate" +
                ",b.dayid,date_format(b.day_date,'%Y-%m-%d') as day_date," +
                "b.state,(CASE  c.writestate WHEN '0' THEN '草稿' WHEN '1' THEN '已提交' WHEN '2' THEN '已审核' WHEN '3' THEN '待修正' ELSE '未填写' end )as writestate," +
                "c.reportstate ,"+
                "c.content,c.title,c.dayreportid," +
                " case when  date_format(b.day_date,'%Y-%m-%d')=date_format(now(),'%Y-%m-%d') then 'z'" +
                "       when date_format(b.day_date,'%Y-%m-%d')<date_format(now(),'%Y-%m-%d') " +
                "       and datediff(now(),b.day_date)<7 then 'b'" +
                "       when date_format(b.day_date,'%Y-%m-%d')>date_format(now(),'%Y-%m-%d') then 'w' end as dateinfo" +
                " from stuff a  " +
                " join `day` b on 1=1 " +
                " left join dailyreport c on a.stuffid=c.stuffid and  b.day_date=c.reportdate " +
                " where 1=1 and  a.stuffid="+stuffid;//这个从session中获取：session在控制层获取
        if(!BaseUtil.checkNull(beginDate)){
            sql=sql+" and b.day_date>='"+beginDate+"'";
        }
        if(!BaseUtil.checkNull(endDate)){
            sql=sql+" and b.day_date<='"+endDate+"'";
        }
        sql=sql+")a";
        return PageUtil.selectByPage(sql,page);
    }

    @Override
    public PageEntity selectReportView(PageEntity page, String stuffid) throws Exception {
        String sql= "select * from(SELECT dayreportid,title,content,DATE_FORMAT(reportdate,'%Y-%m-%d') AS reportdate," +
                "            DATE_FORMAT(submitdate,'%Y-%m-%d %H:%i:%s') as submitdate,createstuffname," +
                "(CASE  writestate WHEN '0' THEN '草稿' WHEN '1' THEN '已提交' WHEN '2' THEN '已审核' WHEN '3' THEN '待修正' ELSE '未填写' end )as writestate," +
                "(CASE  reportstate WHEN '0' THEN '正常填报' WHEN '1' THEN '正常补报' WHEN '2' THEN '异常填报' WHEN '3' THEN '异常补报' ELSE '未填写' end )as reportstate "+
                "             FROM dailyreport where  " +
                "               stuffid IN( " +
                "             SELECT stuffid FROM stuff where tab_stuffid='"+stuffid+"' or stuffid='"+stuffid+"')ORDER BY stuffid)a";
        return PageUtil.selectByPage(sql,page);
    }

    @Override
    public Map selectReportById(String dayreportid) throws Exception {
        String sql="select * from(" +
                "select a.stuffid,a.name,date_format(c.createdate,'%Y-%m-%d %h:%i:%s') as createdate,date_format(c.submitdate,'%Y-%m-%d %h:%i:%s') as submitdate" +
                ",date_format(c.reportdate,'%Y-%m-%d') as reportdate," +
                "c.reportstate,c.content,c.title,c.writestate,c.dayreportid" +
                " from stuff a  " +
                " join dailyreport c on a.stuffid=c.stuffid  " +
                " where 1=1 and c.dayreportid="+dayreportid;
        sql=sql+")a";
        List<Map> list=dbAgent.executeQuery(sql);
        if (list!=null&&list.size()>0){
            return list.get(0);
        }
        return new HashMap();
    }

    @Override
    public PageEntity selectAudit(PageEntity page, String stuffid) throws Exception {
        String sql= "select * from(SELECT dayreportid,title,content,DATE_FORMAT(reportdate,'%Y-%m-%d') AS reportdate," +
                "            DATE_FORMAT(submitdate,'%Y-%m-%d %H:%i:%s') as submitdate,createstuffname," +
                "(CASE  writestate WHEN '0' THEN '草稿' WHEN '1' THEN '已提交' WHEN '2' THEN '已通过' WHEN '3' THEN '待修正' ELSE '未填写' end )as writestate," +
                "(CASE  reportstate WHEN '0' THEN '正常填报' WHEN '1' THEN '正常补报' WHEN '2' THEN '异常填报' WHEN '3' THEN '异常补报' ELSE '未填写' end )as reportstate "+
                "             FROM dailyreport where writestate='1' " +
                "              and stuffid IN( " +
                "             SELECT stuffid FROM stuff where tab_stuffid='"+stuffid+"' and stuffid!='"+stuffid+"')ORDER BY reportdate)a";
        return PageUtil.selectByPage(sql,page);
    }

    @Override
    public Map selectDayReportById(String dayreportid) throws Exception {
        String sql="select * from(" +
                "select a.stuffid,a.name,date_format(c.createdate,'%Y-%m-%d %h:%i:%s') as createdate,date_format(c.submitdate,'%Y-%m-%d %h:%i:%s') as submitdate" +
                ",date_format(c.reportdate,'%Y-%m-%d') as reportdate," +
                "c.reportstate,c.content,c.title,c.writestate,c.dayreportid" +
                " from stuff a  " +
                " join dailyreport c on a.stuffid=c.stuffid  " +
                " where 1=1 and  c.dayreportid="+dayreportid;
        sql=sql+")a";
        List<Map> list=dbAgent.executeQuery(sql);
        if (list!=null&&list.size()>0){
            return list.get(0);
        }
        return new HashMap();
    }

    @Override
    public int insertDayReport(Map map) throws Exception {
        String sql=" insert into dailyreport(stuffid,title,content,reportdate,writestate,reportstate,createdate,createstuffid,createstuffname)" +
                "values(?,?,?,?,'0',?,now(),?,?)";
        return dbAgent.excuteUpdate(sql,map.get("stuffid"),map.get("title"),map.get("content")
                ,BaseUtil.transObjToSqlDate(map.get("reportdate")),map.get("reportstate"),map.get("createstuffid"),map.get("createstuffname"));
    }

    @Override
    public int updateDayReport(Map map) throws Exception {
        String sql="update dailyreport set content=? where dayreportid=?";
        return dbAgent.excuteUpdate(sql,map.get("content"),map.get("dayreportid"));
    }

    @Override
    public int updateWriteState(String writeState, String dayreportid) throws Exception {
        String sql=" update dailyreport set submitdate=now(),writestate=? where dayreportid=?";
        return dbAgent.excuteUpdate(sql,writeState,dayreportid);
    }

    @Override
    public int insertAudit(Map map) throws SQLException {
        String sql="INSERT into daily_opinion(dayreportid,content,opintime,aduitstate,aduitstuffid,\n" +
                "aduitstuffname) VALUES(?,?,?,?,?,?)";
        return dbAgent.excuteUpdate(sql,map.get("dayreportid"),map.get("content"),map.get("opintime")
                ,map.get("aduitstate"),map.get("aduitstuffid"),map.get("aduitstuffname"));
    }

    @Override
    public List<Map> selectAuditByReport(String dayreportid) throws Exception {
        String sql= "SELECT content,date_format(opintime,'%Y-%m-%d' ) as opintime,(CASE aduitstate WHEN '0' THEN '未通过'WHEN '1' THEN '已通过' END)as aduitstate, " +
                " aduitstuffname FROM daily_opinion where dayreportid= " +dayreportid;
        sql=sql+" ORDER BY opinionid DESC   ";
        List<Map> list=dbAgent.executeQuery(sql);

        return list;
    }

    @Override
    public List calendarForDayReport(String stuffid, String date) throws SQLException {
        String sql = "select * from( " +
                "                select date_format(a.day_date,'%Y-%m-%d') as day_date,b.stuffid,c.dayreportid ,  " +
                "                case when a.state=0 then  " +
                "                         case when c.reportstate=0 or  c.reportstate=2 then 'jbtb'  when c.reportstate=1 or  c.reportstate=3 then 'jbbb' END  " +
                "                      when a.state=1 THEN  " +
                "                         case when c.reportstate=0 or  c.reportstate=2 then 'tb'  when c.reportstate=1 or  c.reportstate=3 then 'bb' END  " +
                "                        else 'wt'  " +
                "                    end as zt  " +
                "                from `day` a  " +
                "                cross join stuff b  " +
                "                left join dailyreport c on a.day_date=c.reportdate and b.stuffid=c.stuffid  " +
                " where b.stuffid=" + stuffid + " and DATE_FORMAT(day_date,'%Y-%m') ='" + date + "'" +
                "                )a order by day_date";
        return dbAgent.executeQuery(sql);
    }
}
