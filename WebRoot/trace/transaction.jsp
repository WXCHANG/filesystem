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
	<title>版权链图片展示</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/homePage.js"></script>
   
<style>
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
	
	img{
	    width: 150px;
	    height: 150px;
	    /* border: 1px solid black; */
	}
	img:HOVER{
		 border: 1px solid #ddd;
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
	.img{
		width: 16%;
		height: 140px;
		display: inline-block;
		margin: 30px 3px;
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
		padding: 0 6%;
		/* float: left; */
		margin: 0 auto;
		height: 100%;
		overflow-y: auto;
	}
	
	
</style>
</head>
<body>
	<script>

		$(function(){
			var userId=<%=session.getAttribute("userId")%>; 
	   		if(userId==null){
	   			alert("用户登录超时，请重新登录")
	   			window.parent.location.href='../userLogin.jsp';
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
	    <input type="hidden" id="limit" value="20">
  
	<script>
		var contentHeight = document.body.clientHeight-20;
		$(".imageDiv").css("height", contentHeight)
	</script>
	
	
</body>
</html>