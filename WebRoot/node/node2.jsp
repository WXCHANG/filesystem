<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    
    <title>Document</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">    
    <meta http-equiv="keywords" content="log">
    <meta http-equiv="description" content="operation log">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/bootstrap/js/bootstrapValidator.js"></script>
    <!--[if lt IE9]> 
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
</head>
  
<body>
    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">区块节点管理</div>
        </div>
    </div>
    <div class="text-body">
        <table id="summary" class="layui-table layui-fluid scroll" lay-size="sm" lay-filter="test"></table>   
    </div>
<script type="text/html" id="btn-group">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="start">启动系统</a>
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="stop">停止系统</a>
</script>
<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script>
layui.use('table', function(){
    var table = layui.table;
    // table实例化
    var tableInfo = table.render({
        elem: '#summary'
        ,height: 'full-120'
        ,data: data
//         ,url: 'getPeerList.do'
        ,page: false//开启分页
        ,cols: [[ //表头
            {title: '序号', templet: '#indexTpl', width: "5%",},
            {title: '节点IP', width: '', field: 'peerIP',width: "30%",},
            {title: '活跃状态', field: 'status', width: '20%',id:'status'},
            /*{title: '带宽', field: 'bandWidth',width: 100},
            {title: '内存', field: 'ram',width: 100}, */
            {field: '',title: '操作', width: '45%',toolbar: '#btn-group', fixed: 'right'},
            {title: '容器名称', width: '', field: 'containerName',}
        ]],
        done: function(res, curr, count){
        	$("[data-field='containerName']").css('display','none');
        	//分类显示中文名称  
            $("[data-field='status']").children().each(function(){  

                if($(this).text()=='0'){  
                   $(this).text("已停止").css("color", "red") 
                }else if($(this).text()=='1'){  
                   $(this).text("已启动").css("color", "green")  
                } 
            }) 
            
            
        }
    });
    
    
    //监听工具条
    table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
        var data = obj.data //获得当前行数据
        ,layEvent = obj.event; //获得 lay-event 对应的值
        if(layEvent === 'start'){
            layer.confirm('确定启动系统吗？', function(index){
            	
	            layer.close(index);
	          //向服务端发送删除指令
	            $.ajax({
// 	       	        url:"startContainer.do",
	       	        type:"POST",
	       	        dataType:"json",
	       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
	       	        data:{
	       	        	peerIP:data.peerIP,
	       	        	containerName:data.containerName
	       	        },
	       	        success:function(data){
	       	        	if(data.code==1){
	       	        		tableInfo.reload({
       	           		        url: 'getPeerList.do',
       	           		        where: {}, //设定异步数据接口的额外参数
       	           		        
       	           		    });
	       	        	}else{
	       	        		alert("启动系统失败！");
	       	        	}
	       	        }
	   	    	});
            });
        } else if(layEvent === 'stop'){
        	layer.confirm('确定停止系统吗？', function(index){
                layer.close(index);
                $.ajax({
// 	       	        url:"stopContainer.do",
	       	        type:"POST",
	       	        dataType:"json",
	       	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
	       	        data:{
	       	        	peerIP:data.peerIP,
	       	        	containerName:data.containerName
	       	        },
	       	        success:function(data){
	       	        	if(data.code==1){
	       	        		clearInterval(int);
	       	        		tableInfo.reload({
       	           		        url: 'getPeerList.do',
       	           		        where: {}, //设定异步数据接口的额外参数
       	           		        
       	           		    })
	       	        	}else{
	       	        		alert("停止系统失败！");
	       	        	}
	       	        }
	   	    	});
            });
        }
        
        
    });
    
    
//     var int = setInterval(function () {
//     	tableInfo.reload({
// 	        url: 'getPeerList.do',
// 	        where: {}, //设定异步数据接口的额外参数
// 	    }) 
//     },10000);
    
});

const data = [{
    key: '1',
    peerIP: '101.132.101.109',
    status: '1',
}, {
	key: '2',
    peerIP: '39.107.244.87',
    status: '1',
}, {
    key: '3',
    peerIP: '139.196.140.49',
    status: '0',
}, {
    key: '4',
    peerIP: '47.93.40.96',
    status: '1',
}, {
    key: '5',
    peerIP: '39.105.29.136',
    status: '0',
}];
</script> 
</body>
</html>
