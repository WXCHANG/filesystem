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
    .layui-form-item {
        margin-bottom: 0;
    }
    #user{
        border-radius: 20px;
        text-indent: 25px;
        height: 32px;
        margin: 5px 0;
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
            <div class="ant-card-head-title">信息区块查询</div>
            <div>
                <div class="layui-inline layui-form-item">
                    <div class="layui-input-inline" style="width: 320px;">
                        <i class="layui-icon search">&#xe615;</i>
                        <input id="user" type="text" class="layui-input" name="" layui-filter=""; placeholder="请输入交易ID或数据Hash">
                    </div>
                </div>
                <div class="layui-inline layui-form-item">
                    <button id="search" class="layui-btn" lay-filter="search" data-type="reload">查询</button>
                </div>
            </div>
        </div>
    </div>
    <div class="text-body">
        <table id="summary" class="layui-table layui-fluid scroll" lay-size="sm" lay-filter="test"></table>   
    </div>

<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/javascript">
</script>
<script>
layui.use('table', function(){
    var table = layui.table;

    // table实例化
    table.render({
        elem: '#summary'
        ,height: 'full-100'
        ,url: 'getBlockOrigins.do' //数据接口
        //,data: data
        ,page: true //开启分页
        ,cols: [[ //表头
                  {title: '序号', templet: '#indexTpl', width: 60, type: 'numbers'}
                  // {field: 'id', title: 'ID', width:80, sort: true,}
                  ,{field: 'name', title: '业务字段1'}
                  ,{field: 'area', title: '业务字段2'}
                  ,{field: 'identifier', title: '业务字段3'}
                  ,{field: 'hash', title: '数据Hash'} 
                  ,{field: 'txId', title: '交易ID'}
                  
              ]]
        ,id: 'testReload'
    });

	$("#search").on("click",function(){
		var searchContent= $("#user").val();
		window.location.href='queryByTxIDOrHash.do?searchContent='+searchContent;
// 		table.reload('testReload', {
//             page: {
//                 curr: 1 //重新从第 1 页开始
//             }
//             ,where: {
//                 searchContent:searchContent,
//             }         
//         })

	})
    
});

</script> 
</body>
</html>
