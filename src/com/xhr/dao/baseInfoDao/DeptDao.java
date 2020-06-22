package com.xhr.dao.baseInfoDao;

import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * @author xhr
 * @date 2020/3/24
 *  部门Dao接口
**/
public interface DeptDao {
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
     * 根据部门id查询所在部门（项目管理-部门树）
     * @param deptid
     * @return
     * @throws Exception
     */
    List<Map> selectDeptById(String deptid) throws Exception;

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
    List<Map> deptUnique(String name, String id) throws Exception;

    /**
     * 新增部门
     * @param map
     * @return
     * @throws Exception
     */
    int addDept(Map map) throws Exception;

    /**
     * 修改部门-先根据部门id查询部门
     * @param deptid
     * @return
     * @throws Exception
     */
    Map selectDept(String deptid) throws Exception;

    /**
     * 更新部门
     * @param map
     * @return
     * @throws Exception
     */
    int updateDept(Map map) throws Exception;

    /**
     * 删除部门
     * @param state
     * @param id
     * @return
     * @throws Exception
     */
    int deleteDept(String state, String id) throws Exception;
}
