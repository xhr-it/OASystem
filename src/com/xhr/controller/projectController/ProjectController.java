package com.xhr.controller.projectController;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.DeptService;
import com.xhr.service.baseInfoService.impl.DeptServiceImpl;
import com.xhr.service.projectService.ProjectService;
import com.xhr.service.projectService.impl.ProjectServiceImpl;
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

@WebServlet(name = "ProjectController",urlPatterns = "/project/*")
public class ProjectController extends HttpServlet {
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

    protected void selectProjectByDept(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProjectService projectService = new ProjectServiceImpl();
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) JSONObject.toBean(jsonObject, HashMap.class);
        String pageInfo=request.getParameter("pageInfo");
        JSONObject json=JSONObject.fromObject(pageInfo);
        PageEntity page= (PageEntity) JSONObject.toBean(json, PageEntity.class);
        String deptid=request.getParameter("deptid");
        try {
            PageEntity pageEntity=projectService.selectProjectByDept(map,page,deptid);
            JSONObject jsonObject1=JSONObject.fromObject(pageEntity);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1.toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据部门id和员工id查询部门和部门下的项目（项目树-任务分解）
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectDeptAndProject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProjectService projectService = new ProjectServiceImpl();
        String deptid=request.getParameter("deptid");
        String stuffid=request.getParameter("stuffid");
        try {
            List list=projectService.selectDeptAndProject(stuffid,deptid);
            PrintWriter out=response.getWriter();
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 项目统计
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectProjectCensus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pageInfo=request.getParameter("pageInfo");
        JSONObject json=JSONObject.fromObject(pageInfo);
        PageEntity pageEntity= (PageEntity) JSONObject.toBean(json,PageEntity.class);
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject1=JSONObject.fromObject(dataInfo);
        Map map= (Map) JSONObject.toBean(jsonObject1,HashMap.class);
        ProjectService projectService = new ProjectServiceImpl();
        try {
            PageEntity pageEntity1 =projectService.selectAllProject(map,pageEntity);
            JSONObject jsonObject=JSONObject.fromObject(pageEntity1);
            PrintWriter out=response.getWriter();
            out.print(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增项目-查找项目领取人
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectStuffNameForProject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProjectService projectService = new ProjectServiceImpl();
        try {
            String deptid=request.getParameter("deptid");
            List<Map> list=projectService.selectStuffNameForProject(deptid);
            PrintWriter out=response.getWriter();
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray);
            System.out.println(jsonArray);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增项目
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void insertProject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) JSONObject.toBean(jsonObject,HashMap.class);
        ProjectService projectService = new ProjectServiceImpl();
        try {
            Message message=projectService.insertProject(map);
            JSONObject jsonObject1=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1.toString());
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 项目统计-折线图
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectChart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject1=JSONObject.fromObject(dataInfo);
        Map map= (Map) JSONObject.toBean(jsonObject1,HashMap.class);
        ProjectService projectService = new ProjectServiceImpl();
        try {
            List<Map> list =projectService.selectChart(map);
            JSONArray jsonArray=JSONArray.fromObject(list);
            PrintWriter out=response.getWriter();
            out.print(jsonArray.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
