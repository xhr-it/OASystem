<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>项目管理</title>
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
                        <div class="card-body" style="padding-bottom: 0px;padding-left: 50px">

                            <form class="form-inline" method="post" onsubmit="return false;">
                                <div class="form-group" style="padding-right: 80px">
                                    <a class="btn btn-primary m-r-5" onclick="toAdd(${param.deptid})" ><i class="mdi mdi-plus"></i> 新增</a>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" type="text" id="projectname"  placeholder="请输入项目名称"  >
                                </div>
                                <div class="form-group">
                                    <label >项目起始时间：</label>
                                    <input class="form-control" type="date" id="task-start" >
                                </div>
                                <div class="form-group">
                                    <label >项目结束时间：</label>
                                    <input class="form-control" type="date" id="task-end" >
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
                                        <th>项目编号</th>
                                        <th>项目名称</th>
                                        <th>开始时间</th>
                                        <th>结束时间</th>
                                        <th>项目描述</th>
                                        <th>项目负责人</th>
                                        <th>项目状态</th>
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
                    <h4 class="modal-title" id="myModalLabel">新增项目</h4>
                </div>
                <div id="main"></div>
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
    //查询项目
    function load(nowPage) {
        var id='${param.deptid}';
        var obj={projectname:$("#projectname").val(),projectstart:$("#task-start").val(),projectent:$("#task-end").val(),projectprin:$("#projectprin").val()};
        var pageInfo={nowPage:nowPage,rows:8};
        $.ajax({
            url:"${path}/project/selectProjectByDept",
            data:{dataInfo:JSON.stringify(obj),pageInfo:JSON.stringify(pageInfo),deptid:id},
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
                            "       <td>"+obj.projectno+"</td>\n" +
                            "       <td>"+obj.projectname+"</td>\n" +
                            "       <td>"+obj.projectstart+"</td>\n" +
                            "       <td>"+obj.projectent+"</td>\n" +
                            "       <td>"+obj.projectdescr+"</td>\n" +
                            "       <td>"+obj.name+"</td>\n";

                        if (obj.projectstate==1) {
                            html=html+"<td><a class=\"btn btn-success m-r-5\" href=\"#!\"><i class=\"mdi mdi-check\"></i> 已启用</a></td>\n" ;
                        }else if (obj.projectstate==0){
                            html=html+"<td><a class=\"btn btn-warning m-r-5\" href=\"#!\"><i class=\"mdi mdi-block-helper\"></i> 未启用</a></td>\n";
                        }

                        html=html+ "       </td>\n" +
                            "       </tr>";

                        $("#tab").append(html);
                    }
                }
            }
        })
    }
    //新增项目
    function toAdd(deptid) {
        $("#myModal").modal('show');
        $("#main").load("project-add.jsp?deptid="+deptid);
    }
</script>
</body>
</html>
