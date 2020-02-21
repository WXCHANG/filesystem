<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>登录</title>
<link rel="stylesheet" href="base/layui/css/layui.css">
<link rel="stylesheet" href="base/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/usss.css">
<script type="text/javascript" src="base/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="base/layui/layui.js"></script>
<script type="text/javascript" src="js/usss.js"></script>
</head>
<style type="text/css">
.layui-form-item {
	padding: 5px 80px 0px 80px;
}

#loginBox .form-group {
	margin-bottom: 0;
}

#edit-userForm .layui-form-label::after {
	content: "*";
	color: red;
	margin-left: 2px;
}

#key {
	width: 60%;
}

.flexBox {
	display: flex;
	flex-flow: row nowrap;
	justify-content: space-between;
	align-items: center;
}

#errorC {
	position: absolute;
	bottom: -22px;
	left: 16px;
	color: red;
}

.content_header img {
	border-top: 1px solid #fff;
	border-left: 1px solid #fff;
	border-right: 1px solid #fff;
}

.content .form-control {
	font-size: 13px;
}
</style>
<body>

	<p class="clear box layui-main login"><form class="layui-form layui-form-pane1 form-horizontal col-lg-6"
		action="#" id="loginBox" method="post"
		style="float: none !important; margin: 0px auto;border-radius: 4px; padding-bottom: 5px; ">
		<c:if test="${requestScope.msg ne null }">
			    	<span id="resultMsg" style="display: none;">${requestScope.msg}</span>
			   </c:if>
            <div class="content" style="font-size: 13px;">
                <div class="content_header">
                    <img src="static/images/admin_logo.png">
                </div>
                <img src="static/images/blockChain.png"
				style="position: absolute;top: 0;bottom: 0;left: 15%;margin: auto;"> 
                <div class="layui-form-item form-group">
                  <label
					class="layui-form-label col-sm-3 col-sm-offset-1">用户名</label>
                  <div class="col-sm-8">
                    <input type="text" name="name"
						lay-verify="name|required" autocomplete="off" placeholder="请输入用户名"
						class="layui-input form-control">
                  </div>
                </div>
                <div class="layui-form-item form-group">
                  <label
					class="layui-form-label col-sm-3 col-sm-offset-1">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
                  <div class="col-sm-8">
                    <input type="password" name="password"
						lay-verify="password|required" placeholder="请输入密码"
						autocomplete="off" class="layui-input form-control">
                  </div>
                </div>
               <div class="layui-form-item form-group">
					<label class="layui-form-label col-sm-3 col-sm-offset-1">验证码</label>
					<div class="col-sm-8 flexBox">
						<input type="text" id="key" name="key" lay-verify="key|required"
						placeholder="请输入验证码" autocomplete="off"
						class="layui-input form-control" onBlur="textBlur(this)"
						onFocus=" textFocus(this) "> <span class="add phoKey"
						id="phoKey"></span> <span class="errorC error7" id="errorC"></span>
					</div>
				</div>         
                <div class="layui-form-item form-group" style="margin-top: 5px;">
                  <label class="control-label col-sm-3 col-sm-offset-1"></label>
                  <div class="form_btnGroup col-sm-8">
                    <button type="reset" class="layui-btn"
						lay-filter="demo1">重置</button>
                    <button type="button" id="loginBtn"
						class="layui-btn btn-first" lay-submit lay-filter="login">登录</button>
                  </div>                
                </div>
                <div class="container"
				style="display:table-cell;height:50px;vertical-align:middle;font-size:13px;font-height:14px;color: #aba4a4;text-align:center">
                  <span>版权所有©2018北京邮电大学</span>
                </div>
            </div>
        </form>

	</p>
	<script>
		$("body").keydown(keyDownLogon);
		layui.use([ 'layer', 'form' ], function() {
			var layer = layui.layer,
				$ = layui.jquery,
				form = layui.form;
			form.verify({
				resultMsg : function(value, item) {
					if (value == "用户名或密码错误") {
						return '用户名或密码错误';
					}
	
				},
				name : function(value, item) { //value：表单的值、item：表单的DOM对象
					if (value == "") {
						return '用户名不能为空';
					}
				},
				password : function(value, item) { //value：表单的值、item：表单的DOM对象
					if (value == "") {
						return '密码不能为空';
					}
				}
			});
	
			if ($.trim($("#resultMsg").text()).length > 0) {
				layer.msg($("#resultMsg").text())
			}
	
			form.on('submit(login)', function(data) {
				//console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
				var fields = data.field;
				//console.log(fields.name) //当前容器的全部表单字段，名值对形式：{name: value}
				$.ajax({
					type : "post",
					url : "login.do",
					data : {
						name : fields.name,
						password : fields.password,
						//level:fields.level
						level : "0"
					},
					success : function(data) {
						//0 没选择权限
						//1 用户名或密码错误
						//2 超级管理员成功跳转
						//3 组织管理员成功跳转
						//4 通道管理员成功跳转
						if (data.code == 0) {
							$("#resultMsg").text("请选择管理权限!");
							layer.msg($("#resultMsg").text())
						} else if (data.code == 1) {
							$("#resultMsg").text("用户名或密码错误!");
							layer.msg($("#resultMsg").text())
						} else if (data.code == 5) {
							$("#resultMsg").text("获取密钥失败!");
							layer.msg($("#resultMsg").text())
						} else if (data.code == 2) {
							window.location.href = 'index.jsp'
						} else if (data.code == 3) {
							window.location.href = 'groupindex.jsp'
						} else if (data.code == 4) {
							window.location.href = 'channelindex.jsp'
						}
					}
				});
	
			});
	
		});
		function keyDownLogon() {
			if (event.keyCode == "13") {
				$("#loginBtn").trigger('click');
			}
		}
	</script>
	</body>
</html>