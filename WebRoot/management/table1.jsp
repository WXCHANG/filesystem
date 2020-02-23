<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
    <!--[if lt IE9]> 
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    
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
<!-- <style>
	.layui-form-item {
        margin-bottom: 0;
    }
	#user{
        border-radius: 20px;
        text-indent: 25px;
        height: 32px;
        margin: 5px 0;
    }
    i.search{
        display: inline-block;
        position: absolute;
        top: 12px;
        left: 10px;
    }
    button#search{
        height: 32px;
        line-height: 32px;
        border-radius: 5px;
    }
    body{
    	width: 100%;
    	overflow: hidden;
    }
</style> -->
<body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">待存任务列表</div>
            <!--  <div>
                <div class="layui-inline layui-form-item">
                    <div class="layui-input-inline" style="width: 320px;">
                        <i class="layui-icon search">&#xe631;</i>
                        <input id="user" type="text" class="layui-input" name="" layui-filter=""; placeholder="请输入测试连通性IP地址">
                    </div>
                </div>
                <div class="layui-inline layui-form-item">
                    <button id="search" class="layui-btn" lay-filter="search" >测试</button>
                </div>
            </div> -->
        </div>
    </div>
    <div class="text-body">
        <table id="summary" class="layui-table layui-fluid" lay-size="sm" lay-filter="test"></table>   
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
					<h4 class="modal-title" id="userInfo">编辑数据信息</h4>
				</div>
				<div class="modal-body">
					<form id="edit-userForm" class="form-horizontal">
						<div class="form-group">
							<label for="name" class="layui-form-label col-sm-3 control-label">文件名称</label>
							<div class="col-sm-8">
								<input type="text"
									class="form-control" id="value1" name="value1" />
							</div>
						</div>
						<div class="form-group">
							<label for="area" class="layui-form-label col-sm-3 control-label">作者名称</label>
							<div class="col-sm-8">
								<input type="text"
									class="form-control" id="value2" name="value2" />
							</div>
						</div>
						<div class="form-group">
							<label for="identifier" class="layui-form-label col-sm-3 control-label">文件大小</label>
							<div class="col-sm-8">
								<input type="text"
									class="form-control" id="value3" name="value3" />
							</div>
						</div>
						<div class="form-group">
							<label class="layui-form-label col-sm-3 control-label">文件来源</label>
							<div class="col-sm-8">
								<input type="text"
									class="form-control" id="value4" name="value4" />
							</div>
						</div>
						<div class="form-group">
							<label class="layui-form-label col-sm-3 control-label">业务字段5</label>
							<div class="col-sm-8">
								<textarea rows="" cols="" class="form-control" name="value5" id="value5" ></textarea>
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
    <a class="layui-btn layui-btn layui-btn-xs" lay-event="edit" data-toggle="modal" data-target="#edit-user">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn layui-btn-xs " lay-event="writing" >写入区块</a>
</script>
<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script>
$(".layui-nav-tree dd",window.parent.document).removeClass("layui-this");
$("#table1",window.parent.document).addClass("layui-this")
layui.config({
    base: '/base/layui/modules/'
}).use(['element','form','layer','laypage','table'], function() {
    var table = layui.table;
    console.log($("#indexTpl"))
    // table实例化
    table.render({
        elem: '#summary'
        ,height: 'full-100'
        ,url: 'getNoBlockOrigins.do' //数据接口
        //,data: data
        ,page: true //开启分页
        ,cols: [[ //表头
//             {type:'checkbox', fixed: 'left'}
            {title: '序号', templet: '#indexTpl', width: 60, fixed: 'left', type: 'numbers'}
         // ,{field: 'id', title: 'ID',  sort: true,  width: 80, fixed: 'left'}
             ,{field: 'name', title: '文件名称',}
            ,{field: 'area', title: '作者名称'}
            ,{field: 'identifier', title: '文件大小'}
            ,{field: 'quality', title: '文件来源'}
            ,{field: 'storagetime', title: '录入时间'}
//             ,{field: 'examine', title: '产品审核', width: 150}
            ,{field: 'hash', title: '数据Hash值（系统自动生成）'}
            ,{field: '',title: '操作', width: 220,toolbar: '#btn-group', fixed: 'right'}
        ]]
    });
    
    $('#edit-userForm').bootstrapValidator({
		message : '输入值不合法',
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		fields : {
			name : {
				message : '密码不合法',
				validators : {
					notEmpty : {
						message : '密码不能为空'
					},
				}
			},
			area : {
				message : '两次输入的密码不相符',
				validators : {
					notEmpty : {
						message : '密码不能为空'
					}
				}
			},
			quality : {
				message : '密码不合法',
				validators : {
					notEmpty : {
						message : '密码不能为空'
					},
				}
			},
			name : {
				message : '密码不合法',
				validators : {
					notEmpty : {
						message : '密码不能为空'
					},
				}
			}
		}
	});
    
    //监听工具条
    table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
        var data = obj.data //获得当前行数据
        ,layEvent = obj.event; //获得 lay-event 对应的值
        if(layEvent === 'writing'){
	       	 $.ajax({
	       	        url:"saveDataToBlock.do",
	       	        type:"POST",
	       	        dataType:"json",
	       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
	       	        data:{
	       	        	id:data.id,
	       	        },
	       	        success:function(data){
	       	        	if(data.result=="success"){
	       	        		window.location.href='skipPageTable2.do'
	       	        	}else{
	       	        		alert("写入区块失败！");
	       	        	}
	       	        }
       	    });
        } else if(layEvent === 'del'){
            layer.confirm('真的删除行么', function(index){
            obj.del(); //删除对应行（tr）的DOM结构
            layer.close(index);
            //向服务端发送删除指令
            $.ajax({
       	        url:"deleteOrigin.do",
       	        type:"POST",
       	        dataType:"json",
       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
       	        data:{
       	        	id:data.id,
       	        },
       	        success:function(data){
       	        }
   	    });
            });
        } else if(layEvent === 'edit'){
        	$("#edit-user").one("show.bs.modal", function(event) {
        		
				//  表单传值
				$("#edit-userForm input[ name=value1 ]").val(data.name);
				
				$("#edit-userForm input[ name=value2 ]").val(data.area);

				$("#edit-userForm input[ name=value3 ]").val(data.identifier);
				
				$("#edit-userForm input[ name=value4 ]").val(data.quality);
				
				$("#edit-userForm textarea[ name=value5 ]").val(data.examine);
				
				// layui单选按钮选中
				// $("input[type=radio][value="+data.userPress+"]").next().find("i").click();

				$("#editBtn").unbind("click").one("click", function() {
					var bv = $("#edit-userForm").data('bootstrapValidator');
					bv.validate();
					if (bv.isValid()) {
						//  var form = $("#edit-userForm").serialize() + "&id=" + data.id;
						$.ajax({
							type : "post",
							url : "addOrUpdateData.do",
							dataType : "json",
							data : {
								value1:$("#value1").val(),
								value2:$("#value2").val(),
								value3:$("#value3").val(),
								value4:$("#value4").val(),
								value6:$("#value6").val(),
								id : data.id,
							},
							success : function(data) {
								if (data.code == 1) {
									alert("数据信息编辑成功");
									window.location.href = 'management/table1.jsp'
								} else {
									alert("数据信息编辑失败");
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
        }
    });
});

/* var data = tableContent; */
</script> 
</body>
</html>
