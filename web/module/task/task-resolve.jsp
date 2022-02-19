<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>任务分解</title>
    <link rel="icon" href="../../resource/favicon.ico" type="image/ico">
    <link href="../../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../../resource/css/style.min.css" rel="stylesheet">
</head>
<body>
<div class="lyear-layout-web">
    <div class="lyear-layout-container">

        <!--页面主要内容-->
        <%--<main class="lyear-layout-content">--%>

        <div class="container-fluid">

            <div class="row">
                <div class="col-lg-12">
                    <div class="card" >
                        <div class="card-body" style="padding-bottom: 0px;padding-left: 150px">

                            <form class="form-inline" method="post" onsubmit="return false;">
                                <div class="form-group" style="padding-right: 100px">
                                    <a class="btn btn-primary m-r-5" onclick="toAdd(${param.projectid},'${param.projectname}')" ><i class="mdi mdi-plus"></i> 新增</a>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" type="text" id="projectid" style="display: none"  placeholder="${param.projectid}">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" type="text" id="address" style="display: none"  placeholder="${param.projectname}">
                                </div>
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

        <%--</main>--%>
        <!--End 页面主要内容-->
    </div>

    <%--模态框--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增子任务</h4>
                </div>
                <div id="main" ></div>
            </div>
        </div>
    </div>
    <%--新增父任务--%>
    <div class="modal fade" id="addTaskModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel1">新增父任务</h4>
                </div>
                <div id="main2" ></div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="../../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>
<%--消息提示--%>
<script src="../../resource/js/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="../../resource/js/lightyear.js"></script>
<script type="text/javascript" src="../../resource/js/main.min.js"></script>
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
    //查询项目
    function load(nowPage) {
        var projectid='${param.projectid}';
        var obj={projectname:$("#projectname").val(),projectstart:$("#task-start").val(),projectent:$("#task-end").val(),projectprin:$("#projectprin").val()};
        var pageInfo={nowPage:nowPage,rows:8};
        $.ajax({
            url:"${path}/task/selectTaskByProjectId",
            data:{dataInfo:JSON.stringify(obj),pageInfo:JSON.stringify(pageInfo),projectid:projectid},
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
                        var html="<tr id='father"+obj.taskid+"'>\n" +
                            "       <td>"+(i+1)+"</td>\n" +
                            "       <td>"+obj.taskname+"</td>\n" +
                            "       <td>"+obj.begindate+"</td>\n" +
                            "       <td>"+obj.endtime+"</td>\n" +
                            "       <td>"+obj.taskdescr+"</td>\n";

                        html=html+"       <td>\n" +
                            "       <div class=\"btn-group\">\n" +
                            "       <a class=\"btn btn-xs btn-default\" onclick='selectSonTask(this,"+obj.taskid+")' title=\"展开子任务\" data-toggle=\"tooltip\"><i class=\"mdi mdi-arrow-down\"></i></a>\n" +
                            "       <a class=\"btn btn-xs btn-default\" onclick='addSonTask("+obj.taskid+",\"${param.projectid}\",\"${param.projectname}\",\""+obj.taskname+"\")' title=\"新增子任务\" data-toggle=\"tooltip\"><i class=\"mdi mdi-plus\"></i></a>\n" +
                            "       </div>\n" +
                            "       </td>\n" +
                            "       </tr>";
                        //展开子任务
                        html=html+"<tr class='sonTask' style='display:none;'>" +
                            "<td colspan='10' style='padding:0px'>" +
                            "<table class=\"table table-bordered\" style='padding: 0px'>" +
                            "<thead>"+
                            "   <tr>" +
                            "   <th>序号</th>" +
                            "   <th>子任务名称</th>" +
                            "   <th>\n" +
                            "   开始时间\n" +
                            "   </th>"+
                            "   <th>\n" +
                            "     结束时间\n" +
                            "   </th>\n" +
                            "   <th>\n" +
                            "    任务描述\n" +
                            "    </th>\n" +
                            "   <th>\n" +
                            "    发布人\n" +
                            "    </th>\n" +
                            "    <th>\n" +
                            "    子任务状态\n" +
                            "    </th>\n" +
                            "    <th>\n" +
                            "    领取人\n" +
                            "     </th>\n" +
                            "</tr>"+
                            "</thead> "+
                            "<tbody id='sonTask"+obj.taskid+"'> "+
                            "</tbody>"+
                            "<table>" +
                            "</td>" +
                            "</tr>";
                        $("#tab").append(html);
                    }
                }
            }
        })
    }
    <%
                       Map map=(Map) session.getAttribute("account");
                       String resolveName=map.get("username").toString();
           %>
    var fabuuname="<%=resolveName%>";
    function selectSonTask(obj,id) {
        $.ajax({
            url:"${path}/task/selectTaskByFatherId",
            dataType:"json",
            type:"post",
            data:{fatherid:id},
            success:function (data) {
                $("#sonTask"+id).html("");
                for (var i = 0; i < data.length; i++) {
                    var obj=data[i];
                    var tr="<tr>\n" +
                        "                    <td>"+(i+1)+"</td>\n" +
                        "                    <td>"+obj.taskname+"</td>\n" +
                        "                    <td >"+obj.begindate+"</td>\n" +
                        "                    <td >"+obj.endtime+"</td>\n" +
                        "                    <td >"+obj.taskdescr+"</td>\n" +
                        "                    <td >"+fabuuname+"</td>\n" +
                        "                    <td class=\"td-status\">\n" ;
                    if(obj.taskstate==0){
                        tr=tr+"<a class=\"btn btn-warning m-r-5\" ><i class=\"mdi mdi-block-helper\"></i> 未领取</a>";
                    }else if (obj.taskstate==1){
                        tr=tr+"<a class=\"btn btn-success m-r-5\" ><i class=\"mdi mdi-check\"></i> 已领取</a>";
                    }else if (obj.taskstate==2){
                        tr=tr+"<a class=\"btn btn-success m-r-5\" ><i class=\"mdi mdi-check\"></i> 已提交</a>";
                    }else if (obj.taskstate==3){
                        tr=tr+"<a class=\"btn btn-success m-r-5\" ><i class=\"mdi mdi-check\"></i> 已审核</a>";
                    }else if (obj.taskstate==4){
                        tr=tr+"<a class=\"btn btn-warning m-r-5\" ><i class=\"mdi mdi-block-helper\"></i> 有异议</a>";
                    }
                    tr=tr+"<td>"+obj.name+"</td>";
                    $("#sonTask"+id).append(tr);
                }
            }
        });
        $("#father"+id).next().toggle();
    }
    //新增子任务
    function addSonTask(FatherTaskid,projectid,projectname,taskFaname) {
        $("#myModal").modal('show');
        $("#main").load("task-addSonTask.jsp?FatherTaskid="+FatherTaskid+"&projectid="+projectid+"&projectname="+projectname+"&taskFaname="+taskFaname+"");
    }
    //新增父任务
    function toAdd(projectid,projectname) {
        $("#addTaskModal").modal('show');
        $("#main2").load("task-addFatherTask.jsp?projectid="+projectid+"&projectname="+projectname+"");
    }
</script>
</body>
</html>
