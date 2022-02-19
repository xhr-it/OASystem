package com.xhr.service.taskService;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface TaskService {
    /**
     * 查询已提交任务（进行审核）
     * @param resolvePeo 任务分配人
     * @param map
     * @param pageEntity
     * @return
     * @throws Exception
     */
    PageEntity selectTaskAudit(String resolvePeo, Map map, PageEntity pageEntity)throws Exception;

    /**
     * 查询我的任务
     * @param stuffid
     * @param map
     * @param pageEntity
     * @return
     * @throws Exception
     */
    PageEntity selectMyTask(String stuffid,Map map,PageEntity pageEntity)throws Exception;

    /**
     * 根据项目id查询任务
     * @param projectid
     * @param map
     * @param pageEntity
     * @return
     * @throws SQLException
     */
    PageEntity selectTaskByProjectId(String projectid,Map  map, PageEntity pageEntity) throws SQLException;

    /**
     * 根据父任务id查找子任务
     * @param fatherid
     * @return
     * @throws SQLException
     */
    List<Map> selectTaskByFatherId(String fatherid) throws SQLException;

    /**
     * 根据项目id查询员工-任务负责人
     * @param projectid
     * @return
     * @throws Exception
     */
    List<Map> selectStuffByProjectId(String projectid) throws Exception;

    /**
     * 根据父任务id查找所有子任务时间 最晚的时间默认是新增子任务的时间
     * @param taskid
     * @return
     * @throws Exception
     */
    List<Map> selectTab_taskTime(String taskid) throws Exception;

    /**
     * 新增子任务
     * @param map
     * @return
     * @throws Exception
     */
    Message insertSonTask(Map map) throws Exception;

    /**
     * 领取任务
     * @param map
     * @return
     * @throws Exception
     */
    Message getTask(Map map) throws Exception;

    /**
     * 提交任务
     * @param map
     * @return
     * @throws Exception
     */
    Message submitTask(Map map) throws Exception;

    /**
     * 根据任务id查找任务意见
     * @param taskid
     * @return
     * @throws Exception
     */
    List<Map> selectTaskOption(String taskid) throws Exception;

    /**
     * 审核任务-查看任务信息
     * @param taskid
     * @return
     * @throws Exception
     */
    List<Map> selectTaskById(String taskid) throws Exception;

    /**
     * 新增意见并修改任务状态变成已审核
     * @param map
     * @return
     * @throws Exception
     */
    Message insertOption(Map map) throws Exception;

    /**
     * 新增父任务-根据项目id查找项目时间即是父任务开始时间
     * @param projectid
     * @return
     * @throws Exception
     */
    List<Map> selectProTime(String projectid) throws Exception;

    /**
     * 新增父任务
     * @param map
     * @return
     * @throws SQLException
     */
    Message insertFatherTask(Map map) throws SQLException;
}
