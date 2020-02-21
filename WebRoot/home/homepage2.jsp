<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String servicePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>功能导航</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/homePage.js"></script>
    <!--[if lt IE9]> 
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<style>
/* body{
	background-color: #FFF;
	display: flex;
	flex-flow: column;
	justify-content: center;
	/*align-items: center;*/
} */

	.box{
		font-size: 14px;
		width: 100%;
		height: 100%;
		min-height: 485px;
		padding: 10px 10px;
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	.box ul{
		width: 750px;
		height: 410px;
	}
	.box li{
		display: inline-block;
		width: 225px;
		/*height: 50px;*/
		margin: 20px 10px;
	}
	.box li a{
		text-decoration: none;
		color: #000;
	}
	.box li img{
		width: 50px;
		height: 50px;
		display: block;
		margin: 0 auto;
		vertical-align: middle;
	}
	.box li .tbody{
		display: block;
		width: 160px;
		margin-left: 10px;
		vertical-align: middle;
		margin: 0 auto;
	}
	.box li .tbody h4{
		width: 165px;
		/*text-indent: 10px;*/
		line-height: 25px;
		font-size: 14px;
		text-align: center;
		
	}
	.box li .tbody p{
		width: 150px;
		text-indent: 24px;
		word-break: break-word;
		color: #bbb;
	}
	img{
	    width: 150px;
	    height: 150px;
	    border: 1px solid black;
	}
	.photo {
	    margin-left: 25px;
	    margin-top: 25px;
	/*     border: 1px solid black; */
	}
	.title {
	    width: 200px;
	    font-size: 13px;
	    height: 30px;
	    line-height: 30px;
	    border: 1px solid #D4D4D4;
	    padding-left: 18px;
	}
	.layui-col-md3{
		padding-top: 1px;
	}
	.layui-container{
		width: 1000px;
		padding-left: 50px;
	}
	
	html,body{
		background-color: #FFF;
		height: 100%;
		display: flex;
		flex-flow: column;
		justify-content: flex-start;
	}
	.push{
		height: 60px;
       	width: 100%;
     	text-align: center;
  	    position: absolute;
    	bottom: 0;
	}
	.imageDiv{
		width:100%;
		margin: 10px auto;
		flex: 1 0 auto;
		padding-bottom: 50px;
		box-sizing: border-box;
		overflow: hidden;
	}
	.inner{
		width: 100%;
		min-width: 1000px;
		padding: 0 15%;
		/*float: left;*/
		margin: 0 auto;
		height: 100%;
		overflow-y: auto;
	}
	.img{
		width: 25%;
		height: 140px;
		display: inline-block;
		margin: 10px 0;
	}
	
	
</style>
</head>
<body>
	<script>

		$(function(){
			var userId=<%=session.getAttribute("userId")%>; 
	   		if(userId==null){
	   			alert("用户登录超时，请重新登录")
	   			window.parent.location.href='userLogin.jsp';
	   		} 
			var serverPath = "<%=servicePath%>";
			getImageInfo(serverPath);	
			toPage(serverPath);
	    })
	
	</script>
	    <div class="imageDiv" id="">
	    	<div class="inner" id="imageDiv"></div>
        </div>
        <div id="page"  class="push"></div>
	     <!-- 隐藏当前页和条数，初始值为1,10 -->
	    <input type="hidden" id="currPage" value="1">
	    <input type="hidden" id="limit" value="10">
  
	<!-- 	<script>
		$(document).ready(function(){
			
			
			
			
			layui.config({
			    base: '/base/layui/modules/'
			}).use(['element','form','layer','laypage','table'], function() {
		  		var element = layui.element;
		        var table = layui.table;
		        var layer = layui.layer;
		        var laypage = layui.laypage;

		      
				//分页
				laypage.render({



					elem: 'imagePage' 	//分页容器的id
					,layout: ['prev', 'page', 'next','limits','count'] 	//排版
					,limit: 10 		//每页显示数 
					,limits: [10, 20, 30, 40, 50] 	//条数选择项
					/*,curr: location.hash.replace('#!fenye=', '') //获取起始页
		  			,hash: '1' //自定义hash值*/
					,groups: 3 		//连续出现的页数
					,count: 20 	//总条数
					,theme: '#1E9FFF' 	//自定义选中色值
					,skip: true 	//开启跳页
					,jump: function(obj, first){
					  	// if(!first){
					   //  	layer.msg('第'+ obj.curr +'页');
					  	// }
					}
				});
			});
			
		});
		
		</script> -->
	

	
	
	
	<script>
		var contentHeight = document.body.clientHeight-20;
		$(".imageDiv").css("height", contentHeight)
	</script>
	
	
</body>
</html>