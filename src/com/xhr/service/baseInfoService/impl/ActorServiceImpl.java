package com.xhr.service.baseInfoService.impl;

import com.xhr.dao.baseInfoDao.ActorDao;
import com.xhr.dao.baseInfoDao.impl.ActorDaoImpl;
import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.ActorService;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class ActorServiceImpl implements ActorService {
    ActorDao actorDAO=new ActorDaoImpl();

    @Override
    public PageEntity selectAllActor(Map map, PageEntity page) throws SQLException {
        return actorDAO.selectAllActor(map, page);
    }

    /**
     * 查询所有的功能，如果针对这个角色已经存在，则添加一列为true 否则为false
     * @param actorid
     * @return
     * @throws SQLException
     */
    @Override
    public List<Map> selectFunctionByActorID(String actorid) throws SQLException{
        return actorDAO.selectFunctionByActorID(actorid);
    }

    @Override
    public List<Map> selectActorName() throws SQLException {
        return actorDAO.selectActorName();
    }

    @Override
    public List<Map> selectActorByAccount(String accountid) throws SQLException {
        return actorDAO.selectActorByAccount(accountid);
    }

    @Override
    public Message insertActorByAccount(String accountid, String array) throws SQLException {
        if (array!=null){
            String [] arrayString=array.split(",");
            actorDAO.deleteActorByAccount(accountid);
            for (int i=0;i<arrayString.length;i++){
                int j= actorDAO.insertActorByAccount(accountid, arrayString[i]);
            }
        }
        return new Message(true,"分配角色成功");
    }

    @Override
    public Message actorNameUnique(String username, String id) throws SQLException {
        List<Map> mapList = actorDAO.actorNameUnique(username, id);
        if (mapList != null&&mapList.size() >0) {
            return new Message(false,"角色名不可使用");
        }else {
            return new Message(true,"");
        }
    }

    @Override
    public Message addActor(Map map) throws SQLException {
        int i = actorDAO.addActor(map);
        if (i>0){
            return new Message(true,"新增成功");
        }else{
            return new Message(false,"新增失败");
        }
    }

    @Override
    public Message deleteActor(String state, String id) throws SQLException {
        int i = actorDAO.deleteActor(state, id);
        if (i>0){
            return new Message(true,"删除成功");
        }else{
            return new Message(false,"删除失败");
        }
    }

}
