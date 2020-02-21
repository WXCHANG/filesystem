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
            <div class="ant-card-head-title">区块节点监测</div>
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
        // ,height: 300
        ,data: data
        ,page: false//开启分页
        ,cols: [[ //表头
            {title: '序号', templet: '#indexTpl', width: 60,},
            {title: '节点IP', width: 150, field: 'IP',},
            {title: '操作系统类型', field: 'system',},
            {title: 'CPU', field: 'cpu', width: 60},
            {title: '带宽', field: 'bandWidth',width: 100},
            {title: '内存', field: 'ram',width: 100},
            
        ]]
    });
});

const data = [{
    key: '1',
    IP: '101.132.101.109',
    port: '',
    system: 'Ubuntu 14.04 64位',
    cpu: '4核',
    bandWidth: '10Mbps',
    ram: '16GB',
}, {
    key: '2',
    IP: '139.196.140.49',
    port: '',
    system: 'Ubuntu 14.04 64位',
    cpu: '4核',
    bandWidth: '10Mbps',
    ram: '16GB',
}, {
    key: '3',
    IP: '101.132.75.132',
    port: '',
    system: 'Windows Server 2008 R2 企业版 64位中文版',
    cpu: '2核',
    bandWidth: '10Mbps',
    ram: '8GB',
}, {
    key: '4',
    IP: '139.224.232.212',
    port: '',
    system: 'Windows Server  2012 标准版 64位中文版',
    cpu: '2核',
    bandWidth: '5Mbps',
    ram: '4GB',
}, {
    key: '5',
    IP: '39.106.26.231',
    port: '',
    system: 'Ubuntu 16.04 64位',
    cpu: '2核',
    bandWidth: '2Mbps',
    ram: '4GB',
}, {
    key: '6',
    IP: '39.107.75.65',
    port: '',
    system: 'Ubuntu 16.04 64位',
    cpu: '2核',
    bandWidth: '2Mbps',
    ram: '4GB',
}, {
    key: '7',
    IP: '47.93.40.96',
    port: '',
    system: ' Ubuntu 16.04 64位',
    cpu: '2核',
    bandWidth: '2Mbps',
    ram: '4GB',
}];
</script> 
</body>
</html>
