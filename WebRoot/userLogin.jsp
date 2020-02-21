<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>登录</title>
<link rel="stylesheet" href="base/layui/css/layui.css">
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/index.css">
<script type="text/javascript" src="base/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="base/layui/layui.js"></script>

<link rel="stylesheet" href="base/layui/css/layui.css">
<link rel="stylesheet" href="base/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="css/table.css">
<link rel="stylesheet" href="css/usss.css">
<script type="text/javascript" src="base/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="base/layui/layui.js"></script>
<script type="text/javascript" src="base/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="base/bootstrap/js/bootstrapValidator.js"></script>

<script type="text/javascript" src="js/usss.js"></script>
</head>
<style type="text/css">
.layui-form-item {
	padding: 25px 80px 0px 80px;
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
 .content_header img{
    	border-top: 1px solid #fff;
	    border-left: 1px solid #fff;
	    border-right: 1px solid #fff;
    }
    
  .content .form-control {
  	font-size: 13px;
  }
</style>
<!-- <script>
$(function() { 
	var html = "";
	var html1 = "";
	 $.ajax({
         url: 'queryChannels.do',
         async: false,   //同步，阻塞操作
         type: 'post',   //PUT DELETE POST
         data: {},
         success: function (data) {
        	 $("#channelname").html('');
        	 $("#company").html('');
        	 jQuery.each(data.list, function(i,item){  
        		 //查询通道名称
        		 var channelname = item.channelname;
        		 var identifier = item.identifier;
        		 html +="<option value='"+identifier+"'>"+channelname+"</option>";
        		
        		 
              });
              jQuery.each(data.groups, function(i,item){  

        		 //查询公司名称
        		 var company = item.name;
        	
        		 html1 +="<option value='"+company+"'>"+company+"</option>";
        		 
              });
             $("#channelname").append(html);  
        	 $("#company").append(html1);  
         }
     });});
	 
</script> -->
<body>

	<p class="clear box layui-main login">
	<form id="loginBox"
		class="layui-form layui-form-pane1 form-horizontal col-lg-6"
		action="#" method="post"
		style="float: none !important; margin: 0px auto;border-radius: 4px; padding-bottom: 5px; ">
		<c:if test="${requestScope.msg ne null }">
			<span id="resultMsg" style="display: none;">${requestScope.msg}</span>
		</c:if>
		<div class="content" style="font-size: 13px;">
			<div class="content_header">
				<!-- <img src="static/images/logo.png"> -->
				<img src="static/images/login_title.png">
			</div>
			<div>
				<img src="./static/images/G9_logo.png"
					style="position: absolute;top: 20px;bottom: 0;left: 15%;margin: auto; height: 120px;">
				<div class="layui-form-item form-group">
					<label class="layui-form-label col-sm-3 col-sm-offset-1">用户名</label>
					<div class="col-sm-8">
						<input type="text" name="name" lay-verify="name|required"
							autocomplete="off" placeholder="请输入用户名"
							class="layui-input form-control">
					</div>
				</div>
				<div class="layui-form-item form-group">
					<label class="layui-form-label col-sm-3 col-sm-offset-1">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
					<div class="col-sm-8">
						<input type="password" name="password"
							lay-verify="password|required" placeholder="请输入密码"
							autocomplete="off" class="layui-input form-control">
					</div>
				</div>
				<!-- <div class="layui-form-item form-group">
					<label class="layui-form-label col-sm-3 col-sm-offset-1">验证码</label>
					<div class="col-sm-8 flexBox">
						<input type="text" id="key" name="key" lay-verify="key|required"
							placeholder="请输入验证码" autocomplete="off"
							class="layui-input form-control" onBlur="textBlur(this)"
							onFocus=" textFocus(this) "> <span class="add phoKey"
							id="phoKey"></span> <span class="errorC error7" id="errorC"></span>
					</div>
				</div> -->
				<div class="layui-form-item form-group" style="margin-top: 5px;">
					<label class="layui-form-label col-sm-3 col-sm-offset-1"></label>
					<div class="form_btnGroup col-sm-8">
						<button type="button"
							class="layui-btn layui-btn-xs layui-btn-normal"
							data-toggle="modal" data-target="#edit-user">注册</button>
						<button type="button" id="loginBtn" class="layui-btn btn-first"
							lay-submit lay-filter="login">登录</button>
					</div>
				</div>
			</div>
			<div class="container"
				style="display:table-cell;height:50px;font-size:13px;font-height:14px;vertical-align:middle;color: #aba4a4;text-align:center">
				<span>开发单位：北京邮电大学区块链实验室</span>
			</div>
		</div>
	</form>


	</p>
	<p>
		<!-- 注册用户 -->
	<div class="modal fade" id="edit-user" tabindex="-1" role="dialog"
		aria-labelledby="">
		<div class="modal-dialog" role="document"
			style="height: 520px;position: absolute;top: 0;right: 0;bottom: 0;left: 0;margin: auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="userInfo" style="text-align: center;">大通联盟区块链平台用户注册</h4>
				</div>
				<div class="modal-body">
					<form id="edit-userForm" class="bv-form form-horizontal">
						<div class="form-group has-feedback">
							<label for="username" class="layui-form-label col-sm-3 ">用户名称</label>
							<div class=" col-sm-8">
								<input type="text" class="form-control" id="username"
									name="username" placeholder="请输入用户名" />
							</div>
						</div>
						<div class="form-group has-feedback">
							<label for="password" class="layui-form-label col-sm-3">登录密码</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="password"
									name="password" placeholder="请输入密码" />
							</div>
						</div>
						<div class="form-group has-feedback">
							<label for="orgCode" class="layui-form-label col-sm-3">确认密码</label>
							<div class="col-sm-8">
								<input type="password" class="form-control layui-input"
									id="pwd2" name="password2" placeholder="请输入密码">
							</div>
						</div>
						<div class="form-group has-feedback">
							<label for="orgCode" class="layui-form-label col-sm-3">公司名称</label>
							<div class="col-sm-8">
								<input type="text" class="form-control layui-input" id="company"
									name="company" placeholder="请输入公司名称">
							</div>
						</div>
						<!--  <div class="form-group has-feedback">
                            <label for="type" class="layui-form-label col-sm-3">选择组织</label>
                            <div class="col-sm-8">
                              <select name="channelname" lay-verify="required" class="form-control"  placeholder="请选择组名" id="channelname"></select>
                            </div>
                        </div> -->
						<!--  <div class="form-group has-feedback">
                            <label for="type" class="layui-form-label col-sm-3">所属公司</label>
                            <div class="col-sm-8">
                              <select name="company" lay-verify="required" class="form-control"  placeholder="请选择公司" id="company"></select>
                            </div>
                           
                        </div> -->
						<!--  <div class="form-group has-feedback">
                            <label for="email">邮箱</label>
                            <input type="text" id="email" name="email" placeholder="请输入邮箱">
                            <button id="btnSendCode" type="button"  class="btn btn-primary" onclick="sendMessage()">发送验证码</button>
                           
                        </div>
                         <div class="form-group has-feedback">
                            <label for="aaa">验证码</label>
                            <input type="text" id="aaa" name="aaa" placeholder="请输入验证码">
                        </div> -->
						<div class="form-group has-feedback">
							<label class="layui-form-label col-sm-3" for="exampleInputEmail1">邮箱地址</label>
							<div class="col-sm-8">
								<input type="email" class="form-control" id="email" name="email"
									placeholder="请输入邮箱地址">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="layui-form-label col-sm-3">验&nbsp;&nbsp;证&nbsp;&nbsp;码</label>
							<div class="col-sm-8">
								<input type="text" class="form-control col-xs-8" id="validate1"
									placeholder="请输入验证码" style="width: 250px;">
								<button class="btn btn-default col-xs-3 col-sm-offset-9"
									id="btnSendCode" style="margin-top: -35px;height:35px;"
									onclick="sendMsg()">发送验证码</button>
							</div>
						</div>
						<input id="res" name="res" type="reset" style="display:none;" />
					</form>
				</div>
				<div class="modal-footer">
					<div class="col-sm-4 col-sm-offset-7" style="padding: 0">
						<button type="button" class="btn btn-default col-xs-5"
							data-dismiss="modal">取消</button>
						<button id="editBtn" type="button"
							class="btn btn-primary col-xs-5" style="float: right;">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	</p>
	<script>  
  $("body").keydown(keyDownLogon);      
  layui.use(['layer', 'form'], function() {
      var layer = layui.layer,
          $ = layui.jquery,
          form = layui.form;
      form.verify({
          resultMsg: function (value, item){
              if ( value == "用户名或密码错误" ) {
                  return '用户名或密码错误';
              }
              
          },
          name: function(value, item){ //value：表单的值、item：表单的DOM对象
              if( value == "" ){
                  return '用户名不能为空';
              }
          },
          password: function(value, item){ //value：表单的值、item：表单的DOM对象
              if( value == "" ){
                  return '密码不能为空';
              }
          },
          key: function(value, item){ //value：表单的值、item：表单的DOM对象
              if( value == "" ){
                  return '验证码不能为空';
              }else  if( value.toLowerCase() != $("#phoKey").text().toLowerCase()){
                  return '验证码不正确';
              }
          }
      });  
      
      if ( $.trim($("#resultMsg").text()).length > 0 ) {
          layer.msg($("#resultMsg").text())
      }

      form.on('submit(login)',function(data){   
          console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
          var fields = data.field;
          console.log(fields.name) //当前容器的全部表单字段，名值对形式：{name: value}
          $.ajax({
              type: "post",
              url: "login.do",
              data: {
              	name:fields.name,
              	password:fields.password,
              	level:2
              },
              success: function(data){
        //0 没选择权限
    		//1 用户名或密码错误
    		//2 超级管理员成功跳转
    		//3 组织管理员成功跳转
    		//4 通道管理员成功跳转
               	if(data.code == 0){
              		$("#resultMsg").text("请选择管理权限!");
               		layer.msg($("#resultMsg").text())
              	}else if(data.code == 1){
              		$("#resultMsg").text("用户名或密码错误!");
               		layer.msg($("#resultMsg").text())
              	}else if(data.code == 2){
              		window.location.href='index.jsp'
              	}else if(data.code == 3){
              	window.location.href='groupindex.jsp'
              	}else if(data.code == 4){
              	window.location.href='channelindex.jsp'
              	}
              }
             
          });
          
      });
      
      
      
      
     $('#edit-userForm').bootstrapValidator({
          message: '输入值不合法',
          feedbackIcons: {
              valid: 'glyphicon glyphicon-ok',
              invalid: 'glyphicon glyphicon-remove',
              validating: 'glyphicon glyphicon-refresh'
          },
          fields: {
              	username: {
                      message: '用户名不合法',
                      validators: {
                          notEmpty: {
                              message: '用户名不能为空'
                          },
                      
                      }
                  }
          ,email: {
              message: '邮箱不合法',
              validators: {
                  notEmpty: {
                      message: '邮箱不能为空'
                  },
                  regexp: {//正则验证
                      regexp:  /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/,
                      message: '邮箱格式不正确'
                  },
              
              }
          }
            ,password: {
                  message: '密码不合法',
                  validators: {
                      notEmpty: {
                          message: '密码不能为空'
                      },
                      stringLength: {
                          min: 6,
                          max: 12,
                          message: '密码长度6-12位。'
                      },
                    
                  }
              }
              ,password2: {
                  message: '两次输入的密码不相符',
                  validators: {
                      notEmpty: {
                          message: '密码不能为空'
                      },
                      identical: {
                          field: 'password',
                          message: '两次输入的密码不相符'
                      }
                  }
              }
          }
      });

     
      $("#editBtn").unbind("click").on("click", function () {
    	 
    	  if($("#validate1").val()==""){
    		  alert("验证码不能为空");
    		  return;
    	  }
    	  if(code==$("#validate1").val()){
    		  
    			var bv = $("#edit-userForm").data('bootstrapValidator');
                bv.validate();
    				if(bv.isValid()){
    					
    			         //  var form = $("#edit-userForm").serialize() + "&id=" + data.id;
    	                    $.ajax({
    	                        type: "post",  
    	                        url: "addChannelUser.do", 
    	                        dataType: "json", 
    	                        data: {
    	                        	username: $("#username").val(),
    	                        	password: $("#password").val(),
    	                        	channelname: $("#channelname option:selected").text(),
    	                        	channelidentifier:$("#channelname option:selected").val(),
    	                        	email: $("#email").val(),
    	                        	auditStatus: $("#auditStatus").val(),
    	                        	company: $("#company").val(),
    	                        	
    	                        },
    	                        success:function(data){
    			       	        	if(data.code==1){
    			       	        		/* tableInfo.reload({
    		       	           		        url: 'queryChannelUser.do',
    		       	           		        where: {}, //设定异步数据接口的额外参数
    		       	           		        
    		       	           		    }) */
    		       	           		    alert("用户注册成功，请登录");
    			       	        		window.location.href='userLogin.jsp'
    			       	        	}else if(data.code==2){
    			       	        		alert("此用户名已存在");
    			       	        	}else{
    			       	        		alert("注册失败");
    			       	        	}
    			       	        },
    	                        error: function () {
    	                            alert("注册失败，请检查网络后重试！");
    	                        },
    	                        complete: function () {
    	                            //$("#edit-user").modal("hide");
    	                        }
    	                    })
    				}
    	  }else{
    		  alert("验证码错误，请重新输入验证码");
    	  }
        
    

  });
 
  });

  function keyDownLogon() {
    if (event.keyCode == "13") {
        $("#loginBtn").trigger('click');
    }
  }
  </script>

	<script type="text/javascript">

	/*----获取邮箱验证码---------*/
	

	var IntervalValObj;//timer变量，控制时间
	var count = 60;//间隔函数，1秒执行
	var curCount;//当前剩余秒数
	var code = "";//验证码
	var codeLength=4;
  	function sendMsg(){
  		
  		curCount = count;
  		var email = $("#email").val();
  		var bv = $("#edit-userForm").data('bootstrapValidator');
        bv.validate();
	    if(bv.isValid()){
  		//产生验证码
  			for (var i = 0; i < codeLength; i++) {
  				code+=parseInt(Math.random()*9).toString();
  			}
  	  		//alert(code);
  			//设置button效果，开始计时
  			$("#btnSendCode").attr("disabled","true");
  			$("#btnSendCode").html(curCount+"秒后重发");
  			IntervalValObj=setInterval("SendRemainTime()", 1000);//启动计时器，1秒执行一次
  	  		$.ajax({
  				url:'sendEmail.do',
  				type:'post',
  				data:{
  					mail:email,
  					subject:"验证码",
  					text:code,
  				},
  				success:function(data){
  					if(data.flag=="error"){
  						$("#tipDiv").html("<font color='red'>发送验证码失败<font>");
  						window.clearInterval(IntervalValObj);
  						$("#btnSendCode").removeAttr("disabled");//启用按钮
  			  			$("#btnSendCode").html("获取验证码");
  					}else{
  						$("#code").val(data.code);
  						$("#tipDiv").html("");
  						
  					}
  				}
  			});
  		}
  		
  	}
  //timer处理函数
  	function SendRemainTime() {
  		if (curCount==0) {
  			window.clearInterval(IntervalValObj);//停止计时器
  			$("#btnSendCode").removeAttr("disabled");//启用按钮
  			$("#btnSendCode").html("获取验证码");
  			code="";//清除验证码。如果不清除，过时间后，输入收到的验证码依然有效
  		}else{
  			curCount--;
  			$("#btnSendCode").html(curCount +"秒后重发");
  		}
  	}
  
  	//通过用户选择的通道，来确定所属公司并赋值
  	$('#channelname').change(function(){
  		
  		 $.ajax({
  	         url: 'queryChannelByIdentifier.do',
  	         async: false,   //同步，阻塞操作
  	         type: 'post',   //PUT DELETE POST
  	         data: {
  	        	identifier :$('#channelname option:selected').val(),
  	         },
  	         success: function (data) {
  	        	
  	        	$("#company").val(data.channel.groupuser);
  	           /*   $("#channelname").append(html);  
  	        	 $("#company").append(html1);   */
  	         }
  		
  		});
  	});
  	            	/* 
  	            	$("#form #conferencePlace").val($('#editAnotherConferencePlace option:selected').text());
  	            	}); */
 
</script>

</body>
</html>