package com.xhr.dao.baseInfoDao.impl;

import com.xhr.dao.baseInfoDao.DeptDao;
import com.xhr.entity.PageEntity;
import com.xhr.util.DBAgent;
import com.xhr.util.PageUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptDaoImpl implements DeptDao {
    DBAgent dbAgent = new DBAgent();

    @Override
    public PageEntity selectAllDept(Map query, PageEntity page, String id) throws Exception {
        StringBuffer sql = new StringBuffer("select * from dept where 1=1 AND tab_deptid="+id);
        if (query != null&&!query.equals("")) {
            if (query.get("deptno") != null && !query.get("deptno").equals("")) {
                sql.append(" and deptno like '%" + query.get("deptno") + "%'");
            }
            if (query.get("deptname") != null && !query.get("deptname").equals("")) {
                sql.append(" and deptname like '%" + query.get("deptname") + "%'");
            }
            if (query.get("deptdescr") != null && !query.get("deptdescr").equals("")) {
                sql.append(" and deptdescr like '%" + query.get("deptdescr") + "%'");
            }
            if (query.get("deptstate") != null && !query.get("deptstate").equals("")) {
                sql.append(" and deptstate like '%" + query.get("deptstate") + "%'");
            }
        }
        sql.append(" order by deptid desc");
        return PageUtil.selectByPage(sql.toString(),page);
    }

    @Override
    public List<Map> selectDeptById(String deptid) throws Exception {
        String sql="select * from (select 'b' as type,deptname,deptid,tab_deptid," +
                "            case when tab_deptid is not null then true else false end as checked " +
                "            from dept " +
                "            where tab_deptid=?)a";
        List<Map> list=dbAgent.executeQuery(sql,deptid);
        return list;
    }

    @Override
    public List<Map> selectDeptName() throws Exception {
        String sql="SELECT deptid,deptname FROM dept WHERE deptstate=0 ";
        return dbAgent.executeQuery(sql);
    }

    @Override
    public List<Map> deptUnique(String name, String id) throws Exception {
        StringBuffer sql=new StringBuffer("SELECT * FROM dept WHERE deptname=? ");
        List list=new ArrayList();
        if (id!=null&&!id.equals("")&&!id.equals("null")){
            sql.append("AND deptid!=?");
            list=dbAgent.executeQuery(sql.toString(),name,id);
        }else {
            list=dbAgent.executeQuery(sql.toString(),name);
        }
        return list;
    }

    @Override
    public int addDept(Map map) throws Exception {
        String sql="insert into dept(tab_deptid,deptno,deptname,deptdescr,deptstate)values(?,?,?,?,?)";
        return dbAgent.excuteUpdate(sql,map.get("tab_deptid"),map.get("deptno"),map.get("deptname"),map.get("deptdescr"),map.get("deptstate"));
    }

    @Override
    public Map selectDept(String deptid) throws Exception {
        String sql="select * from dept where deptid=?";
        List<Map> list=dbAgent.executeQuery(sql,deptid);
        if (list!=null&&list.size()>0){
            return list.get(0);
        }
        return new HashMap();
    }

    @Override
    public int updateDept(Map map) throws Exception {
        String sql="update dept set deptno=?,deptname=?,deptdescr=?,deptstate=? where deptid=?";
        System.out.println(sql);
        return dbAgent.excuteUpdate(sql,map.get("deptno"),map.get("deptname"),map.get("deptdescr"),map.get("deptstate"),map.get("deptid"));
    }

    @Override
    public int deleteDept(String state, String id) throws Exception {
        StringBuffer sql=new StringBuffer("UPDATE dept SET deptstate=? WHERE deptid=? ");
        return dbAgent.excuteUpdate(sql.toString(),state,id);
    }
}
