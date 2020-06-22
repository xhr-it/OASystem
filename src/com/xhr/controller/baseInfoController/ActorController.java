package com.xhr.controller.baseInfoController;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.ActorService;
import com.xhr.service.baseInfoService.impl.ActorServiceImpl;
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

@WebServlet(name = "ActorController",urlPatterns = "/actor/*")
public class ActorController extends HttpServlet {
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
     * 查询所有角色
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectActor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ActorService actorService=new ActorServiceImpl();
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) JSONObject.toBean(jsonObject, HashMap.class);
        String pageInfo=request.getParameter("pageInfo");
        JSONObject json=JSONObject.fromObject(pageInfo);
        PageEntity pageEntity= (PageEntity) JSONObject.toBean(json,PageEntity.class);
        try {
            PageEntity page=actorService.selectAllActor(map,pageEntity);
            PrintWriter out=response.getWriter();
            JSONObject jsonObject1=JSONObject.fromObject(page);
            out.print(jsonObject1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 查询所有的功能，如果针对这个角色已经存在，则添加一列为true 否则为false（权限树）
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectFunctionByActorID(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        ActorService ActorService=new ActorServiceImpl();
        String actorid=request.getParameter("actorid");
        try {
            List list=ActorService.selectFunctionByActorID(actorid);
            JSONArray jsonArray= JSONArray.fromObject(list);
            out.print(jsonArray.toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 分配角色-查询
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectActorName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ActorService actorService=new ActorServiceImpl();
        try {
            List<Map> list=actorService.selectActorName();
            PrintWriter out=response.getWriter();
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据账户id查询原本的角色-分配角色
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectActorByAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("id");
        ActorService actorService=new ActorServiceImpl();
        try {
            List<Map> list=actorService.selectActorByAccount(id);
            JSONArray jsonArray=JSONArray.fromObject(list);
            PrintWriter out=response.getWriter();
            out.print(jsonArray);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 分配角色-给账户分配角色
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void distributeActor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String array=request.getParameter("array");
        String id=request.getParameter("id");
        ActorService actorService=new ActorServiceImpl();
        try {
            Message message=actorService.insertActorByAccount(id,array);
            JSONObject jsonObject=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 角色名唯一性校验
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void actorUnique(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String id = request.getParameter("id");
        ActorService actorService=new ActorServiceImpl();
        Message messageEntity;
        try {
            messageEntity = actorService.actorNameUnique(username, id);
            PrintWriter out = response.getWriter();
            JSONObject jsonObject = JSONObject.fromObject(messageEntity);
            out.print(jsonObject);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增角色
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void addActor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject= JSONObject.fromObject(dataInfo);
        Map map=(Map) JSONObject.toBean(jsonObject, HashMap.class);
        ActorService actorService=new ActorServiceImpl();
        try {
            Message messageEntity=actorService.addActor(map);
            PrintWriter out=response.getWriter();
            JSONObject json= JSONObject.fromObject(messageEntity);
            out.print(json);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除角色
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void deleteActor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String state=request.getParameter("actorstate");
        String id=request.getParameter("actorid");
        ActorService actorService=new ActorServiceImpl();
        try {
            Message messageEntity=actorService.deleteActor(state,id);
            PrintWriter out=response.getWriter();
            JSONObject json= JSONObject.fromObject(messageEntity);
            out.print(json);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
