package com.xhr.dao.baseInfoDao.impl;

import com.xhr.dao.baseInfoDao.AccountDao;
import com.xhr.entity.PageEntity;
import com.xhr.util.BaseUtil;
import com.xhr.util.DBAgent;
import com.xhr.util.PageUtil;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AccountDaoImpl implements AccountDao {
    DBAgent dbAgent = new DBAgent();

    /**
     * 根据用户名密码登录
     * @param username
     * @param password
     * @return
     * @throws SQLException
     */
    @Override
    public Map login(String username, String password) throws SQLException {
        String sql="select a.accountid,a.username,b.stuffid,b.`name` from  account a   " +
                "join stuff b on a.accountid=b.accountid  " +
                "where a.username=? and a.`password`=? ";
        List<Map> mapList=dbAgent.executeQuery(sql,username,password);
        if(mapList!=null && mapList.size()>0){
            return mapList.get(0);
        }else{
            return null;
        }
    }

    @Override
    public int updatePassword(Map map) throws SQLException {
        String sql="UPDATE account SET PASSWORD=? WHERE username=? ";
        return dbAgent.excuteUpdate(sql,map.get("password"),map.get("username"));
    }

    /**
     * 根据当前登陆人查询他具备的所有权限
     * @param accountid
     * @return
     * @throws SQLException
     */
    @Override
    public List<Map> queryFunForAcc(String accountid) throws SQLException {
        StringBuffer sql=new StringBuffer();
        sql.append("select DISTINCT d.functionid,d.functionname,d.url ");
        sql.append("from account a ");
        sql.append("join actor_account b on a.accountid=b.accountid ");
        sql.append("join actor_function c on b.actorid=c.actorid ");
        sql.append("join `function` d on c.functionid=d.functionid ");
        sql.append("where a.accountid=? and d.tab_functionid = -1");
        List<Map> mapList = dbAgent.executeQuery(sql.toString(), accountid);
        return mapList;
    }

    /**
     * 根据父权限找子权限
     * @param accountid
     * @return
     * @throws SQLException
     */
    @Override
    public List<Map> queryFunForFunctionId(String accountid, String fatherId)throws SQLException {
        StringBuffer sql=new StringBuffer();
        sql.append("select DISTINCT d.functionid,d.functionname,d.url ");
        sql.append("from account a ");
        sql.append("join actor_account b on a.accountid=b.accountid ");
        sql.append("join actor_function c on b.actorid=c.actorid ");
        sql.append("join `function` d on c.functionid=d.functionid ");
        sql.append("where a.accountid=? and d.tab_functionid="+fatherId);
        List<Map> mapList=dbAgent.executeQuery(sql.toString(),accountid);
        return mapList;
    }

    @Override
    public PageEntity selectAllAccount(Map map, PageEntity page) throws SQLException {
        StringBuffer sql=new StringBuffer("SELECT a.accountid,b.name,a.username,a.`password`,a.accountstate FROM account a \n" +
                "JOIN stuff b ON a.stuffid=b.stuffid WHERE 1=1 ");
        //模糊查询
        if (map!=null){
            if (map.get("username")!=null&&!map.get("username").equals("")){
                sql.append("AND a.username LIKE '%"+map.get("username")+"%' ");
            }
            if (map.get("name")!=null&&!map.get("name").equals("")){
                sql.append("AND b.name LIKE '%"+map.get("name")+"%' ");
            }
        }
        sql.append(" ORDER BY a.accountid DESC ");
        System.out.println(sql);
        //工具返回分页查询
        return PageUtil.selectByPage(sql.toString(),page);
    }

    @Override
    public List<Map> usernameUnique(String username, String accountid) throws SQLException {
        StringBuffer sql=new StringBuffer();
        sql=new StringBuffer("SELECT accountid,stuffid,username,password,accountstate FROM account " +
                "WHERE 1=1 AND username=? ");
        List<Map> list;
        if (!BaseUtil.checkNull(accountid)){
            sql.append("AND accountid!=? ");
            list=dbAgent.executeQuery(sql.toString(),username,accountid);
        }else {
            list=dbAgent.executeQuery(sql.toString(),username);
        }
        return list;
    }

    @Override
    public int addAccount(Map map) throws SQLException {
        StringBuffer sql=new StringBuffer("INSERT INTO account (stuffid,username,password,accountstate) VALUES (?,?,?,?) ");
        int i=dbAgent.insertAndGetKey(sql.toString(),map.get("stuffid"),map.get("username"),map.get("password"),map.get("accountstate"));
        return i;
    }

    @Override
    public int deleteAccount(String state, String id) throws SQLException {
        StringBuffer sql=new StringBuffer("UPDATE account SET accountstate=? WHERE accountid=? ");
        return dbAgent.excuteUpdate(sql.toString(),state,id);
    }
}
