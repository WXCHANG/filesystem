<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    
    <title>自定义标题和Logo</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">    
    <meta http-equiv="keywords" content="log">
    <meta http-equiv="description" content="operation log">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customize.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
    <!--[if lt IE9]> 
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <style>
    fieldset{
        display: block;
        -webkit-margin-start: 2px;
        -webkit-margin-end: 2px;
        -webkit-padding-before: 0.35em;
        -webkit-padding-start: 0.75em;
        -webkit-padding-end: 0.75em;
        -webkit-padding-after: 0.625em;
        min-width: -webkit-min-content;
        border-width: 2px;
        border-style: dotted;
        border-color: threedface;
        border-image: initial;
    }
    legend{
        display: block;
        width: 80px;
        padding: 0;
        margin-bottom: 20px;
        line-height: inherit;
        color: #333;
        border: 0;
        text-indent: 12px;
        font-size: 14px;
    }
    </style>
</head>
  
<body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">显示设置</div>
        </div>
    </div>
    <div class="text-body">
        <fieldset>
            <legend>标题设置</legend>
            <form id="editTitle" class="bv-form layui-form form-horizontal" method="post">
                <div class="layui-form-item form-group has-feedback">
                    <label class="layui-form-label col-sm-3 input-required" for="">中文标题</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control layui-input" id="" name="titleCh" placeholder="自定义中文名称">
                    </div>
                </div>
                <div class="layui-form-item form-group has-feedback">
                    <label class="layui-form-label col-sm-3 input-required" for="">英文标题</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control layui-input" id="" name="titleEn" placeholder="自定义英文名称">
                    </div>
                </div>
                <div class="text-right">
                    <span id="" class="glyphicon"></span>
                    <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button id="btn-editTitle" type="submit" class="btn btn-primary">提交</button>
                </div>
            </form> 
        </fieldset>
       
        <fieldset>
            <legend>logo设置</legend>
            <form id="" class="bv-form layui-form form-horizontal" method="post">
                <div class="layui-form-item form-group has-feedback">
                    <label class="layui-form-label col-sm-3 input-required" for="">上传公司logo</label>
                    <div class="col-sm-9">
                        <button type="button" class="layui-btn" id="test1">
                            <i class="layui-icon">&#xe67c;</i>上传图片
                        </button>
                        <p style="color: #bbb;">建议尺寸<span style="color: red;">60*60</span> 或 <span style="color: red;">200*60</span></p>
                    </div>
                </div>
            </form> 
        </fieldset>
         <fieldset>
            <legend>版权设置</legend>
            <form id="editCopyright" class="bv-form layui-form form-horizontal" method="post">
                <div class="layui-form-item form-group has-feedback">
                    <label class="layui-form-label col-sm-3 input-required" for="">版权所属</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control layui-input" id="" name="copyright" placeholder="自定义中文名称">
                    </div>
                </div>
                <div class="layui-form-item form-group has-feedback">
                    <label class="layui-form-label col-sm-3 input-required" for="">官网地址</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control layui-input" id="" name="website" placeholder="自定义英文名称">
                    </div>
                </div>
                <div class="text-right">
                    <span id="" class="glyphicon"></span>
                    <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button id="btn-editCopyright" type="submit" class="btn btn-primary">提交</button>
                </div>
            </form> 
        </fieldset>
    </div>
<script>

$("#editTitle").bootstrapValidator({
    message: '输入值不合法',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
        titleCh: {
            message: '中文标题不合法',
            validators: {
                notEmpty: {
                    message: '中文标题不能为空'
                },
                regexp: {
                    regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                    message: '不能包含空格以及特殊字符。'
                }
            }
        }
        ,titleEn: {
            message: '英文标题不合法',
            validators: {
                notEmpty: {
                    message: '英文标题不能为空'
                },
                regexp: {
                    regexp: /^[ A-Za-z0-9]*$/,
                    message: '只能输入英文字母和数字'
                }
            }
        }
    }
});
$("#editCopyright").bootstrapValidator({
    message: '输入值不合法',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
        copyrights: {
            message: '版权所属不合法',
            validators: {
                notEmpty: {
                    message: '版权所属不能为空'
                },
                regexp: {
                    regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                    message: '不能包含空格以及特殊字符。'
                }
            }
        }
        ,website: {
            message: '官网地址不合法',
            validators: {
                notEmpty: {
                    message: '官网地址不能为空'
                },
                regexp: {
                    regexp: /^((ht|f)tps?):\/\/[\w\-]+(\.[\w\-]+)+([\w\-.,@?^=%&:\/~+#]*[\w\-@?^=%&\/~+#])?$/,
                    message: '只能输入英文字母和数字'
                }
            }
        }
    }
});
layui.config({
    base: '/base/layui/modules/'
}).use(['element','form','layer','upload'], function() {
    
    var upload = layui.upload;
    

    //执行实例
    var uploadInst = upload.render({
        elem: '#test1' //绑定元素
        ,url: 'setLogo.do' //上传接口
        ,done: function(res){
            layer.msg("上传成功！")
            var _parent = window.parent;
            setTimeout(function () {
                _parent.location.reload();
            },900)
        }
        ,error: function(){
            //请求异常回调
            layer.msg("上传失败！")
        }
    });
    
    $("#btn-editTitle").click(function() {
        var bv = $('#editTitle').data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
            $.ajax({
                url: "setTitle.do",  // 提交接口
                type: "post",
                data: $('#editTitle').serialize(),
                success: function (data) {   
                    if ( data.code == 0 ) {
                        layer.msg("设置成功！")
                        var _parent = window.parent;
                        setTimeout(function () {
                            _parent.location.reload();
                        },900)
                    }   
                },
                error: function () {
                    // 失败操作
                    layer.msg("设置失败！");
                }
            })
        }
    })
    $("#btn-editCopyright").click(function() {
        var bv = $('#editCopyright').data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
            $.ajax({
                url: "setCopyright.do",  // 提交接口
                type: "post",
                data: $('#editCopyright').serialize(),
                success: function (data) {   
                    if ( data.code == 0 ) {
                        layer.msg("设置成功！")
                        var _parent = window.parent;
                        setTimeout(function () {
                            _parent.location.reload();
                        },900)
                    }   
                },
                error: function () {
                    // 失败操作
                    layer.msg("设置失败！");
                }
            })
        }
    })
   
});


</script> 
</body>
</html>
