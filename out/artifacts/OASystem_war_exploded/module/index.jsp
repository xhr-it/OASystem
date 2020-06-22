<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map account= (Map) session.getAttribute("account");
    if (account != null&&account.size()>0) {
        String name= account.get("username").toString();
        request.setAttribute("username",name);
    }
%>
<html>
<head>
    <title>首页 - 光年OA办公系统</title>
    <link rel="icon" href="../resource/favicon.ico" type="image/ico">
    <link href="../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../resource/css/style.min.css" rel="stylesheet">
    <script type="text/javascript" src="../resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="../resource/js/bootstrap.min.js"></script>
    <%@ include file="../resource/common.jsp"%>
    <script>
        $().ready(function () {
            $("#username").html("${username}");
            $.ajax({
                url:"${path}/account/getFunction",
                data:{},
                type:"post",
                dataType:"json",
                success:function (data) {
                    if(data!=null){
                        for(var i=0;i<data.length;i++){
                            var obj=data[i];
                            var functionname=obj.functionname;
                            var sonList=obj.sonList;
                            var html="<li class='nav-item nav-item-has-subnav'>" +
                                "       <a href='javascript:void(0)'><i class='mdi mdi-menu'></i>"+functionname+"</a>" +
                                "           <ul class='nav nav-subnav' style='display: none'>";
                            if(sonList!=null){
                                for(var j=0;j<sonList.length;j++){
                                    var son=sonList[j];
                                    var sonid=son.functionid;
                                    var sonname=son.functionname;
                                    var sonurl=son.url;
                                    html=html+"<li> <a href='${path}/"+sonurl+"' target='main'>"+sonname+"</a> </li>";
                                }
                            }
                            html=html+"</ul>" +
                                "     </li>";
                            $("#nav").append(html);
                        }
                    }
                }
            })
        })
    </script>
