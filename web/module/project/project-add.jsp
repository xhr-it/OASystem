<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增项目</title>
    <link href="../../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../../resource/css/style.min.css" rel="stylesheet">
</head>
<body>
<div class="modal-body">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-md-3 control-label" for="L_projectno" class="control-label">项目编号：</label>
            <div class="col-md-7">
                <input type="text" class="form-control" id="L_projectno">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label" for="L_projectname" class="control-label" >项目名称：</label>
            <div class="col-md-7">
                <input type="text" class="form-control" id="L_projectname" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label" for="L_projectstart" class="control-label" >开始时间：</label>
            <div class="col-md-7">
                <input type="date" class="form-control" id="L_projectstart" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label" for="L_projectend" class="control-label" >结束时间：</label>
            <div class="col-md-7">
                <input type="date" class="form-control" id="L_projectend" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label" for="L_projectdescr" class="control-label" >项目描述：</label>
            <div class="col-md-7">
                <textarea class="form-control" id="L_projectdescr" ></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label" for="taskPeo" class="control-label" >项目领取人：</label>
            <div class="col-md-7">
                <select class="form-control" id="taskPeo" size="1">
                    <option>请选择</option>
                </select>
            </div>
        </div>
    </form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
    <button type="button" class="btn btn-primary" id="saveBtn">点击保存</button>
</div>
<script type="text/javascript" src="../../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>
<%--消息提示--%>
<script src="../../resource/js/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="../../resource/js/lightyear.js"></script>
<script type="text/javascript" src="../../resource/js/main.min.js"></script>
<%@ include file="../../resource/common.jsp"%>
<script>
    var deptid='${param.deptid}';
    function compareDate(begintime,endtime){
        var starttime = new Date(Date.parse(begintime));
        var endtime = new Date(Date.parse(endtime));
        return starttime<=endtime;
    }
    //加载员工列表
    $.ajax({
        url:"${path}/project/selectStuffNameForProject",
        data:{deptid:deptid},
        dataType:"json",
        async:false,
        type:"post",
        success:function (data) {
            if (data!=null){
                for (var i=0;i<data.length;i++){
                    var obj=data[i];
                    var html="<option value='"+obj.stuffid+"'>"+obj.name+"</option>";
                    $("#taskPeo").append(html);
                }
            }
        }
    })
    //确认新增
    $("#saveBtn").click(function () {
        var start=$("#L_projectstart").val();
        var end=$("#L_projectend").val();
        var obj={projectno:$("#L_projectno").val(),projectname:$("#L_projectname").val(),
            projectstart:$("#L_projectstart").val(),projectent:$("#L_projectend").val(),
            projectdescr:$("#L_projectdescr").val(), projectprin:$("#taskPeo").val(),deptid:${param.deptid}};
        console.log(obj)
        if(compareDate(start,end)){
            $.ajax({
                url:"${path}/project/insertProject",
                data:{"dataInfo":JSON.stringify(obj)},
                dataType:"json",
                type:"post",
                success:function (data) {
                    if (data.state==true||data.state=='true'){
                        lightyear.loading('show');
                        setTimeout(function() {
                            lightyear.loading('hide');
                            lightyear.notify(data.message,'success', 2000,'mdi mdi-emoticon-happy');
                        }, 1e2);
                        window.location.reload();
                    }
                }
            });
        }else{
            lightyear.loading('show');
            setTimeout(function() {
                lightyear.loading('hide');
                lightyear.notify('结束时间不能小于开始时间','danger', 1000,'mdi mdi-emoticon-happy');
            }, 1e2);
        }
        return false;
    })
</script>
</body>
</html>
