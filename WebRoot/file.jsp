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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/lay/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/table.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/lay/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/url.js"></script>
    
</head>
<body>
    <blockquote class="layui-elem-quote">
        <h1>历史文件</h1>
    </blockquote>
    <!-- 条件查询 -->
    <form class="layui-form">
        <div class="layui-inline layui-form-item">
            <label for="" class="layui-form-label" style="width: 100px;">文件类型</label>
            <div class="layui-input-inline " style="width: 200px;">
                <select id="fileType" name="fileType" lay-verify="required" lay-filter="fileType">
                    <option value="">全部</option>
                    <option value="DEMO">Demo安装包</option>
                    <option value="DOC">Doc开发文档</option>
                    <option value="SDK">SDK包</option>
                </select>
                <div class="layui-unselect layui-form-select">
                    <div class="layui-select-title">
                        <input type="text" placeholder="全部" value="" readonly="" class="layui-input layui-unselect">
                        <i class="layui-edge"></i>
                    </div>
                    <dl class="layui-anim layui-anim-upbit" style="">
                        <dd lay-value="" class="layui-select-tips">全部</dd>
                        <dd lay-value="DEMO" class="">demo安装包</dd>
                        <dd lay-value="DOC" class="">开发文档</dd>
                        <dd lay-value="SDK" class="">SDK包</dd>
                    </dl>
                </div>
            </div>
        </div>
        <div class="layui-inline layui-form-item">
            <label for="" class="layui-form-label" style="width: 100px;">文件位置</label>
            <!-- 一级标题 -->
            <div class="layui-input-inline t1" style="width: 200px;">
                <select id="t1" name="title1" lay-verify="" lay-filter="title1">
                    <option value="">全部</option>
                </select>
                <div class="layui-unselect layui-form-select">
                    <div class="layui-select-title">
                        <input type="text" placeholder="全部" value="" readonly="" class="layui-input layui-unselect">
                        <i class="layui-edge"></i>
                    </div>
                    <dl class="layui-anim layui-anim-upbit" style=""></dl>
                </div>
            </div>
            <div class="layui-form-mid">-</div>
            <!-- 二级标题 -->
            <div class="layui-input-inline t2" style="width: 200px;">
                <select id="t2" name="title2" lay-verify="" lay-filter="title2">
                    <option value="">全部</option>
                </select>
                <div class="layui-unselect layui-form-select">
                    <div class="layui-select-title">
                        <input type="text" placeholder="全部" value="" readonly="" class="layui-input layui-unselect">
                        <i class="layui-edge"></i>
                    </div>
                    <dl class="layui-anim layui-anim-upbit"></dl>
                </div>            
            </div>
        </div>
        <div class="layui-inline layui-form-item">
            <button id="inquire" class="layui-btn" lay-submit lay-filter="inquire" style="margin-top: -5px;">查询</button>
        </div>
    </form>
    <div class=""></div>
    <table id="logTable" class="layui-table layui-fluid" lay-size="sm">
        <thead class="layui-bg-gray">
            <tr class="">
                <th >序号</th>
                <th >ID</th>
                <th >文件名</th>
                <th >文件类型</th>
                <th >文件路径</th>
                <th >上传时间</th>
                <th >操作</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <div>
        <span id="layPage"></span>
    </div>
    <!-- 删除提示 -->
    <div class="modal fade bs-example-modal-sm" id="dele-file" tabindex="-1" role="dialog" aria-labelledby="deleInfo">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">删除文件</h4>
                </div>
                <div class="modal-body">
                    <p>确定要删除该文件吗？</p>
                    <div class="text-right">
                        <span id="returnMessage" class="glyphicon"> </span>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button id="deleBtn" type="button" class="btn btn-danger">删除</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <script src="${pageContext.request.contextPath}/base/lay/lay/modules/layer.js"></script>
     <script type="text/javascript">
         layer.load();
     </script>
    <script type="text/javascript" src="js/file.js"></script>
</body>
</html>