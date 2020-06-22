<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="icon" href="../../resource/favicon.ico" type="image/ico">
    <link href="../../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../../resource/css/style.min.css" rel="stylesheet">
</head>
<body>
<div class="modal-body">
    <div class="card">
        <div class="card-body">
            <form class="form-horizontal" method="post" onsubmit="return false;">
                <div class="form-group">
                    <label class="col-md-3 control-label" for="stuffid"></label>
                    <div class="col-md-7">
                        <input class="form-control" type="hidden" id="stuffid" name="username" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="username">账号名称</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="username" name="username" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="password">账号密码</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="password" value="默认密码123456" readonly>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
    <button type="button" class="btn btn-primary" onclick="addAccount()">点击保存</button>
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
    var id=${param.id};
    //账号名称唯一性校验
    $("#username").blur(function () {
        $.ajax({
            url:"${path}/account/usernameUnique",
            data:{username:$("#username").val(),id:null},
            dataType:"json",
            type:"post",
            success:function (data) {
                if (data.state==true){
                    $("#saveBtn").prop("disabled",false);
                }else {
                    lightyear.loading('show');
                    setTimeout(function() {
                        lightyear.loading('hide');
                        lightyear.notify(data.message,'danger', 1000,'mdi mdi-emoticon-happy');
                    }, 1e2);
                    $("#saveBtn").prop("disabled",true);
                }
            }
        })
    });
    //新增账号
    function addAccount() {
        var obj={stuffid:id,username:$("#username").val(),password:123456,accountstate:0};
        $.ajax({
            url:"${path}/account/addAccount",
            data:{id:id,dataInfo:JSON.stringify(obj)},
            async:false,
            dataType:"json",
            type:"post",
            success:function (data) {
                if (data.state==true||data.state=='true'){
                    lightyear.loading('show');
                    setTimeout(function() {
                        lightyear.loading('hide');
                        lightyear.notify(data.message,'success', 3000,'mdi mdi-emoticon-happy');
                    }, 1e2);
                    setInterval(function () {
                        window.parent.location.reload();
                    },1e3)
                }
            }
        })
    }
</script>
</body>
</html>
