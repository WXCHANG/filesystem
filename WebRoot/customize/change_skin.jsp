<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta charset="UTF-8">
		<title>é¡µé¢æ¢è¤</title>
		<meta name="description" content="" />
		<script type="text/javascript" src="../base/jquery-3.2.1.min.js" ></script>
		<script type="text/javascript" src="../jquery-cookie/jquery.cookie.js" ></script>
	    <link rel="stylesheet" type="text/css" href="../iconfont/iconfont.css"/>
	    <link rel="stylesheet" type="text/css" href="../css/skin_0.css" id="cssfile"/>
		<style>
			#skin{
				list-style: none;
				border: 1px solid #A9A9A9;
				padding: 0px;
			}
			li{
				position: relative;
				display: inline-block;
				border: 1px solid;
				width: 15px;
				height: 15px;
				margin: 5px 3px;
				margin-top:8px;
			}
			#skin_0{
				border-color: darkgrey;
				background-color: darkgrey;
			}
			#skin_1{
				border-color: mediumpurple;
				background-color: mediumpurple;
			}
			#skin_2{
				border-color: red;
				background-color: red;
			}
			#skin_3{
				border-color: skyblue;
				background-color: skyblue;
			}
			#skin_4{
				border-color: darkorange;
				background-color: darkorange;
			}
			#skin_5{
				border-color: lawngreen;
				background-color: lawngreen;
			}
			.selected{
				top:-7px;
			}
			#div_side_0,#div_side_1{
				margin: 10px 20px;
				width:550px;
				height:60px;
				line-height: 24px;
				color: #FFFFFF;
				text-align: center;
				font-weight: bold;
			}
		</style>
		<script>
		    function swithSkin(skinName){
		    	$("#"+skinName).addClass("icon iconfont icon-gou-copy selected")
				.siblings().removeClass("icon iconfont icon-gou-copy selected");
				$("#cssfile").attr("href","../css/"+skinName+".css");
				$.cookie("MyCssSkin",skinName,{paht:'/',expires:30});
		    }
			$(function(){
				var cookie_skin=$.cookie("MyCssSkin");
				if(cookie_skin){
					swithSkin(cookie_skin);
				}
				var li = $("#skin li");
				li.click(function(){
					swithSkin(this.id)
				})
				
				
			})
		</script>
	</head>
	<body>
		<fieldset style="width:600px;margin: 30px auto;">
			<legend>页面换肤</legend>
			<ul id="skin">
				<li id="skin_0" title="灰色" class="icon iconfont icon-gou-copy selected"></li>
				<li id="skin_1" title="紫色"></li>
				<li id="skin_2" title="红色"></li>
				<li id="skin_3" title="天蓝色"></li>
				<li id="skin_4" title="橙色"></li>
				<li id="skin_5" title="淡绿色"></li>
			</ul>
			<div id="div_side_0">
				页面换肤
			</div>
			<div id="div_side_1">
				页面换肤
			</div>
		</fieldset>
	</body>
</html>