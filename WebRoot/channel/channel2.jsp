<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
</head>
<style>
.row {
	margin-top: 10px;
	margin-bottom: -5px;
}

.row input {
	border: 2px solid #5bc0de;
}

select#org option {
	background: #FFF;
	color: #000;
}
.modal-body{
	padding: 30px;
}
#cancel {
	margin-right: 20px;
}
</style>
<script type="text/javascript">
	$(function() {
		var html = "";
		$.ajax({
			url : 'queryOrgs.do',
			async : false, //同步，阻塞操作
			type : 'post', //PUT DELETE POST
			success : function(data) {
				$("#org").html('');
				$("#groupuser").html('');
				jQuery.each(data.list, function(i, item) {
					var orgName = item.name;
					html += "<option value='" + orgName + "'>" + orgName + "</option>";
				})
				$("#org").append(html);
				$("#groupuser").append(html);
			}
		});

		$("#org").change(function() {
			var selectedValue = $("#org option:selected").text();
		})
	})
</script>
<body>
	<div class="ant-card-head">
		<div class="ant-card-head-wrapper">
			<div class="ant-card-head-title">通道信息管理</div>
		</div>
	</div>
	<div class="row text-center">
		<span style="margin-left: 25%; margin-top: 10px;float: left;"><b>请选择域</b></span>
		<div class="col-md-6">
			<div class="input-group">
				<div class="input-group-btn">
					<select class="btn btn-info" id="org" lay-verify="required"
						lay-search="" style="height:34px;outline: none;">

					</select>
				</div>
				<input type="text" class="form-control" aria-label="..." id="search">
				<span class="input-group-btn" id="btn-search">
					<button class="btn btn-info" type="button">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>&nbsp;&nbsp;查&nbsp;询
					</button>
				</span>
			</div>
		</div>
	</div>
	<div class="text-body">
		<table id="summary" class="layui-table layui-fluid" lay-size="sm"
			lay-filter="test"></table>
	</div>
	<!-- 编辑通道织管理表单 -->
	<div class="modal fade" id="edit-user" tabindex="-1" role="dialog"
		aria-labelledby="">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="userInfo">编辑通道信息</h4>
				</div>
				<div class="modal-body">
					<form id="edit-userForm" class="form-horizontal">
						<div class="form-group">
							<label for="channelname" class="layui-form-label col-sm-3 control-label">通道名称</label> 
							<div class="col-sm-8">
								<input type="text"
									class="form-control" id="channelname" name="channelname" />
							</div>
						</div>
						<div class="form-group">
							<label for="symbol" class="layui-form-label col-sm-3 control-label">通道标识</label> 
							<div class="col-sm-8">
								<input type="text"
									class="form-control" id="symbol" name="symbol" />
							</div>
						</div>
						<div class="form-group">
							<label for="description" class="layui-form-label col-sm-3 control-label">通道描述</label> 
							<div class="col-sm-8">
								<input type="text"
									class="form-control" id="description" name="description" />
							</div>
						</div>
						<div class="form-group">
							<label class="layui-form-label col-sm-3 control-label">通道所属域</label>
							<div class="col-sm-8">
								<select name="org" lay-verify="required" class="form-control"
									id="groupuser">
								</select>
							</div>
						</div>


						<div class="form-group text-right">
							<span id="returnMessage" class="glyphicon"> </span>
							<div class="col-sm-offset-3 col-sm-8">
								<button type="button" class="btn btn-default"
									data-dismiss="modal" id="cancel">取&nbsp;&nbsp;&nbsp;消</button>
								<button id="editBtn" type="button" class="btn btn-primary">提&nbsp;&nbsp;&nbsp;交</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>




	<script type="text/html" id="btn-group">
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit" data-toggle="modal" data-target="#edit-user">编辑</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
	<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
	<script>
	
		layui.config({
			base : '/base/layui/modules/'
		}).use([ 'element', 'form', 'layer', 'laypage', 'table' ], function() {
			var table = layui.table;
			var search = $("#org option:selected").text();
			// table实例化
			var tableInfo = table.render({
				elem : '#summary',
				height : 540,
				url : 'queryChannel.do?search=' + search, //数据接口 //,data: data
				page : true, //开启分页
				cols : [ [ //表头
					//             {type:'checkbox', fixed: 'left'}
					{
						title : '序号',
						templet : '#indexTpl',
						width : 60,
						fixed : 'left'
					}
					// , {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
					, {
						field : 'channelname',
						title : '通道名称'
					}
					, {
						field : 'symbol',
						title : '通道标识'
					}
					, {
						field : 'groupuser',
						title : '通道所属域'
					}
					, {
						field : 'createtime',
						title : '通道创建时间'
					}
					, {
						field : 'description',
						title : '通道描述'
					}
					, {
						field : 'status',
						title : '状态'
					}
					, {
						field : '',
						title : '操作',
						width : 150,
						toolbar : '#btn-group',
						fixed : 'right'
					}
				] ],
				done : function(res, curr, count) {
					//分类显示中文名称  
					$("[data-field='status']").children().each(function() {
						if ($(this).text() == 0) {
							$(this).text("创建中").css("color", "orange")
						} else if ($(this).text() == 1) {
							$(this).text("创建成功").css("color", "green")
						} else if ($(this).text() == 2) {
							$(this).text("创建失败").css("color", "red")
						}
					})
				}
			});
			$('#edit-userForm').bootstrapValidator({
				message : '输入值不合法',
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					password : {
						message : '密码不合法',
						validators : {
							notEmpty : {
								message : '密码不能为空'
							},
							stringLength : {
								min : 6,
								max : 12,
								message : '密码长度6-12位。'
							},
						}
					},
					password2 : {
						message : '两次输入的密码不相符',
						validators : {
							notEmpty : {
								message : '密码不能为空'
							},
							identical : {
								field : 'password',
								message : '两次输入的密码不相符'
							}
						}
					}
				}
			});
			//监听工具条
			table.on('tool(test)', function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
				var data = obj.data, //获得当前行数据
					layEvent = obj.event; //获得 lay-event 对应的值
				if (layEvent === "edit") {
					$("#edit-user").one("show.bs.modal", function(event) {
	
						//  表单传值
						$("#edit-userForm input[ name=channelname ]").val(data.channelname);
						
						$("#edit-userForm input[ name=symbol ]").val(data.symbol);
	
						$("#edit-userForm input[ name=description ]").val(data.description);
						
						$("#edit-userForm select[ name=org ] option:selected").text(data.groupuser);
	
						// layui单选按钮选中
						// $("input[type=radio][value="+data.userPress+"]").next().find("i").click();
	
						$("#editBtn").unbind("click").one("click", function() {
							var bv = $("#edit-userForm").data('bootstrapValidator');
							bv.validate();
							if (bv.isValid()) {
								//  var form = $("#edit-userForm").serialize() + "&id=" + data.id;
								$.ajax({
									type : "post",
									url : "updateChannel.do",
									dataType : "json",
									data : {
										channelname : $("#channelname").val(),
										description : $("#description").val(),
										groupuser : $("#groupuser option:selected").val(),
										id : data.id,
									},
									success : function(data) {
										if (data.code == 1) {
											alert("通道信息编辑成功");
											window.location.href = 'channel/channel2.jsp'
										} else {
											alert("通道信息编辑失败");
										}
									},
									error : function() {
										alert("编辑失败，请检查网络后重试！");
									},
									complete : function() {
										$("#edit-user").modal("hide");
									}
								})
							}
	
						})
					})
				} else if (layEvent === "del") {
					layer.confirm('确定要删除吗？', function(index) {
						obj.del(); //删除对应行（tr）的DOM结构
						layer.close(index);
						//向服务端发送删除指令
						$.ajax({
							url : "deleteChannel.do",
							type : "POST",
							dataType : "json",
							contentType : 'application/x-www-form-urlencoded; charset=UTF-8', //防止乱码
							data : {
								id : data.id,
							},
							success : function(data) {
								if (data.code == 1) {
									tableInfo.reload({
										url : 'queryChannel.do',
										where : {
											search : search
										}, //设定异步数据接口的额外参数
	
									})
								} else {
									alert("域用户删除失败");
								}
							}
						});
					});
				}
			});
			$("#btn-search").click(function() {
				var selectValue = $("#org option:selected").text();
				var searchValue = $("#search").val();
				if (searchValue !== "" && searchValue !== null && searchValue !== undefined) {
					search = searchValue;
				} else {
					search = selectValue;
				}
				console.log(search);
				tableInfo.reload({
					url : 'queryChannel.do',
					where : {
						search : search
					}, //设定异步数据接口的额外参数
	
				});
			});
		});
	</script>
</body>
</html>
