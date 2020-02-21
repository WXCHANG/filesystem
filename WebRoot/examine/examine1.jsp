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
</head>
 <style>
 	.modal-body{
 		padding: 20px 30px;
 	}
 	#cancel{
 		margin-right: 20px;
 	}
 	.layui-form-select dl {
        z-index: 9999;
    }
    .layui-table-cell {
    	overflow: visible;
    }
    .layui-input{
    	height:30px; 
    }
 </style>
 
<body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">待审核用户列表</div>
        </div>
    </div>
    <div class="text-body">
        <table id="summary" class="layui-table layui-fluid" lay-size="sm" lay-filter="test"></table>   
    </div>
	<!-- 点击不通过模态框 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">原因</h4>
	      </div>
	      <div class="modal-body">
	        	<form id="edit-userForm" class="bv-form">
					<div class="form-group has-feedback">
						<label for="channelname" >内容</label> 
						<textarea class="form-control" rows="5" name="reason"></textarea>
					</div>
					 <div class="text-right">
                            <span id="returnMessage" class="glyphicon"> </span>
                            <button type="button" class="btn btn-default" data-dismiss="modal" id="cancel">取&nbsp;&nbsp;&nbsp;消</button>
                            <button id="editBtn" type="button" class="btn btn-primary">提&nbsp;&nbsp;&nbsp;交</button>
                     </div>
				</form>
	      </div>
	    </div>
	  </div>
	</div>
<script type="text/html" id="btn-group">
    <a class="layui-btn layui-btn-xs" lay-event="approval">通过</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="unapproval" data-toggle="modal" data-target="#myModal">不通过</a>
</script>
<script type="text/html" id="select-group">
      <select name="channel" lay-verify="required" class="select">
        <option value=""></option>
      </select>
</script>
<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script>

layui.config({
    base: '/base/layui/modules/'
}).use(['element','form','layer','laypage','table'], function() {
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;
    
    // table实例化
    var tableInfo = table.render({
        elem: '#summary'
        ,height: 540
        ,url: 'queryChannelUserUnexamined.do' //数据接口
        //,data: data
        ,page: true //开启分页
        ,cols: [[ //表头
//             {type:'checkbox', fixed: 'left'}
            {title: '序号', templet: '#indexTpl', width: 80, fixed: 'left'}
         // ,{field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
            ,{field: 'username', title: '用户名称'}
            ,{field: 'email', title: '用户邮箱'} 
            ,{field: 'company', title: '公司名称'}
            ,{field: '',title : '选择通道', templet: '#select-group'}
            ,{field: '',title: '操作', toolbar: '#btn-group', fixed: 'right'}
        ]],
        done: function () {
        	
        	var html = "";
       	 	$.ajax({
               url: 'queryAllChannel.do',//查询所有有效通道
               async: false,   //同步，阻塞操作
               type: 'post',   //PUT DELETE POST
               data: {},
               success: function (data) {
              	 jQuery.each(data.list, function(i,item){  
              		 var channelName = item.channelname;
              		 var channelIdentifier = item.identifier;
              		 html +="<option value='"+channelIdentifier+"'>"+channelName+"</option>";
              		 console.log(html)
                    })
                   $(".select").append(html);  
              	 form.render('select')
               }
           	})
        }
    });
    //监听工具条
    table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
        var data = obj.data //获得当前行数据
        ,layEvent = obj.event; //获得 lay-event 对应的值
       if(layEvent === 'approval'){
    	   var channel = $("select[ name=channel ] option:selected").val();
    	   var channelname = $("select[ name=channel ] option:selected").text();
    	   if(channel==null || channel==undefined || channel==""){
    		   layer.msg('通道未选择');
    		   return;
    	   }
            layer.confirm('确定审核通过', function(index){
	            //向服务端发送删除指令
	            $.ajax({
	       	        url:"approve.do",
	       	        type:"POST",
	       	        dataType:"json",
	       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
	       	        data:{
	       	        	id:data.id,
	       	        	username:data.username,
	       	        	channelidentifier:channel,
	       	        	channelname: channelname
	       	        },
	       	        success:function(data){
	       	        	if(data.code==1){
	       	        		window.location.href="examine/examine1.jsp"
	       	        		/* tableInfo.reload({
	       	           		        url: 'queryChannelUserUnexamined.do',
	       	           		        where: {}, //设定异步数据接口的额外参数
	       	           		        
	       	           		    }) */
	       	        	}else{
	       	        		alert("审核出现错误");
	       	        	}
	       	        }
	   	    	});
            });
        } else if(layEvent === 'unapproval'){
        	  $("#editBtn").unbind("click").one("click", function () {
				var reason = $("#edit-userForm textarea[name=reason]").val();
				console.log(reason);
                  $.ajax({
                      type: "post",  
                      url: "unapprove.do", 
                      dataType: "json", 
                      data: {
                    	  id:data.id,
                    	  reason:reason
                      },
                      success:function(data){
		       	        	if(data.code==1){
		       	        		layer.msg('审核成功');
		       	        		window.location.href='examine/examine1.jsp'
		       	        	}else{
		       	        		alert("审核出现错误");
		       	        	}
		       	        },
                      error: function () {
                          alert("审核失败，请检查网络后重试！");
                      },
                      complete: function () {
                          $("#edit-user").modal("hide");
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
