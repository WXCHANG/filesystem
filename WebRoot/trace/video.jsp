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
	<title>产品视频展示</title>
	
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/videos.css">
	<script>
	
		$(function(){
			var userId=<%=session.getAttribute("userId")%>; 
	   		if(userId==null){
	   			alert("用户登录超时，请重新登录")
	   			window.parent.location.href='../userLogin.jsp';
	   			return;
	   		} 
			var serverPath = "<%=servicePath%>";
			getInfo(serverPath);	
			toPage(serverPath);
		    //获取并存储当前视频的id和路径
		    $('a').on('click',function(){
		        id=$(this).children('video').attr('id');
		        src=$(this).children('video').attr('src');
		        localStorage.setItem('id',id);
		        localStorage.setItem('src',src);
		       
		    }) 
	    })
	</script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/homeVideoPage.js"></script>
	<style>
	html,body{
		background-color: #FFF;
		height: 100%;
		display: flex;
		flex-flow: column;
		justify-content: flex-start;
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
		width: 90%;
		min-width: 1000px;
		padding: 0 10%;
		/*float: left;*/
		margin: 0 auto;
		height: 98%;
		overflow-y: auto;
	}
	.push{
		height: 60px;
       	width: 80%;
     	text-align: center;
  	    position: absolute;
    	bottom: 0;
	}
	</style>
</head>

<body>
    <!-- <div id="header" >
        <p>视频列表</p>
        
   </div> -->
   <div class="imageDiv">
	   	<div class="inner">
	   		<ul></ul>
	   	<div>
   </div>
    
    <div id="page"  class="push">
	</div>
     <!-- 隐藏当前页和条数，初始值为1,10 -->
    <input type="hidden" id="currPage" value="1">
    <input type="hidden" id="limit" value="10">
	<script>
		var contentHeight = document.body.clientHeight-20;
		$(".imageDiv").css("height", contentHeight)
	</script>
	
</body>

</html>