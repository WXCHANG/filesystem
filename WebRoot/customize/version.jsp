<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    
    <title>版本切换</title>
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
    <script src="https://cdn.jsdelivr.net/npm/vue"></script>
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
            <div class="ant-card-head-title">版本切换</div>
        </div>
    </div>
    <div class="text-body">
        <fieldset>
            <legend>版本切换</legend>
            <form id="editTitle" class="bv-form layui-form form-horizontal">
                <div class="form-group has-feedback">
                    <label for="type">平台版本</label>
                    <div>
                        <label class="radio" v-for="item in list">
                            <input type="radio" :value="item.tablename" name="tableName" data-bv-field="type">
                            {{item.titleCHN}}
                        </label>
                    </div>
                </div>
                <div class="text-right">
                    <span id="" class="glyphicon"></span>
                    <!-- <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button> -->
                    <button id="btn-editTitle" type="button" class="btn btn-primary">切换</button>
                </div>
            </form> 
        </fieldset>
    </div>
<script>
$.ajax({
    url: "queryLogoTitles.do",  
    type: "post",
    async: false,
    data: $('#edit-userForm').serialize(),
    success: function (data) {  
        list = data.logoTitles;
        if ( data.result == "success" ) {
            
        }       
    },
    error: function () {
        // 失败操作
        // layer.msg("失败！");
    }
})

var editTitle = new Vue({
    el: '#editTitle',
    data: list,
})

layui.config({
    base: '/base/layui/modules/'
}).use(['element','form','layer','upload'], function() {
    
    var layer = layui.layer;
    
    $("#btn-editTitle").click(function() {
        // var bv = $('#editTitle').data('bootstrapValidator');
        // bv.validate();
        // if (bv.isValid()) {
        // }
        $.ajax({
            url: "selectTable.do",  // 提交接口
            type: "post",
            data: $('#editTitle').serialize(),
            success: function (data) {   
                if ( data.result == "success" ) {
                    layer.msg("切换成功");
                    var _parent = window.parent;
                    setTimeout(function () {
                        _parent.location.reload();
                    },1300)
                }   
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("失败！");
                // 状态码
                console.log(XMLHttpRequest.status);
                // 状态
                console.log(XMLHttpRequest.readyState);
                // 错误信息   
                console.log(textStatus);
            }
        })
    })
   
});


</script> 
</body>
</html>
