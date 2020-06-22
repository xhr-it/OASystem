<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的任务</title>
    <link rel="icon" href="../../resource/favicon.ico" type="image/ico">
    <link href="../../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../../resource/css/style.min.css" rel="stylesheet">
    <!--对话框-->
    <link rel="stylesheet" href="../../resource/js/jconfirm/jquery-confirm.min.css">
    <link href="../../resource/css/style.min.css" rel="stylesheet">
</head>
<body>
<div class="lyear-layout-web">
    <div class="lyear-layout-container">

        <!--页面主要内容-->
        <main class="lyear-layout-content">

            <div class="container-fluid">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="card" >
                            <div class="card-body" style="padding-bottom: 0px;padding-left: 500px">

                                <form class="form-inline" method="post" onsubmit="return false;">
                                    <div class="form-group">
                                        <input class="form-control" type="text" id="taskname"  placeholder="请输入任务名称">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" type="date" id="task-start"  placeholder="请输入起始时间">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" type="date" id="task-end"  placeholder="请输入结束时间">
                                    </div>
                                    <div class="form-group">
                                        <button class="btn btn-default" type="button" id="selectBtn">搜索</button>
                                    </div>
                                </form>

                            </div>

                            <div class="card-body" >

                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>任务名称</th>
                                            <th>开始时间</th>
                                            <th>结束时间</th>
                                            <th>任务描述</th>
                                            <th>项目发布人</th>
                                            <th>所属项目</th>
                                            <th>项目领取人</th>
                                            <th>任务状态</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody id="tab">

                                        </tbody>
                                    </table>
                                </div>

                                <ul class="pagination" id="page" style="padding-left: 500px">

                                </ul>
                                <span style="display: none">
                                        总页数：<span  id="allPage"></span>
                                        总条数：<span  id="allRows"></span>
                                        当前页：<span  id="nowPage">1</span>
                                </span>

                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </main>
        <!--End 页面主要内容-->
    </div>

    <%--查看意见模态框--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">审核意见</h4>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>意见序号</th>
                                <th>审核人</th>
                                <th>意见详情</th>
                                <th>审核日期</th>
                                <th>审核结果</th>
                            </tr>
                            </thead>
                            <tbody id="opinionTab">

                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="../../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>
