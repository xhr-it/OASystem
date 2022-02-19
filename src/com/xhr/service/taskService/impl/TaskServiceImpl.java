package com.xhr.service.taskService.impl;

import com.xhr.dao.taskDao.TaskDao;
import com.xhr.dao.taskDao.impl.TaskDaoImpl;
import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.taskService.TaskService;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class TaskServiceImpl implements TaskService {
    TaskDao taskDao = new TaskDaoImpl();
    @Override
    public PageEntity selectTaskAudit(String resolvePeo, Map map, PageEntity pageEntity) throws Exception {
        return taskDao.selectTaskAudit(resolvePeo, map, pageEntity);
    }

    @Override
    public PageEntity selectMyTask(String stuffid, Map map, PageEntity pageEntity) throws Exception {
        return taskDao.selectMyTask(stuffid,map,pageEntity);
    }

    @Override
    public PageEntity selectTaskByProjectId(String projectid, Map map, PageEntity pageEntity) throws SQLException {
        return taskDao.selectTaskByProjectId(projectid,map,pageEntity);
    }

    @Override
    public List<Map> selectTaskByFatherId(String fatherid) throws SQLException {
        return taskDao.selectTaskByFatherId(fatherid);
    }

    @Override
    public List<Map> selectStuffByProjectId(String projectid) throws Exception {
        return taskDao.selectStuffByProjectId(projectid);
    }

    @Override
    public List<Map> selectTab_taskTime(String taskid) throws Exception {
        return taskDao.selectTab_taskTime(taskid);
    }

    @Override
    public Message insertSonTask(Map map) throws Exception {
        int i1=taskDao.insertSonTask(map);
        String stuffid= (String) map.get("taskgetPeo");
        int i=taskDao.insertTask_Stuff(i1,stuffid);
        if (i1>0&&i>0){
            return new Message(true,"新增成功");
        }else {
            return new Message(false,"新增失败");
        }
    }

    @Override
    public Message getTask(Map map) throws Exception {
        int i=taskDao.getTask(map);
        if (i>0){
            return new Message(true,"领取成功");
        }
        return new Message(false,"领取失败");
    }

    @Override
    public Message submitTask(Map map) throws Exception {
        int i=taskDao.submitTask(map);
        if (i>0){
            return new Message(true,"提交成功");
        }
        return new Message(false,"提交失败");
    }

    @Override
    public List<Map> selectTaskOption(String taskid) throws Exception {
        return taskDao.selectTaskOption(taskid);
    }

    @Override
    public List<Map> selectTaskById(String taskid) throws Exception {
        return taskDao.selectTaskById(taskid);
    }

    @Override
    public Message insertOption(Map map) throws Exception {
        int i=taskDao.insertOption(map);
        int i1=0;
        String state=map.get("auditstate").toString();
        if (state.equals("1")){
            i1=taskDao.updateTaskState(map.get("taskid").toString());
        }else if (state.equals("2")){
            i1=taskDao.updateTaskState2(map.get("taskid").toString());
        }
        if (i>0&&i1>0){
            return new Message(true,"审核成功");
        }
        return new Message(false,"审核失败");
    }

    @Override
    public List<Map> selectProTime(String projectid) throws Exception {
        return taskDao.selectProTime(projectid);
    }

    @Override
    public Message insertFatherTask(Map map) throws SQLException {
        int i=taskDao.insertFatherTask(map);
        if (i>0){
            return new Message(true,"新增成功");
        }else {
            return new Message(false,"新增失败");
        }
    }
}
