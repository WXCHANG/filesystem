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
            <div class="ant-card-head-title">网络配置</div>
        </div>
    </div>
    <div class="text-body">
        <table id="summary" class="layui-table layui-fluid scroll" lay-size="sm" lay-filter="test"></table>   
    </div>
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
            {field: 'name', title: '配置参数', width:'15%',}
            ,{field: 'value', title: '参数描述', width:'85%'}
            
        ]]
    });
});

const data = [{
    key: '1',
    name: 'mixhash',
    value: '与nonce配合用于挖矿，由上一个区块的一部分生成的hash。注意他和nonce的设置需要满足以太坊的Yellow paper, 4.3.4. Block Header Validity, (44)章节所描述的条',
}, {
    key: '2',
    name: 'nonce',
    value: 'nonce就是一个64位随机数，用于挖矿，注意他和mixhash的设置需要满足以太坊的Yellow paper, 4.3.4. Block Header Validity, (44)章节所描述的条件。',
}, {
    key: '3',
    name: 'difficulty',
    value: '设置当前区块的难度，如果难度过大，cpu挖矿就很难，这里设置较小难度',
}, {
    key: '4',
    name: 'alloc',
    value: '用来预置账号以及账号的**币数量。',
}, {
    key: '5',
    name: 'coinbase',
    value: '矿工的账号。',
}, {
    key: '6',
    name: 'timestamp',
    value: '时间戳',
}, {
    key: '7',
    name: 'parentHash',
    value: '上一个区块的hash值',
}, {
    key: '8',
    name: 'extraData',
    value: '附加信息，根据需要填写。',
}, {
    key: '9',
    name: 'gasLimit',
    value: '该值设置对GAS的消耗总量限制，用来限制区块能包含的交易信息总和。',
}];
</script> 
</body>
</html>
