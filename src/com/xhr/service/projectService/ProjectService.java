package com.xhr.service.projectService;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface ProjectService {
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
     * 根据部门id和员工id查询项目（项目树）
     * @param stuffid
     * @param deptid
     * @return
     * @throws Exception
     */
    List<Map> selectDeptAndProject(String stuffid, String deptid) throws Exception;

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
     * 新增项目
     * @param map
     * @return
     * @throws Exception
     */
    Message insertProject(Map map) throws Exception;
}
