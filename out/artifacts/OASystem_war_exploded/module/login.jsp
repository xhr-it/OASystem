<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录页面 - 光年OA办公系统</title>
    <link rel="icon" href="../resource/favicon.ico" type="image/ico">
    <link href="../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../resource/css/style.min.css" rel="stylesheet">
    <%@ include file="../resource/common.jsp"%>
    <style>
        .lyear-wrapper {
            position: relative;
        }
        .lyear-login {
            display: flex !important;
            min-height: 100vh;
            align-items: center !important;
            justify-content: center !important;
        }
        .login-center {
            background: #fff;
            min-width: 38.25rem;
            padding: 2.14286em 3.57143em;
            border-radius: 5px;
            margin: 2.85714em 0;
        }
        .login-header {
            margin-bottom: 1.5rem !important;
        }
        .login-center .has-feedback.feedback-left .form-control {
            padding-left: 38px;
            padding-right: 12px;
        }
        .login-center .has-feedback.feedback-left .form-control-feedback {
            left: 0;
            right: auto;
            width: 38px;
            height: 38px;
            line-height: 38px;
            z-index: 4;
            color: #dcdcdc;
        }
        .login-center .has-feedback.feedback-left.row .form-control-feedback {
            left: 15px;
        }
    </style>
</head>
<body>
<div class="row lyear-wrapper">
    <div class="lyear-login">
        <div class="login-center">
            <div class="login-header text-center">
                <a href="index.jsp"> <img alt="light year admin" src="../resource/images/logo-sidebar.png"> </a>
            </div>
            <form action="#!" method="post">
                <div class="form-group has-feedback feedback-left">
                    <input autocomplete="off" type="text" placeholder="请输入您的用户名" class="form-control" name="username" id="username" />
                    <span class="mdi mdi-account form-control-feedback" aria-hidden="true"></span>
                </div>
                <div class="form-group has-feedback feedback-left">
                    <input autocomplete="off" type="password" placeholder="请输入密码" class="form-control" id="password" name="password" />
                    <span class="mdi mdi-lock form-control-feedback" aria-hidden="true"></span>
                </div>
                <div class="form-group has-feedback feedback-left row">
                    <div class="col-xs-7">
                        <input autocomplete="off" type="text" id="captcha" name="captcha" class="form-control" placeholder="验证码">
                        <span class="mdi mdi-check-all form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <div class="col-xs-5">
                        <img src="${path}/checkImg" class="pull-right" style="cursor: pointer;" onclick="this.src=this.src+'?d='+Math.random();" title="点击刷新" alt="captcha">
                    </div>
                </div>
                <div class="form-group">
                    <button class="btn btn-block btn-primary" type="button" id="loginBtn">立即登录</button>
                </div>
            </form>
            <hr>
            <footer class="col-sm-12 text-center">
                <p class="m-b-0">制作 by 徐浩然</p>
            </footer>
        </div>
    </div>
</div>
<script type="text/javascript" src="../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../resource/js/bootstrap.min.js"></script>
<!--消息提示-->
<script src="../resource/js/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="../resource/js/lightyear.js"></script>
<script type="text/javascript" src="../resource/js/main.min.js"></script>

<script type="text/javascript">;</script>
<script>
    $("#loginBtn").click(function(){
        $.ajax({
            url:"${path}/account/login",
            data:{username:$("#username").val(),pwd:$("#password").val(),checkCode:$("#captcha").val()},
            dataType:"json",
            type:"post",
            success:function (data) {
                if(data.state){
                    window.location.href="${path}/module/index.jsp"
                }else {
                    lightyear.loading('show');
                    setTimeout(function() {
                        lightyear.loading('hide');
                        lightyear.notify(data.message, 'danger', 100);
                    }, 1e2) //1*（10的二次方）
                }
            }
        });
    });

</script>
</body>
</html>
