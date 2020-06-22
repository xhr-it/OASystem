package com.xhr.service.projectService.impl;

import com.xhr.dao.baseInfoDao.DeptDao;
import com.xhr.dao.baseInfoDao.impl.DeptDaoImpl;
import com.xhr.dao.projectDao.ProjectDao;
import com.xhr.dao.projectDao.impl.ProjectDaoImpl;
import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.projectService.ProjectService;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class ProjectServiceImpl implements ProjectService {
    ProjectDao projectDao = new ProjectDaoImpl();
    DeptDao deptDao = new DeptDaoImpl();

    @Override
    public PageEntity selectProjectByDept(Map query, PageEntity page, String deptid) throws SQLException {
        return projectDao.selectProjectByDept(query,page,deptid);
    }

    @Override
    public List<Map> selectDeptAndProject(String stuffid, String deptid) throws Exception {
        List<Map> list =deptDao.selectDeptById(deptid);
        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Map map = list.get(i);
                String id = map.get("deptid").toString();
                List sonList = this.selectDeptAndProject(stuffid,id);
                if (sonList == null || sonList.size() == 0) {
                    sonList = projectDao.selectProjectByDeptAndStuff(id,stuffid);
                }
                map.put("children", sonList);
            }
        }
        return list;
    }

    @Override
    public PageEntity selectAllProject(Map map, PageEntity pageEntity) throws Exception {
        return projectDao.selectAllProject(map,pageEntity);
    }

    @Override
    public List<Map> selectChart(Map map) throws Exception {
        return projectDao.selectChart(map);
    }

    @Override
    public List<Map> selectStuffNameForProject(String deptid) throws Exception {
        return projectDao.selectStuffNameForProject(deptid);
    }

    @Override
    public Message insertProject(Map map) throws Exception {
        int key=projectDao.insertProject(map);
        String deptid=map.get("deptid").toString();
        int i=projectDao.insertProjectDept(key,deptid);
        if (key>0&&i>0){
            return new Message(true,"新增成功");
        }
        return new Message(false,"新增失败");
    }
}
