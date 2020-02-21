<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    
    <title>业务数据查询</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">    
    <meta http-equiv="keywords" content="log">
    <meta http-equiv="description" content="operation log">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/publicStyle.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
    <!--[if lt IE9]> 
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <style>
    .layui-form-radio{
        height: 50px;
        line-height: 50px; 
        margin: 0;
        padding: 0;
    }
    .layui-form-label{
        margin-bottom: 0;
    }
    .search-code{
    	width: 300px;
    }
    .condition{
   	    height: 50px;
	    display: flex;
	    flex-flow: column;
	    justify-content: center;
	    width: 420px;
    }
    .condition .layui-input-inline{
    	width: 295px;   	
    }
    input{
    	text-overflow: ellipsis;
    }
    </style>
     <script>
	     $(function () {
	    	var userId=<%=session.getAttribute("userId")%>; 
	   		if(userId==null){
	   			alert("用户登录超时，请重新登录")
	   			window.parent.location.href='userLogin.jsp';
	   		} 
	    })
    </script>
</head>
<body>
    <div class="ant-card-head header-box">
        <div class="ant-card-head-wrapper col-sm-2 paddingNone">
            <div class="ant-card-head-title">业务数据查询</div>
        </div>
        
        <div class="bv-form layui-form paddingNone search-code">           
            <label for="" class="col-sm-3 paddingNone" style="height: 50px;line-height: 50px;margin: 0">查询范围:</label>
            <div class="layui-input-inline col-sm-9 paddingNone">
                <label for="" class="layui-form-label col-xs-6 paddingNone">
                    <input class="" type="radio" name="peerType" value="1" title="当前节点" lay-filter="peer" checked>
                    	当前节点
                </label>
                <label for="" class="layui-form-label col-xs-6 paddingNone">
                    <input class="" type="radio" name="peerType" value="2" title="全部节点" lay-filter="peer">
                   	 全部节点
                </label>
            </div>
        </div>
        <div class="condition">
	        <form class="bv-form">
	            <div class="from-group ">
	                <label class="control-label" style="text-align: center;">查询条件</label>
	                <div class="layui-input-inline">
	                    <input id="hashInfo" type="text" class="form-control" placeholder="请输入需要查询区块Hash值">
	                </div>
	                <button type="button" id="searchBtn" class="btn btn-primary">查询</button>
	            </div>
	        </form>
	    </div>
    </div>
	    
    <div class="content-box">
        <table id="dataList" class="layui-table layui-fluid scroll" lay-size="sm" lay-filter="details" lay-data="{id: 'dataList'}"></table>   
    </div>
<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/html" id="btn-group">
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="details">详情</a>
</script>
<script>
layui.config({
    base: '/base/layui/modules/'
}).use(['element','form','layer','laypage','table','laydate'], function() {
    var element = layui.element;
    var table = layui.table;
    var layer = layui.layer;
    var laypage = layui.laypage;
    var form = layui.form;

    $("#searchBtn").click(function () {
        let tableInfoUrl = '';
        const peerType = $("input[name=peerType]:checked").val();
        if ( peerType == "1" ) {
            tableInfoUrl = "queryDefaultPeerDataInfo.do";
        } else if ( peerType == "2" ) {
            tableInfoUrl = "queryPeerDataInfo.do";
        }

        table.render({
            elem: '#dataList',
            height: 'full-100',
            cellMinWidth: 80,
            url: tableInfoUrl,
            where: {
                hash: $("#hashInfo").val()
            },
            page: false,//开启分页
            cols: [[ //表头
                // {title: '序号', templet: '#indexTpl', width: '10%',},
                {title: '区块高度', field: 'number', width: '12%'},
                {title: '所属节点', field: 'peer', width: '20%'},
                {title: '区块hash值', field: 'currentHash', width: '20%'},
                {title: '区块父hash值', field: 'previousHash',width: '20%'},
                {title: '区块data_hash值', field: 'dataHash',width: '20%'}, 
                {title: '操作', field: '', toolbar : '#btn-group', width: '8%'},
            ]]
        });

        form.on('radio(peer)', function(data){
            // console.log(data.elem); //得到radio原始DOM对象
            // console.log(data.value); //被点击的radio的value值
            let tableInfoUrl = '';
            switch (data.value) {
                case "1": 
                    tableInfoUrl = "queryDefaultPeerDataInfo.do";
                    break;
                case "2":
                    tableInfoUrl = "queryPeerDataInfo.do";
                    break;
                default:
                    return;
            }
            table.reload('dataList', {
                url: tableInfoUrl,
                where: {
                    hash: $("#hashInfo").val()
                }
            });
        });  
    })




    //监听工具条
    table.on('tool(details)', function(obj){ //
        let data = obj.data, //获得当前行数据
        layEvent = obj.event; //获得 lay-event 对应的值

        if(layEvent === 'details'){
            window.location.href='queryBlockByNumber.do?number='+data.number;
        }
    });
})
</script>
</body>
</html>
