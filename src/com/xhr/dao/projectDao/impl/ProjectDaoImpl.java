package com.xhr.dao.projectDao.impl;

import com.xhr.dao.projectDao.ProjectDao;
import com.xhr.entity.PageEntity;
import com.xhr.util.BaseUtil;
import com.xhr.util.DBAgent;
import com.xhr.util.PageUtil;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class ProjectDaoImpl implements ProjectDao {
    DBAgent dbAgent = new DBAgent();
    @Override
    public PageEntity selectProjectByDept(Map query, PageEntity page, String deptid) throws SQLException {
        StringBuffer sql=new StringBuffer("select a.projectid,a.projectno,a.projectname," +
                "                date_format(a.projectstart,'%Y-%m-%d') as projectstart," +
                "                date_format(a.projectent,'%Y-%m-%d') as projectent," +
                "                a.projectdescr,a.projectstate,a.projectprin,d.name from project a" +
                "                JOIN project_dept b on a.projectid=b.projectid" +
                "                JOIN dept c on b.deptid=c.deptid" +
                "                JOIN stuff d on a.projectprin=d.stuffid" +
                "                where c.deptid="+deptid+" and 1=1");
        if (query!=null){
            if (query.get("projectname")!=null&&!query.get("projectname").equals("")){
                sql.append(" and projectname like '%"+query.get("projectname")+"%'");
            }
            if (query.get("projectprin")!=null&&!query.get("projectprin").equals("")){
                sql.append(" and projectprin like '%"+query.get("projectprin")+"%'");
            }
            if (query.get("projectstart")!=null&&!query.get("projectstart").equals("")){
                sql.append(" and projectstart like  '%"+query.get("projectstart")+"%'");
            }
            if (query.get("projectent")!=null&&!query.get("projectent").equals("")){
                sql.append(" and projectent like '%"+query.get("projectent")+"%'");
            }
        }
        sql.append(" order by projectid");
        System.out.println(PageUtil.selectByPage(sql.toString(),page));
        return PageUtil.selectByPage(sql.toString(),page);
    }

    @Override
    public List<Map> selectProjectByDeptAndStuff(String deptid, String stuffid) throws Exception {
        String sql="select * from (select 'x' as type,a.projectname as deptname,a.projectid as deptid,b.deptid as tab_deptid,\n" +
                "            case when a.projectid is not null then true else false end as checked \n" +
                "            from project a\n" +
                "            JOIN project_dept b on b.projectid=a.projectid \n" +
                "            JOIN stuff c on a.projectprin=c.stuffid\n" +
                "            where b.deptid=? and c.stuffid=?)d";
        List<Map> list=dbAgent.executeQuery(sql,deptid,stuffid);
        return list;
    }

    @Override
    public PageEntity selectAllProject(Map map, PageEntity pageEntity) throws Exception {
        String begin=map.get("begin").toString();
        String end=map.get("end").toString();
        StringBuffer sql=new StringBuffer("select projectid,projectname,xiangmutianshu,sum(tianshu)as 总任务天数,\n" +
                "sum(wctaskts)as 完成任务天数,sum(jxtaskts)as 进行中任务天数,sum(wttaskts) as 有问题任务天数,\n" +
                "count(taskid) as 总任务个数,\n" +
                "count(wctask)as 完成任务个数,count(jxtask)as 进行中任务个数,count(wttask) as 有问题任务个数\n" +
                " from(\n" +
                " select a.taskid,a.taskresolvepeo,a.taskname, \n" +
                " DATEDIFF(DATE_FORMAT(a.taskend,'%Y-%m-%d'),DATE_FORMAT(a.taskstart,'%Y-%m-%d'))+1 as tianshu,\n" +
                " e.deptid as orgid,e.deptname as orgname,c.projectid,c.projectname,\n" +
                " DATEDIFF(DATE_FORMAT(c.projectent,'%Y-%m-%d'),DATE_FORMAT(c.projectstart,'%Y-%m-%d'))+1 as xiangmutianshu,\n" +
                " a.taskstate,\n" +
                " case when taskstate='2' or taskstate='3' then a.taskid else null end as wctask,\n" +
                " case when taskstate='1' then a.taskid else null end as jxtask,\n" +
                " case when taskstate='4' then a.taskid else null end as wttask,\n" +
                " case when taskstate='2' or taskstate='3' then DATEDIFF(DATE_FORMAT(a.taskend ,'%Y-%m-%d'),DATE_FORMAT(a.taskstart,'%Y-%m-%d'))+1\n" +
                " else 0 end as wctaskts,\n" +
                " case when taskstate='1' then DATEDIFF(DATE_FORMAT(a.taskend,'%Y-%m-%d'),DATE_FORMAT(a.taskstart,'%Y-%m-%d'))+1 \n" +
                " else 0 end as jxtaskts,\n" +
                " case when taskstate='4' then DATEDIFF(DATE_FORMAT(a.taskend,'%Y-%m-%d'),DATE_FORMAT(a.taskstart,'%Y-%m-%d'))+1 \n" +
                " else 0 end as wttaskts\n" +
                " from task a\n" +
                " join stuff b on a.taskresolvepeo=b.stuffid\n" +
                " join project c on a.projectid=c.projectid\n" +
                " JOIN project_dept d on c.projectid=d.projectid\n" +
                " join dept e on e.deptid=d.deptid where 1=1 \n" );

        /*if (!BaseUtil.checkNull(begin)){
            sql.append(" and taskstart>= '"+begin+"'");
        }else {
            sql.append("and taskstart>=(select date_sub((SELECT current_date()), interval 1 MONTH))");
        }
        if (!BaseUtil.checkNull(end)){
            sql.append(" and taskend<= '"+end+"'");
        }else {
            sql.append(" and taskend<=now()");
        }
        if (map.get("projectname")!=null&&!map.get("projectname").equals("")){
            sql.append(" and projectname like '%"+map.get("projectname")+"%'");
        }*/
        sql.append( ")a where 1=1 ");
        sql.append(" group by projectid,projectname,xiangmutianshu ");
        sql.append(" ORDER BY projectid ");
        return PageUtil.selectByPage(sql.toString(),pageEntity);
    }

    @Override
    public List<Map> selectChart(Map map) throws Exception {
        String begin= (String) map.get("begin");
        String end= (String) map.get("end");
        StringBuffer sql=new StringBuffer("select projectid,projectname,xiangmutianshu,sum(tianshu)as zt,\n" +
                "sum(wctaskts)as wt,sum(jxtaskts)as jt,sum(wttaskts) as yt,\n" +
                "count(taskid) as zg,\n" +
                "count(wctask)as wg,count(jxtask)as jg,count(wttask) as yg\n" +
                " from(\n" +
                " select a.taskid,a.taskresolvepeo,a.taskname, \n" +
                " DATEDIFF(DATE_FORMAT(a.taskend,'%Y-%m-%d'),DATE_FORMAT(a.taskstart,'%Y-%m-%d'))+1 as tianshu,\n" +
                " e.deptid as orgid,e.deptname as orgname,c.projectid,c.projectname,\n" +
                " DATEDIFF(DATE_FORMAT(c.projectent,'%Y-%m-%d'),DATE_FORMAT(c.projectstart,'%Y-%m-%d'))+1 as xiangmutianshu,\n" +
                " a.taskstate,\n" +
                " case when taskstate='2' or taskstate='3' then a.taskid else null end as wctask,\n" +
                " case when taskstate='1' then a.taskid else null end as jxtask,\n" +
                " case when taskstate='4' then a.taskid else null end as wttask,\n" +
                " case when taskstate='2' or taskstate='3' then DATEDIFF(DATE_FORMAT(a.taskend ,'%Y-%m-%d'),DATE_FORMAT(a.taskstart,'%Y-%m-%d'))+1\n" +
                " else 0 end as wctaskts,\n" +
                " case when taskstate='1' then DATEDIFF(DATE_FORMAT(a.taskend,'%Y-%m-%d'),DATE_FORMAT(a.taskstart,'%Y-%m-%d'))+1 \n" +
                " else 0 end as jxtaskts,\n" +
                " case when taskstate='4' then DATEDIFF(DATE_FORMAT(a.taskend,'%Y-%m-%d'),DATE_FORMAT(a.taskstart,'%Y-%m-%d'))+1 \n" +
                " else 0 end as wttaskts\n" +
                " from task a\n" +
                " join stuff b on a.taskresolvepeo=b.stuffid\n" +
                " join project c on a.projectid=c.projectid\n" +
                " JOIN project_dept d on c.projectid=d.projectid\n" +
                " join dept e on e.deptid=d.deptid where 1=1 \n" );
        /*if (map!=null){
            if (!BaseUtil.checkNull(begin)){
                sql.append(" and taskstart>= '"+begin+"'");
            }else {
                sql.append(" and taskstart>=(select date_sub((SELECT current_date()), interval 1 MONTH))");
            }
            if (!BaseUtil.checkNull(end)){
                sql.append(" and taskend<= '"+end+"'");
            }else {
                sql.append(" and taskend<= now()");
            }
        }*/
        /*if (map!=null){
            if (map.get("projectname")!=null&&!map.get("projectname").equals("")){
                sql.append(" and projectname like '%"+map.get("projectname")+"%'");
            }
        }*/
        sql.append( ")a where 1=1 ");
        sql.append(" group by projectid,projectname,xiangmutianshu ");
        List<Map> list=dbAgent.executeQuery(sql.toString());
        return list;
    }

    @Override
    public List<Map> selectStuffNameForProject(String deptid) throws Exception {
        String sql="SELECT stuffid,name FROM stuff where deptid="+deptid;
        return dbAgent.executeQuery(sql);
    }

    @Override
    public int insertProject(Map map) throws SQLException {
        String sql="insert into project(projectid,projectno,projectname,projectstart,projectent,projectdescr,projectstate,projectprin) values(?,?,?,?,?,?,1,?)";
        return  dbAgent.insertAndGetKey(sql,map.get("projectid"),map.get("projectno"),map.get("projectname"),map.get("projectstart"),map.get("projectent"),map.get("projectdescr"),map.get("projectprin"));
    }

    @Override
    public int insertProjectDept(int key, String deptid) throws Exception {
        String sql="insert into project_dept (projectid,deptid) VALUES(?,?)";
        return dbAgent.excuteUpdate(sql,key,deptid);
    }
}
