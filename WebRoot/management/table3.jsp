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
    body{
    	width: 100%;
    	overflow: hidden;
    }
    .layui-form-item {
        margin-bottom: 0;
    }
    #user{
        border-radius: 20px;
        padding: 0 15px 0 30px;
        height: 32px;
        margin: 5px 0;
        text-overflow:ellipsis;
    }
    i.search{
        display: inline-block;
        position: absolute;
        top: 12px;
        left: 10px;
    }
    button#search{
        height: 32px;
        line-height: 32px;
        border-radius: 5px;
    }
    .search-box{
    	min-width: 400px;
    }
    </style>
     <script>
	     $(function () {
	    	var userId=<%=session.getAttribute("userId")%>; 
	   		if(userId==null){
	   			alert("用户登录超时，请重新登录")
	   			window.parent.location.href='userLogin.jsp';
	   		} 
	    })
    </script>
</head>
  
<body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">区块信息列表</div>
            <div>
                <div class="layui-inline layui-form-item">
                    <div class="layui-input-inline search-box">
                        <i class="layui-icon search">&#xe615;</i>
                        <input id="user" type="text" class="layui-input" name="" layui-filter=""; placeholder="请输入区块编号或区块Hash">
                    </div>
                </div>
                <div class="layui-inline layui-form-item">
                    <button id="search" class="layui-btn" lay-filter="search" >查询</button>
                </div>
            </div>
        </div>
    </div>
    <div class="text-body">
        <table id="summary" class="layui-table layui-fluid scroll" lay-size="sm" lay-filter="test"></table>   
    </div>  
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn layui-btn-mini" lay-event="detail">查看详情</a>
</script>
<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script>
layui.use('table', function(){
    var table = layui.table;
    // table实例化
    table.render({
        elem: '#summary'
        ,height: 'full-100'
        ,url: 'queryBlocks.do' //数据接口
        ,limits: [10]
        //,data: data
        ,page: true //开启分页
        ,cols: [[ //表头
           {title: '序号', templet: '#indexTpl', width: 60, fixed: 'left', type: 'numbers'}
            // {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
            ,{field: 'number', title: '区块高度', width: 120,}
            ,{field: 'currentHash', title: '区块hash值'}
            ,{field: 'previousHash', title: '区块父hash值'} 
            ,{field: 'dataHash', title: '区块data_hash值'}
            ,{field:'', title: '操作',toolbar:"#barDemo",fixed: 'right', width: 120}
        ]]
        ,id: 'table'
    });
  //监听工具条
    table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
        var data = obj.data //获得当前行数据
        ,layEvent = obj.event; //获得 lay-event 对应的值
        if(layEvent === 'detail'){
        	window.location.href='queryBlockByNumber.do?number='+data.number;
        } 
    });
    $("#search").on("click",function(){
        var searchContent= $("#user").val();
        table.reload('table', {
            page: {
                curr: 1 //重新从第 1 页开始
            }
            ,where: {
                searchContent:searchContent,
            }         
        })

    })
})
</script> 
</body>
</html>
