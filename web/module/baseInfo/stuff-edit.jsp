<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="icon" href="../../resource/favicon.ico" type="image/ico">
    <link href="../../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../../resource/css/style.min.css" rel="stylesheet">
    <!--对话框-->
    <link rel="stylesheet" href="../../resource/js/jconfirm/jquery-confirm.min.css">
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
                    <label class="col-md-3 control-label" for="E_name">姓名</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="E_name" name="name" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="E_sex">性别</label>
                    <div class="col-md-7">
                        <select class="form-control" id="E_sex" code="BM_SEX" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="E_age">年龄</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="E_age" name="age" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="E_idcard">身份证号码</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="E_idcard" name="idcard" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="E_province">地址</label>
                    <div class="col-md-7">
                        <select class="form-control" id="E_province" code="BM_DISTRICT" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                    <label class="col-md-3 control-label" ></label>
                    <div class="col-md-7">
                        <select class="form-control" id="E_city" name="E_city" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                    <label class="col-md-3 control-label" ></label>
                    <div class="col-md-7">
                        <select class="form-control" id="E_country" name="country" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="E_address">详细地址</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="E_address" name="address" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="E_phone">手机号</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="E_phone" name="phone" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="E_email">邮箱</label>
                    <div class="col-md-7">
                        <input class="form-control" type="email" id="E_email" name="email" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="E_date">入职时间</label>
                    <div class="col-md-7">
                        <input class="form-control" type="date" id="E_date" name="date" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="E_state">工作状态</label>
                    <div class="col-md-7">
                        <select class="form-control" id="E_state" code="BM_STATE"  name="state" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="E_dept">部门</label>
                    <div class="col-md-7">
                        <select class="form-control" id="E_dept" name="dept" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="E_position">职务</label>
                    <div class="col-md-7">
                        <select class="form-control" id="E_position" name="position" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="E_tab_stuffid">直属领导</label>
                    <div class="col-md-7">
                        <select class="form-control" id="E_tab_stuffid" name="tab_stuffid" size="1">
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
    <button type="button" class="btn btn-primary" id="saveBtn" onclick="updateStuff()">点击保存</button>
