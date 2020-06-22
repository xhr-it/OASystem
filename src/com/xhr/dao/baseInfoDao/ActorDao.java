package com.xhr.dao.baseInfoDao;

import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * @author xhr
 * @date 2020/3/18
 *  角色Dao接口
**/
public interface ActorDao {
    /**
     * 查找所有角色
     * @return
     * @throws SQLException
     */
    public PageEntity selectAllActor(Map map, PageEntity page) throws SQLException;

    /**
     * 查询所有的功能，如果针对这个角色已经存在，则添加一列为true 否则为false
     * @param actorid
     * @return
     * @throws SQLException
     */
    public List<Map> selectFunctionByActorID(String actorid) throws SQLException;

    /**
     * 分配角色-查询
     * @return
     * @throws SQLException
     */
    List<Map> selectActorName() throws SQLException;

    /**
     * 分配角色-根据账户id查询原本的角色
     * @param accountid
     * @return
     * @throws SQLException
     */
    List<Map> selectActorByAccount(String accountid) throws SQLException;

    /**
     * 分配角色-根据账户id删除原有角色
     * @param accountid
     * @return
     * @throws SQLException
     */
    int deleteActorByAccount(String accountid) throws SQLException;

    /**
     * 分配角色-给相应账户分配角色
     * @param accountid
     * @param actorid
     * @return
     * @throws SQLException
     */
    int insertActorByAccount(String accountid, String actorid) throws SQLException;

    /**
     * 角色名唯一性校验
     * @param username
     * @param id
     * @return
     * @throws SQLException
     */
    List<Map> actorNameUnique(String username,String id) throws SQLException;

    /**
     * 新增角色
     * @param map
     * @return
     * @throws SQLException
     */
    int addActor(Map map) throws SQLException;

    /**
     * 删除角色
     * @param state
     * @param id
     * @return
     * @throws SQLException
     */
    int deleteActor(String state,String id) throws SQLException;
}
