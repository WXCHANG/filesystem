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
		width: 700px;
	}
	.layui-form-item{
		padding-top: 10px;
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
  </head>
  
  <body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">修改用户信息</div>
        </div>
    </div>
    <div class="form-box">
        <form id="edit-userForm" class="bv-form  form-horizontal" method="post">
        	<input type="hidden" name="id" value="${admin.id }" id="adminId"/>
            <div class="layui-form-item form-group has-feedback">
                <label for="userName" class="layui-form-label col-sm-3">用户名称</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="name" name="name" value="${admin.name}" readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item form-group has-feedback">
                <label for="pwd" class="layui-form-label col-sm-3">新&nbsp;&nbsp;密&nbsp;&nbsp;码</label>
                <div class="col-sm-8">
                    <input type="password" class="form-control" id="pwd" name="password" placeholder="请输入新密码">
                </div>
            </div>
            <div class="layui-form-item form-group has-feedback">
                <label for="permission" class="layui-form-label col-sm-3">确认新密码</label>
                <div class="col-sm-8">
                    <input type="password" class="form-control" id="pwd2" name="password2" placeholder="请输入新密码">
                </div>
            </div>
             <div class="layui-form-item form-group has-feedback">
                <label for="userName" class="layui-form-label col-sm-3">用户描述</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="description" name="description" value="${admin.description}">
                </div>
            </div>
            <div class="layui-form-item form-group">
                <label class="control-label col-sm-3" for=""></label>
                <div class="col-sm-8 form_btnGroup">
                    <button type="reset" class="btn btn-default" style="margin-right: 30px;" data-dismiss="modal">重置</button>
                    <button id="editBtn" type="button" class="btn btn-primary">提交</button>
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

    $('#edit-userForm').bootstrapValidator({
        message: '输入值不合法',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            /*username: {
                message: '名不合法',
                validators: {
                    notEmpty: {
                        message: '名不能为空'
                    },
                    regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '端类名只能由汉字,字母和数字组成。 '
                    }
                }
            }
            ,*/password: {
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
            }
        }
    });
    $('#edit-userForm').data('bootstrapValidator').resetForm();

    
    $('#editBtn').on("click",function () {
        var bv = $("#edit-userForm").data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
            $.ajax({
            	 url: "updateAdmin.do", 
                async: false,   //同步，阻塞操作
                type: 'post',   //PUT DELETE POST
                data: {
                	name: $("#name").val(),
                	password: $("#pwd").val(),
                	description: $("#description").val(),
                	id: $("#adminId").val()
                },
                complete: function (msg) {
                },
                success: function (data) {
                    if ( data.code==1 ) {   // 成功
                        alert("信息修改成功，请重新登录");
                        var _parent = window.parent;
                        _parent.location.href = '${pageContext.request.contextPath}/loginOut.do';
                    } else {
                        layer.msg("信息修改失败")
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
