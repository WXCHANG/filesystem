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
<style>
	.buttons{
		padding: 5px;
	}
	.buttons button{
		height: 30px;
		line-height: 30px;
	}
</style>
<body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">待存任务列表</div>
            <div class="buttons">
			   	<button class="layui-btn" id="start">启动批量写入</button>
				<button class="layui-btn layui-btn-danger" id="stop">关闭批量写入</button>
	   		</div>
        </div>
    </div>
    <div class="text-body">
        <table id="summary" class="layui-table layui-fluid" lay-size="sm" lay-filter="test"></table>   
    </div>
<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script>
layui.config({
    base: '/base/layui/modules/'
}).use(['element','form','layer','laypage','table'], function() {
    var table = layui.table;

    console.log($("#indexTpl"))
    // table实例化
    table.render({
        elem: '#summary'
        ,height: 540
        ,url: 'getNoBlockOrigins.do' //数据接口
        //,data: data
        ,page: true //开启分页
        ,cols: [[ //表头
//             {type:'checkbox', fixed: 'left'}
            // ,{title: '序号', templet: '#indexTpl', width: 60, fixed: 'left'}
            {field: 'id', title: 'ID',  sort: true,  width: 80, fixed: 'left'}
            ,{field: 'name', title: '广告主题',}
            ,{field: 'area', title: '广告类型' }
            ,{field: 'identifier', title: '广告时长'} 
            ,{field: 'quality', title: '广告位置'}
            ,{field: 'storagetime', title: '录入时间'}
//             ,{field: 'examine', title: '产品审核', width: 150}
            ,{field: 'hash', title: '数据Hash值（系统自动生成）'}
        ]]
    });
    $("#start").click(function () {
    	$.ajax({
    	        url:"startProcessData.do",
    	        type:"POST",
    	        dataType:"json",
    	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
    	        success:function(data){
    	        	if(data.code==1){
    	        		tableInfo.reload({
	           		        url: 'getNoBlockOrigins.do',
	           		    })
    	        	}else{
    	        		alert("批量操作失败");
    	        	}
    	        }
    		})
	    });
    $("#stop").click(function () {
    	$.ajax({
    	        url:"stopProcessData.do",
    	        type:"POST",
    	        dataType:"json",
    	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
    	        success:function(data){
    	        	if(data.code==1){
    	        		tableInfo.reload({
	           		        url: 'getNoBlockOrigins.do',
	           		    })
    	        	}else{
    	        		alert("批量操作失败");
    	        	}
    	        }
    		})
	    });
});



/* var data = tableContent; */
</script> 
</body>
</html>
