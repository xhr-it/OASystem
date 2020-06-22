package com.xhr.service.baseInfoService;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface FunctionService {
    /**
     * 查询所有权限
     * @param map
     * @param page
     * @param id
     * @return
     * @throws SecurityException
     * @throws SQLException
     */
    PageEntity selectAllFunction(Map map, PageEntity page, String id) throws SecurityException, SQLException;

    /**
     * 权限树
     * @return
     * @throws SQLException
     */
    List<Map> selectFunctionTree() throws SQLException;

    /**
     * 保存权限树
     * @param tree
     * @param actorid
     * @return
     * @throws SQLException
     */
    Message saveFunctionTree(String tree, String actorid) throws SQLException;

    /**
     * 新增权限-查找父权限名
     * @return
     * @throws SQLException
     */
    List<Map> selectFunctionName() throws SQLException;

    /**
     * 权限名唯一性校验
     * @param name
     * @param id
     * @return
     * @throws SQLException
     */
    Message functionUnique(String name, String id) throws SQLException;

    /**
     * 增加功能
     * @param map
     * @return
     * @throws SQLException
     */
    Message addFunction(Map map) throws SQLException;

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
    Message updateFunction(Map map) throws SQLException;

    /**
     * 删除功能
     * @param state
     * @param id
     * @return
     * @throws SQLException
     */
    Message deleteFunction(String state,String id) throws SQLException;
}
