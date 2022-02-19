package com.xhr.service.baseInfoService;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface StuffService {
    /**
     * 查询所有员工
     * @param query
     * @param page
     * @param id
     * @return
     * @throws Exception
     */
    PageEntity selectStuff(Map query, PageEntity page, String id) throws Exception;

    /**
     * 查询部门树
     * @return
     * @throws SQLException
     */
    List<Map> selectDeptTree() throws SQLException;

    /**
     * 从码表中查询下拉框的数据
     * @param type
     * @param parent
     * @return
     * @throws Exception
     */
    List<Map> selectCode(String type,String parent) throws Exception;

    /**
     * 查询领导-下拉框
     * @param deptid
     * @return
     * @throws Exception
     */
    List<Map> selectLeader(String deptid) throws Exception;

    /**
     * 新增员工
     * @param map
     * @return
     * @throws Exception
     */
    Message insertStuff(Map map) throws Exception;

    /**
     * 身份证唯一性校验
     * @param idcard
     * @param stuffid
     * @return
     * @throws Exception
     */
    Message selectStuffByIdCard(String idcard, String stuffid) throws Exception;

    /**
     * 修改员工状态
     * @param state
     * @param id
     * @return
     * @throws Exception
     */
    Message deleteStuff(String state,String id) throws Exception;

    /**
     * 根据员工编号查询员工（修改前提）
     * @param stuffid
     * @return
     * @throws Exception
     */
    Map selectStuffById(String stuffid) throws Exception;

    /**
     * 修改员工
     * @param map
     * @return
     * @throws Exception
     */
    Message updateStuff(Map map) throws Exception;
}
