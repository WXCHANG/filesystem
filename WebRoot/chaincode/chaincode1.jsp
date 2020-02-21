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
<script type="text/javascript">
	$(function() {
		var html = "";
		$.ajax({
			url : 'queryOrgs.do',
			async : false, //同步，阻塞操作
			type : 'post', //PUT DELETE POST
			success : function(data) {
				$("#groupuser").html('');
				jQuery.each(data.list, function(i, item) {
					var orgName = item.name;
					html += "<option value='" + orgName + "'>" + orgName + "</option>";
				})
				$("#groupuser").append(html);
			}
		});
	})
</script>
<body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">链码信息列表</div>
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
    					    <label for="name" class="col-sm-2 col-sm-offset-2 layui-form-label">底层链码</label>
    					    <div class="col-sm-6">
    					      <input type="text" class="form-control" id="chaincode" name="chaincode" placeholder="" readonly="readonly">
    					    </div>
                        </div>
                        <div class="form-group">
    					    <label for="name" class="col-sm-2 col-sm-offset-2 layui-form-label">底层通道</label>
    					    <div class="col-sm-6">
    					      <input type="text" class="form-control" id="identifier" name="identifier" placeholder="" readonly="readonly">
    					    </div>
                        </div>
                        <div class="form-group">
    					    <label for="email" class="col-sm-2 col-sm-offset-2 layui-form-label">通道名称</label>
    					    <div class="col-sm-6">
    					      <input type="text" class="form-control" id="channelname" name="channelname" placeholder="请输入通道名称">
    					    </div>
                        </div>
                        <div class="form-group">
    					    <label for="company" class="col-sm-3 col-sm-offset-1 layui-form-label">通道所属域</label>
    					    <div class="col-sm-6">
    					      <select name="groupuser" lay-verify="required" class="form-control"
									id="groupuser">
								</select>
    					    </div>
                        </div>
                        <div class="form-group">
    					    <label for="channelname" class="col-sm-2 col-sm-offset-2 layui-form-label">通道描述</label>
    					    <div class="col-sm-6">
    					      <input type="text" class="form-control" id="description" name="description" placeholder="请输入通道描述">
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
    <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="edit" data-toggle="modal" data-target="#edit-user">编辑</button>
   
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
  
</script>  
<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script>
layui.config({
    base: '/base/layui/modules/'
}).use(['element','form','layer','laypage','table'], function() {
    var table = layui.table;

    console.log($("#indexTpl"))
    // table实例化
    table.render({
        elem: '#summary'
        ,height: 540
        ,url: 'queryChannelcode.do' //数据接口
        //,data: data
        ,page: true //开启分页
        ,cols: [ [ //表头
				//             {type:'checkbox', fixed: 'left'}
				{
					title : '序号',
					templet : '#indexTpl',
					width : 60,
					fixed : 'left'
				}
				// , {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
				, {
					field : 'chaincode',
					title : '底层链码'
				}
				, {
					field : 'identifier',
					title : '底层通道'
				}
				, {
					field : 'channelname',
					title : '通道名称'
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
				 ,{field: '',title: '操作', width: 150,toolbar: '#btn-group', fixed: 'right'}
				] ]
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
       	        url:"deleteChannel.do",
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
        } else if ( layEvent === "edit" ) {
            
            $("#edit-user").one("show.bs.modal",function (event) {
                //  表单传值
                $("#edit-userForm input[ name=chaincode ]").val( data.chaincode );
            
                $("#edit-userForm input[ name=identifier ]").val( data.identifier );
                
                $("#edit-userForm input[ name=channelname ]").val( data.channelname );
                
                $("#edit-userForm input[ name=description ]").val( data.description );
                
                $("#edit-userForm select[ name=groupuser ] option:selected").val( data.groupuser );
                
               
                // layui单选按钮选中
                // $("input[type=radio][value="+data.userPress+"]").next().find("i").click();

                $("#editBtn").unbind("click").one("click", function () {

                    var form = $("#edit-userForm").serialize() + "&id=" + data.id;
                    $.ajax({
                        type: "post",  
                        url: "updateChannel.do", 
                        dataType: "json", 
                        data: form,
                        success:function(data){
		       	        	if(data.code==1){
		       	        		alert("编辑成功");
		       	        		window.location.href='chaincode/chaincode1.jsp'
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


/* var data = tableContent; */
</script> 
</body>
</html>
