package com.xhr.dao.baseInfoDao.impl;

import com.xhr.dao.baseInfoDao.StuffDao;
import com.xhr.entity.PageEntity;
import com.xhr.util.DBAgent;
import com.xhr.util.PageUtil;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StuffDaoImpl implements StuffDao {
    DBAgent dbAgent = new DBAgent();
    @Override
    public PageEntity selectStuff(Map query, PageEntity page, String id) throws Exception {
        StringBuffer sql=new StringBuffer("select * from(" +
                "SELECT a.stuffid,a.tab_stuffid,a.dist,a.positionid,a.accountid,a.deptid,a.name,a.sex,a.age,a.addr,a.idcard,a.phone,a.email,a.stuffstate,date_format(a.time,'%Y-%m-%d') as time,GROUP_CONCAT(c.actorname) AS actorname,d.username FROM stuff a " +
                "LEFT JOIN actor_account b ON a.accountid=b.accountid " +
                "LEFT JOIN actor c ON b.actorid=c.actorid " +
                "LEFT JOIN account d ON d.accountid=a.accountid ");
        if (id!=null&&!id.equals("")&&!id.equals("null")){
            sql.append("WHERE a.deptid="+id);
        }else {
            sql.append("WHERE 1=1 ");
        }
        if (query!=null){
            if (query.get("stuffname")!=null&&!query.get("stuffname").equals("")&&!query.get("stuffname").equals("null")){
                sql.append(" and a.name like '%"+query.get("stuffname")+"%'");
            }
            if (query.get("phone")!=null&&!query.get("phone").equals("")&&!query.get("phone").equals("null")){
                sql.append(" and a.phone like '%"+query.get("phone")+"%'");
            }
            if (query.get("idcard")!=null&&!query.get("idcard").equals("")&&!query.get("idcard").equals("null")){
                sql.append(" and a.idcard like '%"+query.get("idcard")+"%'");
            }
            if (query.get("address")!=null&&!query.get("address").equals("")&&!query.get("address").equals("null")){
                sql.append(" and a.addr like '%"+query.get("address")+"%'");
            }
        }
        sql.append(" GROUP BY stuffid ORDER BY a.stuffid DESC )a ");
        return PageUtil.selectByPage(sql.toString(),page);
    }

    @Override
    public List<Map> selectDeptTree() throws SQLException {
        String sql="SELECT * FROM( " +
                " SELECT deptid AS id,tab_deptid AS parentid,deptname AS menuname FROM dept " +
                ") a ";
        return dbAgent.executeQuery(sql);
    }

    @Override
    public List<Map> selectCode(String type, String parent) throws Exception {
        String sql;
        if (parent==null||parent.equals("")){
            sql="SELECT * FROM code WHERE code_type=? AND code_parent is NULL ";
        }else{
            sql="SELECT * FROM code WHERE code_type=? AND code_parent="+parent;
        }
        return dbAgent.executeQuery(sql,type);
    }

    @Override
    public List<Map> selectLeader(String deptid) throws Exception {
        String sql = "select a.stuffid,a.name from stuff a where a.deptid=" + deptid +
                " union " +
                " select a.stuffid,a.name from stuff a where a.deptid=( " +
                "   select b.tab_deptid from dept b where b.deptid=" + deptid +
                " ) ";
        return dbAgent.executeQuery(sql);
    }

    @Override
    public int insertStuff(Map map) throws Exception {
        String sql="insert into stuff (positionid,deptid,name,sex,age,addr,idcard,phone," +
                "stuffstate,time,email,dist,tab_stuffid ) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        return dbAgent.excuteUpdate(sql,map.get("positionid"),map.get("deptid"),map.get("name")
                ,map.get("sex"),map.get("age"),map.get("addr"),map.get("idcard"),map.get("phone"),map.get("stuffstate"),map.get("time"),map.get("email"),map.get("dist"),map.get("tab_stuffid"));
    }

    @Override
    public List<Map> selectStuffByIdCard(String idcard, String stuffid) throws Exception {
        String sql="select * from stuff where idcard=?";
        if (stuffid!=null&&!stuffid.equals("")){
            sql=sql+" and stuffid!="+stuffid;
        }
        List list=dbAgent.executeQuery(sql,idcard);
        return list;
    }

    @Override
    public int deleteStuff(String state, String id) throws Exception {
        String sql="UPDATE stuff SET stuffstate=? WHERE stuffid=? ";
        return dbAgent.excuteUpdate(sql,state,id);
    }

    @Override
    public Map selectStuffById(String stuffid) throws Exception {
        String sql="select stuffid,positionid,accountid,deptid,name,sex,age,addr, " +
                "idcard,phone,email,stuffstate,date_format(time,'%Y-%m-%d') as time,tab_stuffid,dist " +
                "from stuff where stuffid=? ";
        List<Map> list=dbAgent.executeQuery(sql,stuffid);
        if (list!=null&&list.size()>0){
            return list.get(0);
        }
        return new HashMap();
    }

    @Override
    public int updateStuff(Map map) throws Exception {
        if (map.get("accountid")!=null&&!map.get("accountid").equals("")&&!map.get("accountid").equals("null")){
            String sql="UPDATE stuff SET positionid=?,accountid=?,deptid=?,name=?,sex=?,age=?,addr=?," +
                    "idcard=?,phone=?,email=?,stuffstate=?,time=?,tab_stuffid=?,dist=? WHERE stuffid=? ";
            return dbAgent.excuteUpdate(sql,map.get("positionid"),map.get("accountid"),map.get("deptid"),map.get("name"),map.get("sex"),map.get("age"),map.get("addr"),
                    map.get("idcard"),map.get("phone"),map.get("email"),map.get("stuffstate"),map.get("time"),map.get("tab_stuffid"),map.get("dist"),map.get("stuffid"));
        }else {
            String sql="UPDATE stuff SET positionid=?,deptid=?,name=?,sex=?,age=?,addr=?," +
                    "idcard=?,phone=?,email=?,stuffstate=?,time=?,tab_stuffid=?,dist=? WHERE stuffid=? ";
            return dbAgent.excuteUpdate(sql,map.get("positionid"),map.get("deptid"),map.get("name"),map.get("sex"),map.get("age"),map.get("addr"),
                    map.get("idcard"),map.get("phone"),map.get("email"),map.get("stuffstate"),map.get("time"),map.get("tab_stuffid"),map.get("dist"),map.get("stuffid"));
        }
    }
}
