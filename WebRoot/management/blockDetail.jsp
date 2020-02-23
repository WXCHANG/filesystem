<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Document</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="log">
<meta http-equiv="description" content="operation log">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/base/layui/css/layui.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/table.css">
<link rel="stylesheet" href="css/index.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/index.js"></script>
<!--[if lt IE9]> 
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
</head>
<style>
.column {
	width: 300px;
	background: #eee;
}

td, caption {
	font-size: 14px !important;
	word-break: break-all;
	word-wrap: break-word;
	vertical-align: middle !important;
}
#userForm{
	padding: 25px 30px 0px 30px;
}
.form-btns{
	text-align: right;
}
.form-group {
    margin-bottom: 25px;
}
</style>
<script type="text/javascript">
layui.config({
    base: 'base/'
}).use(['element','form','layer'], function() {
	var form = layui.form;
    $('#userForm').bootstrapValidator({
        message: '输入值不合法',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
	        userName: {
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
        }
    });
    $('#userForm').data('bootstrapValidator').resetForm();

    
    $('#editBtn').on("click",function () {
        var bv = $("#userForm").data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
        	var userName = $("#userName").val();
        	var userNameVal = $("#userNameVal").val();
        	var password = $("#password").val();
        	var passwordVal = $("#passwordVal").val();
        	if(userName==userNameVal && password==passwordVal){
        		decryptData();
        	}else{
        		layer.msg("用户名或密码不正确！");
        	}
        }
    })
})
	function decryptData(){
		var content=$("#payload").text();
	   $.ajax({
              url: 'decryptData.do',
              async: false,   //同步，阻塞操作
              type: 'post',   //PUT DELETE POST
              dataType: 'json',
              data: {
            	  "content":content,
            	  "enCodeRules":"cpsec"
              },
              success: function (result) {
                  if (result.code == 1 ) {   // 解密成功
                  	$("#decryptData").text(result.data)
                  	$('#myModal').modal('hide');
                  } else {
                      layer.msg("解密失败");
                  }
              }, 
              error: function () {
                  layer.msg("请求失败！请检查您的网络环境！")
              }
          })
	}
</script>
<body>
	<div class="ant-card-head">
		<div class="ant-card-head-wrapper">
			<div class="ant-card-head-title">区块详情</div>
		</div>
	</div>
	<div class="text-body">
		<br>
		<table class="table table-bordered">
			<caption>区块信息概要 [ summary ]</caption>
			<tr>
				<td class="column">区块高度 [ number ]</td>
				<td>${block.number }</td>
			</tr>
			<tr>
				<td class="column">区块hash值 [ current_hash ]</td>
				<td>${block.currentHash }</td>
			</tr>
			<tr>
				<td class="column">区块父hash值 [ previous_Hash ]</td>
				<td>${block.previousHash }</td>
			</tr>
			<tr>
				<td class="column">区块data_hash值 [ data_hash ]</td>
				<td>${block.dataHash }</td>
			</tr>
			<tr>
				<td class="column">交易数量 [ number Of transactions ]</td>
				<td>${block.transactions.size() }</td>
			</tr>
		</table>
		<br>
		<table class="table table-bordered">
			<caption>交易信息 [ transactions ]</caption>
			<c:if
				test="${block.transactions!=null && block.transactions.size()>0 }">
				<c:forEach items="${block.transactions }" var="transaction">
					<tr>
						<td class="column">交易ID [ tx_id ]</td>
						<td>${transaction.tx_id }</td>
					</tr>
					<tr>
						<td class="column">交易proposal_hash值 [ proposal_hash ]</td>
						<td>${transaction.proposal_hash }</td>
					</tr>
					<tr>
						<td class="column">交易payload值 [ payload ]</td>
						<td id="payload">${transaction.payload }</td>
					</tr>
					<tr>
						<td class="column">交易时间戳 [ timestamp ]</td>
						<td>${transaction.timestamp }</td>
					</tr>
					<%--<tr>--%>
						<%--<td class="column">--%>
							<%--<button type="button" class="btn btn-primary" data-toggle="modal"--%>
								<%--data-target="#myModal">交易payload解密</button>--%>
						<%--</td>--%>
						<%--<td><span id="decryptData"></span></td>--%>
					<%--</tr>--%>
				</c:forEach>
			</c:if>
		</table>
		<br /> <br /> <br />
	</div>
	<!-- 模态框 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">输入用户信息</h4>
				</div>
				<div class="modal-body">
					<form id="userForm" class="bv-form  form-horizontal"
						method="post">
						<input type="hidden" value="${channelUser.username }" id="userNameVal">
						<input type="hidden" value="${channelUser.password }" id="passwordVal">
						<div class="form-group has-feedback">
							<label for="userName" class="layui-form-label col-sm-3">用户名</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="userName"
									name="userName" placeholder="请输入用户名">
							</div>
						</div>
						<div class="form-group has-feedback">
							<label for="userName" class="layui-form-label col-sm-3">密&nbsp;&nbsp;&nbsp;码</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="password"
									name="password" placeholder="请输入密码">
							</div>
						</div>
						<div class="form-group form-btns">
							<label class="control-label col-sm-3" for=""></label>
							<div class="col-sm-8 form_btnGroup">
								<button type="reset" class="btn btn-default" id="resetBtn"
									style="margin-right: 30px;" data-dismiss="modal">取&nbsp;&nbsp;&nbsp;消</button>
								<button id="editBtn" type="button" class="btn btn-primary">确&nbsp;&nbsp;&nbsp;定</button>
							</div>
						</div>
					</form>
				</div>
				<!-- <div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary">确定</button>
				</div> -->
			</div>
		</div>
	</div>
</body>
</html>
