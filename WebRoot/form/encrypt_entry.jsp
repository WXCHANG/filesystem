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
	height: 100%;
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
	/* height: 100%; */
	margin-top: 45px;
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
	margin-bottom: 45px;
}

.text-right {
	padding-right: 15px;
}
.adtheme{
	position:relative;
}
.encryption{
	position:absolute;
	top:5px;
	right:-35px;
}
</style>
</head>
<script type="text/javascript">

		$(function () {
			var userId=<%=session.getAttribute("userId")%>; 
				if(userId==null){
					alert("用户登录超时，请重新登录")
					window.parent.location.href='userLogin.jsp';
				} 
		})

	function encrypt(checkbox,data,ID){
		if(checkbox.checked == true){
			if(data=="" || data==undefined || data==null){
				alert("加密数据为空！")
			}else{
				  $.ajax({
		              type: "post",
		              url: "encryptData.do",
		              dataType: 'json',
		              
		              data: {
		              	content:data,
		              	enCodeRules:"cpsec"
		              },
		              success: function(result){
		        		if(result.code==1){
		        			$("#"+ID+"Content").text("加密后：");
		        			$("#"+ID+"Encrypt").text(result.data);
		        		}
		              }
		             
		          });
			}
		}else{
			$("#"+ID+"Content").text("");
			$("#"+ID+"Encrypt").text("");
		}
	}
	
	 function test(a){
		if(a.value==2){
			$("#videoNum").attr("style","display:block;");
		}else{
			$("#videoNum").attr("style","display:none;");
		}
		
	} 
</script>
<body>
	<div class="ant-card-head">
		<div class="ant-card-head-wrapper">
			<div class="ant-card-head-title">业务数据录入</div>
		</div>
	</div>
	<input type="hidden" id="auditStatus" value="${channelUser.auditstatus }" />
	<div class="form-box">
		<form id="info" class="" >
			<div class="layui-form-item form-group has-feedback adtheme">
				<label class="layui-form-label col-sm-2" for=""><span
					style="color:red;">* </span><span id="field1">文件名称</span></label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id="value1"
						name="value1" placeholder="" value="">
					<!-- <div class="encryption">
						<input type="checkbox" onclick="encrypt(this,$('#value1').val(),'value1')">加密
					</div>
					<div>
						<span style="color: green" id="value1Content"></span>
						<span id="value1Encrypt"></span>	
					</div> -->
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for=""><span
					style="color:red;">* </span><span id="field2">葡萄品种</span></label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id="value2"
						name="value2" placeholder="">
					<!-- <div class="encryption">
						<input type="checkbox" onclick="encrypt(this,$('#value2').val(),'value2')">加密
					</div>
					<div>
						<span style="color: green" id="value2Content"></span>
						<span id="value2Encrypt"></span>	
					</div> -->
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for=""><span
					style="color:red;">* </span><span id="field3">产品年份</span></label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id="value3"
						name="value3" placeholder="">
					<!-- <div class="encryption">
						<input type="checkbox" onclick="encrypt(this,$('#value3').val(),'value3')">加密
					</div>
					<div>
						<span style="color: green" id="value3Content"></span>
						<span id="value3Encrypt"></span>	
					</div> -->
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for=""><span
					style="color:red;">* </span><span id="field4">产品规格</span></label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id="value4"
						name="value4" placeholder="">
					<!-- <div class="encryption">
						<input type="checkbox" onclick="encrypt(this,$('#value4').val(),'value4')">加密
					</div>
					<div>
						<span style="color: green" id="value4Content"></span>
						<span id="value4Encrypt"></span>	
					</div> -->
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for="">产品酒精度</label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id="value7"
						name="value7" placeholder="">
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for=""></span>产品生产地</label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id="value8"
						name="value8" placeholder="">
				</div>
			</div>
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for=""></span>产品经销商</label>
				<div class="col-sm-10">
					<input type="text" class="form-control layui-input" id="value9"
						name="value9" placeholder="">
						<div class="encryption">
						<input type="checkbox" onclick="encrypt(this,$('#value9').val(),'value9')">加密
					</div>
					<div>
						<span style="color: green" id="value9Content"></span>
						<span id="value9Encrypt"></span>	
					</div>
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
				<label class="layui-form-label col-sm-2" for=""><span
					style="color:red;">* </span><span id="field4">数据类型</span></label>
				<div class="col-sm-10" id="radio1">
					图片<input type="radio" name="type" value="1" title="图片" checked onchange="test(this)"> 
                                                     视频 <input type="radio" name="type" value="2" title="视频" onchange="test(this)"> 
				</div>
			</div>
			
		  <!--   <div class="layui-form-item">
                 <label class="layui-form-label">媒体类型</label>
                 <div class="layui-input-block">
                     <input type="radio" name="type" value="1" title="图片" checked>
                     <input type="radio" name="type" value="2" title="视频">
                 </div>
           </div> -->
           <!--  <div class="form-group">
                            <label for="" class="col-sm-2 col-sm-offset-2 layui-form-label">当前状态</label>
                            <div class="col-sm-6 radio">
    						  <label>
    						    <input type="radio" name="auditstatus" id="auditstatus1" value="1" checked>通过
    						  </label>
    						  <label style="margin-left: 30px;">
    						    <input type="radio" name="auditstatus" id="auditstatus2" value="2">不通过
    						  </label>
                            </div>
    					</div> -->
			<div class="layui-form-item form-group has-feedback" id="imageType">
				<label class="layui-form-label col-sm-2" for="">
					<span style="color:red;">* </span>
					<span id="field5">数据文件</span>
				</label>
				<div class="col-sm-8 col-md-6">
					<input type="file" class="form-control layui-input" id="pic-file"
						name="value5" placeholder="" onchange="setImagePreview()">
				</div>
				<div class="col-sm-6 col-md-4" id="localImag">
					<img src="" id="preview" alt="预览" style="display: none;">
				</div>

			</div>
			<!-- <div class="layui-form-item form-group has-feedback" style="display: none;" id="videoNum">
				<label class="layui-form-label col-sm-2" for=""><span
					style="color:red;">* </span><span id="num">视频总数</span></label>
				<div class="col-sm-6">
					<input type="text" class="form-control layui-input" id="total"
						name="total" placeholder="">
				</div>
			</div> -->
		<!-- 	<div class="layui-form-item form-group has-feedback" id="videoType" style="display:none;">
				<label class="layui-form-label col-sm-2" for="">
					<span id="field5">选择媒体文件</span>
				</label>
				<div class="col-sm-8 col-md-6">
					<input type="file" class="form-control layui-input" id="pic-file"
						name="value5" placeholder="" onchange="setImagePreview()">
				</div>
			</div> -->
			<div class="layui-form-item form-group has-feedback">
				<label class="layui-form-label col-sm-2" for="">
					<span >产品描述</span>
				</label>
				<div class="col-sm-10">
					<textarea class="form-control layui-input" id="value6" name="value6"
						placeholder="" style="height: 60px;"></textarea>
				</div>
			</div>

			<div class="text-right">
				<span id="returnMessage" class="glyphicon"></span>
				<button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
				<button id="editBtn" type="button" class="btn btn-primary">提交</button>
			</div>
		</form>
	</div>
	<!-- <div id="loading">
		<div id="AjaxLoading" class="showbox in">
			<div class="loadingWord">
				<img src="Image/waiting.gif">请稍候...
			</div>
		</div>
	</div> -->
