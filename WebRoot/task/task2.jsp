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
    body{
        height: 500px;
    }
    table{
        min-width: 1100px;
    }
    tr,th{
        text-align: center !important;
    }
    td:first-child{
        background: #f2f2f2;
    }
    .layui-elem-quote h1{
        font-size: 14px;
        margin: 0;
    }
    .form-box{
        width: 100%;
        height: 100%;
        display: flex;
        display: -webkit-box; 
        display: -moz-box;  
        display: -ms-flexbox; 
        display: -webkit-flex; 
        flex-direction: column;
        justify-content: center;
        align-items: center;
    } 
    #edit-userForm{
        width: 500px;
        padding: 50px 30px 30px 30px;
        border: 2px dotted #aaa;
        border-radius: 10px;
    }
    .form_btnGroup{
        display: flex;
        flex-flow: row nowrap;
        justify-content: flex-end;
        align-items: center;
    }
    </style>
  </head>
  
  <body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">连通性测试</div>
        </div>
    </div>
    <div class="form-box">
        <form action="/openPlatform/manager/updateManager1.do" id="edit-userForm" class="bv-form  form-horizontal" method="post">
            <div class="form-group has-feedback">
                <label for="userName" class="layui-form-label col-sm-3">IP地址</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="IPAddress" name="IPAddress" placeholder="请输入IP地址">
                </div>
            </div>
            <div class="form-group has-feedback">
                <label for="userName" class="layui-form-label col-sm-3">用户名</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="userName" name="userName" placeholder="请输入用户名">
                </div>
            </div>
            <div class="form-group has-feedback">
                <label for="userName" class="layui-form-label col-sm-3">密&nbsp;&nbsp;&nbsp;码</label>
                <div class="col-sm-8">
                    <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-3" for=""></label>
                <div class="col-sm-8 form_btnGroup">
                    <button type="reset" class="btn btn-default" id="resetBtn" style="margin-right: 30px;" data-dismiss="modal">重置</button>
                    <button id="editBtn" type="submit" class="btn btn-primary">测试</button>
                </div>
            </div>
        </form>
    </div>
    <div id="loading">
        <div id="AjaxLoading" class="showbox in">
            <div class="loadingWord"><img src="images/waiting.gif">请稍候...</div>
        </div>
    </div>
</body>
<script type="text/javascript" >
$("#loading").hide();
$(document).ajaxStart(function(){
    $("#loading").show();
　　})

　　$(document).ajaxComplete(function(){
　　$("#loading").hide()
})
layui.config({
    base: 'base/'
}).use(['element','form','layer'], function() {
	var form = layui.form;
    $('#edit-userForm').bootstrapValidator({
        message: '输入值不合法',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	IPAddress: {
                message: 'IP地址不合法',
                validators: {
                    notEmpty: {
                        message: 'IP地址不能为空'
                    },
                    regexp: {
                        regexp: /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/,
                        message: 'IP地址格式不匹配'
                    }
                }
            }
	        ,userName: {
	            message: '用户名不合法',
	            validators: {
	                notEmpty: {
	                    message: '用户名不能为空'
	                }
	            }
	        }
            ,password: {
                message: '密码不合法',
                validators: {
                    notEmpty: {
                        message: '密码不能为空'
                    }
                }
            }
            /* ,password2: {
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
            } */
        }
    });
    $('#edit-userForm').data('bootstrapValidator').resetForm();

    
    $('#editBtn').on("click",function () {
        var bv = $("#edit-userForm").data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
            $.ajax({
            	 url: "connectivityTest.do", 
                async: false,   //同步，阻塞操作
                type: 'post',   //PUT DELETE POST
                data: {
                	userName: $("#userName").val(),
                	password: $("#password").val(),
                	IPAddress: $("#IPAddress").val()
                },
                timeout: 10000,
                complete: function (XMLHttpRequest,status) {
                    if(status == 'timeout') {
                        xhr.abort();    // 超时后中断请求
                        $.alert("网络超时，请刷新", function () {
                            location.reload();
                        })
                    }
                },
                success: function (data) {
                    if ( data.code==1 ) {   // 成功
                    	alert("连通性测试成功");
                    	$('#resetBtn').click();
                    	/* setTimeout(function(){
                    	},3500); */
                    } else if( data.code==0 ){
                        layer.msg("用户名或密码错误");
                    }else{
                    	 layer.msg("连通性测试失败");
                    }
                }, 
                error: function () {
                    layer.msg("请求失败！请检查您的网络环境！")
                }
            })
            
        }
    })
})
</script>
</html>
