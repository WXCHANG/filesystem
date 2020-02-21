<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    
    <title>字段设置</title>
    
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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/fields.js"></script>
    <!--[if lt IE9]> 
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <style>
    .text-body{
        justify-content: flex-start;
    }
    form#editFields{
        width: 400px;
        margin: 30px auto;
    }
    fieldset{
	    width: 412px;
        /*margin-bottom: 15px;*/
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
        margin-bottom: 0px;
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
            <div class="ant-card-head-title">字段设置</div>
        </div>
    </div>
   <!--  <button id="addBtn" class="layui-btn layui-btn-normal btn-sm" data-toggle="modal" data-target="#edit-fields" style="margin: 10px 0 0 20px;">添加字段</button>
   <div class="text-body">
        
    </div>-->
    <form id="editFields" class="bv-form layui-form form-horizontal" method="post">
        <div class="layui-form-item form-group has-feedback">
            <fieldset>
                <legend>字段一</legend>
                <label class="layui-form-label col-sm-3 input-required" for="">字段名</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control layui-input" id="" name="field1" placeholder="">
                </div>
            </fieldset>
        </div>
        <div class="layui-form-item form-group has-feedback">
            <fieldset>
                <legend>字段二</legend>
                <label class="layui-form-label col-sm-3 input-required" for="">字段名</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control layui-input" id="" name="field2" placeholder="">
                </div>
            </fieldset>
        </div>
        <div class="layui-form-item form-group has-feedback">
            <fieldset>
                <legend>字段三</legend>
                <label class="layui-form-label col-sm-3 input-required" for="">字段名</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control layui-input" id="" name="field3" placeholder="">
                </div>
            </fieldset>
        </div>
        <div class="layui-form-item form-group has-feedback">
            <fieldset>
                <legend>字段四</legend>
                <label class="layui-form-label col-sm-3 input-required" for="">字段名</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control layui-input" id="" name="field4" placeholder="">
                </div>
            </fieldset>
        </div>
        <div class="layui-form-item form-group has-feedback">
            <fieldset>
                <legend>字段五</legend>
                <label class="layui-form-label col-sm-3 input-required" for="">字段名</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control layui-input" id="" name="field5" placeholder="">
                </div>
            </fieldset>
        </div>
         <div class="layui-form-item form-group has-feedback">
            <fieldset>
                <legend>字段六</legend>
                <label class="layui-form-label col-sm-3 input-required" for="">字段名</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control layui-input" id="" name="field6" placeholder="">
                </div>
            </fieldset>
        </div>
        <div class="text-right">
            <span id="" class="glyphicon"></span>
            <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
            <button id="editBtn" type="submit" class="btn btn-primary">提交</button>
        </div>
    </form> 
    <!-- 添加表单 -->
    <!-- <div class="modal fade" id="edit-fields" tabindex="-1" role="dialog" aria-labelledby="">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="userInfo">编辑字段信息</h4>
                </div>
                <div class="modal-body">
                    <form id="edit-userForm" class="bv-form">
                        <div class="form-group has-feedback">
                            <label for="userName">字段名</label>
                            <input type="text" class="form-control" id="" name="columnName" placeholder="字段名只能由汉字,字母和数字组成">
                        </div>
                        <div class="form-group has-feedback">
                            <label for="type">字段类型</label>
                            <div>
                                <label class="radio-inline">
                                    <input type="radio" value="1" name="type" data-bv-field="type" checked>
                                    文本框
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" value="2" name="type" data-bv-field="type">
                                    上传文件
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" value="3" name="type" data-bv-field="type">
                                    富文本框
                                </label>
                            </div>
                        </div>
                        <div class="form-group has-feedback">
                            <label for="priority">字段优先级</label>
                            <div>
                                <label class="radio-inline">
                                    <input type="radio" value="1" name="priority" data-bv-field="priority" checked>
                                    必填
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" value="2" name="priority" data-bv-field="priority">
                                    非必填
                                </label>
                            </div>
                        </div>
                        <div class="text-right">
                            <span id="returnMessage" class="glyphicon"></span>
                            <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button id="editBtn" type="button" class="btn btn-primary">提交</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>  -->
</body>
</html>
