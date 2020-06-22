package com.xhr.service.baseInfoService.impl;

import com.xhr.dao.baseInfoDao.FunctionDao;
import com.xhr.dao.baseInfoDao.impl.FunctionDaoImpl;
import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.FunctionService;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class FunctionServiceImpl implements FunctionService {
    FunctionDao functionDao=new FunctionDaoImpl();

    @Override
    public PageEntity selectAllFunction(Map map, PageEntity page, String id) throws SecurityException, SQLException {
        return functionDao.selectAllFunction(map,page,id);
    }

    @Override
    public List<Map> selectFunctionTree() throws SQLException {
        return functionDao.selectFunctionTree();
    }

    @Override
    public Message saveFunctionTree(String tree, String actorid) throws SQLException {
        //首先删除原有权限
        functionDao.deleteFunctionForActor(actorid);
        String treeA=tree.substring(1,tree.length()-1);
        String[] treeB=treeA.split(",");
        int row=0;
        Message message;
        for (int i=0;i<treeB.length;i++){
            String num=treeB[i];
            int number=Integer.parseInt(num);
            row =functionDao.insertFunctionForActor(number,actorid);
        }
        if (row>0) {
            return new Message(true,"新增权限成功");
        }else {
            return new Message(false,"新增权限失败");
        }
    }

    @Override
    public List<Map> selectFunctionName() throws SQLException {
        return functionDao.selectFunctionName();
    }

    @Override
    public Message functionUnique(String name, String id) throws SQLException {
        List<Map> mapList = functionDao.functionUnique(name, id);
        if (mapList != null&&mapList.size() >0) {
            return new Message(false,"功能名重复");
        }else {
            return new Message(true,"");
        }
    }

    @Override
    public Message addFunction(Map map) throws SQLException {
        int i = functionDao.addFunction(map);
        if (i>0){
            return new Message(true,"新增成功");
        }else {
            return new Message(false,"新增失败");
        }
    }

    @Override
    public Map selectFunctionById(String id) throws SQLException {
        return functionDao.selectFunctionById(id);
    }

    @Override
    public Message updateFunction(Map map) throws SQLException {
        int i = functionDao.updateFunction(map);

        if (i>0){
            return new Message(true,"修改成功");
        }else {
            return new Message(false,"修改失败");
        }
    }

    @Override
    public Message deleteFunction(String state, String id) throws SQLException {
        int i = functionDao.deleteFunction(state, id);
        if (i>0){
            return new Message(true,"修改成功");
        }else {
            return new Message(false,"修改失败");
        }
    }
}
