package com.xhr.dao.baseInfoDao;

import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/***
 * @author xhr
 * @date 2020/3/23
 *  权限Dao接口
**/
public interface FunctionDao {
    /**
     * 查询所有权限
     * @param map
     * @param page
     * @param id
     * @return
     * @throws SecurityException
     * @throws SQLException
     */
    PageEntity selectAllFunction(Map map,PageEntity page,String id) throws SecurityException, SQLException;

    /**
     * 权限树
     * @return
     * @throws SQLException
     */
    List<Map> selectFunctionTree() throws SQLException;

    /**
     * 删除角色原有权限
     * @param id
     * @return
     * @throws SQLException
     */
    int deleteFunctionForActor(String id) throws SQLException;

    /**
     * 为角色新增权限
     * @param functionid
     * @param actorid
     * @return
     * @throws SQLException
     */
    int insertFunctionForActor(int functionid,String actorid) throws SQLException;

    /**
     * 新增权限-查找父权限名
     * @return
     * @throws SQLException
     */
    List<Map> selectFunctionName() throws SQLException;

    /**
     * 权限名唯一性校验
     * @param username
     * @param id
     * @return
     * @throws SQLException
     */
    List<Map> functionUnique(String username, String id) throws SQLException;

    /**
     * 增加功能
     * @param map
     * @return
     * @throws SQLException
     */
    int addFunction(Map map) throws SQLException;

    /**
     * 修改功能-根据id查询功能
     * @param id
     * @return
     * @throws SQLException
     */
    Map selectFunctionById(String id) throws SQLException;

    /**
     * 修改功能
     * @param map
     * @return
     * @throws SQLException
     */
    int updateFunction(Map map) throws SQLException;

    /**
     * 删除功能
     * @param state
     * @param id
     * @return
     * @throws SQLException
     */
    int deleteFunction(String state,String id) throws SQLException;
}