</body>
<script type="text/javascript">
function setImagePreview() {
	　　var docObj=document.getElementById("pic-file");
	　　var imgObjPreview=document.getElementById("preview");
	var test = $("input[name='type']:checked").val();
	　　if(docObj.files && docObj.files[0]){
		if(test==1){
			　//火狐下，直接设img属性
			　　imgObjPreview.style.display = 'block';
			　　imgObjPreview.style.width = '100px';
			　　imgObjPreview.style.height = '100px';
		}else{
			　imgObjPreview.style.display = 'none';
		}
	　
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
/* $("#loading").hide();
$(document).ajaxStart(function(){
    $("#loading").show();
　　})

　　$(document).ajaxComplete(function(){
　　$("#loading").hide();
}) */
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
        	value1: {
                message: '业务字段不合法',
                validators: {
                    notEmpty: {
                        message: '业务字段不能为空'
                    },
                }
            }
            ,value2: {
                message: '业务字段不合法',
                validators: {
                    notEmpty: {
                        message: '业务字段不能为空'
                    },
                }
            }
            ,value3: {
                message: '业务字段不合法',
                validators: {
                    notEmpty: {
                        message: '业务字段不能为空'
                    },
                }
            }
            ,value4: {
                message: '业务字段不合法',
                validators: {
                    notEmpty: {
                        message: '业务字段不能为空'
                    },
                }
            }
        }
    });
    $('#info').data('bootstrapValidator').resetForm();

    $('#editBtn').on("click",function () {
    	var test = $("input[name='type']:checked").val();
    	//alert(test);
    	//return;
	   if($("#auditStatus").val()!=1){
		   layer.msg("用户未审核或审核不通过,不能提交数据！");
		  
		   return;
	   }
        var bv = $("#info").data('bootstrapValidator');
        if (bv.isValid()) {
        	//alert($("#total").val());
        	var fd = new FormData();
        	fd.set("value5", $("#pic-file").get(0).files[0]);
            fd.set("value1",$("#value1").val());
            fd.set("value1Encrypt",$("#value1Encrypt").text());
            fd.set("value2",$("#value2").val());
            fd.set("value2Encrypt",$("#value2Encrypt").text());
            fd.set("value3",$("#value3").val());
            fd.set("value3Encrypt",$("#value3Encrypt").text());
            fd.set("value4",$("#value4").val());
            fd.set("value4Encrypt",$("#value4Encrypt").text());
            fd.set("value6",$("#value6").val());
            fd.set("value7",$("#value7").val());
            fd.set("value8",$("#value8").val());
            fd.set("value9",$("#value9").val());
            fd.set("value9Encrypt",$("#value9Encrypt").text());
            fd.set("type",test);
            //  fd.set("total",$("#total").val());
            fd.set("total",60);
            $.ajax({
                url: 'addOrigin.do',
                async: false,   //同步，阻塞操作
                type: 'post',   //PUT DELETE POST
                dataType: 'json',
                data: fd,
                contentType: false, //不设置内容类型
                processData: false, //不处理数据 	
                success: function (data) {
                    if (data.code == 1 ) {   // 添加成功
                    	window.location.href='management/table1.jsp';
                    } else {
                    	if(userCode==0){
                    		layer.msg("用户登录超时，请重新登录");
                    		window.location.href='userLogin.jsp';
                    	}
                        layer.msg("提交失败");
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