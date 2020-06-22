package com.xhr.service.baseInfoService;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * @author xhr
 * @date 2020/3/18
 *  角色Service接口
**/
public interface ActorService {
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
     * 根据账户id查询原本的角色-分配角色
     * @param accountid
     * @return
     * @throws SQLException
     */
    List<Map> selectActorByAccount(String accountid) throws SQLException;

    /**
     * 分配角色-根据账户id删除原有角色,再给该账户分配新角色
     * @param accountid
     * @param array
     * @return
     * @throws SQLException
     */
    Message insertActorByAccount(String accountid, String array) throws SQLException;

    /**
     * 角色名唯一性校验
     * @param username
     * @param id
     * @return
     * @throws SQLException
     */
    Message actorNameUnique(String username,String id) throws SQLException;

    /**
     * 新增角色
     * @param map
     * @return
     * @throws SQLException
     */
    Message addActor(Map map) throws SQLException;

    /**
     * 删除角色
     * @param state
     * @param id
     * @return
     * @throws SQLException
     */
    Message deleteActor(String state,String id) throws SQLException;
}