<!--对话框-->
<script type="text/javascript" src="../../resource/js/jconfirm/jquery-confirm.min.js"></script>
<script type="text/javascript" src="../../resource/js/main.min.js"></script>
<!--消息提示-->
<script src="../../resource/js/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="../../resource/js/lightyear.js"></script>
<%@ include file="../../resource/common.jsp"%>
<script>
    //分页
    $().ready(function () {
        load(1);
        var nowPage=Number($("#nowPage").html());
        $("body").on("click","#prev",function () {
            nowPage=Number($("#nowPage").html());
            if (nowPage==1){
                nowPage=1;
            } else {
                nowPage=nowPage-1;
            }
            load(nowPage);
        })

        $("body").on("click","#next",function () {
            nowPage=Number($("#nowPage").html());
            var allPage=$("#allPage").html();
            if (nowPage==allPage){
                nowPage=allPage;
            } else {
                nowPage=nowPage+1;
            }
            load(nowPage);
        })
        $("#selectBtn").click(function () {
            load(1);
        });
    })
    //查询我的任务
    <%
                       Map map=(Map) session.getAttribute("account");
                       String resolveName=map.get("username").toString();
           %>
    var resolveName="<%=resolveName%>";
    function load(nowPage) {
        var obj={taskname:$("#taskname").val(),taskstart:$("#task-start").val(),taskend:$("#task-end").val()};
        var pageInfo={nowPage:nowPage,rows:8};
        $.ajax({
            url:"${path}/task/selectMyTask",
            data:{id:2,dataInfo:JSON.stringify(obj),pageInfo:JSON.stringify(pageInfo)},
            dataType:"json",
            type:"post",
            success:function (page) {
                $("#nowPage").html(nowPage);
                $("#allPage").html(page.allPage);
                $("#allRows").html(page.allRows);
                $("#tab").html("");
                $("#page").html("")
                if (page!=null){
                    //添加页码
                    if (nowPage==1){
                        var li="<li class=\"disabled\" id=\"prev\"><span>«</span></li>\n";
                    }else {
                        var li="<li id=\"prev\"><span>«</span></li>\n";
                    }
                    for (var i = 1; i <= page.allPage; i++) {
                        if (nowPage==i){
                            li=li+"<li class=\"active\"><span>"+i+"</span></li>\n";
                        }else {
                            li=li+"<li ><span>"+i+"</span></li>\n";
                        }
                    }
                    if (nowPage==page.allPage){
                        li=li+"<li class=\"disabled\" id=\"next\"><a href='javascript:void(0);'>»</a></li>";
                    }else {
                        li=li+"<li id=\"next\"><a href='javascript:void(0);'>»</a></li>";
                    }
                    $("#page").append(li);
                    //添加数据
                    for (var i = 0; i < page.data.length; i++) {
                        var obj=page.data[i];
                        var html="<tr>\n" +
                            "       <td>"+(i+1)+"</td>\n" +
                            "       <td>"+obj.taskname+"</td>\n" +
                            "       <td>"+obj.begindate+"</td>\n" +
                            "       <td>"+obj.endtime+"</td>\n" +
                            "       <td>"+obj.taskdescr+"</td>\n" +
                            "       <td>"+obj.name+"</td>\n" +
                            "       <td>"+obj.projectname+"</td>\n" +
                            "       <td>"+resolveName+"</td>\n";
                        if (obj.taskstate==0) {
                            html=html+"<td><a class=\"btn btn-warning m-r-5\" href=\"#!\"><i class=\"mdi mdi-block-helper\"></i> 未领取</a></td>\n" ;
                        }else if (obj.taskstate==1){
                            html=html+"<td><a class=\"btn btn-success m-r-5\" href=\"#!\"><i class=\"mdi mdi-check\"></i> 已领取</a></td>\n";
                        }else if (obj.taskstate==2){
                            html=html+"<td><a class=\"btn btn-success m-r-5\" href=\"#!\"><i class=\"mdi mdi-check\"></i> 已提交</a></td>\n";
                        }else if (obj.taskstate==3){
                            html=html+"<td><a class=\"btn btn-success m-r-5\" href=\"#!\"><i class=\"mdi mdi-check\"></i> 已审核</a></td>\n";
                        }else if (obj.taskstate==4){
                            html=html+"<td><a class=\"btn btn-success m-r-5\" href=\"#!\"><i class=\"mdi mdi-check\"></i> 已领取</a></td>\n";
                        }

                        html=html+"<td>"
                        if (obj.taskstate==1||obj.taskstate==2||obj.taskstate==3||obj.taskstate==4){
                            html=html+"<a style='display: none' class=\"btn btn-xs btn-default\" title=\"领取\" data-toggle=\"tooltip\"><i class=\"mdi mdi-download\"></i></a>";
                        }else if (obj.taskstate==0){
                            html=html+"<a onclick=\"getTask(this,'"+obj.taskid+"')\" class=\"btn btn-xs btn-default\" title=\"领取\" data-toggle=\"tooltip\"><i class=\"mdi mdi-download\"></i></a>";
                        }
                        if (obj.taskstate==0||obj.taskstate==2||obj.taskstate==3) {
                            html=html+"<a style='display: none' class=\"btn btn-xs btn-default\" title=\"提交\" data-toggle=\"tooltip\"><i class=\"mdi mdi-arrow-up-bold\"></i></a>";
                        }else if (obj.taskstate==1||obj.taskstate==4) {
                            html=html+"<a onclick=\"submitTask(this,'"+obj.taskid+"')\" class=\"btn btn-xs btn-default\" title=\"提交\" data-toggle=\"tooltip\"><i class=\"mdi mdi-arrow-up-bold\"></i></a>";
                        }
                        if (obj.auditstate==1||obj.auditstate==2) {
                          html=html+"<a  onclick=\"selectOpinion("+obj.taskid+")\" class=\"btn btn-xs btn-default\" title=\"查看意见\" data-toggle=\"tooltip\"><i class=\"mdi mdi-magnify\"></i></a>";
                        }
                        html=html+ "       </td>\n" +
                            "     </tr>";
                        $("#tab").append(html);
                    }
                }
            }
        })
    }
    <%
        Date d = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd ");
        String now = df.format(d);
    %>
    var date="<%=now%>";
    //领取
    function getTask(obj,id) {
        var startTime=date;
        var obj={taskrealyStart:startTime,taskid:id};
        $.ajax({
            url:"${path}/task/getTask",
            data:{dateInfo:JSON.stringify(obj)},
            dataType:"json",
            type:"post",
            success:function (data) {
                if (data.state==true||data.state=='true'){
                    load(1);
                }
            }
        });
    }
    //提交
    function submitTask(obj,id) {
        var startTime=date;
        var obj={taskenddate:startTime,taskid:id}
        $.confirm({
            title: '提示',
            content: '<p class="text-center" style="font-size: 18px;">确认提交吗</p>',
            buttons: {
                confirm: {
                    text: '确认',
                    btnClass: 'btn-primary',
                    action: function(){
                        $.ajax({
                            url:"${path}/task/submitTask",
                            dataType:"json",
                            data:{dateInfo:JSON.stringify(obj)},
                            type:"post",
                            success:function (data) {
                                if (data.state){
                                    lightyear.loading('show');
                                    setTimeout(function() {
                                        lightyear.loading('hide');
                                        lightyear.notify('提交成功~','success', 3000,'mdi mdi-emoticon-happy','bottom');
                                    }, 1e2);
                                    load(1);
                                }
                            }
                        })
                    }
                },
                cancel: {
                    text: '关闭'
                }
            }
        });
    }
    //查看意见
    function selectOpinion(taskid) {
        $("#myModal").modal('show');
        $.ajax({
            url:"${path}/task/selectTaskOption",
            dataType:"json",
            data:{taskid:taskid},
            type:"post",
            success:function (data) {
                if (data!=null){
                    $("#opinionTab").html("");
                    for (var i = 0; i <data.length ; i++) {
                        var obj=data[i];
                        console.log(obj);
                        var tr="<tr id='father"+obj.taskid+"'>\n" +
                            "                    <td>"+(i+1)+"</td>\n" +
                            "                    <td>"+obj.name+"</td>\n" +
                            "                    <td >"+obj.opdescr+"</td>\n" +
                            "                    <td >"+obj.optime+"</td>\n" +
                            "                    <td >" ;
                        if (obj.auditstate==1){
                            tr=tr+"<span class=\"layui-btn layui-btn-normal layui-btn-mini\">已审核</span>";
                        }else if (obj.auditstate==2){
                            tr=tr+"<span class=\"layui-btn layui-btn-normal layui-btn-mini\">有异议</span>";
                        }
                        tr=tr+"                    </td>" +
                            "                </tr>";
                        $("#opinionTab").append(tr);
                    }

                }
            }
        })
    }
</script>
</body>
</html>
