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
body {
	height: 450px;
}

table {
	min-width: 1100px;
}

tr, th {
	text-align: center !important;
}

td:first-child {
	background: #f2f2f2;
}

.layui-elem-quote h1 {
	font-size: 14px;
	margin: 0;
}

.form-box {
	width: 100%;
	height: 100%;
	margin-top:30px;
	display: flex;
	display: -webkit-box; /* OLD - iOS 6-, Safari 3.1-6 */
	display: -moz-box; /* OLD - Firefox 19- (buggy but mostly works) */
	display: -ms-flexbox; /* TWEENER - IE 10 */
	display: -webkit-flex; /* NEW - Chrome */
	flex-direction: column;
	/* justify-content: center; */
	align-items: center;
}

#edit-userForm {
	width: 800px;
	margin: 30px auto;
}

#info {
	width: 740px;
}
.text-right{
	padding-right: 15px;
}
</style>
</head>

<body>
	<div class="ant-card-head">
		<div class="ant-card-head-wrapper">
			<div class="ant-card-head-title">信息录入</div>
		</div>
	</div>
	<div class="form-box">
		<form action="addOrigin.do" id="info"
			class="" method="post"
			enctype="multipart/form-data">
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for=""><span
					style="color:red;">* </span>广告主题</label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id=""
						name="name" placeholder="" value="">
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for=""><span
					style="color:red;">* </span>广告类型</label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id=""
						name="area" placeholder="">
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for=""><span
					style="color:red;">* </span>广告时长</label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id=""
						name="identifier" placeholder="">
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for=""><span
					style="color:red;">* </span>广告位置</label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id=""
						name="quality" placeholder="">
				</div>
			</div>
			<!-- <div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for=""><span
					style="color:red;">* </span>产品审核</label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id=""
						name="examine" placeholder="">
				</div>
			</div> -->
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for="">添加附件</label>
				<div class="col-sm-8 col-md-6">
					<input type="file" class="form-control layui-input" id="pic-file"
						name="file" placeholder="" onchange="setImagePreview()">
				</div>
				<div class="col-sm-6 col-md-4" id="localImag">
					<img src="" id="preview" alt="预览" style="display: none;">
				</div>

			</div>
			<div class="layui-form-item form-group has-feedback">
                <label class="layui-form-label col-sm-2" for="">广告描述</label>
                <div class="col-sm-10">
                    <textarea class="form-control layui-input" id="" name="examine" placeholder="最大可容10M" style="height: 60px;"></textarea>
                </div>
            </div>

			<div class="text-right">
				<span id="returnMessage" class="glyphicon"></span>
				<button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
				<button id="editBtn" type="submit" class="btn btn-primary">提交</button>
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
function setImagePreview() {
	　　var docObj=document.getElementById("pic-file");
	　　var imgObjPreview=document.getElementById("preview");
	　　if(docObj.files && docObj.files[0]){
	　　//火狐下，直接设img属性
	　　imgObjPreview.style.display = 'block';
	　　imgObjPreview.style.width = '100px';
	　　imgObjPreview.style.height = '100px';
	　　//imgObjPreview.src = docObj.files[0].getAsDataURL();
	　　//火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式
	　　imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
	　　}else{
		　　//IE下，使用滤镜
		　　docObj.select();
		　　var imgSrc = document.selection.createRange().text;
		　　var localImagId = document.getElementById("localImag");
		　　//必须设置初始大小
		　　localImagId.style.width = "100px";
		　　localImagId.style.height = "100px";
		　　//图片异常的捕捉，防止用户修改后缀来伪造图片
		　　try{
		　　localImagId.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
		　　localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
		　　}catch(e){
		　　alert("您上传的图片格式不正确，请重新选择!");
		　　return false;
		　　}
		　　imgObjPreview.style.display = 'none';
		　　document.selection.empty();
	　　}
	　　return true;
	}
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

    /*$('#edit-userForm').bootstrapValidator({
        message: '输入值不合法',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            username: {
                message: '端类名不合法',
                validators: {
                    notEmpty: {
                        message: '端类名不能为空'
                    },
                    regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '端类名只能由汉字,字母和数字组成。 '
                    }
                }
            }
            ,password: {
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
                    regexp: {
                        regexp: /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,10}$/,
                        message: '密码必须且只含有数字和字母。 '
                    }
                }
            }
            ,password2: {
                message: '版本号不合法',
                validators: {
                    identical: {
                        field: 'password',
                        message: '两次输入的密码不相符'
                    }
                }
            }
        }
    });
    $('#edit-userForm').data('bootstrapValidator').resetForm();*/

    
    /*$('#editBtn').on("click",function () {
        var bv = $("#edit-userForm").data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
            $.ajax({
                url: '/openPlatform/manager/updateManager1.do',
                async: false,   //同步，阻塞操作
                type: 'post',   //PUT DELETE POST
                data: {
                    username: "admin",
                    password: $("#pwd").val(),
                },
                complete: function (msg) {
                },
                success: function (data) {
                    if ( data.flag == "success" ) {   // 添加成功
                        layer.msg("修改成功！")
                        var _parent = window.parent;
                        _parent.location.href = url+data.url;
                    } else {
                        layer.msg(data.msg)
                    }
                }, 
                error: function () {
                    layer.msg("请求失败！请检查您的网络环境！")
                }
            })
            
        }
    })*/
})
</script>
</html>
