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
.modal-body{
	padding: 30px;
}
#cancel{
	margin-right: 20px;
}
</style>
</head>

<body>
	<div class="ant-card-head">
		<div class="ant-card-head-wrapper">
			<div class="ant-card-head-title">域管理</div>
		</div>
	</div>
	<div class="text-body">
		<br />
		<%-- <button id="pop-btn" data-method="offset" data-type="auto"
			class="layui-btn layui-btn-normal" onclick="window.location.href='${pageContext.request.contextPath}/organization/addOrg.jsp'">添加组织</button> --%>
		<table id="summary" class="layui-table layui-fluid scroll"
			lay-size="sm" lay-filter="test"></table>
	</div>
	
	
	  <!-- 编辑组织管理表单 -->
    <div class="modal fade" id="edit-user" tabindex="-1" role="dialog" aria-labelledby="">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="userInfo">编辑域信息</h4>
                </div>
                <div class="modal-body">
                    <form id="edit-userForm" class="form-horizontal">
                        <div class="form-group">
                            <label for="name" class="layui-form-label col-sm-3 control-label">域&nbsp;名&nbsp;称</label>
                            <div class="col-sm-8">
                            	<input type="text" class="form-control" id="name" name="name" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="orgCode" class="layui-form-label col-sm-3 control-label">唯一标识</label>
                            <div class="col-sm-8">
                            	<input type="text" class="form-control" id="orgCode" name="orgCode" />
                            </div>
                        </div>
                        <div class="form-group has-feedback">
                            <label for="type" class="layui-form-label col-sm-3 control-label">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</label>
                            <div class="col-sm-8">
                            	<input type="text" class="form-control" id="type" name="type" >
                            </div>
                        </div>
                        <div class="text-right form-group">
                            <span id="returnMessage" class="glyphicon"> </span>
                            <div class="col-sm-offset-3 col-sm-8">
	                            <button type="button" class="btn btn-default" data-dismiss="modal" id="cancel">取&nbsp;&nbsp;&nbsp;消</button>
	                            <button id="editBtn" type="button" class="btn btn-primary">提&nbsp;&nbsp;&nbsp;交</button>
	                        </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div> 
	
	
	
	
	
	
	<script type="text/html" id="btn-group">
    <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="edit" data-toggle="modal" data-target="#edit-user">编辑</button>
   
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
  
</script>
<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
	<script>
	$(".layui-nav-tree dd",window.parent.document).removeClass("layui-this");
	$("#organization1",window.parent.document).addClass("layui-this")
	layui.use('table', function(){
	    var table = layui.table;
	    // table实例化
	    table.render({
	        elem: '#summary'
	        ,height: 540
	        ,url: 'queryOrg.do' //数据接口
	        //,data: data
	        ,page: true //开启分页
	        ,cols: [[ //表头
	            {title: '序号', templet: '#indexTpl', width:80, fixed: 'left'}
	            ,{field: 'name', title: '名称'}
	            ,{field: 'orgCode', title: '唯一标识'}
	            ,{field: 'type', title: '类别'} 
	            ,{field: '',title: '操作', toolbar: '#btn-group', fixed: 'right'}
	        ]]
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
	       	        url:"deleteOrgr.do",
	       	        type:"POST",
	       	        dataType:"json",
	       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
	       	        data:{
	       	        	id:data.id,
	       	        },
	       	        success:function(data){
	       	        	if(data.code==1){
	       	        		alert("删除成功");
	       	        		window.location.href='organization/organization1.jsp'
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
		       	        url:"stopUser.do",
		       	        type:"POST",
		       	        dataType:"json",
		       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
		       	        data:{
		       	        	id:data.id,
		       	        },
		       	        success:function(data){
		       	        	if(data.code==1){
		       	        		window.location.href='organization/organization1.jsp'
		       	        	}else{
		       	        		alert("用户停用失败");
		       	        	}
		       	        }
		   	    });
		            });
	        }else if ( layEvent === "edit" ) {
	            
	            $("#edit-user").one("show.bs.modal",function (event) {
	                //  表单传值
	                $("#edit-userForm input[ name=name ]").val( data.name );
	            
	                $("#edit-userForm input[ name=orgCode ]").val( data.orgCode );
	                
	                $("#edit-userForm input[ name=type ]").val( data.type );
	               
	                // layui单选按钮选中
	                // $("input[type=radio][value="+data.userPress+"]").next().find("i").click();

	                $("#editBtn").unbind("click").one("click", function () {

	                    var form = $("#edit-userForm").serialize() + "&id=" + data.id;
	                    $.ajax({
	                        type: "post",  
	                        url: "updateOrg.do", 
	                        dataType: "json", 
	                        data: form,
	                        success:function(data){
			       	        	if(data.code==1){
			       	        		alert("编辑成功");
			       	        		window.location.href='organization/organization1.jsp'
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
	                })
	            })
	        }
	    });
	});
	
	
	
	

	</script>
</body>
</html>
