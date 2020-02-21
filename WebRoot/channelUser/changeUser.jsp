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
    body{
        height: 500px;
    }
    table{
        min-width: 1100px;
    }
    tr,th{
        text-align: center !important;
    }
    td:first-child{
        background: #f2f2f2;
    }
    .layui-elem-quote h1{
        font-size: 14px;
        margin: 0;
    }
    .form-box{
        width: 100%;
        height: 100%;
        display: flex;
        display: -webkit-box; /* OLD - iOS 6-, Safari 3.1-6 */ 
        display: -moz-box; /* OLD - Firefox 19- (buggy but mostly works) */ 
        display: -ms-flexbox; /* TWEENER - IE 10 */ 
        display: -webkit-flex; /* NEW - Chrome */ 
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
    #edit-userForm{
        width: 500px;
        padding: 50px 30px 30px 30px;
        border: 2px dotted #aaa;
        border-radius: 10px;
    }
    .form_btnGroup{
        display: flex;
        flex-flow: row nowrap;
        justify-content: flex-end;
        align-items: center;
    }
    </style>
  </head>
 <script type="text/javascript">
 $(function() { 
		var html = "";
		var html1 = "";
		 $.ajax({
	         url: 'queryChannels.do',
	         async: false,   //同步，阻塞操作
	         type: 'post',   //PUT DELETE POST
	         data: {
	        	
	         },
	         success: function (data) {
	        	 jQuery.each(data.list, function(i,item){  
	        		 //查询通道名称
	        		 var channelname = item.channelname;
	        		 var identifier = item.identifier;
	        		 html +="<option value='"+identifier+"'>"+channelname+"</option>";
	        		
	        		 
	              });
	              jQuery.each(data.groups, function(i,item){  

	        		 //查询公司名称
	        		 var company = item.name;
	        	
	        		 html1 +="<option value='"+company+"'>"+company+"</option>";
	        		 
	              });
	             
	             $("#channelname").append(html);  
	        	 $("#company").append(html1);  
	        	
	        	 $("#channelname").val(data.channelUser.channelidentifier);
	        	 $("#company").val(data.channelUser.company);
	        	 
		        	
	         }
	     });});
		 
</script>
  <body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">修改用户信息</div>
        </div>
    </div>
    <div class="form-box">
        <form  id="edit-userForm" class="bv-form  form-horizontal" method="post">
            <div class="form-group has-feedback">
                <label for="userName" class="control-label col-sm-3">账号</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="userName" name="username" value="${channelUser.username}"  readonly="true">
                </div>
            </div>
            <div class="form-group has-feedback">
                <label for="type" class="control-label col-sm-3">选择组织</label>
                <div class="col-sm-8">
                    <select name="channelname" lay-verify="required" class="form-control"  placeholder="请选择组名" id="channelname">
        				
                    </select>
                </div>
             </div>
             <div class="form-group has-feedback">
                 <label for="company" class="control-label col-sm-3">选择公司</label>
                <div class="col-sm-8">
                    <select name="company" lay-verify="required" class="form-control"  placeholder="请选择域名" id="company">
   					   
                    </select>
                </div>
            </div>
                        
              <div class="form-group">
                <label for="" class="control-label col-sm-3"></label>
                <div class="col-sm-8 form_btnGroup">
                    <button type="reset" class="btn btn-default" style="margin-right: 30px;" data-dismiss="modal">取消</button>
                    <button id="editBtn" type="submit" class="btn btn-primary">提交</button>
                </div>           
              </div>
        </form>
    </div>
    <div id="loading">
        <div id="AjaxLoading" class="showbox in">
            <div class="loadingWord"><img src="images/waiting.gif">请稍候...</div>
        </div>
    </div>
</body>
<script type="text/javascript" >
$("#loading").hide();
$(document).ajaxStart(function(){
    $("#loading").show()
　　});

　　$(document).ajaxComplete(function(){
　　$("#loading").hide()
})
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
            /*username: {
                message: '名不合法',
                validators: {
                    notEmpty: {
                        message: '名不能为空'
                    },
                    regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '端类名只能由汉字,字母和数字组成。 '
                    }
                }
            }
            ,*/channelname: {
                message: '组织不合法',
                validators: {
                    notEmpty: {
                        message: '请选择组织'
                    },
                    
                    /*regexp: {
                        regexp: /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,10}$/,
                        message: '密码必须且只含有数字和字母。 '
                    }*/
                }
            }
            ,company: {
                message: '公司不合法',
                validators: {
                    notEmpty: {
                        message: '请选择公司'
                    },
                    
                }
            }
        }
    });
    $('#edit-userForm').data('bootstrapValidator').resetForm();

    
    $('#editBtn').on("click",function () {
        var bv = $("#edit-userForm").data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
            $.ajax({
            	 url: "userUpdateChannelUser.do", 
                async: false,   //同步，阻塞操作
                type: 'post',   //PUT DELETE POST
                data: {
                	username: $("#userName").val(),
                	channelname: $("#channelname option:selected").text(),
                	channelidentifier:$("#channelname option:selected").val(),
                	company: $("#company").val(),
                	auditstatus:"0",
                	type:"2"
                },
                complete: function (msg) {
                },
                success: function (data) {
                    if ( data.code==1 ) {   // 成功
                        alert("用户信息修改成功");
                        var _parent = window.parent;
                        _parent.location.href = '${pageContext.request.contextPath}/channelindex.jsp';
                    } else if(data.code==2) {
                    	alert("此用户已经审核通过，不能修改信息");
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
