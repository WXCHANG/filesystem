<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% request.getSession().setMaxInactiveInterval(1800); %>
<%-- <!-- <%
    if (session.getAttribute("manager") == null) {
        response.setHeader("refresh", "0;URL=/openPlatform/admin/login.jsp");
        return;
    }
%>
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
    
    <title>可信区块链BaaS平台</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is Background home page">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
	<link rel="stylesheet" href="css/index.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
	<!-- <script type="text/javascript" src="js/iframeUrl.js"></script> -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/index.js"></script>
    <style>
    .layui-bg-black, .layui-nav{
        background-color: #001529;
    }
    .layui-nav-itemed .layui-nav-child{
        background-color: #000c17;
    }
    .layui-nav-itemed .layui-nav-child dd a{
        padding-left: 20px;
    }
    td{
        word-wrap:break-word;
    }
    /*.layui-nav-tree .layui-nav-child dd.layui-this, 
    .layui-nav-tree .layui-nav-child dd.layui-this a,
    .layui-nav-tree .layui-this>a, 
    .layui-nav-tree .layui-this>a:hover {
        background-color: #4381af;

    }*/
    .layui-header{
		height: 75px;
	}
	.title-text{
		height: 75px;
	}
    </style>
  </head>
  
  <body>
	<div class="layui-layout layui-layout-admin">
		<header class="layui-header header">
			<div class="title-banner">
				  <!-- <img src="images/banner/logo.png" class="logo title-logo1" alt=""> -->
                <div class="title-text">
                    <span class="title-ch">文件管理系统</span>
                </div>
                <span style="margin-left: 25px;color: #6FB1FC;font-size: 20px;"></span>
                <!-- <img src="images/banner/blockChain1.png" class="logo title-logo2" alt="">   -->       
            </div>
			<div>
				<ul class="layui-nav layui-layout-right">
                    <li class="layui-nav-item">
                        <a href="javascript:;">
                            <img src="images/logo.jpg" class="layui-nav-img">
                            
                            <span id="user">${admin.name }</span>                            
                            <!-- <span class="layui-nav-more"></span> -->
                        </a>
                       <!--  <dl class="layui-nav-child layui-anim layui-anim-upbit">
                            <dd><a href="javascript:;" id="change-pwd" data-toggle="modal" data-target="#changePwd">修改密码</a></dd>                          
                            <dd><a href="/openPlatform/admin/index.jsp">管理中心</a></dd>
                            
                        </dl> -->
                    </li>
	      			<li id="loginOut" class="layui-nav-item"><a href="loginOut.do">退出登录</a></li>
      			</ul>
			</div>
		</header>
		<main>
			<nav class="layui-side layui-bg-black">
				<div class="layui-side-scroll" id="admin-navbar-side" lay-filter='sdie'>
			      	<!-- 左侧导航区域-->
			      	<ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
				        <li id="home" class="layui-nav-item layui-nav-itemed">
				          	<a class="" href="javascript:;">
				          		<i class="layui-icon">&#xe68e;</i>区块链平台概况
				          	</a>
				          	<dl class="layui-nav-child">
					            <dd id="homepage" class="layui-this">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>业务概览</a>
					            </dd>
				          	</dl>
				        </li>
			      	</ul>
			      	<!-- <ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
				        <li id="form" class="layui-nav-item layui-nav-itemed">
				          	<a href="javascript:;">
				          		<i class="layui-icon">&#xe61f;</i>数据信息录入
				          	</a>
				          	<dl class="layui-nav-child">
					            <dd id="entry">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>信息录入</a>
					            </dd>
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
                                <dd id="table4">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>溯源数据详情</a>
                                </dd>
                                <dd id="table5">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>信息区块查询</a>
                                </dd>
				          	</dl>
				        </li>
			      	</ul>
			      	<ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
				        <li id="channel" class="layui-nav-item layui-nav-itemed">
				          	<a href="javascript:;">
				          		<i class="layui-icon">&#xe653;</i>区块通道管理
				          	</a>
				          	<dl class="layui-nav-child">
					            <dd id="channel1">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>区块通道创建</a>
					            </dd>
				          	</dl>
				          	<dl class="layui-nav-child">
					            <dd id="channel2">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>通道信息管理</a>
					            </dd>
				          	</dl>
				        </li>
			      	</ul>
                    <ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
                        <li id="node" class="layui-nav-item layui-nav-itemed">
                            <a class="" href="javascript:;">
                                <i class="layui-icon">&#xe637;</i>区块链节点管理
                            </a>
                            <dl class="layui-nav-child">
                                <dd id="node2">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>区块节点管理</a>
                                </dd>
                            </dl>
                        </li>
                    </ul> -->
                      <ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
                        <li id="organization" class="layui-nav-item layui-nav-itemed">
                            <a class="" href="javascript:;">
                                <i class="layui-icon">&#xe653;</i>域管理
                            </a>
                             <dl class="layui-nav-child">
								 <dd id="organization2">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>域创建</a>
                                </dd>
                                <dd id="organization1">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>域信息</a>
                                </dd>
                            </dl>
                        </li>
                    </ul>
                    <ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
				        <li id="channel" class="layui-nav-item layui-nav-itemed">
				          	<a href="javascript:;">
				          		<i class="layui-icon">&#xe637;</i>通道管理
				          	</a>
				          	<dl class="layui-nav-child">
					            <dd id="channel1">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>通道创建</a>
					            </dd>
				          	</dl>
				          	<dl class="layui-nav-child">
					            <dd id="channel2">
					            	<a href="javascript:;"><i class="layui-icon">&#xe623;</i>通道信息</a>
					            </dd>
				          	</dl>
				        </li>
			      	</ul>
			      	<ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
                        <li id="examine" class="layui-nav-item layui-nav-itemed">
                            <a class="" href="javascript:;">
                                <i class="layui-icon">&#xe63c;</i>审核管理
                            </a>
                            <dl class="layui-nav-child">

                                <dd id="examine1">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>待审核用户</a>
                                </dd>


							<dd id="examine2">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>已审核用户</a>
                                </dd>
                                
                            </dl>
                        </li>
                    </ul>
			      	<ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
                        <li id="chaincode" class="layui-nav-item layui-nav-itemed">
                            <a class="" href="javascript:;">
                                <i class="layui-icon">&#xe628;</i>链码管理
                            </a>
                            <dl class="layui-nav-child">
                                <dd id="chaincode1">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>链码信息</a>
                                </dd>
                            </dl>
                        </li>
                    </ul>
                   <!--  <ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
                        <li id="node" class="layui-nav-item layui-nav-itemed">
                            <a class="" href="javascript:;">
                                <i class="layui-icon">&#xe857;</i>区块链节点管理
                            </a>
                            <dl class="layui-nav-child">
                                <dd id="node2">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>区块节点管理</a>
                                </dd>
                            </dl>
                        </li>
                      </ul> -->
			      	<!-- <ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
                        <li id="channelUser" class="layui-nav-item layui-nav-itemed">
                            <a class="" href="javascript:;">
                                <i class="layui-icon">&#xe770;</i>用户管理
                            </a>
                            <dl class="layui-nav-child">

                                <dd id="channelUser1">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>用户管理</a>
                                </dd>


							<dd id="channelUser2">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>用户创建</a>
                                </dd>
                                
                            </dl>
                        </li>
                    </ul> -->
                    <!-- <ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
                        <li id="system" class="layui-nav-item layui-nav-itemed">
                            <a class="" href="javascript:;">
                                <i class="layui-icon">&#xe770;</i>域用户管理
                            </a>
                            <dl class="layui-nav-child">
                                <dd id="system5">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>域用户信息管理</a>
                                </dd>
                            </dl>
                            <dl class="layui-nav-child">
                                <dd id="system6">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>域用户创建</a>
                                </dd>
                            </dl>
                            
                        </li>
                    </ul> -->
                  	 <ul class="layui-nav layui-nav-tree beg-navbar">
	                        <li id="customize" class="layui-nav-item layui-nav-itemed">
	                            <a class="" href="javascript:;">
	                                <i class="layui-icon">&#xe620;</i>自定义设置
	                            </a>
	                            <dl class="layui-nav-child">
	                                <dd id="logo">
	                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>显示设置</a>
	                                <!-- </dd> -->
	                                <dd id="fields">
	                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>字段设置</a>
	                                </dd>
	                                <dd id="version">
	                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>版本切换</a>
	                                </dd>
	                                <!-- <dd id="change_skin">
	                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>更换皮肤</a>
	                                </dd> -->
	                            </dl>
	                        </li>
	                    </ul>
                     <ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
                        <li id="admin" class="layui-nav-item layui-nav-itemed">
                            <a class="" href="javascript:;">
                                <i class="layui-icon">&#xe60a;</i>系统管理
                            </a>
                            <dl class="layui-nav-child">
                                <dd id="admin2">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>账号管理</a>
                                </dd>
                            </dl>
                             <dl class="layui-nav-child">
                                <dd id="admin1">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>修改信息</a>
                                </dd>
                            </dl>
                        </li>
                    </ul>
                    <!--  <ul class="layui-nav layui-nav-tree beg-navbar"  lay-filter="test">
                        <li id="channelUser" class="layui-nav-item layui-nav-itemed">
                            <a class="" href="javascript:;">
                                <i class="layui-icon">&#xe770;</i>用户管理
                            </a>
                            <dl class="layui-nav-child">

                                <dd id="channelUser1">
                                    <a href="javascript:;"><i class="layui-icon">&#xe623;</i>用户管理</a>
                                </dd>

                            </dl>
                        </li>
                    </ul> -->
			    </div>
			</nav>
			<div class="layui-body" id="admin-body">
				<div class="layui-tab admin-nav-card layui-tab-brief" lay-filter="admin-tab">
					<div class="layui-tab-content">
						<div class="video">
							<div class="iframe-title"></div>
							<iframe src="home/homepage.jsp"></iframe>
						</div>						
					</div>
				</div>
			</div>
		</main>	
        <div class="layui-footer footer footer-demo">
            <div class="layui-main">
                <p>用户单位：<a href="/">深圳大通实业股份有限公司</a></p>
                
            </div>
        </div>	
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
