package com.xhr.service.baseInfoService.impl;

import com.xhr.dao.baseInfoDao.PositionDao;
import com.xhr.dao.baseInfoDao.impl.PositionDaoImpl;
import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.PositionService;

import java.util.List;
import java.util.Map;

public class PositionServiceImpl implements PositionService {
    PositionDao positionDao = new PositionDaoImpl();

    @Override
    public PageEntity selectPosition(Map query, PageEntity page) throws Exception {
        return positionDao.selectPosition(query,page);
    }

    @Override
    public List<Map> selectPositionName() throws Exception {
        return positionDao.selectPositionName();
    }

    @Override
    public Message deletePosition(String state, String id) throws Exception {
        int i = positionDao.deletePosition(state, id);
        if (i>0){
            return new Message(true,"修改成功");
        }
        return new Message(false,"修改失败");
    }

    @Override
    public Message selectPositionCard(String positionno, String positionid) throws Exception {
        List list=positionDao.selectPositionCard(positionno,positionid);
        if (list!=null&&list.size()>0){
            return new Message(false,"职位编号已经重复");
        }
        return new Message(true,"职位编号可以使用");
    }

    @Override
    public Message positionNameUnique(String positionname, String positionid) throws Exception {
        List list=positionDao.positionNameUnique(positionname,positionid);
        if (list!=null&&list.size()>0){
            return new Message(false,"职位名称已经重复");
        }
        return new Message(true,"职位名称可以使用");
    }

    @Override
    public Message addPosition(Map map) throws Exception {
        int i=positionDao.addPosition(map);
        if (i>0){
            return new Message(true,"新增成功");
        }
        return new Message(false,"新增失败");
    }

    @Override
    public Map selectPositionById(String positionid) throws Exception {
        return positionDao.selectPositionById(positionid);
    }

    @Override
    public Message updatePosition(Map map) throws Exception {
        int i=positionDao.updatePosition(map);
        if (i>0){
            return new Message(true,"修改成功");
        }else {
            return new Message(true,"修改失败");
        }
    }
}
