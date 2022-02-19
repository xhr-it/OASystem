<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>日报审核</title>
    <link rel="icon" href="../../resource/favicon.ico" type="image/ico">
    <link href="../../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../../resource/css/style.min.css" rel="stylesheet">
    <link href="../../resource/zTree_v3/css/metroStyle/metroStyle.css" rel="stylesheet"/>
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

                            <div class="card-body" >

                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>日报名称</th>
                                            <th>日报内容</th>
                                            <th>提交时间</th>
                                            <th>填报类型</th>
                                            <th>状态</th>
                                            <th>意见</th>
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

    <%--日报详情模态框--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">日报内容</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="title1" class="control-label">标题：</label>
                            <input type="text" class="form-control" id="title1" readonly>
                        </div>
                        <div class="form-group">
                            <label for="content1" class="control-label" readonly>内容：</label>
                            <textarea class="form-control" id="content1" readonly></textarea>
                        </div>
                        <div class="form-group">
                            <label for="createstuffname" class="control-label" readonly>提交人：</label>
                            <textarea class="form-control" id="createstuffname" readonly></textarea>
                        </div>
                        <div class="form-group">
                            <label for="rbrq" class="control-label" readonly>日报日期：</label>
                            <textarea class="form-control" id="rbrq" readonly></textarea>
                        </div>
                        <div class="form-group">
                            <label for="tjsj" class="control-label" readonly>提交时间：</label>
                            <textarea class="form-control" id="tjsj" readonly></textarea>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%--日报审核模态框--%>
    <div class="modal fade" id="auditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">日报内容</h4>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="dayreportid1">
                    <input type="hidden" id="rbzt">
                    <form>
                        <div class="form-group">
                            <label for="submitdate" class="control-label">提交日期：</label>
                            <input type="text" class="form-control" id="submitdate" readonly>
                        </div>
                        <div class="form-group">
                            <label for="title" class="control-label" readonly>日报标题：</label>
                            <textarea class="form-control" id="title" readonly></textarea>
                        </div>
                        <div class="form-group">
                            <label for="content" class="control-label" readonly>日报内容：</label>
                            <textarea class="form-control" id="content" readonly></textarea>
                        </div>
                        <div class="form-group">
                            <label for="aduitcon" class="control-label" readonly>审核意见：</label>
                            <textarea value="请输入您的意见" class="form-control" id="aduitcon" ></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="auditBtn">点击保存</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="../../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resource/js/bootstrap.min.js"></script>
<%--<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>--%>
<%@ include file="../../resource/common.jsp"%>
<script>
    var time1=new Date();
    var year=time1.getFullYear();
    var month="0"+(time1.getMonth()+1);
    var day=time1.getDate();
    var day2=time1.getDate()-6;
    var fdate=(year+"-"+month+"-"+day2);
    var nowdate=(year+"-"+month+"-"+day);
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
    //查询
    function load(nowPage) {
        var pageInfo={nowPage:nowPage,rows:8};
        $.ajax({
            url:"${path}/dayReport/selectAudit",
            data:{pageInfo:JSON.stringify(pageInfo)},
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
                        var html="<tr>"+
                            "<td>"+(i+1)+"</td>" +
                            "<td>"+obj.title+"</td>" +
                            "<td><button type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#myModal\" name=\"modal\" dayreportid='"+obj.dayreportid+"'>日报内容</button></td>" +
                            "<td>"+obj.submitdate+"</td>" +
                            "<td>"+obj.reportstate+"</td>" +
                            "<td>"+obj.writestate+"</td>\n";
                        if(obj.writestate=='已提交'){
                            html=html+"<td><a onclick='toAudit("+obj.dayreportid+")' class=\"btn btn-success m-r-5\" > 审核</a></td>\n" ;
                        }else {
                            html=html+"<td>尚未提交</td>\n" ;
                        }
                        html=html+"</tr>";
                        $("#tab").append(html);
                    }
                }
            }
        })
    }

    //点击按钮查看日报详情
    $("#tab").on("click","button[name='modal']",function () {
        var dayreportid=$(this).attr('dayreportid');
        console.log(dayreportid)
        $.ajax({
            url:"${path}/dayReport/selectReportById",
            data:{dayreportid:dayreportid},//给后台参数 organ
            dataType:"json",
            type:"post",
            success:function (data) {
                console.log(data)
                $("#title1").val(data.title);
                $("#content1").val(data.content);
                $("#createstuffname").val(data.name);
                $("#rbrq").val(data.reportdate);
                // if(data.submitdate!=""||data.submitdate!=null){
                $("#tjsj").val(data.submitdate);
                // }else if(data.submitdate!="未提交"){
                //     $("#tjsj").val("未提交");
                // }
            }
        });
    })
    //审核模态框
    function toAudit(dayreportid) {
        $("#aduitcon").val("");
        $("#auditModal").modal('show');
        $.ajax({
            url:"${path}/dayReport/selectDayReportById",
            data:{dayreportid:dayreportid},//给后台参数 organ
            dataType:"json",
            type:"post",
            success:function (data) {
                $("#rbzt").val(data.reportsate);
                $("#dayreportid1").val(dayreportid);
                $("#submitdate").val(data.submitdate);
                $("#title").val(data.title);
                $("#content").val(data.content);
            }
        });
    }
    //点击通过审核-修改填报状态
    $("#auditBtn").click(function () {
        var dayreportid=$("#dayreportid1").val();
        $.ajax({
            url:"${path}/dayReport/updateWriteState",
            data:{"dayreportid":dayreportid,writestate:'2'},//给后台参数 organ
            dataType:"text",
            type:"post",
            success:function (data) {
                load(1);
                $("#auditModal").modal('hide');
            }
        });
    })
    //点击通过审核-新增审核意见
    $("#auditBtn").click(function () {
        var pid='${sessionScope.account.stuffid}'
        var pname='${sessionScope.account.name}'
        var obj={dayreportid:$("#dayreportid1").val(),content:$("#aduitcon").val(),opintime:nowdate,
            aduitstate:1,aduitstuffid:pid,aduitstuffname:pname}
        $.ajax({
            url:"${path}/dayReport/insertAudit",
            dataType:"json",
            type:"post",
            data:{dataInfo:JSON.stringify(obj)},
            success:function (data) {
                load(1);
            }
        });
    });
</script>
</body>
</html>
