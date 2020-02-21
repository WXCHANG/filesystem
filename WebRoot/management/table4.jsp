<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
    <!--[if lt IE9]> 
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
</head>
  
<body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">区块详情列表</div>
        </div>
    </div>
    <div class="text-body">
        <table id="summary" class="layui-table layui-fluid scroll" lay-size="sm" lay-filter="test"></table>   
    </div>

<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script>
layui.use('table', function(){
    var table = layui.table;
    // table实例化
    table.render({
        elem: '#summary'
        ,height: 540
        ,url: 'getBlockOrigins.do' //数据接口
       //,data: data
        ,page: true //开启分页
        ,cols: [[ //表头
            {title: '序号', templet: '#indexTpl', width: 60,}
            // {field: 'id', title: 'ID', width:80, sort: true,}
            ,{field: 'name', title: '业务字段1', width:120,}
            ,{field: 'area', title: '业务字段2', width:200}
            ,{field: 'identifier', title: '业务字段3', width:200}
            ,{field: 'hash', title: '数据Hash',} 
            ,{field: 'blocknumber', title: '区块高度', width: 180,}
            ,{field: 'blockhash', title: '区块Hash值',}
            
        ]]
    });
});


</script> 
</body>
</html>
