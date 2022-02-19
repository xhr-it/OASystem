package com.xhr.service.baseInfoService;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * @author xhr
 * @date 2020/3/01
 *  用户账号Service接口
**/
public interface AccountService {
    /**
     * 用户登录
     * @param username
     * @param password
     * @return
     * @throws SQLException
     */
    Map login(String username, String password) throws SQLException;

    /**
     * 修改密码
     * @param map
     * @return
     * @throws SQLException
     */
    Message updatePassword(Map map) throws SQLException;

    /**
     * 根据当前登陆人查询他具备的所有权限
     * @param accountid
     * @return
     * @throws SQLException
     */
    List<Map> queryFunForAcc(String accountid) throws SQLException;

    /**
     * 查询所有账号（分页）
     * @param map
     * @param page
     * @return
     * @throws SQLException
     */
    PageEntity selectAllAccount(Map map, PageEntity page) throws SQLException;

    /**
     * 用户名唯一性校验
     * @param name
     * @param accountid
     * @return
     * @throws SQLException
     */
    Message usernameUnique(String name, String accountid) throws SQLException;

    /**
     * 分配账号
     * @param map
     * @param id
     * @return
     * @throws SQLException
     */
    Message addAccount(Map map,String id) throws SQLException;

    /**
     * 删除账户
     * @param state
     * @param id
     * @return
     * @throws SQLException
     */
    Message deleteAccount(String state,String id) throws SQLException;
}
