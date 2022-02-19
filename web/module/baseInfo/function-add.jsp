<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增功能</title>
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
                    <label class="col-md-3 control-label" for="L_tab_functionid">父级功能</label>
                    <div class="col-md-7">
                        <select class="form-control" id="L_tab_functionid" size="1">
                            <option>请选择</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_functionname">功能名</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="L_functionname" name="L_functionname" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_url">路径</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="L_url" name="L_url" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_functionidstate">功能状态</label>
                    <div class="col-md-7">
                        <select class="form-control" id="L_functionidstate" code="BM_STATE"  size="1">
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
    <button type="button" class="btn btn-primary" id="saveBtn" onclick="addFunc()">点击保存</button>
</div>
<script type="text/javascript" src="../../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>
<!--消息提示-->
<script src="../../resource/js/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="../../resource/js/lightyear.js"></script>

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

    //加载功能下拉框
    var  fatherid=${param.functionid};
    $.ajax({
        url:"${path}/function/selectFunctionName",
        data:{},
        dataType:"json",
        type:"post",
        success:function (data) {
            $("#L_tab_functionid").html("");
            var html="<option value='-1'>请选择</option>";
            $("#L_tab_functionid").append(html);
            if (data!=null){
                for (var j=0;j<data.length;j++){
                    var obj=data[j];
                    var html="<option value='"+obj.functionid+"'>"+obj.functionname+"</option>";
                    $("#L_tab_functionid").append("<option value=\'"+obj.functionid+"\'>"+obj.functionname+"</option>");
                }
                if (fatherid!=null||fatherid!=""||fatherid!=undefined){
                    $("#L_tab_functionid").val(fatherid);
                }
            }
        }
    })
    /**
     * 唯一性校验 功能名
     */
    $("#L_functionname").blur(function () {
        console.log("测试功能名");
        $.ajax({
            url:"${path}/function/functionUnique",
            data:{username:$("#L_functionname").val(),id:null},
            dataType:"json",
            type:"post",
            success:function (data) {
                if (data.state==true){
                    $("#saveBtn").prop("disabled",false);
                }else if (data.state==false) {
                    lightyear.loading('show');
                    setTimeout(function() {
                        lightyear.loading('hide');
                        lightyear.notify(data.message,'danger', 100,'mdi mdi-emoticon-happy');
                    }, 1e2);
                    $("#saveBtn").prop("disabled",true);
                }
            }
        })
    });

    function addFunc(){
        var obj={tab_functionid:$("#L_tab_functionid").val(),functionname:$("#L_functionname").val(),url:$("#L_url").val(),functionidstate:$("#L_functionidstate").val()};
        console.log(obj);
        $.ajax({
            url:"${path}/function/addFunction",
            data:{dataInfo:JSON.stringify(obj)},
            dataType:"json",
            async:false,
            type:"post",
            success:function (data) {
                if (data.state||data.state==true||data.state=='true'){
                    lightyear.loading('show');
                    setTimeout(function() {
                        lightyear.loading('hide');
                        lightyear.notify(data.message,'success', 3000,'mdi mdi-emoticon-happy');
                    }, 1e2);
                    setInterval(function () {
                        window.location.reload();
                    }, 1e3)
                }
            }
        })
    }
</script>
</body>
</html>
