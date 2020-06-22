package com.xhr.dao.projectDao;

import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * @author xhr
 * @date 2020/3/26
 *  项目Dao接口
**/
public interface ProjectDao {

    /**
     * 根据部门id（从部门树获取）查询该部门的项目
     * @param query
     * @param page
     * @param deptid
     * @return
     * @throws SQLException
     */
    PageEntity selectProjectByDept(Map query , PageEntity page , String deptid) throws SQLException;

    /**
     * 根据部门id和员工id查询部门和部门下的项目（项目树）
     * @param deptid
     * @param stuffid
     * @return
     * @throws Exception
     */
    List<Map> selectProjectByDeptAndStuff(String deptid, String stuffid) throws Exception;

    /**
     * 项目统计
     * @param map
     * @param pageEntity
     * @return
     * @throws Exception
     */
    PageEntity selectAllProject(Map map,PageEntity pageEntity) throws Exception;

    /**
     * 项目统计-折线图
     * @param map
     * @return
     * @throws Exception
     */
    List<Map> selectChart(Map map) throws Exception;

    /**
     * 新增项目-查找项目领取人
     * @param deptid
     * @return
     * @throws Exception
     */
    List<Map> selectStuffNameForProject(String deptid) throws Exception;

    /**
     * 新增项目-项目表
     * @param map
     * @return
     * @throws SQLException
     */
    int insertProject(Map map) throws SQLException;

    /**
     * 新增项目-项目部门中间表
     * @param key
     * @param deptid
     * @return
     * @throws Exception
     */
    int insertProjectDept(int key,String deptid) throws Exception;
}
