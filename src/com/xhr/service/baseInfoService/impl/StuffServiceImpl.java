package com.xhr.service.baseInfoService.impl;

import com.xhr.dao.baseInfoDao.StuffDao;
import com.xhr.dao.baseInfoDao.impl.StuffDaoImpl;
import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.StuffService;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class StuffServiceImpl implements StuffService {
    StuffDao stuffDao = new StuffDaoImpl();

    @Override
    public PageEntity selectStuff(Map query, PageEntity page, String id) throws Exception {
        return stuffDao.selectStuff(query,page,id);
    }

    @Override
    public List<Map> selectDeptTree() throws SQLException {
        return stuffDao.selectDeptTree();
    }

    @Override
    public List<Map> selectCode(String type, String parent) throws Exception {
        return stuffDao.selectCode(type, parent);
    }

    @Override
    public List<Map> selectLeader(String deptid) throws Exception {
        return stuffDao.selectLeader(deptid);
    }

    @Override
    public Message insertStuff(Map map) throws Exception {
        int i=stuffDao.insertStuff(map);
        if (i>0){
            return new Message(true,"新增成功");
        }
        return new Message(false,"新增失败");
    }

    @Override
    public Message selectStuffByIdCard(String idcard, String stuffid) throws Exception {
        List list=stuffDao.selectStuffByIdCard(idcard,stuffid);
        if (list!=null&&list.size()>0){
            return new Message(false,"身份证号已经重复");
        }
        return new Message(true,"身份证号可以使用");
    }

    @Override
    public Message deleteStuff(String state, String id) throws Exception {
        int i=stuffDao.deleteStuff(state,id);
        if (i>0){
            return new Message(true,"修改成功");
        }
        return new Message(false,"修改失败");
    }

    @Override
    public Map selectStuffById(String stuffid) throws Exception {
        return stuffDao.selectStuffById(stuffid);
    }

    @Override
    public Message updateStuff(Map map) throws Exception {
        int i=stuffDao.updateStuff(map);
        if (i>0){
            return new Message(true,"修改成功");
        }
        return new Message(false,"修改失败");
    }
}
