<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>项目树</title>
    <%@ include file="../../resource/common.jsp"%>
    <link rel="stylesheet" href="../../resource/zTree_v3/css/metroStyle/metroStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div style="float:left;padding-left: 230px;padding-top: 80px;width: 180px">
    <ul id="treeDemo" class="ztree"></ul>
    <%--<iframe style="display: inline-block; border:none;width:100%;height:100%;"   src="" id="main"></iframe>--%>
</div>
<div style="float:left;width:1090px;padding-top: 80px;">
    <iframe style="border:none;width:100%;height:100%;"   src="" id="main"></iframe>
</div>
<script type="text/javascript" src="../../resource/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resource/zTree_v3/js/jquery.ztree.all.min.js" ></script>
<script>
    <%
                      Map map=(Map) session.getAttribute("account");
                      String stuffid=map.get("stuffid").toString();
          %>
    var stuffid="<%=stuffid%>";
    var zTreeObj;//代表一棵树，树目前没值
    //设置
    var setting = {
        data: {
            simpleData: {
                enable: true,  //true 、 false 分别表示 使用 、 不使用 简单数据模式
                idKey: "deptid",  //节点数据中保存唯一标识的属性名称
                pIdKey: "tab_deptid",    //节点数据中保存其父节点唯一标识的属性名称
                rootPId: -1  //用于修正根节点父节点数据，即 pIdKey 指定的属性值
            },
            key: {
                name: "deptname"  //zTree 节点数据保存节点名称的属性名称  默认值："name"
            }
        },
        check:{
            enable:false,  //true 、 false 分别表示 显示 、不显示 复选框或单选框
            nocheckInherit:true  //当父节点设置 nocheck = true 时，设置子节点是否自动继承 nocheck = true
        },
        callback: {
            onDblClick: zTreeOnDblClick
        }
    };
    function zTreeOnDblClick(event, treeId, treeNode) {
        var id=treeNode.deptid;
        var name=treeNode.deptname;
        var type=treeNode.type;
        if (type=='x'){
            $("#main").attr("src","${path}/module/task/task-resolve.jsp?projectid="+id+"&projectname="+name+"");
        }

    };
    //数据
    $.ajax({
        url:"${path}/project/selectDeptAndProject",
        data:{deptid:-1,stuffid:stuffid},
        dataType:"json",
        type:"post",
        success:function (data) {
            var zNodes=data;
            zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes); //初始化树
            zTreeObj.expandAll(false);    //true 节点全部展开、false节点收缩
        }
    })
</script>
</body>
</html>
