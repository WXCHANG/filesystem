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
	padding-top: 30px;
}
button{
	margin-top: 30px;
	margin-left: 50px;
}
</style>
</head>

<body>
	<div class="ant-card-head">
		<div class="ant-card-head-wrapper">
			<div class="ant-card-head-title">添加用户</div>
		</div>
	</div>
	<div class="form-box">
		<form action="addUser.do" id="info"
			class="" method="post">
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for="">用户名称</label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id="username"
						name="username" placeholder="请输入用户名称" value="">
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for="">用户描述</label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id="description"
						name="description" placeholder="请输入用户描述">
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
            username: {
                message: '用户名称不合法',
                validators: {
                    notEmpty: {
                        message: '用户名称不能为空'
                    },
                    /* regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '端类名只能由汉字,字母和数字组成。 '
                    } */
                }
            }
            ,description: {
                message: '用户描述不合法',
                validators: {
                    notEmpty: {
                        message: '用户描述不能为空'
                    },
                   /*  stringLength: {
                        min: 6,
                        max: 12,
                        message: '密码长度6-12位。'
                    }, */
                   /*  regexp: {
                        regexp: /^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|[xX])$/,
                        message: '身份证格式不正确。 '
                    } */
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
            url: 'addUser.do',
            async: false,   //同步，阻塞操作
            type: 'post',   //PUT DELETE POST
            data: {
                username: $("#username").val(),
                description: $("#description").val(),
            },
//             complete: function (msg) {
//             },
            success: function (data) {
                if ( data.code == 0 ) {   // 添加成功
                    layer.msg("添加用户失败！")
                } else if( data.code == 2 ) {
                    layer.msg("用户已存在")
                }else{
                	window.location.href='system/system3.jsp'
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
