package com.xhr.controller.baseInfoController;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.AccountService;
import com.xhr.service.baseInfoService.impl.AccountServiceImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AccountController",urlPatterns = "/account/*")
public class AccountController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url=request.getRequestURI();
        String method=url.substring(url.lastIndexOf("/")+1,url.length());
        Class c=this.getClass();
        try {
            Method method1=c.getDeclaredMethod(method,HttpServletRequest.class,HttpServletResponse.class);
            method1.invoke(this,request,response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    /**
     * 用户登录
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username=request.getParameter("username");
        String pwd=request.getParameter("pwd");
        String path=request.getContextPath();
        AccountService accountService=new AccountServiceImpl();
        Message message=null;
        try {
            //验证码校验
            String checkCode_client=request.getParameter("checkCode");
            //获得生成图片的文字的验证码
            Object checkcode_session = request.getSession().getAttribute("checkcode_session");
            //对比页面的和生成的文字验证码是否一致
            if (checkcode_session.equals(checkCode_client)) {
                Map map=accountService.login(username,pwd);
                if(map!=null){
                    HttpSession session=request.getSession();
                    session.setAttribute("account",map);
                    message=new Message(true,"登陆成功");
                }else{
                    message=new Message(false,"用户名或密码错误，请重新输入~");
                }
            }else {
                message=new Message(false,"验证码输入错误，请重新输入~");
            }
            PrintWriter out=response.getWriter();
            JSONObject jsonObject=JSONObject.fromObject(message);
            out.print(jsonObject.toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 用户退出
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void loginOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path=request.getContextPath();
        HttpSession session=request.getSession();
        session.invalidate();
        response.sendRedirect(path+"/module/login.jsp");
    }

    /**
     * 根据登录人显示不同权限
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void getFunction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        AccountService acc=new AccountServiceImpl();
        HttpSession session=request.getSession();
        Map map= (Map) session.getAttribute("account");

        Object accountid=map.get("accountid");
        try {
            List list = acc.queryFunForAcc(accountid.toString());
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray.toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 查询所有的账号（分页）
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AccountService accountService=new AccountServiceImpl();
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) JSONObject.toBean(jsonObject, HashMap.class);
        String pageInfo=request.getParameter("pageInfo");
        JSONObject json=JSONObject.fromObject(pageInfo);
        PageEntity pageEntity= (PageEntity) JSONObject.toBean(json,PageEntity.class);
        try {
            PageEntity page=accountService.selectAllAccount(map,pageEntity);
            PrintWriter out=response.getWriter();
            JSONObject jsonObject1=JSONObject.fromObject(page);
            out.print(jsonObject1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 用户名唯一性校验
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void usernameUnique(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String id = request.getParameter("id");
        AccountService accountService=new AccountServiceImpl();
        Message messageEntity = new Message(false,"用户名为空不能~");
        try {
            if (username != null&&!username.equals("")) {
                messageEntity = accountService.usernameUnique(username, id);
            }
            PrintWriter out = response.getWriter();
            JSONObject jsonObject = JSONObject.fromObject(messageEntity);
            out.print(jsonObject);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 分配账户
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void addAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("id");
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject= JSONObject.fromObject(dataInfo);
        Map map=(Map) JSONObject.toBean(jsonObject, HashMap.class);
        AccountService accountService=new AccountServiceImpl();
        try {
            Message messageEntity=accountService.addAccount(map,id);
            PrintWriter out=response.getWriter();
            JSONObject json=JSONObject.fromObject(messageEntity);
            out.print(json);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 修改密码
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void updatePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInfo = request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) JSONObject.toBean(jsonObject,HashMap.class);
        AccountService accountService=new AccountServiceImpl();
        Message messageEntity;
        try {
            messageEntity = accountService.updatePassword(map);
            PrintWriter out = response.getWriter();
            JSONObject json = JSONObject.fromObject(messageEntity);
            out.print(json);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除账户
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void deleteAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("id");
        String state=request.getParameter("state");
        AccountService accountService=new AccountServiceImpl();
        try {
            Message messageEntity=accountService.deleteAccount(state,id);
            PrintWriter out=response.getWriter();
            JSONObject json= JSONObject.fromObject(messageEntity);
            out.print(json);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
