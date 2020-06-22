<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>日报填报</title>
    <link rel="icon" href="../../resource/favicon.ico" type="image/ico">
    <link href="../../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../../resource/css/style.min.css" rel="stylesheet">
    <link href="../../resource/zTree_v3/css/metroStyle/metroStyle.css" rel="stylesheet"/>
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
                                            <th>日报名称</th>
                                            <th>日报日期</th>
                                            <th>编写人</th>
                                            <th>日报内容</th>
                                            <th>填报类型</th>
                                            <th>状态</th>
                                            <th>操作</th>
                                            <%--<th>意见</th>--%>
                                        </tr>
                                        </thead>
                                        <tbody id="tab">

                                        </tbody>
                                    </table>
                                    <input type="hidden" id="begindate"/>
                                    <input type="hidden" id="enddate"/>
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

    <%--日报详情模态框--%>
    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel1">日报内容</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="recipient-name" class="control-label">标题：</label>
                            <input type="text" class="form-control" id="recipient-name">
                        </div>
                        <div class="form-group">
                            <label for="message-text" class="control-label" readonly>内容：</label>
                            <textarea class="form-control" id="message-text" readonly></textarea>
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
    <%--日报填报模态框--%>
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding-top: 100px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">填写日报</h4>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="dayreportid">
                    <input type="hidden" id="reportstate"/>
                    <form>
                        <div class="form-group">
                            <label for="recipient-name" class="control-label">日期：</label>
                            <input type="text" class="form-control" id="reportdate">
                        </div>
                        <div class="form-group">
                            <label for="message-text" class="control-label" >标题：</label>
                            <textarea class="form-control" id="title" readonly></textarea>
                        </div>
                        <div class="form-group">
                            <label for="message-text" class="control-label" >内容：</label>
                            <textarea class="form-control" id="content" ></textarea>
                        </div>
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
<%--<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>--%>
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
    });
    //查询日报
    var time=new Date();
    var year=time.getFullYear();
    var month="0"+(time.getMonth()+1);
    var day=time.getDate();
    var day2=time.getDate()-6;
    //前六天
    var fdate=(year+"-"+month+"-"+day2);
    //今天
    var nowdate=(year+"-"+month+"-"+day);
    function load(nowPage) {
        $("#begindate").val(fdate);
        $("#enddate").val(nowdate);
        var dateInfo={begindate:fdate,enddate:nowdate};
        var pageInfo={nowPage:nowPage,rows:8};
        $.ajax({
            url:"${path}/dayReport/selectReport",
            data:{dateInfo:JSON.stringify(dateInfo),pageInfo:JSON.stringify(pageInfo)},
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
                        var html="<tr>"+
                                "<td>"+(i+1)+"</td>";
                        if (obj.title==null){
                            html=html+"<td>未填写</td>\n";
                        }else {
                            html=html+"<td>"+obj.title+"</td>\n";
                        }
                        html=html+"<td class='day_date'>"+obj.day_date+"</td>\n" +
                            "      <td>"+obj.name+"</td>\n" +
                            "      <td><button dayid='"+ obj.dayreportid +"' type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#myModal1\" id='"+obj.actorid+"'>\n" +
                            "      日报内容" +
                            "      </button></td>\n";
                        if (obj.reportstate==0){
                            html=html+"<td>正常填报</td>\n";
                        }else if (obj.reportstate==1){
                            html=html+"<td>正常补报</td>\n";
                        }else if (obj.reportstate==2){
                            html=html+"<td>异常填报</td>\n";
                        }else if (obj.reportstate==3){
                            html=html+"<td>异常补报</td>\n";
                        }else {
                            html=html+"<td>未填写</td>\n";
                        }
                        html=html+"       <td>"+obj.writestate+"</td>\n";
                        if (obj.writestate!=='已提交'&&obj.writestate!=='已通过') {
                            html=html+"<td>";
                            if (obj.dateinfo == 'z') {
                                html=html+"<button id='tianbao' type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#myModal2\" dayid='"+ obj.dayreportid +"'>填报</button>\n" ;
                            }else if (obj.dateinfo == 'b') {
                                html=html+"<button id='bubao' type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#myModal2\" dayid='"+obj.dayreportid+"'>补报</button>\n" ;
                            }
                            if (obj.dayreportid != null && obj.dayreportid != '') {
                                html=html+"<button id='submit' type=\"button\" class=\"btn btn-primary\" dayid='"+obj.dayreportid+"'>提交</button>\n" ;
                            }
                            html=html+"</td>"
                        }else {
                            html=html+"<td>无需操作</td>";
                        }
                        /*if(obj.writestate=='已通过'||obj.reportstate=='2'||obj.reportstate=='3'){
                            html=html+"<td><a class=\"btn btn-success m-r-5\" href=\"#!\"><i class=\"mdi mdi-check\"></i> 查看意见</a></td>\n" ;
                        }else {
                            html=html+"<td></td>\n" ;
                        }*/
                        html=html+"</tr>";
                        $("#tab").append(html);
                    }
                }
            }
        })
    }
    //查看日报内容
    $("#tab").on("click","button[type='button']",function () {
        var dayid=$(this).attr("dayid");
        $.ajax({
            url:"${path}/dayReport/selectDayReportById",
            data:{dayreportid:dayid},//给后台参数 organ
            dataType:"json",
            type:"post",
            success:function (data) {
                console.log(data);
                $("#recipient-name").val(data.title);
                $("#message-text").val(data.content);
                $('#mycontent').modal('show');
            }
        });
    });
    //点击填报
    $('body').on('click','#tianbao',function () {
        var dayid=$(this).attr("dayid");
        if(dayid!=null&&dayid!=undefined&&dayid!=''&&dayid!='null'){
            $("#dayreportid").val(dayid);
            $.ajax({
                url:"${path}/dayReport/selectDayReportById",
                data:{"dayreportid":dayid},//给后台参数 organ
                dataType:"json",
                type:"post",
                success:function (data) {
                    $("#reportstate").val('0');
                    $("#title").val(data.title);
                    $("#reportdate").val(data.reportdate);
                    $("#content").val(data.content);
                }
            });
        }else{
            $("#dayreportid").val('');
            var date=$(this).parent().parent().find(".day_date").html();
            var person='${sessionScope.account.name}';
            $("#title").val(person+date+"日报");
            $("#reportdate").val(date);
            $("#reportstate").val('0');
            $("#content").val('');
        }
    });
    //点击补报
    //如果已经存在则读取数据  否则直接显示
    $('body').on('click','#bubao',function () {
        var dayid=$(this).attr("dayid");
        if(dayid!=null&&dayid!=undefined&&dayid!=''&&dayid!='null'){
            $("#dayreportid").val(dayid);
            $.ajax({
                url:"${path}/dayReport/selectDayReportById",
                data:{"dayreportid":dayid},//给后台参数 organ
                dataType:"json",
                type:"post",
                success:function (data) {
                    $("#reportstate").val('1');
                    $("#title").val(data.title);
                    $("#reportdate").val(data.reportdate);
                    $("#content").val(data.content);
                }
            });
        }else{
            $("#dayreportid").val('');
            var date=$(this).parent().parent().find(".day_date").html()
            var person='${sessionScope.account.name}';
            $("#title").val(person+date+"日报");
            $("#reportdate").val(date);
            $("#reportstate").val('1');
            $("#content").val('');
        }
    })
    //点击保存触发，进行数据保存
    $("#saveBtn").click(function () {
        if($("#content").val()==""||$("#content").val()==null){
            lightyear.loading('show');
            setTimeout(function() {
                lightyear.loading('hide');
                lightyear.notify('日报内容不能为空~','danger', 1000,'mdi mdi-emoticon-happy','bottom');
            }, 1e2);
            return false;
        }
        var pname='${sessionScope.account.name}'
        var pstuffid='${sessionScope.account.stuffid}'
        var obj={dayreportid:$("#dayreportid").val(),
            title:$("#title").val(),
            content:$("#content").val(),
            reportdate:$("#reportdate").val(),
            reportstate:$("#reportstate").val(),
            createstuffid:pstuffid,
            createstuffname:pname
        };
        $.ajax({
            url:"${path}/dayReport/insertOrUpdateReport",
            data:{"datainfo":JSON.stringify(obj)},//给后台参数 organ
            dataType:"text",
            type:"post",
            success:function (data) {
                window.location.reload();
            }
        });
    });
    //提交日报
    $('body').on('click','#submit',function () {
        var dayid=$(this).attr("dayid");
        if(dayid!=null&&dayid!=undefined&&dayid!=''&&dayid!='null'){
            $.ajax({
                url:"${path}/dayReport/updateWriteState",
                data:{"dayreportid":dayid,writestate:'1'},//给后台参数 organ
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
