package com.xhr.service.baseInfoService.impl;

import com.xhr.dao.baseInfoDao.DeptDao;
import com.xhr.dao.baseInfoDao.impl.DeptDaoImpl;
import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.DeptService;
import com.xhr.util.DBAgent;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class DeptServiceImpl implements DeptService {
    DeptDao deptDao = new DeptDaoImpl();

    @Override
    public PageEntity selectAllDept(Map query, PageEntity page, String id) throws Exception {
        return deptDao.selectAllDept(query,page,id);
    }

    @Override
    public List selectDeptByFatherId(String deptid) throws Exception {
        //1.先查出一级部门
        List<Map> list = deptDao.selectDeptById(deptid);
        if (list != null && list.size() > 0) {
            //2.遍历查出当前部门的下属部门
            for (int i = 0; i < list.size(); i++) {
                Map map = list.get(i);
                String id = map.get("deptid").toString();
                List sonList = this.selectDeptByFatherId(id);
                if (sonList == null || sonList.size() == 0) {
                    sonList = this.selectDeptByFatherId(id);
                }
                map.put("children", sonList);
            }
        }
        return list;
    }

    @Override
    public List<Map> selectDeptName() throws Exception {
        return deptDao.selectDeptName();
    }

    @Override
    public Message deptUnique(String name, String id) throws Exception {
        List<Map> mapList = deptDao.deptUnique(name, id);
        if (mapList != null&&mapList.size()>0) {
            return new Message(false,"该部门名称不可使用");
        }else {
            return new Message(true,"可以使用");
        }
    }

    @Override
    public Message addDept(Map map) throws Exception {
        int i=deptDao.addDept(map);
        if (i>0){
            return new Message(true,"新增成功");
        }
        return new Message(false,"新增失败");
    }

    @Override
    public Map selectDeptById(String deptid) throws Exception {
        return deptDao.selectDept(deptid);
    }

    @Override
    public Message updateDept(Map map) throws Exception {
        int i=deptDao.updateDept(map);
        if (i>0){
            return new Message(true,"修改成功");
        }
        return new Message(false,"修改失败");
    }

    @Override
    public Message deleteDept(String state, String id) throws Exception {
        int i = deptDao.deleteDept(state, id);
        if (i>0){
            return new Message(true,"修改成功");
        }else {
            return new Message(false,"修改失败");
        }
    }
}
