<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工管理</title>
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
        <%--<main class="lyear-layout-content">--%>

            <div class="container-fluid">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="card" >
                            <div class="card-toolbar clearfix">
                                <form class="pull-right search-bar" method="post" action="#!" role="form">
                                    <div class="input-group">
                                        <input class="form-control" type="text" id="name"  placeholder="请输入姓名">
                                        <div class="input-group-btn">
                                            <button class="btn btn-default" type="button" id="selectBtn">搜索</button>
                                        </div>
                                    </div>
                                </form>
                                <div class="toolbar-btn-action">
                                    <a class="btn btn-primary m-r-5" data-toggle="modal" data-target="#addStuffModal" ><i class="mdi mdi-plus"></i> 新增</a>
                                </div>
                            </div>

                            <div class="card-body" >

                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>姓名</th>
                                            <th>性别</th>
                                            <th>地址</th>
                                            <th>入职时间</th>
                                            <th>工作状态</th>
                                            <th>账号名</th>
                                            <th>角色名</th>
                                            <th>操作</th>
                                            <th>权限分配</th>
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

    <%--新增模态框--%>
    <div class="modal fade" id="addStuffModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content" id="modal-content1">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel1">新增员工</h4>
                </div>
                <jsp:include page="stuff-add.jsp" flush="true" />
            </div>
        </div>
    </div>

    <%--编辑模态框--%>
    <div class="modal fade" id="editStuffModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content" id="modal-content2">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">修改员工信息</h4>
                </div>
                <div id="main1" ></div>
            </div>
        </div>
    </div>
    <%--分配角色模态框--%>
    <div class="modal fade" id="distributeActorModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content" id="modal-content3">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel3">分配角色</h4>
                </div>
                <div id="main2" ></div>
            </div>
        </div>
    </div>
    <%--分配账号模态框--%>
    <div class="modal fade" id="distributeAccountModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content" id="modal-content4">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel4">分配账号</h4>
                </div>
                <div id="main3" ></div>
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
        var obj={idcard:null,address:null,phone:null,stuffname:$("#name").val()};
        var pageInfo={nowPage:nowPage,rows:8};
        var id=${param.id};
        $.ajax({
            url:"${path}/stuff/selectStuff",
            data:{dataInfo:JSON.stringify(obj),pageInfo:JSON.stringify(pageInfo),id:id},
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
                            "       <td style='display: none;'>" +
                            "       <input type='hidden' class='stuff' value='"+obj.stuffid+"'>"+
                            "       <input type='hidden' class='account' value='"+obj.accountid+"'>"+
                            "       </td>\n" +
                            "       <td>"+(i+1)+"</td>\n" +
                            "       <td>"+obj.name+"</td>\n";
                        if (obj.sex==0){
                            html=html+"<td>未知</td>\n";
                        }else if (obj.sex==1){
                            html=html+"<td>男</td>\n";
                        }else if (obj.sex==2){
                            html=html+"<td>女</td>\n";
                        }else {
                            html=html+"<td>未说明</td>\n";
                        }

                            html=html+"<td>"+obj.addr+"</td>\n" +
                                "<td>"+obj.time+"</td>\n";

                        if (obj.stuffstate==0) {
                            html=html+"<td><a class=\"btn btn-success m-r-5\" href=\"#!\"><i class=\"mdi mdi-check\"></i> 在岗</a></td>\n" ;
                        }else if (obj.stuffstate==1){
                            html=html+"<td><a class=\"btn btn-warning m-r-5\" href=\"#!\"><i class=\"mdi mdi-block-helper\"></i> 离职</a></td>\n";
                        }

                        if (obj.username==null){
                            html=html+"<td>无</td>\n";
                        }else {
                            html=html+"<td>"+obj.username+"</td>\n";
                        }

                        if (obj.actorname==null){
                            html=html+"<td>无</td>\n";
                        }else {
                            html=html+"<td>"+obj.actorname+"</td>\n";
                        }

                        html=html+"       <td>\n" +
                            "       <div class=\"btn-group\">\n" +
                            "       <a class=\"btn btn-xs btn-default\" onclick='editStuff("+obj.stuffid+")' title=\"编辑\" data-toggle=\"tooltip\"><i class=\"mdi mdi-pencil\"></i></a>\n" ;
                        if (obj.stuffstate==1||obj.stuffstate=='1'){
                            html=html+"<a onclick='deleteStuff("+obj.stuffstate+","+obj.stuffid+")' class=\"btn btn-xs btn-default\" href=\"#!\" title=\"启用\" data-toggle=\"tooltip\"><i class=\"mdi mdi-comment-check\"></i></a>\n";

                        }else {
                            html=html+"<a onclick='deleteStuff("+obj.stuffstate+","+obj.stuffid+")' class=\"btn btn-xs btn-default\" href=\"#!\" title=\"禁用\" data-toggle=\"tooltip\"><i class=\"mdi mdi-window-close\"></i></a>\n" ;
                        }
                        html=html+"       </div>\n" +
                            "       </td>\n";

                        if (obj.accountid != null){
                            html=html+"<td>" +
                                "<button type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#distributeActorModal\" id='actor'>分配角色</button>" +
                                "</td>\n" ;
                        }else {
                            html=html+"<td>" +
                                "<button type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#distributeAccountModal\" id='account'>分配账号</button>" +
                                "</td>\n" ;
                        }

                        html=html+"     </tr>";
                        $("#tab").append(html);
                    }
                }
            }
        });
    }
    //编辑
    function editStuff(id){
        //data-toggle="modal" data-target="#editStuffModal"
        $("#editStuffModal").modal('show');
        $("#main1").load("stuff-edit.jsp?stuffid="+id);
    }
    //启用禁用
    function deleteStuff(oldstate,id) {
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
                            url:"${path}/stuff/deleteStuff",
                            dataType:"json",
                            data:{state:state,id:id},
                            type:"post",
                            success:function (data) {
                                if (data.state){
                                    lightyear.loading('show');
                                    setTimeout(function() {
                                        lightyear.loading('hide');
                                        lightyear.notify('修改成功~','success', 3000);
                                    }, 1e2);
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
    //分配角色
    $("#tab").on("click","#actor",function () {
        var id=$(this).parent().parent().find(".account").val();
        $("#main2").load("actor-distribute.jsp?id="+id);
    });
    //分配账号
    $("#tab").on("click","#account",function () {
        var id=$(this).parent().parent().find(".stuff").val();
        $("#main3").load("account-distribute.jsp?id="+id);
    });
</script>
</body>
</html>
