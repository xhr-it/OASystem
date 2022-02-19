<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>周报统计</title>
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
                                            <th>部门名称</th>
                                            <th>周报总数</th>
                                            <th>正常填报</th>
                                            <th>正常补报</th>

                                        </tr>
                                        </thead>
                                        <tbody id="tab">

                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </div>
                        <%--条形图--%>
                        <div class="card">
                            <div class="card-header"><h4>周报数量统计图</h4></div>
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
    $().ready(function () {
        load();
        loadChar();
    });
    <%
        Date d = new Date();
        SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd");
        String date = df1.format(d);
        SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String datetime = df2.format(d);
    %>
    function load() {
        var dataInfo = {stuffid:"<%=session.getAttribute("stuffid")%>",nowdate:"<%=date%>",
            begin:$("#daterange1").val(),end:$("#daterange2").val()};

        var name = "<%=session.getAttribute("name")%>";
        $.ajax({
            url:"${path}/weekReport/selectForTab",
            data:{dataInfo:JSON.stringify(dataInfo)},
            dataType:"json",
            type:"post",
            success:function (data) {
                $("#tab").html("");
                if (data!=null){
                    for (var i=1;i<data.length;i++){
                        var obj = data[i];
                        var tr = "<tr>\n" +
                            "         <td>"+obj.deptname+"</td>\n" +
                            "         <td>"+obj.zc+"</td>\n" +
                            "         <td>"+obj.tb+"</td>\n" +
                            "         <td>"+obj.bb+"</td>\n" +
                            "      </tr>";
                        $("#tab").append(tr);
                    }
                }
            }
        });

    }
    function loadChar() {
        var dataInfo = {
            begin:$("#daterange1").val(),end:$("#daterange2").val()
        };
        $.ajax({
            url:"${path}/weekReport/selectChart",
            data:{dataInfo:JSON.stringify(dataInfo)},
            dataType:"json",
            type:"post",
            success:function (data) {
                new Chart($("#chart-vbar-1"), {
                    type: 'bar',
                    data: {
                        labels: [data[0].date, data[1].date, data[2].date, data[3].date],
                        datasets: [{
                            label: "周报数量",
                            backgroundColor: "rgba(51,202,185,0.5)",
                            borderColor: "rgba(0,0,0,0)",
                            hoverBackgroundColor: "rgba(51,202,185,0.7)",
                            hoverBorderColor: "rgba(0,0,0,0)",
                            data: [data[0].count,data[1].count,data[2].count,data[3].count]
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
