<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>角色管理</title>
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
                        <div class="card">
                            <div class="card-body" style="padding-bottom: 0px;padding-left: 60px">

                                <form class="form-inline" method="post" onsubmit="return false;">
                                    <div class="form-group" style="padding-right: 100px">
                                        <a class="btn btn-primary m-r-5" onclick="toAdd()" ><i class="mdi mdi-plus"></i> 新增</a>
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" type="text" id="inputSearch1"  placeholder="请输入角色名">
                                    </div>
                                    <div class="form-group">
                                        <button class="btn btn-default" type="button" id="selectBtn">搜索</button>
                                    </div>
                                </form>

                            </div>
                            <div class="card-body">

                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>编号</th>
                                            <th>角色名称</th>
                                            <th>角色描述</th>
                                            <th>角色状态</th>
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
                    <button type="button" class="btn btn-primary" id="saveBtn">点击保存</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="addActorModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel1">新增角色</h4>
                </div>
                <jsp:include page="actor-add.jsp" flush="true" />
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="../../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="../../resource/js/main.min.js"></script>
<script type="text/javascript" src="../../resource/zTree_v3/js/jquery.ztree.all.min.js"></script>
<!--对话框-->
<script type="text/javascript" src="../../resource/js/jconfirm/jquery-confirm.min.js"></script>
<script type="text/javascript" src="../../resource/js/main.min.js"></script>
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
    });
    function load(nowPage){
        var obj={actorname:$("#inputSearch1").val(),actordesc:$("#inputSearch2").val()};
        var pageInfo={nowPage:nowPage,rows:8};
        $.ajax({
            url:"${path}/actor/selectActor",
            data:{dataInfo:JSON.stringify(obj),pageInfo:JSON.stringify(pageInfo)},//给后台参数 organ
            dataType:"json",
            type:"post",
            success:function (page) {//list   message-----JSON数组
                $("#nowPage").html(nowPage);
                $("#allPage").html(page.allPage);
                $("#allRows").html(page.allRows);
                $("#tab").html("");
                $("#page").html("");
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
                //dom控制数据显示
                if(page!=null){
                    for(var i=0;i<page.data.length;i++){
                        var obj=page.data[i];
                        var html="<tr>\n" +
                            "       <td>"+(i+1)+"</td>\n" +
                            "       <td>"+obj.actorname+"</td>\n" +
                            "       <td>"+obj.actordesc+"</td>\n" +
                            "       <td style='display: none' id='actorid'>"+obj.actorid+"</td>\n";
                        if (obj.actorstate==0) {
                            html=html+"<td><a class=\"btn btn-success m-r-5\" href=\"#!\"><i class=\"mdi mdi-check\"></i> 已启用</a></td>\n" ;
                        }else if (obj.actorstate==1){
                            html=html+"<td><a class=\"btn btn-warning m-r-5\" href=\"#!\"><i class=\"mdi mdi-block-helper\"></i> 已禁用</a></td>\n";
                        }

                        html=html+"       <td>\n" +
                            "       <div class=\"btn-group\">\n" +
                            "       <button type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#myModal\" id='"+obj.actorid+"'>\n" +
                            "      分配权限\n" +
                            "   </button>";
                            "       </div>\n" ;
                        if (obj.actorstate==1||obj.actorstate=='1'){
                            html=html+"<a onclick='deleteActor("+obj.actorstate+","+obj.actorid+")' class=\"btn btn-xs btn-default\" href=\"#!\" title=\"启用\" data-toggle=\"tooltip\"><i class=\"mdi mdi-comment-check\"></i></a>\n";

                        }else {
                            html=html+"<a onclick='deleteActor("+obj.actorstate+","+obj.actorid+")' class=\"btn btn-xs btn-default\" href=\"#!\" title=\"禁用\" data-toggle=\"tooltip\"><i class=\"mdi mdi-window-close\"></i></a>\n" ;
                        }

                        html=html+"       </td>\n" +
                            "     </tr>";
                        $("#tab").append(html);

                    }
                }
            }
        });
    }

    var zTreeObj;//代表一棵树，树目前没值
    //设置
    var setting = {
        data: {
            simpleData: {
                enable: true,  //true 、 false 分别表示 使用 、 不使用 简单数据模式
                idKey: "id",  //节点数据中保存唯一标识的属性名称
                pIdKey: "parentid",    //节点数据中保存其父节点唯一标识的属性名称
                rootPId: -1  //用于修正根节点父节点数据，即 pIdKey 指定的属性值
            },
            key: {
                name: "menuname"  //zTree 节点数据保存节点名称的属性名称  默认值："name"
            }
        },
        check:{
            enable:true,  //true 、 false 分别表示 显示 、不显示 复选框或单选框
            nocheckInherit:true  //当父节点设置 nocheck = true 时，设置子节点是否自动继承 nocheck = true
        }
    };
    $("#tab").on("click","button[type='button']",function () {
        var actorid=this.id;//角色有默认的权限
        console.log(actorid);
        $.ajax({
            url:"${path}/actor/selectFunctionByActorID",
            data:{actorid:actorid},
            dataType:"json",
            type:"post",
            success:function (data) {
                var zNodes=data;
                $("#actorid").val(actorid)
                zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes); //初始化树
                zTreeObj.expandAll(true);    //true 节点全部展开、false节点收缩
            }
        })
    });
    $("#saveBtn").click(function () {
        var actorid=$("#actorid").val();
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getCheckedNodes(true);
        var tree=new Array();
        for(var a=0;a<nodes.length;a++){
            var obj=nodes[a].id;
            tree[a]=obj;
        }
        $.ajax({
            url:"${path}/function/saveFunctionTree",
            data:{tree:JSON.stringify(tree),id:actorid},
            dataType:"json",
            type:"post",
            success:function (data) {
                console.log("分配成功");
                $("#myModal").modal('hide');
            }
        });
    })
    //新增
    function toAdd() {
        $("#addActorModal").modal('show');
    }
    //启用禁用
    function deleteActor(actorstate,id) {
        $.confirm({
            title: '提示',
            content: '<p class="text-center" style="font-size: 18px;">确认操作吗</p>',
            buttons: {
                confirm: {
                    text: '确认',
                    btnClass: 'btn-primary',
                    action: function(){
                        var state=0;
                        if (actorstate==1||actorstate=="1"){
                            state=0;
                        }else {
                            state=1;
                        }
                        $.ajax({
                            url:"${path}/actor/deleteActor",
                            dataType:"json",
                            data:{actorstate:state,actorid:id},
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
