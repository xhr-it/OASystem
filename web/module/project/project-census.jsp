<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>项目统计</title>
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
                        <div class="card-body" style="padding-bottom: 0px;padding-left: 150px">

                            <%--<form class="form-inline" method="post" onsubmit="return false;">
                                <div class="form-group">
                                    <input class="form-control" type="text" id="projectname"  placeholder="项目名称">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" type="date" id="begindate"  placeholder="起始时间">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" type="date" id="enddate"  placeholder="结束时间">
                                </div>
                                <div class="form-group">
                                    <button class="btn btn-default" type="button" id="selectBtn">搜索</button>
                                </div>
                            </form>--%>

                        </div>

                        <div class="card-body" >

                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th>序号</th>
                                        <th>项目名称</th>
                                        <th>项目天数</th>
                                        <th>总任务天数</th>
                                        <th>完成任务天数</th>
                                        <th>进行中任务天数</th>
                                        <th>有问题任务天数</th>
                                        <th>总任务个数</th>
                                        <th>完成任务个数</th>
                                        <th>进行中任务个数</th>
                                        <th>有问题任务个数</th>
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
                    <%--条形图--%>
                    <div class="card">
                        <div class="card-header"><h4>项目情况统计图</h4></div>
                        <div class="card-body">
                            <canvas id="chart-vbar-1" width="400" height="250"></canvas>
                        </div>
                    </div>
                </div>

            </div>

        </div>

        </main>
        <!--End 页面主要内容-->
    </div>

</div>
<script type="text/javascript" src="../../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>
<%--Chart.js--%>
<script type="text/javascript" src="../../resource/js/Chart.js"></script>
<script type="text/javascript" src="../../resource/js/main.min.js"></script>
<%@ include file="../../resource/common.jsp"%>
<script>
    //分页
    $().ready(function () {
        load(1);
        loadChar();
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
    //查询项目
    function load(nowPage) {
        var obj={projectname:null,begin:null,end:null};
        var pageInfo={nowPage:nowPage,rows:5};
        $.ajax({
            url:"${path}/project/selectProjectCensus",
            data:{dataInfo:JSON.stringify(obj),pageInfo:JSON.stringify(pageInfo)},
            dataType:"json",
            type:"post",
            success:function (page) {
                console.log("统计数据：")
                console.log(page.data);
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
                            "                    <td>"+(i+1)+"</td>\n" +
                            "                    <td>"+obj.projectname+"</td>\n" +
                            "                    <td >"+obj.xiangmutianshu+"</td>\n" +
                            "                    <td >"+obj.总任务天数+"</td>\n" +
                            "                    <td >"+obj.完成任务天数+"</td>\n" +
                            "                    <td >"+obj.进行中任务天数+"</td>\n" +
                            "                    <td >"+obj.有问题任务天数+"</td>\n" +
                            "                    <td >"+obj.总任务个数+"</td>\n" +
                            "                    <td >"+obj.完成任务个数+"</td>\n" +
                            "                    <td >"+obj.进行中任务个数+"</td>\n" +
                            "                    <td >"+obj.有问题任务个数+"</td>\n" +
                            "                </tr>";

                        $("#tab").append(html);
                    }
                }
            }
        })
    }
    //折线图
    function loadChar() {
        var dataInfo = {
            projectname:$("#projectname").val(),begin:$("#begindate").val(),end:$("#enddate").val()
        };
        $.ajax({
            url:"${path}/project/selectChart",
            data:{dataInfo:JSON.stringify(dataInfo)},
            dataType:"json",
            type:"post",
            success:function (data) {
                var objName= new Array;
                var obj= new Array;
                for (var i = 0; i <data.length ; i++) {
                    objName.push(data[i].projectname);
                    obj.push(data[i].jg);
                }
                new Chart($("#chart-vbar-1"), {
                    type: 'bar',
                    data: {
                        labels: objName,
                        datasets: [{
                            label: "进行中任务个数",
                            backgroundColor: "rgba(51,202,185,0.5)",
                            borderColor: "rgba(0,0,0,0)",
                            hoverBackgroundColor: "rgba(51,202,185,0.7)",
                            hoverBorderColor: "rgba(0,0,0,0)",
                            data: obj
                        }]
                    },
                    options: {
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                        }
                    }
                });
            }
        });

    }
</script>
</body>
</html>
