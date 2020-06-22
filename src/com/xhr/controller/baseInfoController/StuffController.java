package com.xhr.controller.baseInfoController;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.StuffService;
import com.xhr.service.baseInfoService.impl.StuffServiceImpl;
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

@WebServlet(name = "StuffController" , urlPatterns = "/stuff/*")
public class StuffController extends HttpServlet {
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
     * 查询所有员工
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectStuff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StuffService stuffService = new StuffServiceImpl();
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map =(Map)JSONObject.toBean(jsonObject, HashMap.class);
        String pageInfo=request.getParameter("pageInfo");
        String id=request.getParameter("id");
        JSONObject jsonPage=JSONObject.fromObject(pageInfo);
        PageEntity pageEntity= (PageEntity) JSONObject.toBean(jsonPage,PageEntity.class);
        try {
            PageEntity pageEntity1=stuffService.selectStuff(map,pageEntity,id);
            JSONObject jsonObject1=JSONObject.fromObject(pageEntity1);
            PrintWriter out= response.getWriter();
            out.print(jsonObject1.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 查询部门树
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectDeptTree(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StuffService stuffService = new StuffServiceImpl();
        try {
            PrintWriter out=response.getWriter();
            List<Map> list=stuffService.selectDeptTree();
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 加载下拉框
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectCode(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type=request.getParameter("code");
        String parent=request.getParameter("parent");
        StuffService stuffService=new StuffServiceImpl();
        try {
            List<Map> list=stuffService.selectCode(type,parent);
            PrintWriter out=response.getWriter();
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 查询领导-下拉框
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectLeader(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StuffService stuffService=new StuffServiceImpl();
        String id=request.getParameter("id");
        try {
            List<Map> list=stuffService.selectLeader(id);
            PrintWriter out=response.getWriter();
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增员工
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void insertStuff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) jsonObject.toBean(jsonObject, HashMap.class);
        StuffService stuffService=new StuffServiceImpl();
        try {
            Message message=stuffService.insertStuff(map);
            JSONObject jsonObject1=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 身份证唯一性校验
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectByIdCard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idcard=request.getParameter("idcard");
        String stuffid=request.getParameter("stuffid");
        StuffService stuffService=new StuffServiceImpl();
        try {
            Message message=stuffService.selectStuffByIdCard(idcard,stuffid);
            PrintWriter out=response.getWriter();
            JSONObject jsonObject=JSONObject.fromObject(message);
            out.print(jsonObject.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 修改员工状态
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void deleteStuff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StuffService stuffService=new StuffServiceImpl();
        String id=request.getParameter("id");
        String state=request.getParameter("state");
        try {
            Message message=stuffService.deleteStuff(state,id);
            JSONObject jsonObject=JSONObject.fromObject(message);
            PrintWriter out =response.getWriter();
            out.print(jsonObject.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据员工编号查询员工（修改前提）
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectStuffById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("stuffid");
        StuffService stuffService=new StuffServiceImpl();
        request.setCharacterEncoding("utf-8");
        try {
            Map map=stuffService.selectStuffById(id);
            PrintWriter out=response.getWriter();
            JSONObject jsonObject=JSONObject.fromObject(map);
            out.print(jsonObject.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 修改员工
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void updateStuff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) JSONObject.toBean(jsonObject,HashMap.class);
        StuffService stuffService=new StuffServiceImpl();
        try {
            Message message=stuffService.updateStuff(map);
            PrintWriter out=response.getWriter();
            JSONObject jsonObject1=JSONObject.fromObject(message);
            out.print(jsonObject1.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
