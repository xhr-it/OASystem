package com.xhr.dao.baseInfoDao.impl;

import com.xhr.dao.baseInfoDao.ActorDao;
import com.xhr.entity.PageEntity;
import com.xhr.util.DBAgent;
import com.xhr.util.PageUtil;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class ActorDaoImpl implements ActorDao {
    DBAgent dbAgent=new DBAgent();
    @Override
    public PageEntity selectAllActor(Map map, PageEntity page) throws SQLException {
        StringBuffer sql=new StringBuffer("SELECT actorid,actorname,actordesc,actorstate FROM actor " +
                "WHERE 1=1 ");
        //模糊查询
        if (map!=null){
            if (map.get("actorname")!=null&&!map.get("actorname").equals("")){
                sql.append("AND actorname LIKE '%"+map.get("actorname")+"%' ");
            }
            if (map.get("actordesc")!=null&&!map.get("actordesc").equals("")){
                sql.append("AND actordesc LIKE '%"+map.get("actordesc")+"%' ");
            }
        }
        sql.append(" GROUP BY actorid DESC ");
        //工具返回分页查询
        return PageUtil.selectByPage(sql.toString(),page);
    }

    /**
     * 查询所有的功能，如果针对这个角色已经存在，则添加一列为true 否则为false
     * @param actorid
     * @return
     * @throws SQLException
     */
    @Override
    public List<Map> selectFunctionByActorID(String actorid) throws SQLException {
        String sql="select * from(" +
                "   select a.functionname as menuname , a.functionid as id,a.tab_functionid as parentid, " +
                "   case when b.functionid is not null then true else false end as checked " +
                "   from `function` a " +
                "   left join( " +
                "       select a.functionid " +
                "       from actor_function a " +
                "       join `function` b on a.functionid=b.functionid " +
                "        where a.actorid=? " +
                "   )b on a.functionid=b.functionid" +
                ")a";
        return dbAgent.executeQuery(sql,actorid);
    }

    @Override
    public List<Map> selectActorName() throws SQLException {
        StringBuffer sql=new StringBuffer("SELECT actorid,actorname FROM actor WHERE actorstate=0 ");
        return dbAgent.executeQuery(sql.toString());
    }

    @Override
    public List<Map> selectActorByAccount(String accountid) throws SQLException {
        StringBuffer sql=new StringBuffer("SELECT actorid FROM actor_account WHERE accountid=? ");
        return dbAgent.executeQuery(sql.toString(),accountid);
    }

    @Override
    public int deleteActorByAccount(String accountid) throws SQLException {
        StringBuffer sql=new StringBuffer("DELETE FROM actor_account WHERE accountid=? ");
        return dbAgent.excuteUpdate(sql.toString(),accountid);
    }

    @Override
    public int insertActorByAccount(String accountid, String actorid) throws SQLException {
        StringBuffer sql=new StringBuffer("INSERT INTO actor_account (accountid,actorid) " +
                "VALUES(?,?)");
        return dbAgent.excuteUpdate(sql.toString(),accountid,actorid);
    }

    @Override
    public List<Map> actorNameUnique(String username, String id) throws SQLException {
        StringBuffer sql=new StringBuffer("SELECT * FROM actor " +
                "WHERE 1=1 AND actorname=? ");
        return dbAgent.executeQuery(sql.toString(),username);
    }

    @Override
    public int addActor(Map map) throws SQLException {
        StringBuffer sql=new StringBuffer("INSERT INTO actor (actorname,actordesc,actorstate) " +
                "VALUES (?,?,?) ");
        return dbAgent.excuteUpdate(sql.toString(),map.get("actorname"),map.get("actordesc"),map.get("actorstate"));
    }

    @Override
    public int deleteActor(String state, String id) throws SQLException {
        StringBuffer sql=new StringBuffer("UPDATE actor SET actorstate=? WHERE actorid=? ");
        return dbAgent.excuteUpdate(sql.toString(),state,id);
    }
}