</div>
<script type="text/javascript" src="../../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>
<!--消息提示-->
<script src="../../resource/js/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="../../resource/js/lightyear.js"></script>
<script type="text/javascript" src="../../resource/js/main.min.js"></script>
<!--对话框-->
<script type="text/javascript" src="../../resource/js/jconfirm/jquery-confirm.min.js"></script>
<script type="text/javascript" src="../../resource/js/main.min.js"></script>
<%@ include file="../../resource/common.jsp"%>
<script>
    //加载预选项
    var stuffid='${param.stuffid}';
    var sex;
    var country="";
    var city="";
    var province="";
    var address="";
    var distStr="";
    var state;
    var dept;
    var position;
    var tab_stuffid;
    $.ajax({
        url:"${path}/stuff/selectStuffById",
        data:{stuffid:stuffid},
        dataType:"json",
        async:false,
        type:"post",
        success:function (data) {
            $("#E_name").val(data.name);
            $("#E_email").val(data.email);
            $("#E_idcard").val(data.idcard);
            $("#E_phone").val(data.phone);
            sex=data.sex;
            $("#E_age").val(data.age);
            //存储的数据为字符串格式不匹配 需要改为字符串
            distStr=data.dist;
            country=data.dist+"";
            city=country.substring(0,4)+"00";
            province=country.substring(0,2)+"0000";
            address=data.addr;
            $("#E_address").val(data.addr);
            $("#E_date").val(data.time);
            state=data.stuffstate;
            dept=data.deptid;
            position=data.positionid;
            tab_stuffid=data.tab_stuffid;
            $("#E_accountid").val(data.accountid);
        }
    });
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
                    $("#E_sex").val(sex);
                    $("#E_state").val(state);
                    $("#E_province").val(province);
                    $("#E_province").trigger('change');
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
            $("#E_position").html("");
            var html="<option>请选择</option>";
            $("#E_position").append(html);
            if (data!=null){
                for (var i=0;i<data.length;i++){
                    var obj=data[i];
                    var html="<option value='"+obj.positionid+"'>"+obj.positionname+"</option>";
                    $("#E_position").append(html);
                }
                if (position!=null){
                    $("#E_position").val(position)
                }
            }
        }
    });
    //加载市下拉框
    $("#E_province").change(function () {
        $.ajax({
            url:"${path}/stuff/selectCode",
            data:{code:'BM_DISTRICT',parent:$("#E_province").val()},//给后台参数 organ
            dataType:"json",
            type:"post",
            success:function (data) {//list
                $("#E_city").html('');
                var html="<option selected='selected'>请选择</option>";
                $("#E_city").append(html);
                if(data!=null){
                    for(var i=0;i<data.length;i++){
                        var obj=data[i];
                        var html="<option value='"+obj.code_no+"'>"+obj.code_value+"</option>";
                        $("#E_city").append(html);
                    }
                }
                $("#E_city").val(city);
                $("#E_city").trigger('change');
                getAddress();
            }
        });
    });
    //加载县下拉框
    $("#E_city").change(function () {
        $.ajax({
            url:"${path}/stuff/selectCode",
            data:{code:'BM_DISTRICT',parent:$("#E_city").val()},//给后台参数 organ
            dataType:"json",
            type:"post",
            success:function (data) {//list
                $("#E_country").html('');
                var html="<option selected='selected'>请选择</option>";
                $("#E_country").append(html);
                //dom控制数据显示
                if(data!=null){
                    for(var i=0;i<data.length;i++){
                        var obj=data[i];
                        var html="<option value='"+obj.code_no+"'>"+obj.code_value+"</option>";
                        $("#E_country").append(html);
                    }
                }
                $("#E_country").val(country);
                $("#E_country").trigger('change');
                getAddress();
            }
        });
    });
    //加载详细地址
    $("#E_country").change(function () {
        getAddress();
    });
    function getAddress(){
        var province=$("#E_province option:selected").html();
        var E_city=$("#E_city option:selected").html();
        var country=$("#E_country option:selected").html();
        var address=province+E_city+country;
        $("#E_address").val(address);
    };
    //加载员工部门下拉框
    $.ajax({
        url:"${path}/dept/selectDeptName",
        data:{},
        dataType:"json",
        type:"post",
        success:function (data) {
            $("#E_dept").html("");
            var html="<option>请选择</option>";
            $("#E_dept").append(html);
            if (data!=null){
                for (var i=0;i<data.length;i++){
                    var obj=data[i];
                    var html="<option value='"+obj.deptid+"'>"+obj.deptname+"</option>";
                    $("#E_dept").append(html);
                }
            }
            if (dept!=null){
                $("#E_dept").val(dept);
                $("#E_dept").trigger('change');
            }
        }
    });

    //加载领导下拉框
    $("#E_dept").change(function () {
        var value=$("#E_dept").val();
        $.ajax({
            url:"${path}/stuff/selectLeader",
            data:{id:value},
            dataType:"json",
            type:"post",
            success:function (data) {//list
                $("#E_tab_stuffid").html('');
                var html="<option>请选择</option>";
                $("#E_tab_stuffid").append(html);
                //dom控制数据显示
                if(data!=null){
                    for(var i=0;i<data.length;i++){
                        var obj=data[i];
                        var html="<option value='"+obj.stuffid+"'>"+obj.name+"</option>";
                        $("#E_tab_stuffid").append(html);
                    }
                }
                if (tab_stuffid!=null){
                    $("#E_tab_stuffid").val(tab_stuffid)
                }
            }
        });
    });
    /*唯一性校验身份证号码*/
    $("input[name='idcard']").blur(function () {
        $.ajax({
            url:"${path}/stuff/selectByIdCard",
            data:{idcard:$("#E_idcard").val()},
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
    function updateStuff() {
        var obj={stuffid:stuffid,name:$("#E_name").val(),sex:$("#E_sex").val(),age:$("#E_age").val(),idcard:$("#E_idcard").val(),dist:$("#E_country").val(),addr:$("#E_address").val(),phone:$("#E_phone").val(),email:$("#E_email").val(),
            time:$("#E_date").val(),stuffstate:$("#E_state").val(),tab_stuffid:$("#E_tab_stuffid").val(),positionid:$("#E_position").val(),deptid:$("#E_dept").val(),accountid:$("#E_accountid").val()};
        $.ajax({
            url:"${path}/stuff/updateStuff",
            data:{"dataInfo":JSON.stringify(obj)},
            dataType:"json",
            async:false,
            type:"post",
            success:function (data) {
                if (data.state||data.state==true||data.state=='true'){
                    lightyear.loading('show');
                    setTimeout(function() {
                        lightyear.loading('hide');
                        lightyear.notify('修改成功~','success', 3000,'mdi mdi-emoticon-happy','bottom');
                    }, 1e2);
                    setInterval(function () {
                        window.location.reload();
                    },1e3)
                }
            }
        });
    }
</script>
</body>
</html>
