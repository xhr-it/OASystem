<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>任务审核</title>
    <link rel="icon" href="../../resource/favicon.ico" type="image/ico">
    <link href="../../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resource/css/materialdesignicons.min.css" rel="stylesheet">
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
                                            <th>任务发布人</th>
                                            <th>任务领取人</th>
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

    <%--模态框--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">任务审核</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="task-no" class="control-label">任务编号：</label>
                            <input type="text" class="form-control" id="task-no" readonly>
                        </div>
                        <div class="form-group">
                            <label for="task-name" class="control-label" readonly>任务名称：</label>
                            <input type="text" class="form-control" id="task-name" readonly>
                        </div>
                        <div class="form-group">
                            <label for="task-startTime" class="control-label" readonly>实际开始时间：</label>
                            <input type="text" class="form-control" id="task-startTime" readonly>
                        </div>
                        <div class="form-group">
                            <label for="task-endTime" class="control-label" readonly>实际结束时间：</label>
                            <input type="text" class="form-control" id="task-endTime" readonly>
                        </div>
                        <div class="form-group">
                            <label for="task-describe" class="control-label" readonly>任务内容：</label>
                            <textarea class="form-control" id="task-describe" readonly></textarea>
                        </div>
                        <div class="form-group">
                            <label for="taskPeo" class="control-label" readonly>任务领取人：</label>
                            <input type="text" class="form-control" id="taskPeo" readonly>
                        </div>
                        <div class="form-group" style="display: none">
                            <label for="task-opNo" class="control-label" readonly>任务编号：</label>
                            <input type="text" class="form-control" value="001" id="task-opNo" readonly>
                        </div>
                        <div class="form-group">
                            <label for="task-suggetion" class="control-label" readonly>审核意见：</label>
                            <textarea class="form-control" id="task-suggetion" ></textarea>
                        </div>
                        <div class="form-group">
                            <label for="taskresult" class="control-label" readonly>审核意见：</label>
                            <select class="form-control" id="taskresult"  size="1">
                                <option>请选择</option>
                                <option value="1" >已阅</option>
                                <option value="2">有异议</option>
                            </select>
                        </div>
                        <div class="form-group" >
                            <label for="task-auditDate" class="control-label" readonly>审核日期：</label>
                            <input type="text" class="form-control" value="001" id="task-auditDate" readonly>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="saveBtn">通过审核</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="../../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>
<!--消息提示-->
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
    //查询已提交任务
    <%
                       Map map=(Map) session.getAttribute("account");
                       String resolveName=map.get("username").toString();
                       String resolveid=map.get("stuffid").toString();
           %>
    var resolveName="<%=resolveName%>";
    function load(nowPage) {
        var obj={taskname:$("#taskname").val(),taskstart:$("#task-start").val(),taskend:$("#task-end").val()};
        var pageInfo={nowPage:nowPage,rows:8};
        $.ajax({
            url:"${path}/task/selectTaskAudit",
            data:{dateInfo:JSON.stringify(obj),pageInfo:JSON.stringify(pageInfo)},
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
                            "       <td>"+resolveName+"</td>\n" +
                            "       <td>"+obj.name+"</td>\n";
                        html=html+"       <td>\n" +
                            "       <button type=\"button\" class=\"btn btn-primary\" onclick=\"auditTask("+obj.taskid+")\">\n" +
                            "      审核\n" +
                            "   </button>"+
                            "       </td>\n" +
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

    var fabuuname="<%=resolveName%>";
    var fabuid="<%=resolveid%>";
    var date="<%=now%>";
    //审核
    function auditTask(taskid) {
        $("#myModal").modal('show');
        $.ajax({
            url:"${path}/task/selectTaskById",
            dataType:"json",
            data:{taskid:taskid},
            type:"post",
            success:function (data) {
                console.log(data);
                for (var i = 0; i <data.length ; i++) {
                    var obj=data[i];
                    $("#task-no").val(obj.taskid);
                    $("#task-name").val(obj.taskname);
                    $("#task-startTime").val(obj.realystarttime);
                    $("#task-endTime").val(obj.realyendtime);
                    $("#task-describe").val(obj.taskdescr);
                    $("#taskPeo").val(obj.name);
                    $("#task-auditDate").val(date);
                    $("#task-auditPeo").val(fabuuname);
                }
            }
        })
    }
    //审核通过
    $("#saveBtn").click(function () {
        var id=$("#task-no").val();
        var obj={opno:$("#task-opNo").val(),auditstate:$("#taskresult").val(),
            opdescr:$("#task-suggetion").val(),optime:$("#task-auditDate").val(),
            taskid:id,auditpeo:fabuid};
        $.ajax({
            url:"${path}/task/insertOpinion",
            dataType:"json",
            data:{dateInfo:JSON.stringify(obj)},
            type:"post",
            success:function(data){
                console.log(data);
                if (data.state==true||data.state=='true'){
                    lightyear.loading('show');
                    setTimeout(function() {
                        lightyear.loading('hide');
                        lightyear.notify(data.message,'success', 3000,'mdi mdi-emoticon-happy','bottom');
                    }, 1e2);
                    setInterval(function () {
                        window.location.reload();
                    },1e3)
                }
            }
        })
    })
</script>
</body>
</html>
