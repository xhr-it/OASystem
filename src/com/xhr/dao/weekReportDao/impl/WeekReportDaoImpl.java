package com.xhr.dao.weekReportDao.impl;

import com.xhr.dao.weekReportDao.WeekReportDao;
import com.xhr.entity.PageEntity;
import com.xhr.util.BaseUtil;
import com.xhr.util.DBAgent;
import com.xhr.util.PageUtil;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WeekReportDaoImpl implements WeekReportDao {
    DBAgent dbAgent = new DBAgent();
    @Override
    public PageEntity selectAudit(PageEntity page, String stuffid) throws Exception {
        String sql= "select * from(SELECT reportid,title,content,DATE_FORMAT(reportdate,'%Y-%m-%d') AS reportdate," +
                "            DATE_FORMAT(submitdate,'%Y-%m-%d %H:%i:%s') as submitdate,createstuffname," +
                "(CASE  writestate WHEN '0' THEN '草稿' WHEN '1' THEN '已提交' WHEN '2' THEN '已通过' WHEN '3' THEN '待修正' ELSE '未填写' end )as writestate," +
                "(CASE  reportstate WHEN '0' THEN '正常填报' WHEN '1' THEN '正常补报' WHEN '2' THEN '异常填报' WHEN '3' THEN '异常补报' ELSE '未填写' end )as reportstate "+
                "             FROM weekreport where writestate='1' " +
                "              and stuffid IN( " +
                "             SELECT stuffid FROM stuff where tab_stuffid='"+stuffid+"' and stuffid!='"+stuffid+"')ORDER BY reportdate)a";
        return PageUtil.selectByPage(sql,page);
    }

    @Override
    public PageEntity selectWeekReport(PageEntity page, String stuffid) throws Exception {
        String sql= "select * from(SELECT reportid,title,content,DATE_FORMAT(reportdate,'%Y-%m-%d') AS reportdate," +
                "            DATE_FORMAT(submitdate,'%Y-%m-%d %H:%i:%s') as submitdate,createstuffname," +
                "(CASE  writestate WHEN '0' THEN '草稿' WHEN '1' THEN '已提交' WHEN '2' THEN '已通过' WHEN '3' THEN '待修正' ELSE '未填写' end )as writestate," +
                "(CASE  reportstate WHEN '0' THEN '正常填报' WHEN '1' THEN '正常补报' WHEN '2' THEN '异常填报' WHEN '3' THEN '异常补报' ELSE '未填写' end )as reportstate "+
                "             FROM weekreport where  " +
                "               stuffid IN( " +
                "             SELECT stuffid FROM stuff where tab_stuffid='"+stuffid+"' or stuffid='"+stuffid+"')ORDER BY stuffid)a";
        return PageUtil.selectByPage(sql,page);
    }

    @Override
    public List<Map> selectForTab(Map map) throws SQLException {
        String begin = (String) map.get("begin");
        String now = (String)map.get("nowdate");

        String beginDate=begin;
        String endDate=now;

        String a = "(select date_sub((SELECT current_date()), interval 1 MONTH))";

        String sql = "select deptid,deptname,count(zcreportid) zc,count(tbid) as tb ,count(bbid) as bb from " +
                "( " +
                "    select b.deptid,d.deptname,a.day_date,b.stuffid,c.reportid, " +
                " case when a.state=1 then c.reportid else null end as zcreportid, " +
                " case when c.reportState=0 then c.reportid else null end as tbid, " +
                " case when c.reportState=1 then c.reportid else null end as bbid " +
                " from `day` a " +
                " cross join stuff b  " +
                " left join weekreport c on a.day_date=c.reportdate and b.stuffid=c.stuffid " +
                " join dept d on b.deptid=d.deptid where 1=1 ";
        if(!BaseUtil.checkNull(beginDate)){
            sql=sql+" and a.day_date>='"+beginDate+"'";
        } else {
            sql=sql+" and a.day_date>="+a;
        }
        if(!BaseUtil.checkNull(endDate)){
            sql=sql+" and a.day_date<='"+endDate+"'";
        } else {
            sql=sql+" and a.day_date<='"+now+"'";
        }
        sql=sql+")a group by deptid";
        List<Map> list =  dbAgent.executeQuery(sql);
        return list;
    }

    @Override
    public List<Map> selectChart(Map map) throws SQLException {
        String begin = (String) map.get("begin");
        String now = (String)map.get("nowdate");

        String beginDate=begin;
        String endDate=now;

        String a = "(select date_sub((SELECT current_date()), interval 4 week))";


        String sql = "select * from(SELECT COUNT(b.reportDate) AS count,date_format(a.day_date,'%Y-%m-%d') as Date FROM `day` a\n" +
                "LEFT JOIN weekreport b ON a.day_date=b.reportDate\n" +
                "WHERE a.week_date='星期五'";

        if(!BaseUtil.checkNull(beginDate)){
            sql=sql+" and a.day_date>='"+beginDate+"'";
        } else {
            sql=sql+" and a.day_date>="+a;
        }
        if(!BaseUtil.checkNull(endDate)){
            sql=sql+" and a.day_date<='"+endDate+"'";
        } else {
            sql =sql+" and a.day_date<=now() ";
        }
        sql = sql+" GROUP BY a.day_date  ";
        sql=sql+")a";
        List<Map> list =  dbAgent.executeQuery(sql);

        return list;
    }

    @Override
    public PageEntity selectMyWeekReport(Map map, PageEntity page, String stuffid) throws Exception {
        String beginDate=(String) map.get("begindate");
        String endDate=(String) map.get("enddate");
        String sql="select * from(" +
                "select a.stuffid,a.name,date_format(c.submitdate,'%Y-%m-%d %h:%i:%s') as submitdate" +
                ",b.dayid,date_format(b.day_date,'%Y-%m-%d') as day_date," +
                "b.state,(CASE  c.writestate WHEN '0' THEN '草稿' WHEN '1' THEN '已提交' WHEN '2' THEN '已通过' WHEN '3' THEN '待修正' ELSE '未填写' end )as writestate," +
                "c.reportstate ,"+
                "c.content,c.title,c.reportid," +
                " case when  date_format(b.day_date,'%Y-%m-%d')=date_format(now(),'%Y-%m-%d') then 'z'" +
                "       when date_format(b.day_date,'%Y-%m-%d')<date_format(now(),'%Y-%m-%d') " +
                "       and datediff(now(),b.day_date)<30 then 'b'" +
                "       when date_format(b.day_date,'%Y-%m-%d')>date_format(now(),'%Y-%m-%d') then 'w' end as dateinfo" +
                " from stuff a  " +
                " join `day` b on 1=1 and b.week_date='星期五'" +
                " left join weekreport c on a.stuffid=c.stuffid and  b.day_date=c.reportdate " +
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
    public Map selectWeekById(String reportid) throws Exception {
        String sql="select * from(" +
                "select a.stuffid,a.name,date_format(c.createdate,'%Y-%m-%d %h:%i:%s') as createdate,date_format(c.submitdate,'%Y-%m-%d %h:%i:%s') as submitdate" +
                ",date_format(c.reportdate,'%Y-%m-%d') as reportdate," +
                "c.reportstate,c.content,c.title,c.writestate,c.reportid" +
                " from stuff a  " +
                " join weekreport c on a.stuffid=c.stuffid  " +
                " where 1=1 and   c.reportid="+reportid;
        sql=sql+")a";
        List<Map> list=dbAgent.executeQuery(sql);
        if (list!=null&&list.size()>0){
            return list.get(0);
        }
        return new HashMap();
    }

    @Override
    public int insertWeek(Map map) throws Exception {
        String sql=" insert into weekreport(stuffid,title,content,reportdate,writestate,reportstate,createdate,createstuffid,createstuffname)" +
                "values(?,?,?,?,'0',?,now(),?,?)";
        return dbAgent.excuteUpdate(sql,map.get("stuffid"),map.get("title"),map.get("content")
                ,BaseUtil.transObjToSqlDate(map.get("reportdate")),map.get("reportstate"),map.get("createstuffid"),map.get("createstuffname"));
    }

    @Override
    public int updateWeek(Map map) throws Exception {
        String sql="update weekreport set content=? where reportid=?";
        return dbAgent.excuteUpdate(sql,map.get("content"),map.get("reportid"));
    }

    @Override
    public int updateWriteState(String writeState, String reportid) throws Exception {
        String sql=" update weekreport set submitdate=now(),writestate=? where reportid=?";
        return dbAgent.excuteUpdate(sql,writeState,reportid);
    }

    @Override
    public int insertAudit(Map map) throws SQLException {
        String sql="INSERT into week_opinion(reportid,content,opintime,aduitstate,aduitstuffid,\n" +
                "aduitstuffname) VALUES(?,?,?,?,?,?)";
        return dbAgent.excuteUpdate(sql,map.get("reportid"),map.get("content"),map.get("opintime")
                ,map.get("aduitstate"),map.get("aduitstuffid"),map.get("aduitstuffname"));
    }

    @Override
    public List<Map> selectAuditByReport(String reportid) throws Exception {
        String sql= "SELECT content,date_format(opintime,'%Y-%m-%d' ) as opintime,(CASE aduitstate WHEN '0' THEN '未通过'WHEN '1' THEN '已通过' END)as aduitstate, " +
                " aduitstuffname FROM week_opinion where reportid= " +reportid;
        sql=sql+" ORDER BY opinionid DESC   ";
        List<Map> list=dbAgent.executeQuery(sql);

        return list;
    }
}
