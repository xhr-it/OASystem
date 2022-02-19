<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>周报填报</title>
    <link rel="icon" href="../../resource/favicon.ico" type="image/ico">
    <link href="../../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../../resource/css/style.min.css" rel="stylesheet">
</head>
<body>
<div class="lyear-layout-web">
    <div class="lyear-layout-container">

        <!--页面主要内容-->
        <main class="lyear-layout-content">

            <div class="container-fluid">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="card" >

                            <div class="card-body" >

                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>周报名称</th>
                                            <th>周报日期</th>
                                            <th>填写人</th>
                                            <th>周报内容</th>
                                            <th>状态</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody id="tab">

                                        </tbody>
                                    </table>
                                </div>

                                <ul class="pagination" id="page" style="padding-left: 500px">

                                </ul>
                                <span style="display: none">
                                        总页数：<span  id="allPage"></span>
                                        总条数：<span  id="allRows"></span>
                                        当前页：<span  id="nowPage">1</span>
                                </span>

                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </main>
        <!--End 页面主要内容-->
    </div>

    <%--模态框--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">周报详情</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="title1" class="control-label">标题：</label>
                            <input type="text" class="form-control" id="title1">
                        </div>
                        <div class="form-group">
                            <label for="content1" class="control-label" readonly>内容：</label>
                            <textarea class="form-control" id="content1" readonly></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary">点击保存</button>
                </div>
            </div>
        </div>
    </div>
    <%--填报补报--%>
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel1">周报信息</h4>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="reportid"/><br/>
                    <form>
                        <div class="form-group">
                            <label for="reportdate" class="control-label">日期：</label>
                            <input type="text" class="form-control" id="reportdate">
                        </div>
                        <div class="form-group">
                            <label for="title" class="control-label" >标题：</label>
                            <textarea class="form-control" id="title" ></textarea>
                        </div>
                        <div class="form-group">
                            <label for="content" class="control-label" >内容：</label>
                            <textarea class="form-control" id="content" ></textarea>
                        </div>
                        <input type="hidden" id="reportstate"/>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="saveBtn">点击保存</button>
                </div>
            </div>
        </div>
    </div>
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
    //分页
    $().ready(function () {
        load(1);
        var nowPage=Number($("#nowPage").html());
        $("body").on("click","#prev",function () {
            nowPage=Number($("#nowPage").html());
            if (nowPage==1){
                nowPage=1;
            } else {
                nowPage=nowPage-1;
            }
            load(nowPage);
        })

        $("body").on("click","#next",function () {
            nowPage=Number($("#nowPage").html());
            var allPage=$("#allPage").html();
            if (nowPage==allPage){
                nowPage=allPage;
            } else {
                nowPage=nowPage+1;
            }
            load(nowPage);
        })
        $("#selectBtn").click(function () {
            load(1);
        });
    })
    var time1=new Date();
    var year=time1.getFullYear();
    var month="0"+(time1.getMonth()+1);
    var month1="0"+(time1.getMonth());
    var day=time1.getDate();
    var fdate=(year+"-"+month1+"-"+day);
    var nowdate=(year+"-"+month+"-"+day);
    //查询所有账号
    function load(nowPage) {
        $("#begindate").val(fdate);
        $("#enddate").val(nowdate);
        var tiandiyule={begindate:fdate,enddate:nowdate};
        var pageInfo={nowPage:nowPage,rows:8};
        $.ajax({
            url:"${path}/weekReport/selectMyWeekReport",
            data:{"pageInfo":JSON.stringify(pageInfo),"tiandiyule":JSON.stringify(tiandiyule)},
            dataType:"json",
            type:"post",
            success:function (page) {
                $("#nowPage").html(nowPage);
                $("#allPage").html(page.allPage);
                $("#allRows").html(page.allRows);
                $("#tab").html("");
                $("#page").html("")
                if (page!=null){
                    //添加页码
                    if (nowPage==1){
                        var li="<li class=\"disabled\" id=\"prev\"><span>«</span></li>\n";
                    }else {
                        var li="<li id=\"prev\"><span>«</span></li>\n";
                    }
                    for (var i = 1; i <= page.allPage; i++) {
                        if (nowPage==i){
                            li=li+"<li class=\"active\"><span>"+i+"</span></li>\n";
                        }else {
                            li=li+"<li ><span>"+i+"</span></li>\n";
                        }
                    }
                    if (nowPage==page.allPage){
                        li=li+"<li class=\"disabled\" id=\"next\"><a href='javascript:void(0);'>»</a></li>";
                    }else {
                        li=li+"<li id=\"next\"><a href='javascript:void(0);'>»</a></li>";
                    }
                    $("#page").append(li);
                    //添加数据
                    for (var i = 0; i < page.data.length; i++) {
                        var obj=page.data[i];
                        var html="<tr>\n" +
                            "       <td>"+(i+1)+"</td>\n" ;
                        if (obj.title==null){
                            html=html+"<td>"+obj.name+obj.day_date+"周报</td>\n";
                        }else {
                            html=html+"<td>"+obj.title+"</td>\n";
                        }
                        html=html+"       <td class='day_date'>"+obj.day_date+"</td>\n"+
                            "       <td>"+obj.name+"</td>\n"+
                            "       <td>" +
                            "       <button id='select' type=\"button\" class=\"btn btn-primary\"  dayid='" + obj.reportid + "'>\n" +
                            "      查看详情\n" +
                            "   </button>"+
                            "</td>\n";
                        html = html + "<td>" + obj.writestate + "</td>" +
                            "            <td>";
                        if (obj.writestate !== '已提交' && obj.writestate !== '已通过') {
                            if (obj.dateinfo == 'z') {
                                html = html + "<input value='填报' dayid='" + obj.reportid + "' type='button' class=\"btn btn-info\" />";
                            }
                            if (obj.dateinfo == 'b') {
                                html = html + "<input value='补报' dayid='" + obj.reportid + "' type='button' class=\"btn btn-info\" />";
                            }
                            if (obj.reportid != null && obj.reportid != '') {
                                html = html + "<input value='提交' dayid='" + obj.reportid + "' type='button' class=\"btn btn-warning\" />";
                            }
                        }

                        html = html + "</td>"
                        html=html+"     </tr>";
                        $("#tab").append(html);
                    }
                }
            }
        })
    }
    //周报详情
    $("#tab").on("click","#select",function () {
        var dayid=$(this).attr("dayid");
        $.ajax({
            url:"${path}/weekReport/selectWeekById",
            data:{reportid:dayid},//给后台参数 organ
            dataType:"json",
            type:"post",
            success:function (data) {
                $("#title1").val(data.title);
                $("#content1").val(data.content);
                $('#myModal').modal('show');
            }
        });
    })
    //点击补录，如果已经保存过则读取数据  否则直接显示
    $("#tab").on("click","input[value='补报']",function () {
        var dayid=$(this).attr("dayid");
        if(dayid!=null&&dayid!=undefined&&dayid!=''&&dayid!='null'){
            $("#reportid").val(dayid);

            $.ajax({
                url:"${path}/weekReport/selectWeekById",
                data:{"reportid":dayid},//给后台参数 organ
                dataType:"json",
                type:"post",
                success:function (data) {
                    $("#reportstate").val('1');
                    $("#title").val(data.title);
                    $("#reportdate").val(data.reportdate);
                    $("#content").val(data.content);
                    $("#editModal").modal("show");
                }
            });
        }else{
            $("#reportid").val('');
            var date=$(this).parent().parent().find(".day_date").html();
            var person='${sessionScope.account.name}';
            $("#title").val(person+date+"周报");
            $("#reportdate").val(date);
            $("#reportstate").val('1');
            $("#content").val('');
            $('#editModal').modal('show')
        }
    });
     //填报
    $("#tab").on("click","input[value='填报']",function () {
        var dayid=$(this).attr("dayid");
        if(dayid!=null&&dayid!=undefined&&dayid!=''&&dayid!='null'){
            $("#reportid").val(dayid);
            $.ajax({
                url:"${path}/weekReport/selectWeekById",
                data:{"reportid":dayid},//给后台参数 organ
                dataType:"json",
                type:"post",
                success:function (data) {
                    $("#reportstate").val('0');
                    $("#title").val(data.title);
                    $("#reportdate").val(data.reportdate);
                    $("#content").val(data.content);
                    $('#editModal').modal('show');
                }
            });
        }else{
            $("#reportid").val('');
            var date=$(this).parent().parent().find(".day_date").html();
            var person='${sessionScope.account.name}';
            $("#title").val(person+date+"周报");
            $("#reportdate").val(date);
            $("#reportstate").val('0');
            $("#content").val('');
            $('#editModal').modal('show')
        }
    })
    //点击保存触发，进行数据保存
    $("#saveBtn").click(function () {
        if($("#content").val()==""){
            lightyear.loading('show');
            setTimeout(function() {
                lightyear.loading('hide');
                lightyear.notify('周报内容不能为空','danger', 1000,'mdi mdi-emoticon-happy','bottom');
            }, 1e2);
            return false;
        }
        var pname='${sessionScope.account.name}'
        var pstuffid='${sessionScope.account.stuffid}'
        console.log(pname);
        var obj={reportid:$("#reportid").val(),
            title:$("#title").val(),
            content:$("#content").val(),
            reportdate:$("#reportdate").val(),
            reportstate:$("#reportstate").val(),
            createstuffid:pstuffid,
            createstuffname:pname
        };
        $.ajax({
            url:"${path}/weekReport/insertOrUpdateReport",
            data:{"datainfo":JSON.stringify(obj)},//给后台参数 organ
            dataType:"text",
            type:"post",
            success:function (data) {
                load(1);
                $('#editModal').modal('hide');
            }
        });
    });
    //点击提交触发  更改状态为已提交
    $("#tab").on("click","input[value='提交']",function () {
        var dayid=$(this).attr("dayid");
        if(dayid!=null&&dayid!=undefined&&dayid!=''&&dayid!='null'){
            $.ajax({
                url:"${path}/weekReport/updateWriteState",
                data:{"reportid":dayid,writestate:'1'},//给后台参数 organ
                dataType:"text",
                type:"post",
                success:function (data) {
                    load(1);
                }
            });
        }
    })
</script>
</body>
</html>
