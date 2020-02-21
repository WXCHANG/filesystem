<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="base/layui/css/layui.css">
<link rel="stylesheet" href="base/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="css/table.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
<!--[if lt IE9]> 
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<style>
.column {
	width: 300px;
	background: #eee;
}

.column1 {
	width: 150px;
	background: #eee;
}

td, caption {
	font-size: 14px !important;
	word-break: break-all;
	word-wrap: break-word;
	vertical-align: middle !important;
}

#details {
	display: flex;
	flex-flow: row;
	justify-content: space-between;
	align-items: flex-start;
	margin: 15px 0;
}

#details>div {
	padding: 0;
}

#picture {
	width: 295px;
	height: 295px;
	border: 1px solid #ccc;
	/* background-color: blue; */
}

.videos111 {
	width: 295px;
	height: 295px;
	object-fit: fill /* border: 1px solid #ccc; */ 
		/* background-color: blue; */
}

#qrcode {
	width: 220px;
	height: 220px;
	border: 1px solid #ccc;
	/* background-color: red; */
}

.col-xs-2 {
	width: 29.666667%;
}
/* .text-body,.text-body1 {
	
	padding: 10px 15px;
	margin: 30px 16px;
	border-radius: 10px;
} */
/* .text-body1 {
	border: 1px dotted #ccc;
} */
.imgBox {
	display: flex;
	flex-flow: column;
	justify-content: flex-start;
	align-items: center;
}

.imgBox img:not(:first-child){
	margin:30px 0 0;
}
#userForm {
	padding: 25px 30px 0px 30px;
}

.form-btns {
	text-align: right;
}

.form-group {
	margin-bottom: 25px;
}
</style>
<script type="text/javascript">

	$(function() {

		//获取并存储当前视频的id和路径
		$('a').on('click', function() {
			id = $(this).children('video').attr('id');
			src = $(this).children('video').attr('src');
			localStorage.setItem('id', id);
			localStorage.setItem('src', src);

		})
	})

	layui.config({
		base : 'base/'
	}).use([ 'element', 'form', 'layer' ], function() {
		var form = layui.form;
		$('#userForm').bootstrapValidator({
			message : '输入值不合法',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				userName : {
					message : '用户名不合法',
					validators : {
						notEmpty : {
							message : '用户名不能为空'
						}
					}
				},
				password : {
					message : '密码不合法',
					validators : {
						notEmpty : {
							message : '密码不能为空'
						}
					}
				}
			}
		});
		$('#userForm').data('bootstrapValidator').resetForm();


		$('#editBtn').on("click", function() {
			var bv = $("#userForm").data('bootstrapValidator');
			bv.validate();
			if (bv.isValid()) {
				var userName = $("#userName").val();
				var userNameVal = $("#userNameVal").val();
				var password = $("#password").val();
				var passwordVal = $("#passwordVal").val();
				if (userName == userNameVal && password == passwordVal) {
					decryptData();
				} else {
					layer.msg("用户名或密码不正确！");
				}
			}
		})
	})
	function decryptData() {
		var content = $("#payload").text();
		$.ajax({
			url : 'decryptData.do',
			async : false, //同步，阻塞操作
			type : 'post', //PUT DELETE POST
			dataType : 'json',
			data : {
				"content" : content,
				"enCodeRules" : "cpsec"
			},
			success : function(result) {
				if (result.code == 1) { // 解密成功
					$("#decryptData").text(result.data)
					$('#myModal').modal('hide');
				} else {
					layer.msg("解密失败");
				}
			},
			error : function() {
				layer.msg("请求失败！请检查您的网络环境！")
			}
		})
	}
</script>
</head>
<body>
	<div class="ant-card-head">
		<div class="ant-card-head-wrapper">
			<div class="ant-card-head-title">数据详情</div>
		</div>
	</div>
	<div class="text-body">
		<div id="details">
			<div class="col-xs-7">
				<table class="table table-bordered">
					<tr>
						<td class="column">产品名称</td>
						<td>${origin.name }</td>
					</tr>
					<tr>
						<td class="column">葡萄品种</td>
						<td>${origin.area }</td>
					</tr>
					<tr>
						<td class="column">产品年份</td>
						<td>${origin.identifier }</td>
					</tr>
					<tr>
						<td class="column">产品规格</td>
						<td>${origin.quality }</td>
					</tr>
					<tr>
						<td class="column">产品酒精度</td>
						<td>${origin.value7 }</td>
					</tr>
					<tr>
						<td class="column">产品生产地</td>
						<td>${origin.value8 }</td>
					</tr>
					<tr>
						<td class="column">产品经销商</td>
						<td>${origin.value9 }</td>
					</tr>
					<tr>
						<td class="column">产品描述</td>
						<td>${origin.examine }</td>
					</tr>
				</table>

			</div>

			<%-- <img id="picture" src="${origin.file }"
					alt=""> --%>
			<div class="col-xs-2 imgBox">
				<c:if test="${origin.type==1}">
					<img id="picture" src="${origin.file }" alt="">
				</c:if>
				<c:if test="${origin.type==2}">
					<a href="${pageContext.request.contextPath}/trace/videoShow.html">
						<video id="${origin.id }" src="${origin.file}" class="videos111"></video>
					</a>
				</c:if>
			</div>
			<!-- <div class="col-xs-3 "></div> -->

			<%-- <img id="qrcode" src="${origin.qrcode }" alt=""> --%>

		</div>
		<div class="">
			<table class="table table-bordered">
				<caption>区块信息概要 [ summary ]</caption>
				<tr>
					<td class="column">区块编号 [ number ]</td>
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
						<tr>
							<td class="column">
								<button type="button" class="btn btn-primary"
									data-toggle="modal" data-target="#myModal">交易payload解密</button>
							</td>
							<td><span id="decryptData"></span></td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			<table id="summary" class="layui-table layui-fluid scroll"
				lay-size="sm" lay-filter="test"></table>
		</div>
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
					<form id="userForm" class="bv-form  form-horizontal" method="post">
						<input type="hidden" value="${channelUser.username }"
							id="userNameVal"> <input type="hidden"
							value="${channelUser.password }" id="passwordVal">
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
