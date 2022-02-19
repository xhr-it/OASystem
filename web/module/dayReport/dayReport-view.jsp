<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>日报查询</title>
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
                                            <th>提交时间</th>
                                            <th>填报类型</th>
                                            <th>状态</th>
                                            <th>提交人</th>
                                            <th>操作</th>
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

    <%--查看日报详情模态框--%>
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
                            <input type="text" class="form-control" id="title1">
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
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <%--查看审核意见--%>
    <div class="modal fade" id="opinionModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">日报内容</h4>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>序号</th>
                                <th>审核状态</th>
                                <th>审核意见</th>
                                <th>审核人</th>
                                <th>审核时间</th>
                            </tr>
                            </thead>
                            <tbody id="opinion">

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
<%--<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>--%>
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
    //查询
    function load(nowPage) {
        var pageInfo={nowPage:nowPage,rows:8};
        $.ajax({
            url:"${path}/dayReport/selectReportView",
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
                            "<td>"+obj.title+"</td>\n";
                        if (obj.submitdate==null){
                            html=html+"<td>未提交</td>\n";
                        }else {
                            html=html+"<td>"+obj.submitdate+"</td>\n";
                        }
                        html=html+"<td >"+obj.reportstate+"</td>\n" +
                            "      <td>"+obj.writestate+"</td>\n" +
                            "      <td>"+obj.createstuffname+"</td>\n" +
                            "      <td>" +
                            "<button type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#myModal\" name=\"modal\" dayreportid='"+obj.dayreportid+"'>查看详情</button>" +
                            "      </td>\n";
                        if(obj.writestate=='已审核'){
                            html=html+"<td><a class=\"btn btn-success m-r-5\" onclick='lookOpinion("+obj.dayreportid+")'><i class=\"mdi mdi-check\"></i> 查看意见</a></td>\n" ;
                        }else {
                            html=html+"<td>尚未审核</td>\n" ;
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
        console.log("test");
        var dayreportid=$(this).attr('dayreportid');
        $.ajax({
            url:"${path}/dayReport/selectReportById",
            data:{dayreportid:dayreportid},//给后台参数 organ
            dataType:"json",
            type:"post",
            success:function (data) {
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
    //查看审核意见
    function lookOpinion(dayreportid) {
        $("#dayreportid").html(dayreportid);
        $('#opinionModal').modal('show');
        $.ajax({
            url:"${path}/dayReport/selectAuditByReport",
            data:{dayreportid:dayreportid},
            dataType:"json",
            type:"post",
            success:function(data) {
                console.log(data);
                $("#opinion").html("");
                for (var i = 0; i < data.length; i++) {
                    var obj = data[i];
                    var tr = "<tr>\n" +
                        "        <td>"+(i+1)+"</td> " +
                        "                        <td>" +obj.aduitstate+ "</td>\n" +
                        "                        <td>" + obj.content + "</td>\n" +
                        "                        <td>" + obj.aduitstuffname + "</td>\n" +
                        "                        <td>" + obj.opintime + "</td>\n" +
                        "                    </tr>";
                    $("#opinion").append(tr);
                }
            }
            // }
        });
    }
</script>
</body>
</html>
