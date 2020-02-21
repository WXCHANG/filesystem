<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
    if (session.getAttribute("manager") == null) {
    	response.setHeader("refresh", "0;URL=/openPlatform/admin/login.jsp");
        return;
    }
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'account.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/lay/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/index.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/lay/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
    
    <style>
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
    </style>
  </head>
  
  <body>
    <blockquote class="layui-elem-quote">
        <h1>账号管理</h1>
    </blockquote>
    <button class="layui-btn layui-btn-normal" data-toggle="modal" data-target="#add-user">添加账号</button>
    <table id="userTable" class="layui-table layui-fluid" lay-size="sm">
        <thead class="layui-bg-gray">
            <tr class="">
                <th style="width: 50px;">序号</th>
                <th >ID</th>
                <th >账号</th>
                <th >密码</th>
                <th >权限</th>
                <th >操作</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <div>
        <span id="layPage"></span>
    </div>
    <!-- 添加用户权限表单 -->
    <div class="modal fade" id="add-user" tabindex="-1" role="dialog" aria-labelledby="userInfo">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="userInfo">添加账号</h4>
                </div>
                <div class="modal-body">
                    <form id="userForm" class="bv-form">
                        <div class="form-group has-feedback">
                            <label for="userName">账号</label>
                            <input type="text" class="form-control" id="userName" name="username" placeholder="用户名只能由汉字,字母和数字组成">
                        </div>
                        <div class="form-group has-feedback">
                            <label for="pwd">密码</label>
                            <input type="text" class="form-control" id="pwd" name="password" placeholder="密码只能由字母，数字，下划线组成">
                        </div>
                        <div class="form-group has-feedback">
                            <label for="permission">权限</label>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="2" name="permission1" data-bv-field="permissions">
                                    编辑
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="3" name="permission2" data-bv-field="permissions">
                                    审批
                                </label>
                            </div>
                        </div>
                        <div class="text-right">
                            <span id="returnMessage" class="glyphicon"> </span>
                            <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button id="addBtn" type="button" class="btn btn-primary">提交</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>  
    <!-- 编辑用户权限表单 -->
    <div class="modal fade" id="edit-user" tabindex="-1" role="dialog" aria-labelledby="">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="userInfo">编辑账号</h4>
                </div>
                <div class="modal-body">
                    <form id="edit-userForm" class="bv-form">
                        <div class="form-group has-feedback">
                            <label for="userName">账号</label>
                            <input type="text" class="form-control" id="userName" name="username" placeholder="用户名只能由汉字,字母和数字组成" readonly>
                        </div>
                        <div class="form-group has-feedback">
                            <label for="pwd">密码</label>
                            <input type="text" class="form-control" id="pwd" name="password" placeholder="密码只能由字母，数字，下划线组成">
                        </div>
                        <div class="form-group has-feedback">
                            <label for="permission">权限</label>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="2" name="permission1" data-bv-field="permissions">
                                    编辑
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="3" name="permission2" data-bv-field="permissions">
                                    审批
                                </label>
                            </div>
                        </div>
                        <div class="text-right">
                            <span id="returnMessage" class="glyphicon"> </span>
                            <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button id="editBtn" type="button" class="btn btn-primary">提交</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div> 
    <!-- 删除提示 -->
    <div class="modal fade bs-example-modal-sm" id="dele-user" tabindex="-1" role="dialog" aria-labelledby="deleInfo">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">删除账号</h4>
                </div>
                <div class="modal-body">
                    <p>确定要删除该账号吗？</p>
                    <div class="text-right">
                        <span id="returnMessage" class="glyphicon"> </span>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button id="deleBtn" type="button" class="btn btn-danger">删除</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 账号解禁 -->
    <div class="modal fade bs-example-modal-sm" id="lifted" tabindex="-1" role="dialog" aria-labelledby="deleInfo">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">解禁账号</h4>
                </div>
                <div class="modal-body">
                    <p>该账号已存在且被禁用，是否解除禁用？</p>
                    <div class="text-right">
                        <span id="returnMessage" class="glyphicon"></span>
                        <button type="button" class="btn btn-default" data-dismiss="modal">否</button>
                        <button id="subBtn" type="button" class="btn btn-primary">是</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="AjaxLoading" class="showbox">
        <p>&#xe63d;数据请求中...</p>
    </div>
<script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/account.js"></script>
</body>
</html>
