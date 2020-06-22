package com.xhr.controller.dayReportController;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;
import com.xhr.service.dayReportService.DayReportService;
import com.xhr.service.dayReportService.impl.DayReportServiceImpl;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "DayReportController",urlPatterns = "/dayReport/*")
public class DayReportController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url=request.getRequestURI();
        String method=url.substring(url.lastIndexOf("/")+1,url.length());
        //System.out.println(method);
        //System.out.println(url);
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
     * 查询要提交的日报
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DayReportService dayReportService = new DayReportServiceImpl();
        String pageInfo=request.getParameter("pageInfo");
        String map1=request.getParameter("dateInfo");
        PrintWriter out=response.getWriter();
        try {
            JSONObject jsonObject1=JSONObject.fromObject(map1);
            Map jsonmap= (Map) JSONObject.toBean(jsonObject1, HashMap.class);

            HttpSession session=request.getSession();
            Map map=(Map) session.getAttribute("account");
            String stuffid= BaseUtil.transObjToStr(map.get("stuffid"));
            JSONObject jsonObject=JSONObject.fromObject(pageInfo);
            PageEntity pageEntity=(PageEntity) JSONObject.toBean(jsonObject,PageEntity.class);
            pageEntity=dayReportService.selectReportForStuff(jsonmap,pageEntity,stuffid);
            JSONObject page=JSONObject.fromObject(pageEntity);
            out.print(page.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 查询已提交的日报
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectReportView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DayReportService dayReportService = new DayReportServiceImpl();
        String pageInfo=request.getParameter("pageInfo");
        PrintWriter out=response.getWriter();
        try {
            HttpSession session=request.getSession();
            Map map=(Map) session.getAttribute("account");
            String stuffid= BaseUtil.transObjToStr(map.get("stuffid"));
            JSONObject jsonObject=JSONObject.fromObject(pageInfo);
            PageEntity pageEntity=(PageEntity) JSONObject.toBean(jsonObject,PageEntity.class);
            pageEntity=dayReportService.selectReportView(pageEntity,stuffid);
            JSONObject page=JSONObject.fromObject(pageEntity);
            out.print(page.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据日报id查询日报具体信息
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectReportById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dayreportid=request.getParameter("dayreportid");
        DayReportService dayReportService = new DayReportServiceImpl();
        try {
            Map map=dayReportService.selectReportById(dayreportid);
            PrintWriter out=response.getWriter();
            JSONObject jsonObject = JSONObject.fromObject(map);
            out.print(jsonObject.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 日报审核-查询
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectAudit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DayReportService dayReportService = new DayReportServiceImpl();
        String pageInfo=request.getParameter("pageInfo");
        PrintWriter out=response.getWriter();
        try {
            HttpSession session=request.getSession();
            Map map=(Map) session.getAttribute("account");
            String stuffid= BaseUtil.transObjToStr(map.get("stuffid"));
            JSONObject jsonObject=JSONObject.fromObject(pageInfo);
            PageEntity pageEntity=(PageEntity) JSONObject.toBean(jsonObject,PageEntity.class);
            pageEntity= dayReportService.selectAudit(pageEntity,stuffid);
            JSONObject page=JSONObject.fromObject(pageEntity);
            out.print(page.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据id查询日报
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectDayReportById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dayreportid=request.getParameter("dayreportid");
        DayReportService dayReportService = new DayReportServiceImpl();
        try {
            Map map=dayReportService.selectReportById(dayreportid);
            PrintWriter out=response.getWriter();
            JSONObject jsonObject = JSONObject.fromObject(map);
            out.print(jsonObject.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增或修改日报
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void insertOrUpdateReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DayReportService dayReportService = new DayReportServiceImpl();
        String datainfo=request.getParameter("datainfo");
        PrintWriter out=response.getWriter();
        try {
            HttpSession session=request.getSession();
            Map map= (Map) session.getAttribute("account");//获取session中的登陆信息
            JSONObject jsonObject= JSONObject.fromObject(datainfo);
            Map dataMap= (Map) JSONObject.toBean(jsonObject, HashMap.class);
            dataMap.putAll(map);//session的登陆信息放到了日报的信息中
            int i = dayReportService.insertOrUpdateReport(dataMap);
            out.print(i);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 更新日报状态
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void updateWriteState(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DayReportService dayReportService = new DayReportServiceImpl();
        String dayreportid=request.getParameter("dayreportid");
        String writestate=request.getParameter("writestate");
        PrintWriter out=response.getWriter();
        try {
            dayReportService.updateWriteState(writestate,dayreportid);
            out.print(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 新增审核意见
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void insertAudit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInfo=request.getParameter("dataInfo");
        JSONObject jsonObject=JSONObject.fromObject(dataInfo);
        Map map= (Map) jsonObject.toBean(jsonObject, HashMap.class);
        DayReportService dayReportService = new DayReportServiceImpl();
        try {
            Message message=dayReportService.insertAudit(map);
            JSONObject jsonObject1=JSONObject.fromObject(message);
            PrintWriter out=response.getWriter();
            out.print(jsonObject1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据日报id查看审核意见
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void selectAuditByReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dayreportid=request.getParameter("dayreportid");
        DayReportService dayReportService = new DayReportServiceImpl();
        try {
            List<Map> map=dayReportService.selectAuditByReport(dayreportid);
            PrintWriter out=response.getWriter();

            JSONArray jsonObject = JSONArray.fromObject(map);

            System.out.println(jsonObject.toString());
            out.print(jsonObject.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 日历-日报填写情况
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void calendarForDayReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        DayReportService dayReportService = new DayReportServiceImpl();
        try {
            String date=request.getParameter("dateinfo");
            String stuffid=request.getParameter("stuffid");
            List list=dayReportService.calendarForDayReport(stuffid,date);
            JSONArray jsonArray=JSONArray.fromObject(list);
            out.print(jsonArray.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
