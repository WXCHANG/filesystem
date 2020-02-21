<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String date=df.format(new Date());
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

<style>

.form-box {
	width: 100%;
	height: 80%;
	margin-top:30px;
	display: flex;
	display: -webkit-box; /* OLD - iOS 6-, Safari 3.1-6 */
	display: -moz-box; /* OLD - Firefox 19- (buggy but mostly works) */
	display: -ms-flexbox; /* TWEENER - IE 10 */
	display: -webkit-flex; /* NEW - Chrome */
	flex-direction: column;
	/* justify-content: center; */
	align-items: center;
}


#info {
	width: 740px;
}
.layui-form-item{
	padding-top: 20px;
}
button{
	margin-top: 30px;
	margin-left: 50px;
}
</style>
</head>
<script type="text/javascript">
$(function() { 
	var html = "";
	 $.ajax({
         url: 'queryOrgs.do',
         async: false,   //同步，阻塞操作
         type: 'post',   //PUT DELETE POST
         data: {},
         success: function (data) {
        	 jQuery.each(data.list, function(i,item){  
        		 var orgName = item.name;
        		 html +="<option value='"+orgName+"'>"+orgName+"</option>";
              })
             $("#org").append(html);  
         }
     })
});
</script>
<body>
	<div class="ant-card-head">
		<div class="ant-card-head-wrapper">
			<div class="ant-card-head-title">添加域用户信息</div>
		</div>
	</div>
	<div class="form-box">
		<form action="addGroupUser.do" id="info"
			class="" method="post">
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for="">用户名称：</label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id="name"
						name="name" placeholder="请输入用户名称" value="">
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for="">用户密码：</label>
				<div class="col-sm-10">
					<input type="password" class="form-control layui-input" id="password"
						name="password" placeholder="请输入用户密码" value="">
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for="">确认密码：</label>
				<div class="col-sm-10">
					<input type="password" class="form-control layui-input" id="repassword"
						name="repassword" placeholder="请输入用户密码" value="" autocomplete="off" >
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for="">用户描述：</label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id="description"
						name="description" placeholder="请输入用户描述">
				</div>
			</div>
			
			<div class="layui-form-item form-group has-feedback">
			    <label class="layui-form-label col-sm-2">选择域：</label>
			    <div class="col-sm-10">
			      <select name="org" lay-verify="required" class="form-control" id="org">
			       
			      </select>
			    </div>
			  </div>  
			
			<div class="text-center">
				<span id="returnMessage" class="glyphicon"></span>
				<button type="reset" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;消</button>
				<button id="editBtn" type="button" class="btn btn-primary">提&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;交</button>
			</div>
		</form>
	</div>
	<div id="loading">
		<div id="AjaxLoading" class="showbox in">
			<div class="loadingWord">
				<img src="Image/waiting.gif">请稍候...
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$("#loading").hide();
$(document).ajaxStart(function(){
    $("#loading").show();
　　})

　　$(document).ajaxComplete(function(){
　　$("#loading").hide();
})
layui.config({
    base: 'base/'
}).use(['element','form','layer'], function() {
	
    $('#info').bootstrapValidator({
        message: '输入值不合法',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	name: {
                message: '域用户名称不合法',
                validators: {
                    notEmpty: {
                        message: '域用户名称不能为空'
                    },
                    /* regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '端类名只能由汉字,字母和数字组成。 '
                    } */
                }
            }
        	,password: {
                message: '域用户密码不合法',
                validators: {
                    notEmpty: {
                        message: '域用户密码不能为空'
                    },
                    /* regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '端类名只能由汉字,字母和数字组成。 '
                    } */
                    stringLength: {
                        min: 6,
                        max: 12,
                        message: '密码长度6-12位。'
                    }, 
                }
            }
        	,repassword:{
        		
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
            ,description: {
                message: '域用户描述不合法',
                validators: {
                    notEmpty: {
                        message: '域用户描述不能为空'
                    },
                     
                }
            }
        }
    });
  
    $('#info').data('bootstrapValidator').resetForm();
    $('#editBtn').on("click",function () {
    var bv = $("#info").data('bootstrapValidator');
    bv.validate();
    if (bv.isValid()) {
        $.ajax({
            url: 'addGroupUser.do',
            async: false,   //同步，阻塞操作
            type: 'post',   //PUT DELETE POST
            data: {
                name: $("#name").val(),
                password: $("#password").val(),
                description: $("#description").val(),
                org: $("#org option:selected").text()
            },
//             complete: function (msg) {
//             },
            success: function (data) {
                if ( data.code == 0 ) {   // 添加成功
                    layer.msg("域用户添加失败！")
                } else if( data.code == 2 ) {
                    layer.msg("域用户已存在")
                }else{
                	layer.msg("域用户添加成功");
                	window.location.href='system/system5.jsp';
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
