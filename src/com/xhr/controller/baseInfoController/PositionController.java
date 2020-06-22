package com.xhr.controller.baseInfoController;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.PositionService;
import com.xhr.service.baseInfoService.StuffService;
import com.xhr.service.baseInfoService.impl.PositionServiceImpl;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "PositionController",urlPatterns = "/position/*")
public class PositionController extends HttpServlet {
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

    protected void selectPosition(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PositionService positionService=new PositionServiceImpl();
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map =(Map)JSONObject.toBean(jsonObject, HashMap.class);
        String pageInfo=request.getParameter("pageInfo");
        JSONObject jsonPage=JSONObject.fromObject(pageInfo);
        PageEntity pageEntity= (PageEntity) JSONObject.toBean(jsonPage, PageEntity.class);
        try {
            PageEntity page=positionService.selectPosition(map,pageEntity);
            JSONObject jsonObject1=JSONObject.fromObject(page);
            PrintWriter out= response.getWriter();
            out.print(jsonObject1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 查询职位-下拉框
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectPositionName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PositionService positionService = new PositionServiceImpl();
        try {
            List<Map> list=positionService.selectPositionName();
            PrintWriter out=response.getWriter();
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除职务
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void deletePosition(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("id");
        String state=request.getParameter("state");
        PositionService positionService=new PositionServiceImpl();
        try {
            Message messageEntity=positionService.deletePosition(state,id);
            PrintWriter out=response.getWriter();
            JSONObject json= JSONObject.fromObject(messageEntity);
            out.print(json);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 唯一性校验编号
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectPositionCard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String positionno=request.getParameter("positionno");
        String positionid=request.getParameter("positionid");
        PositionService positionService=new PositionServiceImpl();
        try {
            Message message=positionService.selectPositionCard(positionno,positionid);
            PrintWriter out=response.getWriter();
            JSONObject jsonObject=JSONObject.fromObject(message);
            out.print(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 职位名称唯一性校验
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void positionNameUnique(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String positionname=request.getParameter("positionname");
        String positionid=request.getParameter("positionid");
        PositionService positionService=new PositionServiceImpl();
        try {
            Message message=positionService.positionNameUnique(positionname,positionid);
            PrintWriter out=response.getWriter();
            JSONObject jsonObject=JSONObject.fromObject(message);
            out.print(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增职务
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void addPosition(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) jsonObject.toBean(jsonObject, HashMap.class);
        PositionService positionService=new PositionServiceImpl();
        try {
            Message message=positionService.addPosition(map);
            JSONObject jsonObject1=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 修改职位-根据职位id查找职位
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectPositionById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("positionid");
        PositionService positionService=new PositionServiceImpl();
        try {
            Map map=positionService.selectPositionById(id);
            JSONObject jsonObject=JSONObject.fromObject(map);
            PrintWriter out=response.getWriter();
            out.print(jsonObject.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 修改职位
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void updatePosition(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PositionService positionService=new PositionServiceImpl();
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) JSONObject.toBean(jsonObject, HashMap.class);
        try {
            Message message=positionService.updatePosition(map);
            JSONObject jsonObject1=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
