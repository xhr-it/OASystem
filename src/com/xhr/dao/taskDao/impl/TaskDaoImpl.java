package com.xhr.dao.taskDao.impl;

import com.xhr.dao.taskDao.TaskDao;
import com.xhr.entity.PageEntity;
import com.xhr.util.DBAgent;
import com.xhr.util.PageUtil;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class TaskDaoImpl implements TaskDao {
    DBAgent dbAgent = new DBAgent();
    @Override
    public PageEntity selectTaskAudit(String resolvePeo, Map map, PageEntity pageEntity) throws Exception {
        StringBuffer sql=new StringBuffer("SELECT * from(\n" +
                "                               select DISTINCT a.taskid,a.taskgetpeo,a.taskname,a.taskdescr,a.taskresolvepeo,c.name, \n" +
                "  DATE_FORMAT(a.taskrealyStart,'%Y-%m-%d')as realystartTime,\n" +
                "  DATE_FORMAT(a.taskenddate,'%Y-%m-%d')as realyendTime,\n" +
                "                           DATE_FORMAT(a.taskstart,'%Y-%m-%d')as begindate,\n" +
                "                           DATE_FORMAT(a.taskend,'%Y-%m-%d')as endtime,\n" +
                "                           a.projectid,a.taskstate from task a\n" +
                "               JOIN task_stuff b on a.taskgetpeo=b.stuffid\n" +
                "                JOIN stuff c on b.stuffid=c.stuffid\n" +
                "                where a.taskstate='2' and a.taskresolvepeo="+resolvePeo+" " );
        if (map!=null){
            if (map.get("taskname")!=null&&!map.get("taskname").equals("")){
                sql.append(" and taskname like '%"+map.get("taskname")+"%'");
            }
            if (map.get("taskstart")!=null&&!map.get("taskstart").equals("")){
                sql.append(" and taskstart like  '%"+map.get("taskstart")+"%'");
            }
            if (map.get("taskend")!=null&&!map.get("taskend").equals("")){
                sql.append(" and taskend like  '%"+map.get("taskend")+"%'");
            }
        }
        sql.append(")d");
        sql.append(" ORDER BY taskid ");
        pageEntity= PageUtil.selectByPage(sql.toString(),pageEntity);
        return pageEntity;
    }

    @Override
    public PageEntity selectMyTask(String stuffid, Map map, PageEntity pageEntity) throws Exception {
        StringBuffer sql=new StringBuffer("select * from(\n" +
                " SELECT * FROM(SELECT DISTINCT b.stuffid,c.opid,c.opdescr,c.auditstate,a.taskid,a.taskgetpeo,a.taskname,a.taskdescr,a.taskresolvepeo,b.name,d.projectname,\n" +
                " DATE_FORMAT(a.taskrealyStart,'%Y-%m-%d')as realystartTime,\n" +
                " DATE_FORMAT(a.taskenddate,'%Y-%m-%d')as realyendTime,\n" +
                " DATE_FORMAT(a.taskstart,'%Y-%m-%d')as begindate,\n" +
                " DATE_FORMAT(a.taskend,'%Y-%m-%d')as endtime,\n" +
                " a.projectid,a.taskstate from task a\n" +
                " JOIN stuff b ON b.stuffid = a.taskgetpeo\n" +
                " left JOIN opinionaire c ON c.taskid = a.taskid\n" +
                " join project d on a.projectid=d.projectid where 1=1\n" );
        if (map!=null){
            if (map.get("taskstart")!=null&&!map.get("taskstart").equals("")){
                sql.append(" and taskstart like  '%"+map.get("taskstart")+"%'");
            }
            if (map.get("taskend")!=null&&!map.get("taskend").equals("")){
                sql.append(" and taskend like  '%"+map.get("taskend")+"%'");
            }
        }
        sql.append(" ORDER BY c.opid DESC )e\n" +
                " WHERE taskgetpeo="+stuffid+" " );
        if (map!=null){
            if (map.get("taskname")!=null&&!map.get("taskname").equals("")){
                sql.append(" and taskname like  '%"+map.get("taskname")+"%'");
            }
        }
        sql.append("GROUP BY taskid \n" +
                ")f");

        sql.append(" ORDER BY taskid ");
        pageEntity= PageUtil.selectByPage(sql.toString(),pageEntity);
        return pageEntity;
    }

    @Override
    public PageEntity selectTaskByProjectId(String projectid, Map map, PageEntity pageEntity) throws SQLException {
        StringBuffer sql=new StringBuffer("select * from(\n" +
                "                   select  taskid,taskgetpeo,taskname,taskdescr,taskresolvepeo, \n" +
                "                   DATE_FORMAT(taskstart,'%Y-%m-%d')as begindate,  \n" +
                "                   DATE_FORMAT(taskend,'%Y-%m-%d')as endtime, \n" +
                "                   projectid,taskstate \n" +
                "                   from task\n" +
                "                   where tab_taskid is null and projectid="+projectid+"");
        if (map!=null){
            if (map.get("taskname")!=null&&!map.get("taskname").equals("")){
                sql.append(" and taskname like '%"+map.get("taskname")+"%'");
            }
            if (map.get("taskstart")!=null&&!map.get("taskstart").equals("")){
                sql.append(" and taskstart like  '%"+map.get("taskstart")+"%'");
            }
            if (map.get("taskend")!=null&&!map.get("taskend").equals("")){
                sql.append(" and taskend like  '%"+map.get("taskend")+"%'");
            }
        }
        sql.append( "     )a\n");
        pageEntity=PageUtil.selectByPage(sql.toString(),pageEntity);
        return pageEntity;
    }

    @Override
    public List<Map> selectTaskByFatherId(String fatherid) throws SQLException {
        String sql="select * from(\n" +
                "                select  taskid,taskgetpeo,taskname,taskdescr,taskresolvepeo,b.name, \n" +
                "                DATE_FORMAT(taskstart,'%Y-%m-%d')as begindate,  \n" +
                "                 DATE_FORMAT(taskend,'%Y-%m-%d')as endtime, \n" +
                "                 projectid,taskstate \n" +
                "                from task a\n" +
                "JOIN stuff b on a.taskgetpeo=b.stuffid\n" +
                "                where tab_taskid=?" +
                "               )a";
        List<Map> list=dbAgent.executeQuery(sql,fatherid);
        return list;
    }

    @Override
    public List<Map> selectStuffByProjectId(String projectid) throws Exception {
        String sql="SELECT a.stuffid,a.name from \n" +
                "stuff a\n" +
                "JOIN project_dept b on a.deptid=b.deptid\n" +
                "JOIN project c on b.projectid=c.projectid\n" +
                "where c.projectid=?";
        List<Map> list=dbAgent.executeQuery(sql,projectid);
        return list;
    }

    @Override
    public List<Map> selectTab_taskTime(String taskid) throws Exception {
        String sql="select * from(\n" +
                "select DATE_FORMAT( max(begindate),'%Y-%m-%d')as begindate from(\n" +
                "select taskstart as begindate from task where taskid=?\n" +
                "union\n" +
                "select DATE_ADD(taskstart,INTERVAL 1 day)  as begindate  from task where tab_taskid=?\n" +
                ")a )a";
        return dbAgent.executeQuery(sql,taskid,taskid);
    }

    @Override
    public int insertSonTask(Map map) throws Exception {
        String sql="insert into task (tab_taskid,projectid,taskno,taskname,taskstart,taskend,\n" +
                "  taskdescr,taskstate,taskgetpeo,taskresolvepeo)\n" +
                "     values(?,?,?,?,?,?,?,?,?,?)";
        int i=dbAgent.insertAndGetKey(sql,map.get("Fatherid"),map.get("projectid"),map.get("taskno"),map.get("taskname"),
                map.get("taskstart"),map.get("taskend"),map.get("taskdescr"),map.get("taskstate"),
                map.get("taskgetPeo"),map.get("taskresolvepeo"));
        return i;
    }

    @Override
    public int insertTask_Stuff(int taskid, String stuffid) throws Exception {
        String sql="INSERT into task_stuff (taskid,stuffid) VALUES(?,?)";
        return dbAgent.excuteUpdate(sql,taskid,stuffid);
    }

    @Override
    public int getTask(Map map) throws Exception {
        String  sql="update task set taskstate=1,taskrealyStart=? where taskid=?";
        int i=dbAgent.excuteUpdate(sql,map.get("taskrealyStart"),map.get("taskid"));
        return i;
    }

    @Override
    public int submitTask(Map map) throws Exception {
        String  sql="update task set taskstate=2,taskenddate=? where taskid=?";
        int i=dbAgent.excuteUpdate(sql,map.get("taskenddate"),map.get("taskid"));
        return i;
    }

    @Override
    public List<Map> selectTaskOption(String taskid) throws Exception {
        String sql="select opdescr,DATE_FORMAT(optime,'%Y-%m-%d')as optime,auditstate,auditpeo,b.name\n" +
                " from opinionaire a\n" +
                "JOIN stuff b on b.stuffid=a.auditpeo\n" +
                "where taskid=? ORDER BY optime Desc";
        return dbAgent.executeQuery(sql,taskid);
    }

    @Override
    public List<Map> selectTaskById(String taskid) throws Exception {
        String sql="select a.taskid,a.taskgetpeo,a.taskname,a.taskdescr,a.taskresolvepeo,b.name,\n" +
                "  DATE_FORMAT(a.taskrealyStart,'%Y-%m-%d')as realystartTime,\n" +
                "  DATE_FORMAT(a.taskenddate,'%Y-%m-%d')as realyendTime,\n" +
                "                              DATE_FORMAT(a.taskstart,'%Y-%m-%d')as begindate,\n" +
                "                                 DATE_FORMAT(a.taskend,'%Y-%m-%d')as endtime,\n" +
                "                               a.projectid,a.taskstate from task a\n" +
                "JOIN stuff b on  a.taskgetpeo=b.stuffid \n" +
                "                where taskid=?";
        List<Map> list=dbAgent.executeQuery(sql,taskid);
        return list;
    }

    @Override
    public int insertOption(Map map) throws Exception {
        String sql="insert into opinionaire (opno,auditstate,opdescr,optime,taskid,auditpeo) VALUES(?,?,?,?,?,?)";
        int i=dbAgent.excuteUpdate(sql,map.get("opno"),map.get("auditstate"),map.get("opdescr"),map.get("optime"),map.get("taskid"),map.get("auditpeo"));
        return i;
    }

    @Override
    public int updateTaskState(String taskid) throws Exception {
        String sql="update task set taskstate=3 where taskid=?";
        int i=dbAgent.excuteUpdate(sql,taskid);
        return i;
    }

    @Override
    public int updateTaskState2(String taskid) throws Exception {
        String sql="update task set taskstate=4 where taskid=?";
        int i=dbAgent.excuteUpdate(sql,taskid);
        return i;
    }

    @Override
    public List<Map> selectProTime(String projectid) throws Exception {
        String sql="SELECT DATE_FORMAT(projectstart,'%Y-%m-%d')as starttime from project where projectid=?";
        return dbAgent.executeQuery(sql,projectid);
    }

    @Override
    public int insertFatherTask(Map map) throws SQLException {
        String sql="insert into task (projectid,taskno,taskname,taskstart,taskend,\n" +
                "                taskdescr,taskstate)\n" +
                "                values(?,?,?,?,?,?,?)";
        int i=dbAgent.excuteUpdate(sql,map.get("projectid"),map.get("taskno"),map.get("taskname"),
                map.get("taskstart"),map.get("taskend"),map.get("taskdescr"),map.get("taskstate"));
        return i;
    }
}
