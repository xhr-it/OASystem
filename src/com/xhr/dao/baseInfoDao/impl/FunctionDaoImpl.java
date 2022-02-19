package com.xhr.dao.baseInfoDao.impl;

import com.xhr.dao.baseInfoDao.FunctionDao;
import com.xhr.entity.PageEntity;
import com.xhr.util.DBAgent;
import com.xhr.util.PageUtil;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FunctionDaoImpl implements FunctionDao {
    DBAgent dbAgent = new DBAgent();
    @Override
    public PageEntity selectAllFunction(Map map, PageEntity page, String id) throws SecurityException, SQLException {
        StringBuffer sql=new StringBuffer("select * from (SELECT a.functionid,a.functionname,a.url,a.functionidstate,a.tab_functionid,b.functionname AS tab_functionname FROM function a " +
                "LEFT JOIN function b ON a.tab_functionid=b.functionid ");
        if (id!=null&&!id.equals("")&&!id.equals("null")){
            sql.append("WHERE a.tab_functionid="+id);
        }else {
            sql.append("WHERE a.tab_functionid =-1");
        }
        //模糊查询
        if (map!=null){
            if (map.get("functionname")!=null&&!map.get("functionname").equals("")){
                sql.append(" AND a.functionname LIKE '%"+map.get("functionname")+"%' ");
            }
        }
        sql.append(" ORDER BY a.functionid desc ) b  ");
        System.out.println(sql.toString()+"function");
        //工具返回分页查询
        return PageUtil.selectByPage(sql.toString(),page);
    }

    @Override
    public List<Map> selectFunctionTree() throws SQLException {
        String sql="SELECT * FROM ( " +
                " SELECT functionid AS id,functionname AS menuname, " +
                " tab_functionid AS parentid FROM function " +
                ") a";
        return dbAgent.executeQuery(sql);
    }

    @Override
    public int deleteFunctionForActor(String id) throws SQLException {
        String sql="DELETE FROM actor_function WHERE actorid=? ";
        return dbAgent.excuteUpdate(sql,id);
    }

    @Override
    public int insertFunctionForActor(int functionid, String actorid) throws SQLException {
        String sql="INSERT INTO actor_function (functionid,actorid) " +
                "VALUES(?,?) ";
        return dbAgent.excuteUpdate(sql,functionid,actorid);
    }

    @Override
    public List<Map> selectFunctionName() throws SQLException {
        String sql="SELECT functionid,functionname FROM function WHERE tab_functionid=-1 AND FUNCTIONidstate=0 ";
        return dbAgent.executeQuery(sql);
    }

    @Override
    public List<Map> functionUnique(String username, String id) throws SQLException {
        StringBuffer sql=new StringBuffer("SELECT functionid,tab_functionid,functionname,url,functionidstate FROM function " +
                "WHERE 1=1 AND functionname=? ");
        List<Map> list;
        if (id!=null||!id.equals("")||!id.equals("null")){
            sql.append("AND functionid!=? ");
            list=dbAgent.executeQuery(sql.toString(),username,id);
        }else {
            list=dbAgent.executeQuery(sql.toString(),username);
        }
        return list;
    }

    @Override
    public int addFunction(Map map) throws SQLException {
        String sql;
        int i;
        if (map.get("tab_functionid")==null||map.get("tab_functionid").equals("")||map.get("tab_functionid").equals("null")){
            sql=("INSERT INTO function (functionname,url,functionidstate) " +
                    "VALUES(?,?,?) ");
            i=dbAgent.excuteUpdate(sql,map.get("functionname"),map.get("url"),map.get("functionidstate"));
        }else {
            sql=("INSERT INTO function (tab_functionid,functionname,url,functionidstate) " +
                    "VALUES(?,?,?,?) ");
            i=dbAgent.excuteUpdate(sql,map.get("tab_functionid"),map.get("functionname"),map.get("url"),map.get("functionidstate"));
        }
        return i;
    }

    @Override
    public Map selectFunctionById(String id) throws SQLException {
        StringBuffer sql=new StringBuffer("SELECT functionid,tab_functionid,functionname,url,functionidstate FROM function " +
                "WHERE 1=1 AND functionid=? ");
        List<Map> list=dbAgent.executeQuery(sql.toString(),id);
        if (list!=null&&list.size()>0){
            return list.get(0);
        }else {
            return new HashMap();
        }
    }

    @Override
    public int updateFunction(Map map) throws SQLException {
        StringBuffer sql=new StringBuffer();
        int i;
        if (map.get("tab_functionid")==null||map.get("tab_functionid").equals("")||map.get("tab_functionid").equals("null")){
            sql.append("UPDATE function SET functionname=?,url=?,functionidstate=? WHERE functionid=? ");
            i=dbAgent.excuteUpdate(sql.toString(),map.get("functionname"),map.get("url"),map.get("functionidstate"),map.get("functionid"));
        }else {
            sql.append("UPDATE function SET tab_functionid=?,functionname=?,url=?,functionidstate=? WHERE functionid=? ");
            i=dbAgent.excuteUpdate(sql.toString(),map.get("tab_functionid"),map.get("functionname"),map.get("url"),map.get("functionidstate"),map.get("functionid"));
        }
        return i;
    }

    @Override
    public int deleteFunction(String state, String id) throws SQLException {
        StringBuffer sql=new StringBuffer();
        sql.append("UPDATE function SET functionidstate=? WHERE functionid=? ");
        return dbAgent.excuteUpdate(sql.toString(),state,id);
    }
}