</head>
<body>
    <div class="lyear-layout-web">
        <div class="lyear-layout-container">
            <!--左侧导航-->
            <aside class="lyear-layout-sidebar">

                <!-- logo -->
                <div id="logo" class="sidebar-header">
                    <a href="index.jsp"><img src="../resource/images/logo-sidebar.png" title="LightYear" alt="LightYear" /></a>
                </div>
                <div class="lyear-layout-sidebar-scroll">

                    <nav class="sidebar-main">
                        <ul class="nav nav-drawer" id="nav">
                            <li class="nav-item active"> <a href="index.jsp"><i class="mdi mdi-home"></i> 系统首页</a> </li>

                        </ul>
                    </nav>

                    <div class="sidebar-footer">
                        <p class="copyright">系统制作 by 徐浩然</p>
                    </div>
                </div>

            </aside>
            <!--End 左侧导航-->

            <!--头部信息-->
            <header class="lyear-layout-header">

                <nav class="navbar navbar-default">
                    <div class="topbar">

                        <div class="topbar-left">
                            <div class="lyear-aside-toggler">
                                <span class="lyear-toggler-bar"></span>
                                <span class="lyear-toggler-bar"></span>
                                <span class="lyear-toggler-bar"></span>
                            </div>
                            <span class="navbar-page-title"> 系统首页 </span>
                        </div>

                        <ul class="topbar-right">
                            <li style="padding-left: 10px">
                                在线人数：${applicationScope.count}
                            </li>
                            <li class="dropdown dropdown-profile">
                                <a href="javascript:void(0)" data-toggle="dropdown">
                                    <img class="img-avatar img-avatar-48 m-r-10" src="../resource/images/users/avatar.jpg" alt="笔下光年" />
                                    当前用户：<span id="username">  <span class="caret"></span></span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-right">
                                    <li> <a href="javascript:void(0)" id="password"><i class="mdi mdi-lock-outline"></i> 修改密码</a> </li>
                                    <li class="divider"></li>
                                    <li> <a href="${path}/account/loginOut"><i class="mdi mdi-logout-variant"></i> 退出登录</a> </li>
                                </ul>
                                <%--<p>在线人数:${applicationScope.count}</p>--%>
                            </li>

                            <!--切换主题配色-->
                            <li class="dropdown dropdown-skin">
                                <span data-toggle="dropdown" class="icon-palette"><i class="mdi mdi-palette"></i></span>
                                <ul class="dropdown-menu dropdown-menu-right" data-stopPropagation="true">
                                    <li class="drop-title"><p>主题</p></li>
                                    <li class="drop-skin-li clearfix">
                      <span class="inverse">
                        <input type="radio" name="site_theme" value="default" id="site_theme_1" checked>
                        <label for="site_theme_1"></label>
                      </span>
                                        <span>
                        <input type="radio" name="site_theme" value="dark" id="site_theme_2">
                        <label for="site_theme_2"></label>
                      </span>
                                        <span>
                        <input type="radio" name="site_theme" value="translucent" id="site_theme_3">
                        <label for="site_theme_3"></label>
                      </span>
                                    </li>
                                    <li class="drop-title"><p>LOGO</p></li>
                                    <li class="drop-skin-li clearfix">
                      <span class="inverse">
                        <input type="radio" name="logo_bg" value="default" id="logo_bg_1" checked>
                        <label for="logo_bg_1"></label>
                      </span>
                                        <span>
                        <input type="radio" name="logo_bg" value="color_2" id="logo_bg_2">
                        <label for="logo_bg_2"></label>
                      </span>
                                        <span>
                        <input type="radio" name="logo_bg" value="color_3" id="logo_bg_3">
                        <label for="logo_bg_3"></label>
                      </span>
                                        <span>
                        <input type="radio" name="logo_bg" value="color_4" id="logo_bg_4">
                        <label for="logo_bg_4"></label>
                      </span>
                                        <span>
                        <input type="radio" name="logo_bg" value="color_5" id="logo_bg_5">
                        <label for="logo_bg_5"></label>
                      </span>
                                        <span>
                        <input type="radio" name="logo_bg" value="color_6" id="logo_bg_6">
                        <label for="logo_bg_6"></label>
                      </span>
                                        <span>
                        <input type="radio" name="logo_bg" value="color_7" id="logo_bg_7">
                        <label for="logo_bg_7"></label>
                      </span>
                                        <span>
                        <input type="radio" name="logo_bg" value="color_8" id="logo_bg_8">
                        <label for="logo_bg_8"></label>
                      </span>
                                    </li>
                                    <li class="drop-title"><p>头部</p></li>
                                    <li class="drop-skin-li clearfix">
                      <span class="inverse">
                        <input type="radio" name="header_bg" value="default" id="header_bg_1" checked>
                        <label for="header_bg_1"></label>
                      </span>
                                        <span>
                        <input type="radio" name="header_bg" value="color_2" id="header_bg_2">
                        <label for="header_bg_2"></label>
                      </span>
                                        <span>
                        <input type="radio" name="header_bg" value="color_3" id="header_bg_3">
                        <label for="header_bg_3"></label>
                      </span>
                                        <span>
                        <input type="radio" name="header_bg" value="color_4" id="header_bg_4">
                        <label for="header_bg_4"></label>
                      </span>
                                        <span>
                        <input type="radio" name="header_bg" value="color_5" id="header_bg_5">
                        <label for="header_bg_5"></label>
                      </span>
                                        <span>
                        <input type="radio" name="header_bg" value="color_6" id="header_bg_6">
                        <label for="header_bg_6"></label>
                      </span>
                                        <span>
                        <input type="radio" name="header_bg" value="color_7" id="header_bg_7">
                        <label for="header_bg_7"></label>
                      </span>
                                        <span>
                        <input type="radio" name="header_bg" value="color_8" id="header_bg_8">
                        <label for="header_bg_8"></label>
                      </span>
                                    </li>
                                    <li class="drop-title"><p>侧边栏</p></li>
                                    <li class="drop-skin-li clearfix">
                      <span class="inverse">
                        <input type="radio" name="sidebar_bg" value="default" id="sidebar_bg_1" checked>
                        <label for="sidebar_bg_1"></label>
                      </span>
                                        <span>
                        <input type="radio" name="sidebar_bg" value="color_2" id="sidebar_bg_2">
                        <label for="sidebar_bg_2"></label>
                      </span>
                                        <span>
                        <input type="radio" name="sidebar_bg" value="color_3" id="sidebar_bg_3">
                        <label for="sidebar_bg_3"></label>
                      </span>
                                        <span>
                        <input type="radio" name="sidebar_bg" value="color_4" id="sidebar_bg_4">
                        <label for="sidebar_bg_4"></label>
                      </span>
                                        <span>
                        <input type="radio" name="sidebar_bg" value="color_5" id="sidebar_bg_5">
                        <label for="sidebar_bg_5"></label>
                      </span>
                                        <span>
                        <input type="radio" name="sidebar_bg" value="color_6" id="sidebar_bg_6">
                        <label for="sidebar_bg_6"></label>
                      </span>
                                        <span>
                        <input type="radio" name="sidebar_bg" value="color_7" id="sidebar_bg_7">
                        <label for="sidebar_bg_7"></label>
                      </span>
                                        <span>
                        <input type="radio" name="sidebar_bg" value="color_8" id="sidebar_bg_8">
                        <label for="sidebar_bg_8"></label>
                      </span>
                                    </li>
                                </ul>
                            </li>
                            <!--切换主题配色-->
                        </ul>

                    </div>
                </nav>

            </header>
            <!--End 头部信息-->

            <!--页面主要内容-->
            <iframe src="dayReport/calendar.jsp" style="border: 0px;height: 100%;width: 100%" name="main"></iframe>
            <%--<main class="lyear-layout-content">

            </main>--%>
            <!--End 页面主要内容-->
        </div>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">修改密码</h4>
                </div>
                <div class="modal-body">
                    <form method="post" action="#!" class="site-form">
                        <div class="form-group">
                            <label for="old-password">旧密码</label>
                            <input type="password" class="form-control" name="oldpwd" id="old-password" placeholder="输入账号的原登录密码">
                        </div>
                        <div class="form-group">
                            <label for="new-password">新密码</label>
                            <input type="password" class="form-control" name="newpwd" id="new-password" placeholder="输入新的密码">
                        </div>
                        <div class="form-group">
                            <label for="confirm-password">确认新密码</label>
                            <input type="password" class="form-control" name="confirmpwd" id="confirm-password" placeholder="确认新密码">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="saveBtn">修改密码</button>
                </div>
            </div>
        </div>
    </div>

    <!--消息提示-->
    <script src="../resource/js/bootstrap-notify.min.js"></script>
    <script type="text/javascript" src="../resource/js/lightyear.js"></script>
    <script type="text/javascript" src="../resource/js/main.min.js"></script>
    <script>
        $("#password").click(function () {
            $("#myModal").modal('show');
        });
        //判断原密码是否正确
        $("#old-password").blur(function () {
            $.ajax({
                url:"${path}/account/login",
                data:{username:"${username}",pwd:$("#old-password").val()},
                dataType:"json",
                type:"post",
                success:function (data) {
                    if(data.state){
                        $("#saveBtn").prop("disabled",false);
                    }else {
                        $("#saveBtn").prop("disabled",true);
                        lightyear.loading('show');
                        setTimeout(function() {
                            lightyear.loading('hide');
                            lightyear.notify('原密码错误，请重新输入~', 'danger', 100);
                        }, 1e2) //1*（10的二次方）
                    }
                }
            });
        });
        //重复密码验证
        $("#confirm-password").blur(function(){
            var two=$(this).val();
            var one=$("#new-password").val();
            if(two==one){
                $("#saveBtn").prop("disabled",false);
            }else {
                $("#saveBtn").prop("disabled",true);
                lightyear.loading('show');
                setTimeout(function() {
                    lightyear.loading('hide');
                    lightyear.notify('两次密码不一致~','danger', 1000,'mdi mdi-emoticon-happy');
                }, 1e2);
            }
        });
        //保存密码
        $("#saveBtn").click(function () {
            var obj={username:"${username}",password:$("#new-password").val()};
            $.ajax({
                url:"${path}/account/updatePassword",
                data:{"dataInfo":JSON.stringify(obj)},
                dataType:"json",
                async:false,
                type:"post",
                success:function (data) {
                    if (data.state||data.state==true||data.state=='true'){
                        lightyear.loading('show');
                        setTimeout(function() {
                            lightyear.loading('hide');
                            lightyear.notify('修改成功，下次登录生效','success', 2000,'mdi mdi-emoticon-happy');
                        }, 1e2);
                    }
                    $("#myModal").modal('hide');
                }
            });
        })
    </script>
</body>
</html>
