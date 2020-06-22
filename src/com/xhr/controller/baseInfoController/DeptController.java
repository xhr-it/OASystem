package com.xhr.controller.baseInfoController;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.baseInfoService.DeptService;
import com.xhr.service.baseInfoService.impl.DeptServiceImpl;
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

@WebServlet(name = "DeptController" , urlPatterns = "/dept/*")
public class DeptController extends HttpServlet {
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

    protected void selectDept(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DeptService deptService = new DeptServiceImpl();
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        String id=request.getParameter("id");
        Map map =(Map)JSONObject.toBean(jsonObject, HashMap.class);
        String pageInfo=request.getParameter("pageInfo");
        JSONObject jsonPage=JSONObject.fromObject(pageInfo);
        PageEntity pageEntity= (PageEntity) JSONObject.toBean(jsonPage, PageEntity.class);
        try {
            PageEntity pageEntity1=deptService.selectAllDept(map,pageEntity,id);
            JSONObject jsonObject1=JSONObject.fromObject(pageEntity1);
            PrintWriter out= response.getWriter();
            out.print(jsonObject1.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据id查找部门（项目-部门树）
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectDeptById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DeptService deptService=new DeptServiceImpl();
        String deptid=request.getParameter("deptid");
        try {
            List list=deptService.selectDeptByFatherId(deptid);
            PrintWriter out=response.getWriter();
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void selectDeptName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DeptService deptService =  new DeptServiceImpl();
        try {
            List<Map> list=deptService.selectDeptName();
            PrintWriter out=response.getWriter();
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 部门唯一性校验
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void deptUnique(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name=request.getParameter("name");
        String id=request.getParameter("id");
        DeptService deptService = new DeptServiceImpl();
        try {
            Message message=deptService.deptUnique(name,id);
            JSONObject jsonObject=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增部门
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void addDept(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) jsonObject.toBean(jsonObject, HashMap.class);

        DeptService deptService = new DeptServiceImpl();
        try {
            Message message=deptService.addDept(map);
            JSONObject jsonObject1=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 修改部门-先根据部门id查询部门
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectDeptForUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("deptid");
        DeptService deptService = new DeptServiceImpl();
        try {
            Map map=deptService.selectDeptById(id);
            PrintWriter out=response.getWriter();
            JSONObject jsonObject=JSONObject.fromObject(map);
            out.print(jsonObject.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 更新部门
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void updateDept(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInfo = request.getParameter("dataInfo");
        JSONObject jsonObject = JSONObject.fromObject(dataInfo);
        Map map = (Map) JSONObject.toBean(jsonObject, HashMap.class);
        DeptService deptService = new DeptServiceImpl();
        try {
            Message message = deptService.updateDept(map);
            PrintWriter out = response.getWriter();
            JSONObject jsonObject1 = JSONObject.fromObject(message);
            out.print(jsonObject1.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除部门
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void deleteDept(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DeptService deptService = new DeptServiceImpl();
        String id=request.getParameter("id");
        String state=request.getParameter("state");
        try {
            Message message=deptService.deleteDept(state,id);
            JSONObject jsonObject=JSONObject.fromObject(message);
            PrintWriter out =response.getWriter();
            out.print(jsonObject.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
