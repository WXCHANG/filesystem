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
<style>
#summary {
	width: 300px;
	margin: 0 auto;
}

tr, th {
	text-align: center !important;
}
</style>
</head>

<body>
	<div class="ant-card-head">
		<div class="ant-card-head-wrapper">
			<div class="ant-card-head-title">用户管理</div>
		</div>
	</div>
	<div class="text-body">
		<br />
		<%-- <button id="pop-btn" data-method="offset" data-type="auto"
			class="layui-btn layui-btn-normal" onclick="window.location.href='${pageContext.request.contextPath}/channelUser/addChannelUser.jsp'">添加用户</button> --%>
		<table id="summary" class="layui-table layui-fluid scroll"
			lay-size="sm" lay-filter="test"></table>
	</div>
	
	
	  <!-- 编辑组织管理表单 -->
    <div class="modal fade" id="edit-user" tabindex="-1" role="dialog" aria-labelledby="">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="userInfo">编辑用户信息</h4>
                </div>
                <div class="modal-body">
                    <form id="edit-userForm" class="bv-form">
                        <div class="form-group has-feedback">
                            <label for="username">用户名</label>
                            <input type="text" class="form-control" id="username" name="username" readonly />
                        </div>
                        <div class="form-group has-feedback">
                            <label for="password">用户密码</label>
                            <input type="text" class="form-control" id="password" name="password"  />
                        </div>
                         <div class="form-group has-feedback">
                            <label for="orgCode">确认密码</label>
                            <input type="text" class="form-control" id="password2" name="password2"  />
                        </div>
                      
                       
                        <input id="res" name="res" type="reset" style="display:none;" />
                        <div class="text-right">
                            <span id="returnMessage" class="glyphicon"> </span>
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button id="editBtn" type="button" class="btn btn-primary">提交</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div> 
	
	
	
	
	
	
	<script type="text/html" id="btn-group">
    <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="edit" data-toggle="modal" data-target="#edit-user">编辑</button>
   
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="stop">停用</a>
	<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="start">启用</a>
  
</script>
<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
	<script>
	
	layui.use('table', function(){
	    var table = layui.table;
	    // table实例化
	    table.render({
	        elem: '#summary'
	        ,height: 540
	        ,url: 'queryChannelUser.do' //数据接口
	        //,data: data
	        ,page: true //开启分页
	        ,cols: [[ //表头
	            {title: '序号', templet: '#indexTpl', width: 100, fixed: 'left'}
	            ,{field: 'username', title: '用户名'}
	            ,{field: 'password', title: '密码'}
	            ,{field: 'channelname', title: '通道名称'}
	            ,{field: 'status', title: '状态', width:180}
	         
	            ,{field: '',title: '操作', width: 250,toolbar: '#btn-group', fixed: 'right'}
	        ]]
	        ,done: function(res, curr, count){
	            //分类显示中文名称  
		        $("[data-field='status']").children().each(function(){  
	            if($(this).text()=='1'){  
	               $(this).text("启用").css("color", "green")  
	            }else if($(this).text()=='0'){  
	               $(this).text("停用").css("color", "red")  
	            } 
		        }) 
		
		        $("tbody [data-field='password']").children().each(function(){  
		            $(this).text("******")
		        })
	        }
	    });
	  
	    $('#edit-userForm').bootstrapValidator({
	        message: '输入值不合法',
	        feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        fields: {
	          password: {
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
	    //监听工具条
	    table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
	        var data = obj.data //获得当前行数据
	        ,layEvent = obj.event; //获得 lay-event 对应的值
	        if(layEvent === 'del'){
	            layer.confirm('确定要删除吗？', function(index){
	            obj.del(); //删除对应行（tr）的DOM结构
	            layer.close(index);
	            //向服务端发送删除指令
	            $.ajax({
	       	        url:"deleteChannelUser.do",
	       	        type:"POST",
	       	        dataType:"json",
	       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
	       	        data:{
	       	        	id:data.id,
	       	        },
	       	        success:function(data){
	       	        	if(data.code==1){
	       	        		alert("用户删除成功");
	       	        		window.location.href='channelUser/channelUser1.jsp';
	       	        	}else{
	       	        		alert("用户删除失败");
	       	        	}
	       	        }
	   	    });
	            });
	        } else if(layEvent === 'stop'){
	        	layer.confirm('确定要停用吗？', function(index){
		            layer.close(index);
		            //向服务端发送删除指令
		            $.ajax({
		       	        url:"updateChannelUserStatus.do",
		       	        type:"POST",
		       	        dataType:"json",
		       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
		       	        data:{
		       	        	id:data.id,
		       	        	status:0,
		       	        },
		       	        success:function(data){
		       	        	if(data.code==1){
		       	        		alert("用户停用成功");
		       	        		window.location.href='channelUser/channelUser1.jsp';
		       	        	}else{
		       	        		alert("用户停用失败");
		       	        	}
		       	        }
		   	    });
		            });
	        }else if(layEvent === 'start'){
	        	layer.confirm('确定要启用吗？', function(index){
		            layer.close(index);
		            //向服务端发送删除指令
		            $.ajax({
		       	        url:"updateChannelUserStatus.do",
		       	        type:"POST",
		       	        dataType:"json",
		       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
		       	        data:{
		       	        	id:data.id,
		       	        	status:1
		       	        },
		       	        success:function(data){
		       	        	if(data.code==1){
		       	        		alert("用户启用成功");
		       	        		window.location.href='channelUser/channelUser1.jsp'
		       	        	}else{
		       	        		alert("用户启用失败");
		       	        	}
		       	        }
		   	    });
		            });
	        }else if ( layEvent === "edit" ) {
	            
	            $("#edit-user").one("show.bs.modal",function (event) {
	                //  表单传值
	                $("#edit-userForm input[ name=username ]").val( data.username );
	            
	                $("#edit-userForm input[ name=password ]").val( data.password );
	                
	                $("#edit-userForm input[ name=channelname ]").val( data.channelname );
	               
	                // layui单选按钮选中
	                // $("input[type=radio][value="+data.userPress+"]").next().find("i").click();

	                $("#editBtn").unbind("click").one("click", function () {
	                	var bv = $("#edit-userForm").data('bootstrapValidator');
	                    bv.validate();
						if(bv.isValid()){
					         //  var form = $("#edit-userForm").serialize() + "&id=" + data.id;
			                    $.ajax({
			                        type: "post",  
			                        url: "updateChannelUser.do", 
			                        dataType: "json", 
			                        data: {
			                        	username: $("#username").val(),
			                        	password: $("#password").val(),
			                        	channelname: $("#channelname").val(),
			                        	id:data.id,
			                        	
			                        },
			                        success:function(data){
					       	        	if(data.code==1){
					       	        		/* tableInfo.reload({
				       	           		        url: 'queryChannelUser.do',
				       	           		        where: {}, //设定异步数据接口的额外参数
				       	           		        
				       	           		    }) */
				       	           		    alert("用户编辑成功");
					       	        		window.location.href='channelUser/channelUser1.jsp'
					       	        	}else{
					       	        		alert("用户编辑失败");
					       	        	}
					       	        },
			                        error: function () {
			                            alert("编辑失败，请检查网络后重试！");
			                        },
			                        complete: function () {
			                            $("#edit-user").modal("hide");
			                        }
			                    })
						}
	         
	                })
	            })
	        }
	    });
	});
	
	
	
	

	</script>
</body>
</html>
