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
<body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">已审核用户列表</div>
        </div>
    </div>
    <div class="text-body">
        <table id="summary" class="layui-table layui-fluid" lay-size="sm" lay-filter="test"></table>   
    </div>
    
      <!-- 编辑用户表单 -->
    <div class="modal fade" id="edit-user" tabindex="-1" role="dialog" aria-labelledby="">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="userInfo">编辑用户信息</h4>
                </div>
                <div class="modal-body">
                	<form class="form-horizontal" id="edit-userForm">
                        <div class="form-group">
    					    <label for="name" class="col-sm-2 col-sm-offset-2 layui-form-label">用户名称</label>
    					    <div class="col-sm-6">
    					      <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名称">
    					    </div>
                        </div>
                        <div class="form-group">
    					    <label for="email" class="col-sm-2 col-sm-offset-2 layui-form-label">用户邮箱</label>
    					    <div class="col-sm-6">
    					      <input type="text" class="form-control" id="email" name="email" placeholder="请输入用户邮箱">
    					    </div>
                        </div>
                        <div class="form-group">
    					    <label for="company" class="col-sm-2 col-sm-offset-2 layui-form-label">公司名称</label>
    					    <div class="col-sm-6">
    					      <input type="text" class="form-control" id="company" name="company" placeholder="请输入公司名称">
    					    </div>
                        </div>
                        <div class="form-group">
    					    <label for="channelname" class="col-sm-2 col-sm-offset-2 layui-form-label">通道名称</label>
    					    <div class="col-sm-6">
    					      <select name="channelname" lay-verify="required" class="form-control"
									id="channelname" disabled="disabled">
									<option ></option>
								</select>
    					    </div>
                        </div>
    				    <div class="form-group">
                            <label for="" class="col-sm-2 col-sm-offset-2 layui-form-label">当前状态</label>
                            <div class="col-sm-6 radio">
    						  <label>
    						    <input type="radio" name="auditstatus" id="auditstatus1" value="1" checked>通过
    						  </label>
    						  <label style="margin-left: 30px;">
    						    <input type="radio" name="auditstatus" id="auditstatus2" value="2">不通过
    						  </label>
                            </div>
    					</div>
					</form>
                </div>
                <div class="modal-footer" style="margin-right: -10px;">
                    <div class="col-sm-4 col-sm-offset-6">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button id="editBtn" type="button" class="btn btn-primary">提交</button>
                    </div>
                </div>
            </div>
        </div>
    </div> 
    
<script type="text/html" id="btn-group">
    <a class="layui-btn" lay-event="edit" data-toggle="modal" data-target="#edit-user">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script>
$(".layui-nav-tree dd",window.parent.document).removeClass("layui-this");
$("#examine2",window.parent.document).addClass("layui-this")
layui.config({
    base: '/base/layui/modules/'
}).use(['element','form','layer','laypage','table'], function() {
    var table = layui.table;

    console.log($("#indexTpl"))
    // table实例化
    table.render({
        elem: '#summary'
        ,height: 540
        ,url: 'queryChannelUserExamined.do' //数据接口
        //,data: data
        ,page: true //开启分页
        ,cols: [[ //表头
//             {type:'checkbox', fixed: 'left'}
            {title: '序号', templet: '#indexTpl', width: 80, fixed: 'left'}
         // ,{field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
            ,{field: 'username', title: '用户名称'}
            ,{field: 'channelname', title: '通道名称'}
            ,{field: 'email', title: '用户邮箱'} 
            ,{field: 'company', title: '公司名称'}
            ,{field: 'auditstatus', title: '审核结果'}
            ,{field: 'handle',title: '操作',  width: 150, toolbar: '#btn-group', fixed: 'right'}
        ]]
	    ,done: function(res, curr, count){
	         //分类显示中文名称  
	         $("[data-field='auditstatus']").children().each(function(){  
	             if($(this).text()=='2'){  
	                $(this).text("未通过").css("color", "red") 
	             }else if($(this).text()=='1'){  
	                $(this).text("通过").css("color", "green")
	             } 
	         })
	     }
    });
    //监听工具条
    table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
        var data = obj.data //获得当前行数据
        ,layEvent = obj.event; //获得 lay-event 对应的值
       if(layEvent === 'del'){
            layer.confirm('真的删除行么', function(index){
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
       	        	
       	        }
   	    });
            });
        } else if(layEvent === 'edit'){
        	 $("#edit-user").one("show.bs.modal",function (event) {
        		//  表单传值
                 $("#edit-userForm input[ name=username ]").val( data.username );
             
                 $("#edit-userForm select[ name=channelname ] option:selected").text( data.channelname );
                 
                 $("#edit-userForm input[ name=email ]").val( data.email );
                 
                 $("#edit-userForm input[ name=company ]").val( data.company );
                 
                 if(data.auditstatus=='1'){
                 	$("#edit-userForm #auditstatus1").attr("checked", true);
                 	$("#edit-userForm #auditstatus2").attr("checked", false);
                 }else{
                 	$("#edit-userForm #auditstatus1").attr("checked", false);
                 	$("#edit-userForm #auditstatus2").attr("checked", true);
                 }
                 
                 // layui单选按钮选中
                 // $("input[type=radio][value="+data.userPress+"]").next().find("i").click();

                 $("#editBtn").unbind("click").one("click", function () {

                     $.ajax({
                         type: "post",  
                         url: "updateChannelUser.do", 
                         dataType: "json", 
                         data: {
                         	id:data.id,
                         	email:$("#edit-userForm input[ name=email ]").val(),
                         	auditstatus:  $("#edit-userForm input[ name=auditstatus ]").val()
                         },
                         success:function(data){
 		       	        	if(data.code==1){
 		       	        		layer.msg("编辑成功");
 		       	        		window.location.href='examine/examine2.jsp'
 		       	        	}else{
 		       	        		layer.msg("用户编辑失败");
 		       	        	}
 		       	        },
                         error: function () {
                        	 layer.msg("编辑失败，请检查网络后重试！");
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

/* var data = tableContent; */
</script> 
</body>
</html>
