<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>职务管理</title>
    <link rel="icon" href="../../resource/favicon.ico" type="image/ico">
    <link href="../../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../../resource/css/style.min.css" rel="stylesheet">
    <link href="../../resource/zTree_v3/css/metroStyle/metroStyle.css" rel="stylesheet"/>
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
                            <div class="card-body" style="padding-bottom: 0px;padding-left: 100px">

                                <form class="form-inline" method="post" onsubmit="return false;">
                                    <div class="form-group" style="padding-right: 150px">
                                        <a class="btn btn-primary m-r-5" onclick="toAdd()" ><i class="mdi mdi-plus"></i> 新增</a>
                                    </div>
                                    <div class="form-group" style="padding-left: 70px">
                                        <input class="form-control" type="text" id="positionno"  placeholder="职位编号">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" type="text" id="positionname"  placeholder="职位名称">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" type="text" id="positiondescr"  placeholder="职位描述">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" type="text" id="positionstate"  placeholder="职位状态">
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
                                            <th>职位编号</th>
                                            <th>职位名称</th>
                                            <th>职位描述</th>
                                            <th>职位状态</th>
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
                    <h4 class="modal-title" id="myModalLabel">权限分配</h4>
                </div>
                <div class="modal-body">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary">点击保存</button>
                </div>
            </div>
        </div>
    </div>
    <%--新增职位模态框--%>
    <div class="modal fade" id="addPosModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel1">新增职位</h4>
                </div>
                <jsp:include page="pos-add.jsp" flush="true" />
            </div>
        </div>
    </div>
    <%--编辑模态框--%>
    <div class="modal fade" id="editPosModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content" id="modal-content2">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">修改职位信息</h4>
                </div>
                <div id="main1" ></div>
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
    var nowPage;
    $().ready(function () {
        load(1);
        nowPage=Number($("#nowPage").html());
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
        var obj={positionno:$("#positionno").val(),positionname:$("#positionname").val(),positiondescr:$("#positiondescr").val(),positionstate:$("#positionstate").val()};
        var pageInfo={nowPage:nowPage,rows:8};
        $.ajax({
            url:"${path}/position/selectPosition",
            data:{dataInfo:JSON.stringify(obj),pageInfo:JSON.stringify(pageInfo)},
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
                            "       <td>"+obj.positionno+"</td>\n" +
                            "       <td>"+obj.positionname+"</td>\n"+
                            "       <td>"+obj.positiondescr+"</td>\n";

                        if (obj.positionstate==0) {
                            html=html+"<td><a class=\"btn btn-success m-r-5\" href=\"#!\"><i class=\"mdi mdi-check\"></i> 已启用</a></td>\n" ;
                        }else if (obj.positionstate==1){
                            html=html+"<td><a class=\"btn btn-warning m-r-5\" href=\"#!\"><i class=\"mdi mdi-block-helper\"></i> 已禁用</a></td>\n";
                        }
                        html=html+"       <td>\n" +
                            "       <div class=\"btn-group\">\n" +
                            "       <a class=\"btn btn-xs btn-default\" onclick='editPos("+obj.positionid+")' title=\"编辑\" data-toggle=\"tooltip\"><i class=\"mdi mdi-pencil\"></i></a>\n" ;
                        if (obj.positionstate==1||obj.positionstate=='1'){
                            html=html+"<a onclick='deletePos("+obj.positionstate+","+obj.positionid+")' class=\"btn btn-xs btn-default\" href=\"#!\" title=\"启用\" data-toggle=\"tooltip\"><i class=\"mdi mdi-comment-check\"></i></a>\n";

                        }else {
                            html=html+"<a onclick='deletePos("+obj.positionstate+","+obj.positionid+")' class=\"btn btn-xs btn-default\" href=\"#!\" title=\"禁用\" data-toggle=\"tooltip\"><i class=\"mdi mdi-window-close\"></i></a>\n" ;
                        }
                        html=html+ "       </td>\n" +
                            "     </tr>";
                        $("#tab").append(html);
                    }
                }
            }
        })
    }
    //新增
    function toAdd() {
        $("#addPosModal").modal('show');
    }
    //编辑
    function editPos(id){
        //data-toggle="modal" data-target="#editStuffModal"
        $("#editPosModal").modal('show');
        $("#main1").load("pos-edit.jsp?positionid="+id);
    }
    //启用禁用
    function deletePos(oldstate,id) {
        $.confirm({
            title: '提示',
            content: '<p class="text-center" style="font-size: 18px;">确认操作吗</p>',
            buttons: {
                confirm: {
                    text: '确认',
                    btnClass: 'btn-primary',
                    action: function(){
                        var state=0;
                        if (oldstate==1||oldstate=="1"){
                            state=0;
                        }else {
                            state=1;
                        }
                        $.ajax({
                            url:"${path}/position/deletePosition",
                            dataType:"json",
                            data:{state:state,id:id},
                            type:"post",
                            success:function (data) {
                                if (data.state){
                                    load(nowPage);
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
</script>
</body>
</html>
