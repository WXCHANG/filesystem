<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
    if (session.getAttribute("manager") == null) {
        response.setHeader("refresh", "0;URL=/openPlatform/admin/login.jsp");
        return;
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    
    <title>Document</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">    
    <meta http-equiv="keywords" content="log">
    <meta http-equiv="description" content="operation log">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/lay/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/table.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/lay/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
    <!--[if lt IE9]> 
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
</head>
  
<body>
    <blockquote class="layui-elem-quote">
        <h1>操作日志</h1>
    </blockquote>
    <!-- 条件查询 -->
    <form class="layui-form">
        <div class="layui-inline layui-form-item">
            <label for="" class="layui-form-label" style="width: 60px;">时间</label>
            <div class="layui-input-inline " style="width: 200px;">
                <input id="startTime" type="date" class="layui-input" name="">
            </div>
            <div class="layui-form-mid">至</div>
            <div class="layui-input-inline " style="width: 200px;">
                <input id="endTime" type="date" class="layui-input" name="">
            </div>
        </div>
        <div class="layui-inline layui-form-item">
            <label for="" class="layui-form-label" style="width: 90px;">操作账号</label>
            <!-- 账号 -->
            <div class="layui-input-inline" style="width: 200px;">
                <input id="user" type="text" class="layui-input" name="" layui-filter="">
            </div>
        </div>
        <div class="layui-inline layui-form-item">
            <button id="search" class="layui-btn layui-btn-disabled" lay-submit lay-filter="search" style="margin-top: -5px;" >查询</button>
        </div>
    </form>
    <div class=""></div>
    <table id="logTable" class="layui-table layui-fluid" lay-size="sm">
        <thead class="layui-bg-gray">
            <tr class="">
                <th >序号</th>
                <th >日志ID</th>
                <th >账号</th>
                <th >操作时间</th>
                <th >操作内容</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <div>
        <span id="layPage"></span>
    </div>
<script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/log.js"></script>
<script>
layui.use('laydate', function(){
    var laydate = layui.laydate;  
    //执行一个laydate实例
    laydate.render({
        elem: '#time',
        type: 'data',
        range: '-',
        format: 'yyyy-MM-dd',
        min: -30, //30天前
        max: 0, //当天
        trigger: 'click',//采用click弹出
    });
});
</script> 
</body>
</html>
