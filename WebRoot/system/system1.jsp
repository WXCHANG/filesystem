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
    <style>
    #summary{
        width: 300px;
        margin: 0 auto;
    }
    tr,th{
        text-align: center !important;
    }
    </style>
</head>
  
<body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">系统配置</div>
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
        ,height: 460
        ,data: data
        ,page: false//开启分页
        ,cols: [[ //表头
            {field: 'name', title: '系统配置'}
            ,{field: 'value', title: '参数值'}
            
        ]]
    });
});

const data = [{
    key: '1',
    name: 'CPU',
    value: '1.2GHz'
}, {
    key: '2',
    name: '内存',
    value: '16G'
}, {
    key: '3',
    name: '硬盘',
    value: '8GB剩余空间'
},{
    key: '5',
    name: '显存容量',
    value: '2GB'
}, {
    key: '6',
    name: '局域网',
    value: '100/1000Mbps'
}, {
    key: '7',
    name: '转速',
    value: '5400转/分钟'
}, {
    key: '8',
    name: '固态硬盘',
    value: '128GB SSD'
}, {
    key: '9',
    name: '内存类型',
    value: 'DDR4 2133'
}];
</script> 
</body>
</html>
