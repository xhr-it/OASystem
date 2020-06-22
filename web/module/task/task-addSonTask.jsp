<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增子任务</title>
    <link href="../../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../../resource/css/style.min.css" rel="stylesheet">
</head>
<body>
    <div class="modal-body">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-md-3 control-label" for="task-no" class="control-label">任务编号：</label>
                <div class="col-md-7">
                    <input type="text" class="form-control" id="task-no">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label" for="task-name" class="control-label" >任务名称：</label>
                <div class="col-md-7">
                    <input type="text" class="form-control" id="task-name" >
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label" for="task-startTime" class="control-label" >预计开始时间：</label>
                <div class="col-md-7">
                    <input type="date" class="form-control" id="task-startTime" >
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label" for="task-endTime" class="control-label" >预计结束时间：</label>
                <div class="col-md-7">
                    <input type="date" class="form-control" id="task-endTime" >
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label" for="task-describe" class="control-label" >任务描述：</label>
                <div class="col-md-7">
                    <textarea class="form-control" id="task-describe" ></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label" for="taskPeo" class="control-label" >任务领取人：</label>
                <div class="col-md-7">
                    <select class="form-control" id="taskPeo" size="1">
                        <option>请选择</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label" for="task-taskFaname" class="control-label" >父任务名称：</label>
                <div class="col-md-7">
                    <input type="text" class="form-control" value="${param.taskFaname}" id="task-taskFaname" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label" for="task-projectname" class="control-label" >项目名称：</label>
                <div class="col-md-7">
                    <input type="text" class="form-control" value="${param.projectname}" id="task-projectname" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label" for="task-state" class="control-label" >任务状态：</label>
                <div class="col-md-7">
                    <input type="text" class="form-control" value="0" id="task-state" >
                </div>
            </div>
        </form>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="addSonBtn">点击保存</button>
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
    //转换时间格式
    function compareDate(begintime,endtime){
        var starttime = new Date(Date.parse(begintime));
        var endtime = new Date(Date.parse(endtime));
        return starttime<=endtime;
    }
    var fabuid="${sessionScope.account.stuffid}";
    var proId='${param.projectid}';
    //加载项目领取人下拉框
    $.ajax({
            url:"${path}/task/selectStuffByProjectId",
            dataType:"json",
            data:{projectid:proId},
            type:"post",
            success:function (data) {
                if (data!=null){
                    for (var i = 0; i <data.length ; i++) {
                        var obj=data[i];
                        var html= "<option value='"+obj.stuffid+"'>"+obj.name+"</option>";
                        $("#taskPeo").append(html);
                    }
                }
            }
        });
    //根据项目时间限制任务时间
    var id='${param.FatherTaskid}';
    console.log("任务id");
    console.log(id);
    $.ajax({
        url:"${path}/task/selectTab_taskTime",
        dataType:"json",
        data:{taskid:id},
        type:"post",
        success:function (data) {
            for (var i = 0; i <data.length ; i++) {
                var obj=data[i];
                console.log("时间："+obj.begindate)
                $("#task-startTime").val(obj.begindate);
            }
        }
    })
    var name='${param.projectname}';
    $('body').on('unbind','#addSonBtn');
    $('body').on('click','#addSonBtn',function () {
        var start=$("#task-startTime").val();
        var end=$("#task-endTime").val();
        var obj={Fatherid:id,taskno:$("#task-no").val(),taskname:$("#task-name").val(),
            taskstart:$("#task-startTime").val(),taskend:$("#task-endTime").val(),
            taskdescr:$("#task-describe").val(),projectid:proId,taskstate:$("#task-state").val(),
            taskgetPeo:$("#taskPeo").val(),taskresolvepeo:fabuid};
        console.log(obj);
        if(compareDate(start,end)){
            $.ajax({
                url:"${path}/task/insertSonTask",
                dataType:"json",
                data:{dateInfo:JSON.stringify(obj)},
                type:"post",
                success:function (data) {
                    if (data.state==true||data.state=='true'){
                        lightyear.loading('show');
                        setTimeout(function() {
                            lightyear.loading('hide');
                            lightyear.notify(data.message,'success', 3000,'mdi mdi-emoticon-happy','bottom');
                        }, 1e2);
                        setInterval(function () {
                            window.location.reload();
                        },1e3)
                    }
                }
            })
        }else{
            lightyear.loading('show');
            setTimeout(function() {
                lightyear.loading('hide');
                lightyear.notify('结束时间不能小于开始时间~','danger', 1000,'mdi mdi-emoticon-happy','bottom');
            }, 1e2);
        }
    })
</script>
</body>
</html>
