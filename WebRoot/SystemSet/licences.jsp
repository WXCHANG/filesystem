<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">    
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
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
        <style>
       .form-box {
		width: 100%;
		height: 85%;
		display: flex;
		display: -webkit-box; /* OLD - iOS 6-, Safari 3.1-6 */
		display: -moz-box; /* OLD - Firefox 19- (buggy but mostly works) */
		display: -ms-flexbox; /* TWEENER - IE 10 */
		display: -webkit-flex; /* NEW - Chrome */
		flex-direction: column;
		 justify-content: center; 
		align-items: center;
	}


	#edit-userForm {
		width: 740px;
	}
	.layui-form-item{
		padding-top: 20px;
	}
	.form_btnGroup{
	    display: flex;
	    flex-flow: row nowrap;
	    justify-content: flex-end;
	    align-items: center;
	}
	#edit-userForm{
	    padding: 30px 30px 30px 30px;
	    border: 2px dotted #aaa;
	    border-radius: 10px;
	}
    </style>
    
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
  
  <body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">用户token分配</div>
        </div>
    </div>
    <div class="form-box">
        <form action="" id="edit-userForm" class="bv-form  form-horizontal" method="post">
            <div class="form-group has-feedback">
                <label for="userName" class="layui-form-label col-sm-3">用户名称</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="userName" name="username" value="${channelUser.username}"  readonly="true">
                </div>
            </div>
            <div class="form-group has-feedback">
                <label for="userName" class="layui-form-label col-sm-3">许可证ID</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="licencesId" name="licencesId"  value="${videoToken.licencesId}">
                </div>
            </div>
            <div class="form-group has-feedback">
                <label for="userName" class="layui-form-label col-sm-3">有效日期</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="validDate" name="validDate" value="${videoToken.validDateBak}" >
                </div>
            </div>
           
            <div class="form-group has-feedback">
                <label for="userName" class="layui-form-label col-sm-3">token值</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="token" name="token" value="${videoToken.token}">
                </div>
            </div>
           <input  type="hidden"  type="text" class="form-control" id="userId" name="userId" value="${videoToken.userId}" >
            
            <div class="form-group btn_div">
                <label class="control-label col-sm-3" for=""></label>
                <div class="col-sm-8 form_btnGroup">
                    <button type="reset" class="btn btn-default" style="margin-right: 30px;" data-dismiss="modal">重置</button>
                    <button id="editBtn" type="button" class="btn btn-primary">提交</button>
                </div>
            </div>
        </form>
    </div>
 
</body>
<script type="text/javascript" >
layui.config({
    base: 'base/'
}).use(['element','form','layer'], function() {

    $('#edit-userForm').bootstrapValidator({
        message: '输入值不合法',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	licencesId: {
                message: '许可证ID不合法',
                validators: {
                    notEmpty: {
                        message: '许可证ID不能为空'
                    },
                }
            },
            validDate: {
                message: '有效日期不合法',
                validators: {
                    notEmpty: {
                        message: '有效日期不能为空'
                    },
                }
            },
            token: {
                message: 'token不合法',
                validators: {
                    notEmpty: {
                        message: 'token值不能为空'
                    },
                }
            }
        }
    });
    $('#edit-userForm').data('bootstrapValidator').resetForm();
    $('#editBtn').unbind("click").on("click",function () {
    	var bv = $("#edit-userForm").data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
         $.ajax({
            	 url: "addVideoToken.do", 
                async: false,   //同步，阻塞操作
                type: 'post',   //PUT DELETE POST
                data: {
                	licencesId: $("#licencesId").val(),
                	validDateBak: $("#validDate").val(),
                	token: $("#token").val(),
                	userName: $("#userName").val()
                },
                complete: function (msg) {
                },
                success: function (data) {
                    if ( data.code==1 ) {   // 成功
                        alert("视频权限设置成功");
                        var _parent = window.parent;
                        _parent.location.href = '${pageContext.request.contextPath}/channelindex.jsp';
                    } else {
                        layer.msg(data.msg)
                    }
                }, 
                error: function () {
                    layer.msg("请求失败！请检查您的网络环境！")
                }
            }) 
        }
    })
})
</script>
</html>
