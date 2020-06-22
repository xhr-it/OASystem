package com.xhr.controller.baseInfoController;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.FunctionService;
import com.xhr.service.baseInfoService.impl.FunctionServiceImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "FunctionController",urlPatterns = "/function/*")
public class FunctionController extends HttpServlet {
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
     * 查询所有权限
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectFunction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FunctionService functionService=new FunctionServiceImpl();
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) JSONObject.toBean(jsonObject, HashMap.class);
        String pageInfo=request.getParameter("pageInfo");
        String id=request.getParameter("id");
        JSONObject json=JSONObject.fromObject(pageInfo);
        PageEntity pageEntity= (PageEntity) JSONObject.toBean(json,PageEntity.class);
        try {
            PageEntity page=functionService.selectAllFunction(map,pageEntity,id);
            PrintWriter out=response.getWriter();
            JSONObject jsonObject1=JSONObject.fromObject(page);
            out.print(jsonObject1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 权限树
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectFunctionTree(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FunctionService functionService = new FunctionServiceImpl();
        try {
            List<Map> list=functionService.selectFunctionTree();
            PrintWriter out=response.getWriter();
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 保存权限树
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void saveFunctionTree(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tree=request.getParameter("tree");
        String id=request.getParameter("id");
        FunctionService functionService = new FunctionServiceImpl();
        try {
           Message message = functionService.saveFunctionTree(tree,id);
           JSONObject jsonObject=JSONObject.fromObject(message);
           PrintWriter out =response.getWriter();
           out.print(jsonObject.toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增权限-查找父权限名
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectFunctionName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FunctionService functionService=new FunctionServiceImpl();
        try {
            List<Map> list=functionService.selectFunctionName();
            PrintWriter out=response.getWriter();
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 权限名唯一性校验
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void functionUnique(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String id = request.getParameter("id");
        FunctionService functionService=new FunctionServiceImpl();
        Message messageEntity;
        try {
            messageEntity = functionService.functionUnique(username,id);
            PrintWriter out = response.getWriter();
            JSONObject jsonObject = JSONObject.fromObject(messageEntity);
            out.print(jsonObject);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增功能
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void addFunction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject= JSONObject.fromObject(dataInfo);
        Map map=(Map) JSONObject.toBean(jsonObject, HashMap.class);
        FunctionService functionService=new FunctionServiceImpl();
        try {
            Message messageEntity=functionService.addFunction(map);
            PrintWriter out=response.getWriter();
            JSONObject json= JSONObject.fromObject(messageEntity);
            out.print(json);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 修改功能-根据id查询功能
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectFunctionById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("id");
        FunctionService functionService=new FunctionServiceImpl();
        try {
            Map usermap=functionService.selectFunctionById(id);
            PrintWriter out=response.getWriter();
            JSONObject json= JSONObject.fromObject(usermap);
            out.print(json);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 修改功能
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void updateFunction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject= JSONObject.fromObject(dataInfo);
        Map map=(Map) JSONObject.toBean(jsonObject, HashMap.class);
        FunctionService functionService=new FunctionServiceImpl();
        try {
            Message messageEntity=functionService.updateFunction(map);
            PrintWriter out=response.getWriter();
            JSONObject json= JSONObject.fromObject(messageEntity);
            out.print(json);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除功能
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void deleteFunction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("id");
        String state=request.getParameter("state");
        FunctionService functionService=new FunctionServiceImpl();
        try {
            Message messageEntity=functionService.deleteFunction(state,id);
            PrintWriter out=response.getWriter();
            JSONObject json= JSONObject.fromObject(messageEntity);
            out.print(json);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
