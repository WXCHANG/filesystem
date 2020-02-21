<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/base/layui/css/layui.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/table.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
<!--[if lt IE9]> 
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<style>
#summary {
	width: 300px;
	margin: 0 auto;
}

tr, th {
	text-align: center !important;
}
</style>
</head>

<body>
	<div class="ant-card-head">
		<div class="ant-card-head-wrapper">
			<div class="ant-card-head-title">管理员管理</div>
		</div>
	</div>
	<div class="text-body">
		<br />
		<button id="pop-btn" data-method="offset" data-type="auto"
			class="layui-btn layui-btn-normal" onclick="window.location.href='${pageContext.request.contextPath}/system/addAdmin.jsp'">添加管理员</button>
		<table id="summary" class="layui-table layui-fluid scroll"
			lay-size="sm" lay-filter="test"></table>
	</div>
	<script type="text/html" id="btn-group">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="stop">停用</a>
	<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="start">启用</a>
</script>
	<script>
	layui.config({
	    base: '/base/layui/modules/'
	}).use(['element','form','layer','laypage','table'], function() {
	    var table = layui.table;
			// table实例化
		var tableInfo = table.render({
				elem : '#summary',
				height : 460,
				url : 'queryAdmins.do',
				//data : data,
				page : true, //开启分页
				cols : [ [ //表头
					{
						field : 'name',
						title : '管理员名称',
					}
					,{
						field : 'password',
						title : '管理员密码',
					}
					, {
						field : 'status',
						title : '状态',
					}
					, {
						field : 'description',
						title : '描述',
					}
					, {
						field : 'token',
						title : '管理员密钥',
					}
					, {
						field : '',
						title : '操作',
						toolbar : '#btn-group'
					}
				] ]
			,done: function(res, curr, count){
	            //分类显示中文名称  
	            $("[data-field='status']").children().each(function(){  

	                if($(this).text()=='0'){  
	                   $(this).text("已停用").css("color", "red") 
	                }else if($(this).text()=='1'){  
	                   $(this).text("已启用").css("color", "green")  
	                } 
	            }) 
	        }
			});
			
			 //监听工具条
		    table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		        var data = obj.data //获得当前行数据
		        ,layEvent = obj.event; //获得 lay-event 对应的值
		        if(layEvent === 'del'){
		            layer.confirm('确定要删除吗？', function(index){
		            obj.del(); //删除对应行（tr）的DOM结构
		            layer.close(index);
		            //向服务端发送删除指令
		            $.ajax({
		       	        url:"deleteAdmin.do",
		       	        type:"POST",
		       	        dataType:"json",
		       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
		       	        data:{
		       	        	id:data.id,
		       	        },
		       	        success:function(data){
		       	        	if(data.code==1){
		       	        		tableInfo.reload({
	       	           		        url: 'queryAdmins.do',
	       	           		        where: {}, //设定异步数据接口的额外参数
	       	           		        
	       	           		    })
		       	        	}else{
		       	        		alert("用户删除失败");
		       	        	}
		       	        }
		   	    });
		            });
		        } else if(layEvent === 'stop'){
		        	layer.confirm('确定要停用吗？', function(index){
			            layer.close(index);
			            //向服务端发送删除指令
			            $.ajax({
			       	        url:"stopAdmin.do",
			       	        type:"POST",
			       	        dataType:"json",
			       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			       	        data:{
			       	        	id:data.id,
			       	        },
			       	        success:function(data){
			       	        	if(data.code==1){
			       	        		tableInfo.reload({
		       	           		        url: 'queryAdmins.do',
		       	           		        where: {}, //设定异步数据接口的额外参数
		       	           		        
		       	           		    })
			       	        	}else{
			       	        		alert("用户停用失败");
			       	        	}
			       	        }
			   	    });
			            });
		        }else if(layEvent === 'start'){
		        	layer.confirm('确定要启用吗？', function(index){
			            layer.close(index);
			            //向服务端发送删除指令
			            $.ajax({
			       	        url:"startAdmin.do",
			       	        type:"POST",
			       	        dataType:"json",
			       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			       	        data:{
			       	        	id:data.id,
			       	        },
			       	        success:function(data){
			       	        	if(data.code==1){
			       	        		tableInfo.reload({
		       	           		        url: 'queryAdmins.do',
		       	           		        where: {}, //设定异步数据接口的额外参数
		       	           		        
		       	           		    })
			       	        	}else{
			       	        		alert("用户启用失败");
			       	        	}
			       	        }
			   	    });
			            });
		        }
		    });
		});
	
		
	
	/* 
		layui.use('layer', function() { //独立版的layer无需执行这一句
			var $ = layui.jquery,
				layer = layui.layer; //独立版的layer无需执行这一句
	
			//触发事件
			var active = {
				offset : function(othis) {
					var type = othis.data('type'),
						text = '<form class="layui-form" action="" lay-filter="example">'+
							 	 '<div class="layui-form-item">'+
					    			'<label class="layui-form-label">用户名</label>'+
					    			'<div class="layui-input-block">'+
					      				'<input type="text" name="username" lay-verify="title" autocomplete="off" placeholder="请输入用户名" class="layui-input">'+
					    			'</div>'+
					  			 '</div>'+
					  			'<div class="layui-form-item">'+
					    			'<label class="layui-form-label">描述</label>'+
					    			'<div class="layui-input-block">'+
					      				'<input type="text" name="description" lay-verify="title" autocomplete="off" placeholder="请输入描述" class="layui-input">'+
					    			'</div>'+
					  			 '</div>'+
					  			'</form>';
	
					layer.open({
						area: ['500px', '260px'],
						title:'添加用户',
						type : 1,
						offset : type, //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
						id : 'layerDemo' + type, //防止重复弹出
						content : '<div style="padding: 20px 100px;">' + text + '</div>',
						btn : '提  交',
						btnAlign : 'c', //按钮居中
						shade : 0.05, //不显示遮罩
						yes : function() {
							alert(11111)
						}
					});
				}
			};
	
			$('#pop-btn').on('click', function() {
				var othis = $(this),
					method = othis.data('method');
				active[method] ? active[method].call(this, othis) : '';
			});
	
		}); */
	</script>
</body>
</html>
