<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>日历-日报提交情况</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../../resource/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resource/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="../../resource/css/style.min.css" rel="stylesheet">
    <style>
        #cldFrame{
            position: relative;
            width: 800px;
            margin: 50px auto;
        }
        #cldBody{
            margin: 10px;
            position: absolute;
            width: 800px;
        }
        #top{
            position: relative;
            height: 85px;
            text-align: center;
            line-height: 85px;
        }
        #topDate{
            font-size: 20px;
        }
        .curDate{
            color: red;
            font-weight: bold;
        }
        table{
            background-color: #f7f7f7;
        }
        #week td{
            font-size: 15px;
        }
        td{
            height: 70px;
            width: 100px;
            text-align: center;
            font-family: Simsun;
            font-size: 20px;
        }
        #left, #right{
            position: absolute;
            width: 60px;
            height: 60px;
        }
        #left{left: 0px;}
        #right{right: 0px;}
        #left:hover, #right:hover{
            background-color: rgba(30, 30, 30, 0.2);
        }
    </style>
    <script>

    </script>
</head>
<body >
<div style="color: yellow">
未填报：<span style="color:red">×</span>

补报：<span style="color:red">√</span>

加班补报：<span style="color:red">√√</span>

填报：<span style="color:red">√</span>

加班填报：<span style="color:red">√√</span>
    </div>
<div id="cldFrame">
    <div id="cldBody">
        <table class="table table-bordered">
            <thead>
            <tr>
                <td colspan="7">
                    <div style="float: left">
                        提交：✔
                        未提交：✘
                    </div>
                    <div id="top">
                        <span id="left">&lt;</span>
                        <span id="topDate"></span>
                        <span id="right">&gt;</span>
                    </div>
                </td>
            </tr>
            <tr id="week">
                <td>日</td>
                <td>一</td>
                <td>二</td>
                <td>三</td>
                <td>四</td>
                <td>五</td>
                <td>六</td>
            </tr>
            </thead>
            <tbody id="tbody">
            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript" src="../../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../resource/js/perfect-scrollbar.min.js"></script>
<%@ include file="../../resource/common.jsp"%>
<script>
    var monthDay = [31,0,31,30,31,30,31,31,30,31,30,31];
    /*判断某年是否是闰年*/
    function isLeap(year) {
        if((year%4==0 && year%100!=0) || year%400==0){
            return true;
        }
        else{
            return false;
        }
    }
    /*判断某年某月某日是星期几，默认日为1号*/
    function whatDay(year, month, day=1) {
        var sum = 0;
        sum += (year-1)*365+Math.floor((year-1)/4)-Math.floor((year-1)/100)+Math.floor((year-1)/400)+day;
        for(var i=0; i<month-1; i++){
            sum += monthDay[i];
        }
        if(month > 2){
            if(isLeap(year)){
                sum += 29;
            }
            else{
                sum += 28;
            }
        }
        return sum%7;      //余数为0代表那天是周日，为1代表是周一，以此类推
    }
    function showCld(year, month, firstDay){
        var i;
        var tagClass = "";
        var nowDate = new Date();

        var days;//从数组里取出该月的天数
        if(month == 2){
            if(isLeap(year)){
                days = 29;
            }
            else{
                days = 28;
            }
        }
        else{
            days = monthDay[month-1];
        }

        /*当前显示月份添加至顶部*/
        var topdateHtml = year + "年" + month + "月"+"日报概况";
        var topDate = document.getElementById('topDate');
        topDate.innerHTML = topdateHtml;

        /*添加日期部分*/
        var tbodyHtml = '<tr>';
        console.log(firstDay);
        for(i=0; i<firstDay; i++){//对1号前空白格的填充
            tbodyHtml += "<td></td>";
        }
        var changLine = firstDay;
        var monthStr=0;
        if(month<10){
            monthStr="0"+month;
        }else{
            monthStr=month;
        }
        //alert(year+'-'+monthStr);
        $.ajax({
            url:" ${path}/dayReport/calendarForDayReport",
            data:{stuffid:${sessionScope.account.stuffid},dateinfo:year+'-'+monthStr},
            dataType:"json",
            type:"post",
            success:function(data){
                for(i=1; i<=data.length; i++){//每一个日期的填充
                    var obj=data[i-1];
                    var zz=obj.zt;
                    if(zz==null){
                        zz='<span style="color:red">×</span>'
                    }else if(zz=='bb'){
                        zz='<span style="color:red">√</span>'
                    }else if(zz=='jbbb'){
                        zz='<span style="color:red">√</span>'
                    }else if(zz=='tb'){
                        zz='<span style="color:red">√</span>'
                    }else if(zz=='jbtb'){
                        zz='<span style="color:red">√</span>'
                    }
                    if(year == nowDate.getFullYear() && month == nowDate.getMonth()+1 && i == nowDate.getDate()) {
                        tagClass = "curDate";//当前日期对应格子
                    }
                    else{
                        tagClass = "isDate";//普通日期对应格子，设置class便于与空白格子区分开来
                    }
                    tbodyHtml += "<td class=" + tagClass + ">" + i +"("+zz+")"+ "</td>";
                    changLine = (changLine+1)%7;
                    if(changLine == 0 && i != days){//是否换行填充的判断
                        tbodyHtml += "</tr><tr>";

                    }

                }
                if(changLine!=0){//添加结束，对该行剩余位置的空白填充
                    for (i=changLine; i<7; i++) {
                        tbodyHtml += "<td></td>";
                    }
                }//实际上不需要填充后方，但强迫症必须整整齐齐！
                tbodyHtml +="</tr>";
                var tbody = document.getElementById('tbody');
                tbody.innerHTML = tbodyHtml;
            }
        })


    }
    function nextMonth(){
        var topStr = document.getElementById("topDate").innerHTML;
        var pattern = /\d+/g;
        var listTemp = topStr.match(pattern);
        var year = Number(listTemp[0]);
        var month = Number(listTemp[1]);
        var nextMonth = month+1;
        if(nextMonth > 12){
            nextMonth = 1;
            year++;
        }
        document.getElementById('topDate').innerHTML = '';
        showCld(year, nextMonth, whatDay(year, nextMonth));
    }
    function preMonth(){
        var topStr = document.getElementById("topDate").innerHTML;
        var pattern = /\d+/g;
        var listTemp = topStr.match(pattern);
        var year = Number(listTemp[0]);
        var month = Number(listTemp[1]);
        var preMonth = month-1;
        if(preMonth < 1){
            preMonth = 12;
            year--;
        }
        document.getElementById('topDate').innerHTML = '';
        showCld(year, preMonth, whatDay(year, preMonth));
    }

    var curDate = new Date();
    var curYear = curDate.getFullYear();
    var curMonth = curDate.getMonth() + 1;
    showCld(curYear,curMonth,whatDay(curYear,curMonth));
    document.getElementById('right').onclick = function(){
        nextMonth();
    };
    document.getElementById('left').onclick = function(){
        preMonth();
    }

</script>
</body>
</html>
