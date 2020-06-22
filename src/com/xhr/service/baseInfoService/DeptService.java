package com.xhr.service.baseInfoService;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface DeptService {
    /**
     * 查询所有部门
     * @param query
     * @param page
     * @param id
     * @return
     * @throws Exception
     */
    PageEntity selectAllDept(Map query, PageEntity page, String id) throws Exception;

    /**
     * 根据部门父id查找部门
     * @param deptid
     * @return
     * @throws SQLException
     */
    List selectDeptByFatherId(String deptid) throws Exception;

    /**
     * 查询部门（下拉框）
     * @return
     * @throws Exception
     */
    List<Map> selectDeptName() throws Exception;

    /**
     * 部门唯一性校验
     * @param name
     * @param id
     * @return
     * @throws Exception
     */
    Message deptUnique(String name, String id) throws Exception;

    /**
     * 新增部门
     * @param map
     * @return
     * @throws Exception
     */
    Message addDept(Map map) throws Exception;

    /**
     * 修改部门-先根据部门id查询部门
     * @param deptid
     * @return
     * @throws Exception
     */
    Map selectDeptById(String deptid) throws Exception;

    /**
     * 更新部门
     * @param map
     * @return
     * @throws Exception
     */
    Message updateDept(Map map) throws Exception;

    /**
     * 删除部门
     * @param state
     * @param id
     * @return
     * @throws Exception
     */
    Message deleteDept(String state, String id) throws Exception;
}
