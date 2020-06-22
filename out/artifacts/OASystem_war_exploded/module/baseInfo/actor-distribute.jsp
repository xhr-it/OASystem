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
            <div class="card-body" id="checkbox">
                <%--<div class="form-group" style="padding-left: 200px">
                    <div class="col-xs-12">
                        <div class="checkbox">
                            <label for="example-checkbox1">
                                <input type="checkbox" id="example-checkbox1" name="example-checkbox1" value="option1">
                                Option 1 </label>
                        </div>-
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" onclick="actorDistribute()">点击保存</button>
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
    $.ajax({
        url:"${path}/actor/selectActorName",
        data:{},
        async:false,
        dataType:"json",
        type:"post",
        success:function (data) {
            if (data!=null){
                for (var i=0;i<data.length;i++){
                    var obj=data[i];
                    var html="<div class=\"form-group\" style=\"padding-left: 200px\">\n" +
                        "                    <div class=\"col-xs-12\">"+
                        "<div class=\"checkbox\">\n" +
                        "<label for='"+obj.actorname+"'>" +
                        "          <input type=\"checkbox\" name='actor' value='"+obj.actorid+"'>\n" +
                        "                  "+obj.actorname+" </label>\n" +
                        "     </div>" +
                        "</div>\n" +
                        "</div>";
                    $("#checkbox").append(html);
                }
            }
        }
    });
    //获取原本的角色
    var id=${param.id};
    $.ajax({
        url:"${path}/actor/selectActorByAccount",
        data:{id:id},
        async:false,
        dataType:"json",
        type:"post",
        success:function (data) {
            if (data!=null){
                for (var i=0;i<data.length;i++){
                    var obj=data[i].actorid;
                    $("input[name=actor][value='"+obj+"']").prop("checked",true);
                }
            }
        }
    })
    function actorDistribute() {
        //获取所有被选中的input中的值
        var checked="";
        $('input[type=checkbox]:checked').each(function() {
            checked=checked+$(this).val()+",";
        });
        $.ajax({
            url:"${path}/actor/distributeActor",
            data:{id:id,array:checked},
            dataType:"json",
            type:"post",
            success:function (data) {
                lightyear.loading('show');
                setTimeout(function() {
                    lightyear.loading('hide');
                    lightyear.notify(data.message,'success', 3000,'mdi mdi-emoticon-happy');
                }, 1e2);
                setInterval(function () {
                    window.parent.location.reload();
                },1e3)
            }
        })
    }
</script>
</body>
</html>
