package com.xhr.controller.taskController;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.taskService.TaskService;
import com.xhr.service.taskService.impl.TaskServiceImpl;
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

@WebServlet(name = "TaskController",urlPatterns = "/task/*")
public class TaskController extends HttpServlet {
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
     * 查询已提交任务（进行审核）
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectTaskAudit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TaskService taskService = new TaskServiceImpl();
        HttpSession session=request.getSession();
        Map map= (Map) session.getAttribute("account");
        String stuffid=map.get("stuffid").toString();
        String pageInfo=request.getParameter("pageInfo");
        JSONObject jsonObject=JSONObject.fromObject(pageInfo);
        PageEntity pageEntity= (PageEntity) JSONObject.toBean(jsonObject,PageEntity.class);
        String dateInfo=request.getParameter("dateInfo");
        JSONObject jsonObject2=JSONObject.fromObject(dateInfo);
        Map map1= (Map) JSONObject.toBean(jsonObject2, HashMap.class);
        try {
            PageEntity pageEntity1=taskService.selectTaskAudit(stuffid,map1,pageEntity);
            JSONObject jsonObject1=JSONObject.fromObject(pageEntity1);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 查询我的任务
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectMyTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TaskService taskService = new TaskServiceImpl();
        HttpSession session=request.getSession();
        Map map= (Map) session.getAttribute("account");
        String stuffid=map.get("stuffid").toString();
        String pageInfo=request.getParameter("pageInfo");
        JSONObject jsonObject=JSONObject.fromObject(pageInfo);
        PageEntity pageEntity= (PageEntity) JSONObject.toBean(jsonObject,PageEntity.class);
        String dateInfo=request.getParameter("dateInfo");
        JSONObject jsonObject2=JSONObject.fromObject(dateInfo);
        Map map1= (Map) JSONObject.toBean(jsonObject2,HashMap.class);
        try {
            PageEntity pageEntity1=taskService.selectMyTask(stuffid,map1,pageEntity);
            JSONObject jsonObject1=JSONObject.fromObject(pageEntity1);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据项目id查询任务
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectTaskByProjectId(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TaskService taskService=new TaskServiceImpl();
        String proId=request.getParameter("projectid");
        String pageInfo=request.getParameter("pageInfo");
        PrintWriter out=response.getWriter();
        JSONObject jsonObject=JSONObject.fromObject(pageInfo);
        PageEntity pageEntity= (PageEntity) JSONObject.toBean(jsonObject,PageEntity.class);
        String dateInfo=request.getParameter("dateInfo");
        JSONObject jsonObject1=JSONObject.fromObject(dateInfo);
        Map map = (Map) JSONObject.toBean(jsonObject1,HashMap.class);
        try {
            pageEntity=taskService.selectTaskByProjectId(proId,map,pageEntity);
            JSONObject page=JSONObject.fromObject(pageEntity);
            out.print(page.toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据父任务id查找子任务
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectTaskByFatherId(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TaskService taskService=new TaskServiceImpl();
        String fatherid=request.getParameter("fatherid");
        PrintWriter out=response.getWriter();
        try {
            List<Map> list=taskService.selectTaskByFatherId(fatherid);
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray.toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 加载任务负责人下拉框
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectStuffByProjectId(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String projectid=request.getParameter("projectid");
        TaskService taskService=new TaskServiceImpl();
        try {
            List<Map> list=taskService.selectStuffByProjectId(projectid);
            JSONArray jsonArray=JSONArray.fromObject(list);
            PrintWriter out=response.getWriter();
            out.print(jsonArray.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据父任务id查找所有子任务时间 最晚的时间默认是新增子任务的时间
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectTab_taskTime(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskid=request.getParameter("taskid");
        TaskService taskService=new TaskServiceImpl();
        try {
            List<Map> list=taskService.selectTab_taskTime(taskid);
            JSONArray jsonObject1=JSONArray.fromObject(list);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增子任务
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void insertSonTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dateInfo=request.getParameter("dateInfo");
        JSONObject jsonObject=JSONObject.fromObject(dateInfo);
        Map map= (Map) JSONObject.toBean(jsonObject,HashMap.class);
        TaskService taskService=new TaskServiceImpl();
        try {
            Message message=taskService.insertSonTask(map);
            JSONObject jsonObject1=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 领取任务
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void getTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TaskService taskService = new TaskServiceImpl();
        String dateInfo=request.getParameter("dateInfo");
        JSONObject jsonObject1=JSONObject.fromObject(dateInfo);
        Map map = (Map) JSONObject.toBean(jsonObject1,HashMap.class);
        try {
            Message message=taskService.getTask(map);
            JSONObject jsonObject=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 提交任务
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void submitTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TaskService taskService = new TaskServiceImpl();
        String dateInfo=request.getParameter("dateInfo");
        JSONObject jsonObject1=JSONObject.fromObject(dateInfo);
        Map map = (Map) JSONObject.toBean(jsonObject1,HashMap.class);
        try {
            Message message=taskService.submitTask(map);
            JSONObject jsonObject=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据任务id查找任务意见
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectTaskOption(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TaskService taskService = new TaskServiceImpl();
        String taskid=request.getParameter("taskid");
        try {
            List<Map> list=taskService.selectTaskOption(taskid);
            JSONArray jsonArray=JSONArray.fromObject(list);
            PrintWriter out=response.getWriter();
            out.print(jsonArray);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 审核任务-查看任务信息
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectTaskById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TaskService taskService = new TaskServiceImpl();
        String taskid=request.getParameter("taskid");
        try {
            List<Map> list=taskService.selectTaskById(taskid);
            JSONArray jsonArray=JSONArray.fromObject(list);
            PrintWriter out=response.getWriter();
            out.print(jsonArray.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增意见并且修改任务状态
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void insertOpinion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TaskService taskService = new TaskServiceImpl();
        String dateInfo=request.getParameter("dateInfo");
        JSONObject jsonObject=JSONObject.fromObject(dateInfo);
        System.out.println(dateInfo);
        Map map= (Map) JSONObject.toBean(jsonObject, HashMap.class);
        try {
            Message message=taskService.insertOption(map);
            JSONObject jsonObject1=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增父任务-根据项目ID查找项目时间 即是父任务开始时间
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectProTime(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String projectid=request.getParameter("projectid");
        TaskService taskService=new TaskServiceImpl();
        try {
            List<Map> list=taskService.selectProTime(projectid);
            JSONArray jsonObject1=JSONArray.fromObject(list);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增父任务
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void insertFatherTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dateInfo=request.getParameter("dateInfo");
        JSONObject jsonObject=JSONObject.fromObject(dateInfo);
        Map map= (Map) JSONObject.toBean(jsonObject, HashMap.class);
        TaskService taskService=new TaskServiceImpl();
        try {
            Message message=taskService.insertFatherTask(map);
            JSONObject jsonObject1=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
