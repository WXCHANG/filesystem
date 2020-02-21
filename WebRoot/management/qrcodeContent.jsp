<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>提示</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user—scalale=no">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>

</head>
<style type="text/css">
.graphicDetail {
	background: #fff;
	overflow-y: auto;
	height: 1000px;
	width: 90%;
	margin: 0px auto;
	border: 1px solid #ccc;
}

h5 {
	width: 100%;
	height: 20px;
	text-align: center;
}

h4 {
	text-align: center;
	font-size: 14px;
	word-wrap:break-word;
}

.graphicDetail div {
	margin-top: 20px;
}

nav img {
	width: 250px;
	height: 75px;
}

.navbar {
	min-height: 75px;
}

.title {
	margin-bottom: 20px;
}
nav .container{
	text-align: center;
}
@media ( max-width : 480px) {
	.graphicDetail {
		background: #fff;
		overflow-y: auto;
		height: 100%;
		width: 100%;
		margin: 0px auto;
	}
	body {
		font: 14px '微软雅黑' !important;
	}
	h5 {
		font: 14px '微软雅黑' !important;
	}
}

@media ( min-width : 500px) {
	body {
		font: 14px '微软雅黑' !important;
	}
}
</style>
<body>
	<nav class="navbar navbar-default">
	<div class="container">
		<img alt=""
			src="${pageContext.request.contextPath}/images/bupt_logo.png">
	</div>
	</nav>
	<div class="container " style="height: 80%;width: 100%;">
		<h5>已扫描到以下内容</h5>
		<div class="graphicDetail container">
			<h4 class="title">溯源链平台V1.0</h4>
			<div>
				<h4 class="title">商品信息</h4>
				<h4>商品名称：${origin.name }</h4>
				<h4>商品产地：${origin.area }</h4>
				<h4>产品编号：${origin.identifier }</h4>
				<h4>产品质量：${origin.quality }</h4>
				<h4>产品备注：${origin.examine }</h4>
			</div>
			<div>
				<h4 class="title">区块信息</h4>
				<h4>区块高度：${block.number }</h4>
				<h4>区块哈希：${block.currentHash }</h4>
				<h4>父区块哈希：${block.previousHash }</h4>
				<h4>区块data_hash值：${block.dataHash }</h4>

			</div>
			<div>
				<c:if
					test="${block.transactions!=null && block.transactions.size()>0 }">
					<h4 class="title">交易信息</h4>
					<c:forEach items="${block.transactions }" var="transaction">
						<h4 class="column">交易ID：${transaction.tx_id }</h4>
						<h4>交易proposal_hash值：${transaction.proposal_hash }</h4>

						<%-- <h4 class="column">交易payload值： ${transaction.payload }</h4> --%>

						<h4 class="column">交易时间戳：${transaction.timestamp }</h4>
					</c:forEach>
			
				</c:if>
			</div><br><br>
		</div><br>

</body>
</html>
