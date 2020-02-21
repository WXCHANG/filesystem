<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% request.getSession().setMaxInactiveInterval(1800); %>

<%
    if (session.getAttribute("channelUser") == null) {
        response.setHeader("refresh", "0;URL=userLogin.jsp");
        return;
    }
%>

<%-- <!-- 
<%
    if((Integer)session.getAttribute("permission") != 1){
        response.setHeader("refresh", "0;URL=/openPlatform/admin/login.jsp");
        return;
    }
%> --> --%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>基于区块链的可信数据管理平台</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is Background home page">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
	<link rel="stylesheet" href="css/index.css">
	<!-- <link rel="stylesheet" href="css/skin.css"> -->
	<link rel="stylesheet" href="css/skin_2.css" id="cssfile">
	<!-- <link rel="stylesheet" href="css/skin_0.css" id="cssfile"> -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
	<!-- <script type="text/javascript" src="js/iframeUrl.js"></script> -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/index.js"></script>
	<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/skin.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-cookie/jquery.cookie.js"></script> --%>
	<style type="text/css">
	body{
		min-width: 1200px;
	}
	#admin-body{
		min-width: 1000px;
	}
	iframe{
		width: 100%;
	}
	.layui-tab-content{
		height: 100%;
	    padding-bottom: 50px;
    	box-sizing: border-box;
	}
	.layui-layout-admin .layui-side{
		top: 75px;
	}
	.title-banner #logo1{
		margin-left: -200px;
	}
	</style>

  </head>
  <body>
	<div class="layui-layout layui-layout-admin">
		
		<header class="layui-header header">
			<div class="title-banner">
                <div class="title-text">
                    <span class="title-ch">基于区块链的可信数据管理平台</span>
                </div>
              <span style="margin-left: 25px;color: #fff;font-size: 25px;"></span>       
            </div>
			<div>
			   
				<ul class="layui-nav layui-layout-right">
					<li id="auditstatus" class="layui-nav-item" style="font-size:16px">${auditstatus}</a></li>
                    <li class="layui-nav-item">
                        <a href="javascript:;">
                            <img src="images/logo.jpg" class="layui-nav-img">
                            
                            <span id="user"> ${channelUser.username} </span>                            
                           <!--  <span class="layui-nav-more"></span> -->
                        </a>
                      <!--   <dl class="layui-nav-child layui-anim layui-anim-upbit">
                            <dd><a href="javascript:;" id="change-pwd" data-toggle="modal" data-target="#changePwd">修改密码</a></dd>                          
                            <dd><a href="/openPlatform/admin/index.jsp">管理中心</a></dd>
                            
                        </dl> -->
                    </li>
                   
	      			<li id="loginOut" class="layui-nav-item"><a href="userLoginOut.do">退出登录</a></li>
      			</ul>
			</div>
		</header>
		<main>
			<nav class="layui-side layui-bg-black">
				<div class="layui-side-scroll" id="admin-navbar-side" lay-filter='sdie'>
			      		<!-- 左侧导航区域-->
			      	<ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
				        <li id="trace" class="layui-nav-item layui-nav-itemed">
				          	<a class="" href="javascript:;">
				          		<i class="layui-icon">&#xe637;</i>文件展示
				          	</a>
				          	<dl class="layui-nav-child">
					            <dd id="transaction">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>图片文件</a>
					            </dd>
					            <dd id="video">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>视频文件</a>
					            </dd>
					             
                            </dl>
				        </li>
			      	</ul>
			      	<ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
				        <li id="form" class="layui-nav-item layui-nav-itemed">
				          	<a href="javascript:;">
				          		<i class="layui-icon">&#xe61f;</i>数据信息录入
				          	</a>
				          	<dl class="layui-nav-child">
					              <dd id="encrypt_entry">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>业务数据录入</a>
					            </dd>
					            <!--  <dd id="accredit">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>版权链信息录入</a>
					            </dd> -->
				          	</dl>
				          	<dl class="layui-nav-child">
					            <!--  <dd id="accredit1">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>版权链文件列表</a>
					            </dd> -->
				          	</dl>
				          	<dl class="layui-nav-child">
					            <!--  <dd id="credential1">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>版权链证书申请</a>
					            </dd> -->
				          	</dl>
				        </li>
			      	</ul>
			      		
			      	<ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
				        <li id="management" class="layui-nav-item layui-nav-itemed">
				          	<a class="" href="javascript:;">
				          		<i class="layui-icon">&#xe60a;</i>数据信息管理
				          	</a>
				          	<dl class="layui-nav-child">
					            <dd id="table1">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>待存任务列表</a>
					            </dd>
                                <dd id="table2">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>已存数据列表</a>
                                </dd>
                                <dd id="table3">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>区块信息列表</a>
                                </dd>
                                <dd id="dataSearch">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>区块信息查询</a>
                                </dd>
                               <!--  <dd id="table4">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>区块数据详情</a>
                                </dd> -->
                                <dd id="table5">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>业务区块查询</a>
                                </dd>
				          	</dl>
				        </li>
			      	</ul>
					<!-- <ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
				        <li id="task" class="layui-nav-item layui-nav-itemed">
				          	<a href="javascript:;">
				          		<i class="layui-icon">&#xe653;</i>状态监测
				          	</a>
				          	<dl class="layui-nav-child">
					            <dd id="task1">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>任务管理</a>
					            </dd>
				          	</dl>
				          	<dl class="layui-nav-child">
					            <dd id="task2">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>连通性测试</a>
					            </dd>
				          	</dl>
				        </li>
			      	</ul> -->
			       	<ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
				        <li id="channelUser" class="layui-nav-item layui-nav-itemed">
				          	<a class="" href="javascript:;">
				          		<i class="layui-icon">&#xe770;</i>用户信息管理
				          	</a>
				          	<dl class="layui-nav-child">
					            <dd id="changePwd">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>修改用户信息</a>
					            </dd>
				        </li>
			      	</ul>
			      	<ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
				        <li id="SystemSet" class="layui-nav-item layui-nav-itemed">
                            <a href="javascript:;">
                                <i class="layui-icon">&#xe637;</i>系统管理及配置
                            </a>
                            <dl class="layui-nav-child">
                                <dd id="account">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>用户账号管理</a>
                                </dd>
                            </dl>
                             <dl class="layui-nav-child">
                                <dd id="licences">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>视频权限管理</a>
                                </dd>
                            </dl>
                            <dl class="layui-nav-child">
                                <dd id="changePwd">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>系统配置管理</a>
                                </dd>
                            </dl>
                        </li>
                    </ul> 
			      	
			    </div>
			</nav>
			<div class="layui-body" id="admin-body">
				<div class="">
					<div class="layui-tab-content">
						<div class="video">
							<div class="iframe-title"></div>
							<iframe src="overall/panorama.jsp"></iframe>
						</div>						
					</div>
				</div>
			</div>
		</main>	
        <%--<div class="layui-footer footer footer-demo">--%>
            <%--<div class="layui-main">--%>
                <%--<p>开发单位：北京邮电大学区块链实验室</p>--%>
                <%----%>
            <%--</div>--%>
        <%--</div>	--%>
	</div>
	<script>
	layui.config({
	    base: '/base/layui/modules/'
	}).use(['element','form','layer','laypage','table'], function() {
  		var element = layui.element;
        var table = layui.table;
        var layer = layui.layer;
        var laypage = layui.laypage;

        //表格
        table.render({
        	elem: 'userTable',
        	
        })

		//分页
		laypage.render({
			elem: 'layPage' 	//分页容器的id
			,layout: ['prev', 'page', 'next','limits','count'] 	//排版
			,limit: 10 		//每页显示数 
			,limits: [10, 20, 30, 40, 50] 	//条数选择项
			/*,curr: location.hash.replace('#!fenye=', '') //获取起始页
  			,hash: '1' //自定义hash值*/
			,groups: 3 		//连续出现的页数
			,count: 130 	//总条数
			,theme: '#1E9FFF' 	//自定义选中色值
			,skip: true 	//开启跳页
			,jump: function(obj, first){
			  	// if(!first){
			   //  	layer.msg('第'+ obj.curr +'页');
			  	// }
			}
		});
	});
    
	</script>
</body>
</html>
