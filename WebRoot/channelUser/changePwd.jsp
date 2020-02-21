<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">    
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
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
        <style>
       .form-box {
		width: 100%;
		height: 85%;
		display: flex;
		display: -webkit-box; /* OLD - iOS 6-, Safari 3.1-6 */
		display: -moz-box; /* OLD - Firefox 19- (buggy but mostly works) */
		display: -ms-flexbox; /* TWEENER - IE 10 */
		display: -webkit-flex; /* NEW - Chrome */
		flex-direction: column;
		 justify-content: center; 
		align-items: center;
	}


	#edit-userForm {
		width: 740px;
	}
	.layui-form-item{
		padding-top: 20px;
	}
	.form_btnGroup{
	    display: flex;
	    flex-flow: row nowrap;
	    justify-content: flex-end;
	    align-items: center;
	}
	#edit-userForm{
	    padding: 30px 30px 30px 30px;
	    border: 2px dotted #aaa;
	    border-radius: 10px;
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
            <div class="ant-card-head-title">修改用户信息</div>
        </div>
    </div>
    <div class="form-box">
        <form action="/openPlatform/manager/updateManager1.do" id="edit-userForm" class="bv-form  form-horizontal" method="post">
            <div class="form-group has-feedback">
                <label for="userName" class="layui-form-label col-sm-3">用户名称</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="userName" name="username" value="${channelUser.username}"  readonly="true">
                </div>
            </div>
            <div class="form-group has-feedback">
                <label for="userName" class="layui-form-label col-sm-3">公司名称</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="company" name="company" value="${channelUser.company}">
                </div>
            </div>
            <div class="form-group has-feedback">
                <label for="pwd" class="layui-form-label col-sm-3">新&nbsp;&nbsp;密&nbsp;&nbsp;码</label>
                <div class="col-sm-8">
                    <input type="password" class="form-control" id="pwd" name="password" placeholder="请输入新密码">
                </div>
            </div>
            <div class="form-group has-feedback">
                <label for="permission" class="layui-form-label col-sm-3">确认密码</label>
                <div class="col-sm-8">
                    <input type="password" class="form-control" id="pwd2" name="password2" placeholder="请输入新密码">
                </div>
            </div>
            <div class="form-group has-feedback">
                <label for="userName" class="layui-form-label col-sm-3">邮箱地址</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="email" name="email" value="${channelUser.email}">
                </div>
            </div>
            <div class="form-group">
				<label for="" class="layui-form-label col-sm-3">验&nbsp;&nbsp;证&nbsp;&nbsp;码</label>
				<div class="col-sm-8">
					<input type="text" class="form-control col-xs-8" id="validate1" name="validateCode"
						placeholder="请输入验证码" style="width: 250px;">
					<button class="btn btn-default col-xs-3 col-sm-offset-9"
						id="btnSendCode" style="margin-top: -35px;height:35px;"
						onclick="sendMsg()">发送验证码</button>
				</div>
			</div>
            <div class="form-group btn_div">
                <label class="control-label col-sm-3" for=""></label>
                <div class="col-sm-8 form_btnGroup">
                    <button type="reset" class="btn btn-default" style="margin-right: 30px;" data-dismiss="modal">重置</button>
                    <button id="editBtn" type="button" class="btn btn-primary">提交</button>
                </div>
            </div>
        </form>
    </div>
    <!-- <div id="loading">
        <div id="AjaxLoading" class="showbox in">
            <div class="loadingWord"><img src="images/waiting.gif">请稍候...</div>
        </div>
    </div> -->
</body>
<script type="text/javascript" >
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
/* $("#loading").hide();
$(document).ajaxStart(function(){
    $("#loading").show();
　　})

　　$(document).ajaxComplete(function(){
　　$("#loading").hide()
}) */
layui.config({
    base: 'base/'
}).use(['element','form','layer'], function() {

    $('#edit-userForm').bootstrapValidator({
        message: '输入值不合法',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            company: {
                message: '公司名称不合法',
                validators: {
                    notEmpty: {
                        message: '公司名称不能为空'
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
                    /*regexp: {
                        regexp: /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,10}$/,
                        message: '密码必须且只含有数字和字母。 '
                    }*/
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
            },
            email: {
                message: '邮箱地址不合法',
                validators: {
                    notEmpty: {
                        message: '邮箱地址不能为空'
                    },
                }
            }
        }
    });
    $('#edit-userForm').data('bootstrapValidator').resetForm();

    
    $('#editBtn').unbind("click").on("click",function () {
  		var bv = $("#edit-userForm").data('bootstrapValidator');
    	if($("#validate1").val()==""){
  		  layer.msg("验证码不能为空");
  		  return;
  	  	}
     	if(code==$("#validate1").val()){
     	        bv.validate();
     	        if (bv.isValid()) {
     	            $.ajax({
     	            	 url: "userUpdateChannelUser.do", 
     	                async: false,   //同步，阻塞操作
     	                type: 'post',   //PUT DELETE POST
     	                data: {
     	                	username: $("#userName").val(),
     	                	password: $("#pwd").val(),
     	                	company: $("#company").val(),
     	                	email: $("#email").val(),
     	                	type:"1"
     	                },
     	                complete: function (msg) {
     	                },
     	                success: function (data) {
     	                    if ( data.code==1 ) {   // 成功
     	                        alert("密码修改成功，请重新登录");
     	                        var _parent = window.parent;
     	                        _parent.location.href = '${pageContext.request.contextPath}/userLoginOut.do';
     	                    } else {
     	                        layer.msg(data.msg)
     	                    }
     	                }, 
     	                error: function () {
     	                    layer.msg("请求失败！请检查您的网络环境！")
     	                }
     	            })
     	            
     	        }
     	}else{
  		  alert("验证码错误，请重新输入验证码");
  	  }
      
    })
})
</script>
</html>
