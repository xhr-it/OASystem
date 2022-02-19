package com.xhr.controller.weekReportController;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.weekReportService.WeekReportService;
import com.xhr.service.weekReportService.impl.WeekReportServiceImpl;
import com.xhr.util.BaseUtil;
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

@WebServlet(name = "WeekReportController",urlPatterns = "/weekReport/*")
public class WeekReportController extends HttpServlet {
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

    protected void selectAudit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        WeekReportService weekReportService=new WeekReportServiceImpl();
        String pageInfo=request.getParameter("pageInfo");
        PrintWriter out=response.getWriter();
        try {
            HttpSession session=request.getSession();
            Map map=(Map) session.getAttribute("account");
            String stuffid= BaseUtil.transObjToStr(map.get("stuffid"));
            JSONObject jsonObject=JSONObject.fromObject(pageInfo);
            PageEntity pageEntity=(PageEntity) JSONObject.toBean(jsonObject,PageEntity.class);
            pageEntity=weekReportService.selectAudit(pageEntity,stuffid);
            JSONObject page=JSONObject.fromObject(pageEntity);
            out.print(page.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void selectWeekReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        WeekReportService weekReportService=new WeekReportServiceImpl();
        String pageInfo=request.getParameter("pageInfo");
        PrintWriter out=response.getWriter();
        try {
            HttpSession session=request.getSession();
            Map map=(Map) session.getAttribute("account");
            String stuffid= BaseUtil.transObjToStr(map.get("stuffid"));
            JSONObject jsonObject=JSONObject.fromObject(pageInfo);
            PageEntity pageEntity=(PageEntity) JSONObject.toBean(jsonObject,PageEntity.class);
            pageEntity=weekReportService.selectWeekReport(pageEntity,stuffid);
            JSONObject page=JSONObject.fromObject(pageEntity);
            out.print(page.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 周报统计-表格
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectForTab(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        WeekReportService weekReportService = new WeekReportServiceImpl();
        String datainfo = request.getParameter("dataInfo");

        try {
            JSONObject json = JSONObject.fromObject(datainfo);
            Map map = (Map) JSONObject.toBean(json, HashMap.class);

            List<Map> list = weekReportService.selectForTab(map);
            JSONArray jsonArray = JSONArray.fromObject(list);
            out.print(jsonArray);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    /**
     * 周报统计-图
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectChart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        WeekReportService weekReportService = new WeekReportServiceImpl();
        String dataInfo = request.getParameter("dataInfo");
        try {
            JSONObject json = JSONObject.fromObject(dataInfo);
            Map map = (Map) JSONObject.toBean(json, HashMap.class);
            List<Map> list = weekReportService.selectChart(map);
            JSONArray jsonReturn = JSONArray.fromObject(list);
            out.print(jsonReturn.toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    /**
     * 查找我的周报
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectMyWeekReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        WeekReportService weekReportService=new WeekReportServiceImpl();
        String pageInfo=request.getParameter("pageInfo");
        String map1=request.getParameter("tiandiyule");
        PrintWriter out=response.getWriter();
        try {
            JSONObject jsonObject1=JSONObject.fromObject(map1);
            Map  jsonmap= (Map) JSONObject.toBean(jsonObject1,HashMap.class);

            HttpSession session=request.getSession();
            Map map=(Map) session.getAttribute("account");
            String stuffid= BaseUtil.transObjToStr(map.get("stuffid"));
            JSONObject jsonObject=JSONObject.fromObject(pageInfo);
            PageEntity pageEntity=(PageEntity) JSONObject.toBean(jsonObject,PageEntity.class);
            pageEntity=weekReportService.selectMyWeekReport(jsonmap,pageEntity,stuffid);
            JSONObject page=JSONObject.fromObject(pageEntity);
            out.print(page.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 查看日报详情
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectWeekById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportid=request.getParameter("reportid");
        WeekReportService weekReportService=new WeekReportServiceImpl();
        try {
            Map map=weekReportService.selectWeekById(reportid);
            PrintWriter out=response.getWriter();
            JSONObject jsonObject = JSONObject.fromObject(map);
            out.print(jsonObject.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增或修改周报
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void insertOrUpdateReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        WeekReportService weekReportService=new WeekReportServiceImpl();
        String datainfo=request.getParameter("datainfo");
        PrintWriter out=response.getWriter();
        try {
            HttpSession session=request.getSession();
            Map map= (Map) session.getAttribute("account");//获取session中的登陆信息
            JSONObject jsonObject= JSONObject.fromObject(datainfo);
            Map dataMap= (Map) JSONObject.toBean(jsonObject, HashMap.class);
            dataMap.putAll(map);//session的登陆信息放到了日报的信息中
            int i = weekReportService.insertOrUpdateReport(dataMap);
            out.print(i);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 提交后修改状态
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void updateWriteState(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        WeekReportService weekReportService=new WeekReportServiceImpl();
        String reportid=request.getParameter("reportid");
        String writestate=request.getParameter("writestate");
        PrintWriter out=response.getWriter();
        try {
            weekReportService.updateWriteState(writestate,reportid);
            out.print(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增审核
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void insertAudit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) jsonObject.toBean(jsonObject, HashMap.class);
        WeekReportService weekReportService=new WeekReportServiceImpl();
        request.setCharacterEncoding("utf-8");
        try {
            Message message=weekReportService.insertAudit(map);
            JSONObject jsonObject1=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据周报id查看审核意见
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectAuditByReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportid=request.getParameter("reportid");
        WeekReportService weekReportService=new WeekReportServiceImpl();
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        try {
            List<Map> map=weekReportService.selectAuditByReport(reportid);
            PrintWriter out=response.getWriter();
            JSONArray jsonObject = JSONArray.fromObject(map);
            out.print(jsonObject.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
