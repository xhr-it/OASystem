<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>周报审核</title>
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

                            <div class="card-body" >

                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>周报名称</th>
                                            <th>周报内容</th>
                                            <th>提交时间</th>
                                            <th>填报类型</th>
                                            <th>周报状态</th>
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
                    <h4 class="modal-title" id="myModalLabel">周报审核</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="reportid1" class="control-label">周报id：</label>
                            <input type="text" class="form-control" id="reportid1" readonly>
                        </div>
                        <div class="form-group">
                            <label for="submitdate" class="control-label" readonly>提交日期：</label>
                            <input type="text" class="form-control" id="submitdate" readonly>
                        </div>
                        <div class="form-group">
                            <label for="rbzt" class="control-label" readonly>周报状态：</label>
                            <input type="text" class="form-control" id="rbzt" readonly>
                        </div>
                        <div class="form-group">
                            <label for="title" class="control-label" readonly>周报标题：</label>
                            <input type="text" class="form-control" id="title" readonly>
                        </div>
                        <div class="form-group">
                            <label for="content" class="control-label" readonly>周报内容：</label>
                            <textarea class="form-control" id="content" readonly></textarea>
                        </div>
                        <div class="form-group">
                            <label for="aduitcon" class="control-label" readonly>审核意见：</label>
                            <textarea class="form-control" id="aduitcon" ></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="aduitbtn">通过审核</button>
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
    //查询所有账号
    function load(nowPage) {
        var pageInfo={nowPage:nowPage,rows:8};
        $.ajax({
            url:"${path}/weekReport/selectAudit",
            data:{pageInfo:JSON.stringify(pageInfo)},
            dataType:"json",
            type:"post",
            success:function (page) {
                console.log(page)
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
                            "       <td>"+obj.title+"</td>\n" +
                            "       <td>周报内容</td>\n" +
                            "       <td>"+obj.submitdate+"</td>\n"+
                            "       <td>"+obj.reportstate+"</td>\n"+
                            "       <td>"+obj.writestate+"</td>\n";

                        if (obj.writestate=='已提交') {
                            html = html + "<td><input  class='btn btn-warning'  type='button' value='审核' onclick='shenhe(" + obj.reportid + ")' /></td>";
                        }else {
                            html=html+"<td><a class=\"btn btn-warning m-r-5\" href=\"#!\"><i class=\"mdi mdi-block-helper\"></i> 不可操作</a></td>\n";
                        }

                        html=html+"     </tr>";
                        $("#tab").append(html);
                    }
                }
            }
        })
    }
    function shenhe(reportid){
        $("#aduitcon").val("");
        $('#myModal').modal('show');
        $.ajax({
            url:"${path}/weekReport/selectWeekById",
            data:{reportid:reportid},//给后台参数 organ
            dataType:"json",
            type:"post",
            success:function (data) {
                $("#rbzt").val(data.reportstate);
                $("#reportid1").val(reportid);
                $("#submitdate").val(data.submitdate);
                $("#title").val(data.title);
                $("#content").val(data.content);
            }
        });
    }
    //点击通过审核-更新状态
    $("#aduitbtn").click(function () {
        var dayreportid=$("#reportid1").val();
        $.ajax({
            url:"${path}/weekReport/updateWriteState",
            data:{"reportid":dayreportid,writestate:'2'},//给后台参数 organ
            dataType:"text",
            type:"post",
            success:function (data) {
                load(1);
                $("#myModal").modal('hide');
            }
        });
    })
    var time1=new Date();
    var year=time1.getFullYear();
    var month="0"+(time1.getMonth()+1);
    var day=time1.getDate();
    var day2=time1.getDate()-6;
    var fdate=(year+"-"+month+"-"+day2);
    var nowdate=(year+"-"+month+"-"+day);
    //点击审核通过-新增审核
    $("#aduitbtn").click(function () {
        var pid='${sessionScope.account.stuffid}'
        var pname='${sessionScope.account.name}'
        var obj={reportid:$("#reportid1").val(),content:$("#aduitcon").val(),opintime:nowdate,
            aduitstate:1,aduitstuffid:pid,aduitstuffname:pname}
        $.ajax({
            url:"${path}/weekReport/insertAudit",
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
