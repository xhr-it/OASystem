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
<div>

</div>
<div class="modal-body">
    <div class="card">
        <div class="card-body">

            <form class="form-horizontal" method="post" onsubmit="return false;">
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_name">姓名</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="L_name" name="name" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_sex">性别</label>
                    <div class="col-md-7">
                        <select class="form-control" id="L_sex" code="BM_SEX" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_age">年龄</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="L_age" name="age" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_idcard">身份证号码</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="L_idcard" name="idcard" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="province">地址</label>
                    <div class="col-md-7">
                        <select class="form-control" id="province" code="BM_DISTRICT" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                    <label class="col-md-3 control-label" ></label>
                    <div class="col-md-7">
                        <select class="form-control" id="city" name="city" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                    <label class="col-md-3 control-label" ></label>
                    <div class="col-md-7">
                        <select class="form-control" id="country" name="country" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_address">详细地址</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="L_address" name="address" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_phone">手机号</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="L_phone" name="phone" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_email">邮箱</label>
                    <div class="col-md-7">
                        <input class="form-control" type="email" id="L_email" name="email" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_date">入职时间</label>
                    <div class="col-md-7">
                        <input class="form-control" type="date" id="L_date" name="date" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_state">工作状态</label>
                    <div class="col-md-7">
                        <select class="form-control" id="L_state" code="BM_STATE"  name="state" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_dept">部门</label>
                    <div class="col-md-7">
                        <select class="form-control" id="L_dept" name="dept" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_position">职务</label>
                    <div class="col-md-7">
                        <select class="form-control" id="L_position" name="position" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_tab_stuffid">直属领导</label>
                    <div class="col-md-7">
                        <select class="form-control" id="L_tab_stuffid" name="tab_stuffid" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
    <button type="button" class="btn btn-primary" id="saveBtn" onclick="addStuff()">点击保存</button>
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
    //加载下拉框中的选项（码表）
    $("select[code*='BM']").each(function () {
        var obj=$(this);
        var codeType=obj.attr("code");
        $.ajax({
            url:"${path}/stuff/selectCode",
            data:{code:codeType},
            dataType:"json",
            type:"post",
            success:function (data) {
                obj.html("");
                var html="<option>请选择</option>";
                obj.append(html);
                if (data!=null){
                    for (var i=0;i<data.length;i++){
                        var ob=data[i];
                        var html="<option value="+ob.code_no+">"+ob.code_value+"</option>";
                        obj.append(html);
                    }
                }
            }
        })
    });
    //加载职务下拉框
    $.ajax({
        url:"${path}/position/selectPositionName",
        data:{},
        dataType:"json",
        type:"post",
        success:function (data) {
            $("#L_position").html("");
            var html="<option>请选择</option>";
            $("#L_position").append(html);
            if (data!=null){
                for (var i=0;i<data.length;i++){
                    var obj=data[i];
                    var html="<option value='"+obj.positionid+"'>"+obj.positionname+"</option>";
                    $("#L_position").append(html);
                }
            }
        }
    });
    //加载市下拉框
    $("#province").change(function () {
        $.ajax({
            url:"${path}/stuff/selectCode",
            data:{code:'BM_DISTRICT',parent:$("#province").val()},//给后台参数 organ
            dataType:"json",
            type:"post",
            success:function (data) {//list
                $("#city").html('');
                var html="<option value=''>请选择</option>";
                $("#city").append(html);
                if(data!=null){
                    for(var i=0;i<data.length;i++){
                        var obj=data[i];
                        var html="<option value='"+obj.code_no+"'>"+obj.code_value+"</option>";
                        $("#city").append(html);
                    }
                    getAddress();
                }
            }
        });
    });
    //加载县下拉框
    $("#city").change(function () {
        $.ajax({
            url:"${path}/stuff/selectCode",
            data:{code:'BM_DISTRICT',parent:$("#city").val()},//给后台参数 organ
            dataType:"json",
            type:"post",
            success:function (data) {//list
                $("#country").html('');
                var html="<option value=''>请选择</option>";
                $("#country").append(html);
                //dom控制数据显示
                if(data!=null){
                    for(var i=0;i<data.length;i++){
                        var obj=data[i];
                        var html="<option value='"+obj.code_no+"'>"+obj.code_value+"</option>";
                        $("#country").append(html);
                    }
                    getAddress();
                }
            }
        });
    });
    //加载详细地址
    $("#country").change(function () {
        getAddress();
    });
    function getAddress(){
        var province=$("#province option:selected").html();
        var city=$("#city option:selected").html();
        var country=$("#country option:selected").html();
        var address=province+city+country;
        $("#L_address").val(address);
    };
    //加载员工部门下拉框
    $.ajax({
        url:"${path}/dept/selectDeptName",
        data:{},
        dataType:"json",
        type:"post",
        success:function (data) {
            $("#L_dept").html("");
            var html="<option>请选择</option>";
            $("#L_dept").append(html);
            if (data!=null){
                for (var i=0;i<data.length;i++){
                    var obj=data[i];
                    var html="<option value='"+obj.deptid+"'>"+obj.deptname+"</option>";
                    $("#L_dept").append(html);
                }
            }
            /*$("#L_dept").val(id);*/
        }
    });

    //加载领导下拉框
    $("#L_dept").change(function () {
        var value=0;
        value=$("#L_dept").val();
        $.ajax({
            url:"${path}/stuff/selectLeader",
            data:{id:value},
            dataType:"json",
            type:"post",
            success:function (data) {//list
                $("#L_tab_stuffid").html('');
                var html="<option>请选择</option>";
                $("#L_tab_stuffid").append(html);
                //dom控制数据显示
                if(data!=null){
                    for(var i=0;i<data.length;i++){
                        var obj=data[i];
                        var html="<option value='"+obj.stuffid+"'>"+obj.name+"</option>";
                        $("#L_tab_stuffid").append(html);
                    }
                }
            }
        });
    });
    /*唯一性校验身份证号码*/
    $("input[name='idcard']").blur(function () {
        $.ajax({
            url:"${path}/stuff/selectByIdCard",
            data:{idcard:$("#L_idcard").val()},
            dataType:"json",
            type:"post",
            success:function (data) {
                if (data.state==true){
                    $("#saveBtn").prop("disabled",false);
                }else {
                    lightyear.loading('show');
                    setTimeout(function() {
                        lightyear.loading('hide');
                        lightyear.notify('身份证号重复~','danger', 100,'mdi mdi-emoticon-happy','bottom');
                    }, 1e2)
                    $("#saveBtn").prop("disabled",true);
                }
            }
        })
    });
    function addStuff(){
        var obj={name:$("#L_name").val(),sex:$("#L_sex").val(),age:$("#L_age").val(),idcard:$("#L_idcard").val(),dist:$("#country").val(),addr:$("#L_address").val(),phone:$("#L_phone").val(),email:$("#L_email").val(),
            time:$("#L_date").val(),stuffstate:$("#L_state").val(),tab_stuffid:$("#L_tab_stuffid").val(),positionid:$("#L_position").val(),deptid:$("#L_dept").val()};
        $.ajax({
            url:"${path}/stuff/insertStuff",
            data:{"dataInfo":JSON.stringify(obj)},
            dataType:"json",
            async:false,
            type:"post",
            success:function (data) {
                if (data.state==true||data.state=='true'){
                    lightyear.loading('show');
                    setTimeout(function() {
                        lightyear.loading('hide');
                        lightyear.notify('新增成功~','success', 3000,'mdi mdi-emoticon-happy','bottom');
                    }, 1e2);
                    setInterval(function () {
                        window.parent.location.reload();
                    },1e3)
                }else {
                    lightyear.loading('show');
                    setTimeout(function() {
                        lightyear.loading('hide');
                        lightyear.notify('新增失败，请检查输入信息~','danger', 100,'mdi mdi-emoticon-happy','bottom');
                    }, 1e2) //1*（10的二次方）
                }
            },
            error:function () {
                lightyear.loading('show');
                setTimeout(function() {
                    lightyear.loading('hide');
                    lightyear.notify('新增失败，请检查输入信息~','danger', 100,'mdi mdi-emoticon-happy','bottom');
                }, 1e2) //1*（10的二次方）
            }
        });
    };
</script>
</body>
</html>
