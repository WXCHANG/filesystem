<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String date=df.format(new Date());
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


#info {
	width: 650px;
}
.layui-form-item{
	padding-top: 10px;
}
.form_btnGroup{
    display: flex;
    flex-flow: row nowrap;
    justify-content: flex-end;
    align-items: center;
}
#info{
    padding: 30px 20px;
    border: 2px dotted #aaa;
    border-radius: 10px;
}
/* button{
    margin-top: 30px;
    margin-left: 50px;
} */
</style>
</head>
<script type="text/javascript">
$(function() { 
	var html = "";
	 $.ajax({
         url: 'queryOrgs.do',
         async: false,   //同步，阻塞操作
         type: 'post',   //PUT DELETE POST
         data: {},
         success: function (data) {
        	 jQuery.each(data.list, function(i,item){  
        		 var orgName = item.name;
        		 html +="<option value='"+orgName+"'>"+orgName+"</option>";
              })
             $("#org").append(html);  
         }
     })
});
</script>
<body>
	<div class="ant-card-head">
		<div class="ant-card-head-wrapper">
			<div class="ant-card-head-title">添加通道信息</div>
		</div>
	</div>
	<div class="form-box">
		<form action="addChannel.do" id="info"
			class="" method="post">
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-4" for="">通道名称</label>
				<div class="col-sm-6">
					<input type="text" class="form-control layui-input" id="channelname"
						name="channelname" placeholder="请输入通道名称" value="">
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-4" for="">通道标识</label>
				<div class="col-sm-6">
					<input type="text" class="form-control layui-input" id="symbol"
						name="symbol" placeholder="请输入通道标识" value="">
				</div>
				<!-- <span style="color:red;">必须是英文</span> -->
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-4" for="">通道描述</label>
				<div class="col-sm-6">
					<input type="text" class="form-control layui-input" id="description"
						name="description" placeholder="请输入通道描述">
				</div>
			</div>
			
			<div class="layui-form-item form-group has-feedback">
			    <label class="layui-form-label col-sm-4">通道所属域</label>
			    <div class="col-sm-6">
			      <select name="org" lay-verify="required" class="form-control" id="org">
			      </select>
			    </div>
			  </div>  
			
			<div class="form-group">
                <label class="layui-form-label col-sm-4"></label>
				<div class="col-sm-6 form_btnGroup">
    				<button type="reset" class="btn btn-default" data-dismiss="modal">重置</button>
    				<button id="editBtn" type="button" class="btn btn-primary" style="margin-left: 20px;">提交</button>
                </div>
			</div>
		</form>
	</div>
	<div id="loading">
		<div id="AjaxLoading" class="showbox in">
			<div class="loadingWord">
				<img src="Image/waiting.gif">请稍候...
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$("#loading").hide();
$(document).ajaxStart(function(){
    $("#loading").show();
　　})

　　$(document).ajaxComplete(function(){
　　$("#loading").hide();
})
layui.config({
    base: 'base/'
}).use(['element','form','layer'], function() {

    $('#info').bootstrapValidator({
        message: '输入值不合法',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	channelname: {
                message: '通道名称不合法',
                validators: {
                    notEmpty: {
                        message: '通道名称不能为空'
                    },
                    /* regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '端类名只能由汉字,字母和数字组成。 '
                    } */
                }
            }
            ,description: {
                message: '通道描述不合法',
                validators: {
                    notEmpty: {
                        message: '通道描述不能为空'
                    },
                   /*  stringLength: {
                        min: 6,
                        max: 12,
                        message: '密码长度6-12位。'
                    }, */
                   /*  regexp: {
                        regexp: /^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|[xX])$/,
                        message: '身份证格式不正确。 '
                    } */
                }
            }
        }
    });
    $('#info').data('bootstrapValidator').resetForm();
    $('#editBtn').on("click",function () {
    var bv = $("#info").data('bootstrapValidator');
    bv.validate();
    if (bv.isValid()) {
        $.ajax({
            url: 'addChannel.do',
            async: false,   //同步，阻塞操作
            type: 'post',   //PUT DELETE POST
            data: {
                channelname: $("#channelname").val(),
                description: $("#description").val(),
                org: $("#org option:selected").text(),
                symbol: $("#symbol").val()
            },
//             complete: function (msg) {
//             },
            success: function (data) {
                if ( data.code == 0 ) {   // 添加成功
                    layer.msg("添加通道失败！")
                } else if( data.code == 2 ) {
                    layer.msg("通道已存在")
                }else{
                	window.location.href='channel/channel2.jsp'
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
