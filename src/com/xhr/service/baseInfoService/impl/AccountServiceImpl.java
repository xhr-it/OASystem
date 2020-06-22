package com.xhr.service.baseInfoService.impl;

import com.xhr.dao.baseInfoDao.AccountDao;
import com.xhr.dao.baseInfoDao.impl.AccountDaoImpl;
import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.AccountService;
import com.xhr.util.DBAgent;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class AccountServiceImpl implements AccountService {
    AccountDao accountDao = new AccountDaoImpl();

    /**
     * 用户登录
     * @param username
     * @param password
     * @return
     * @throws SQLException
     */
    @Override
    public Map login(String username, String password) throws SQLException {
        return accountDao.login(username,password);
    }

    @Override
    public Message updatePassword(Map map) throws SQLException {
        int i = accountDao.updatePassword(map);
        Message messageEntity;
        if (i>0) {
            messageEntity=new Message(true,"修改成功");
        }else {
            messageEntity=new Message(false,"修改失败");
        }
        return messageEntity;
    }

    /**
     * 根据当前登陆人查询他具备的所有权限
     */
    @Override
    public List<Map> queryFunForAcc(String accountid) throws SQLException {
        //只有父
        List<Map> mapList= accountDao.queryFunForAcc(accountid);
        //封装子：
        if(mapList!=null){
            for(Map map:mapList){
                //map是每一个父功能
                Object functionid=map.get("functionid");
                List sonList=accountDao.queryFunForFunctionId(accountid,functionid.toString());
                map.put("sonList",sonList);//d.functionid,d.functionname,d.url,sonList--列表
            }
        }
        return mapList;
    }

    @Override
    public PageEntity selectAllAccount(Map map, PageEntity page) throws SQLException {
        return accountDao.selectAllAccount(map,page);
    }

    @Override
    public Message usernameUnique(String name, String accountid) throws SQLException {
        List<Map> mapList = accountDao.usernameUnique(name, accountid);
        if (mapList != null&& mapList.size()>0) {
            return new Message(false,"用户名重复~");
        }else {
            return new Message(true,"");
        }
    }

    @Override
    public Message addAccount(Map map, String id) throws SQLException {
        int i=accountDao.addAccount(map);
        //新增账号后要更新用户信息
        String sql="UPDATE stuff SET accountid=? WHERE stuffid=? ";
        DBAgent dbAgent = new DBAgent();
        int j=dbAgent.excuteUpdate(sql,i,id);
        Message message;
        if (j>0){
            message=new Message(true,"分配账号成功~");
        }else {
            message=new Message(false,"分配账号失败~");
        }
        return message;
    }

    @Override
    public Message deleteAccount(String state, String id) throws SQLException {
        int i = accountDao.deleteAccount(state, id);
        if (i>0){
            return new Message(true,"修改成功");
        }
        return new Message(false,"修改失败");
    }

}
