<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增部门</title>
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
                    <label class="col-md-3 control-label" for="L_deptno">部门编号</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="L_deptno" name="name" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_deptname">部门名称</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="L_deptname" name="deptname" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_deptdescr">部门描述</label>
                    <div class="col-md-7">
                        <input class="form-control" type="text" id="L_deptdescr" name="name" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label" for="L_deptstate">部门状态</label>
                    <div class="col-md-7">
                        <select class="form-control" id="L_deptstate" code="BM_STATE"  size="1">
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
    <button type="button" class="btn btn-primary" id="saveBtn" onclick="addDept()">点击保存</button>
</div>
<script type="text/javascript" src="../../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>

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

    /**
     * 唯一性校验 部门名
     */
    var fatherid='${param.id}';
    $("#L_deptname").blur(function () {
        $.ajax({
            url:"${path}/dept/deptUnique",
            data:{name:$("#L_deptname").val(),id:null},
            dataType:"json",
            type:"post",
            success:function (data) {
                if (data.state==true){
                    $("#saveBtn").prop("disabled",false);
                }else {
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
    function addDept(){
        var obj={tab_deptid:fatherid,deptno:$("#L_deptno").val(),deptname:$("#L_deptname").val(),deptdescr:$("#L_deptdescr").val(),deptstate:$("#L_deptstate").val()};
        $.ajax({
            url:"${path}/dept/addDept",
            data:{dataInfo:JSON.stringify(obj)},
            dataType:"json",
            async:false,
            type:"post",
            success:function (data) {
                if (data.state||data.state==true||data.state=='true'){
                    lightyear.loading('show');
                    setTimeout(function() {
                        lightyear.loading('hide');
                        lightyear.notify('新增成功','success', 3000,'mdi mdi-emoticon-happy','bottom');
                    }, 1e2);
                    setInterval(function () {
                        window.location.reload();
                    }, 1e3)
                }
            }
        })
    };
</script>
</body>
</html>
