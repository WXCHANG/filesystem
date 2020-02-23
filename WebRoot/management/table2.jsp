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
    <style>
    body{
    	width: 100%;
    	overflow: hidden;
    }
    </style>
     <script>
	     $(function () {
	    	var userId=<%=session.getAttribute("userId")%>; 
	   		if(userId==null){
	   			alert("用户登录超时，请重新登录")
	   			//window.parent.location.href='userLogin.jsp';
	   		} 
	    })
    </script>	
</head>
  
<body>

    <div class="ant-card-head">
        <div class="ant-card-head-wrapper">
            <div class="ant-card-head-title">已存数据列表</div>
        </div>
    </div>
    <div class="text-body">
        <table id="summary" class="layui-table layui-fluid scroll" lay-size="sm" lay-filter="test"></table>   
    </div>
<script type="text/html" id="btn-group">
    <a class="layui-btn layui-btn" lay-event="detail">详情</a>
</script>
<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script>
$(".layui-nav-tree dd",window.parent.document).removeClass("layui-this");
$("#table2",window.parent.document).addClass("layui-this")
layui.use('table', function(){
    var table = layui.table;
    // table实例化
    table.render({
        elem: '#summary'
        ,height: 'full-100'
        ,url: 'getBlockOrigins.do' //数据接口
        //,data: data
        ,page: true //开启分页
        ,cols: [[ //表头
            {title: '序号', templet: '#indexTpl', width: 80, fixed: 'left', type: 'numbers'}
            // {field: 'id', title: 'ID', width:80, sort: true,}
            ,{field: 'name', title: '文件名称',}
            ,{field: 'area', title: '作者名称'}
            ,{field: 'identifier', title: '文件大小'}
            ,{field: 'quality', title: '文件来源'}
            ,{field: 'storagetime', title: '提交时间', width:180} 
            ,{field: 'savetime', title: '存入区块时间'}
            ,{field: 'status', title: '存入状态'}
//             ,{field: 'examine', title: '产品审核', width: 150}
            ,{field: 'hash', title: '数据Hash（系统自动生成）'}
            ,{field: '123',title: '操作', width: 80,toolbar: '#btn-group', fixed: 'right'}
        ]]
	    ,done: function(res, curr, count){
	        //分类显示中文名称  
	        $("[data-field='status']").children().each(function(){  
	            if($(this).text()==1){
	            	$(this).text("已存入").css("color", "green"); 
                    // 当容器宽度不足时，定位在右侧的操作按钮
                    let _index = $(this).parents("tr").attr("data-index");
                    let _thisParent = $(this).parents(".layui-table-body").siblings($(".layui-table-fixed-r"))
                    let btn = _thisParent.find($("[data-index='" + _index + "'] a"))

                    // 当容器宽度足够时的操作按钮
                    let btn2 = $(this).parents("td").siblings("td[data-field='123']").find("a")

                    // btn为需要修改状态的按钮
                    btn.attr("disable",true)
                    btn2.attr("disable",true)
	            }else if($(this).text()==2){
            	    $(this).text("存入中").css("color", "orange");
            	   // 当容器宽度不足时，定位在右侧的操作按钮
                    let _index = $(this).parents("tr").attr("data-index");
                    let _thisParent = $(this).parents(".layui-table-body").siblings($(".layui-table-fixed-r"))
                    let btn = _thisParent.find($("[data-index='" + _index + "'] a"))

                    // 当容器宽度足够时的操作按钮
                    let btn2 = $(this).parents("td").siblings("td[data-field='123']").find("a")

                    // btn为需要修改状态的按钮
                    btn.attr("disable",false)
                    btn2.attr("disable",false)
	            }
	        })
	    }
    });
    //监听工具条
    table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
        var data = obj.data //获得当前行数据
        ,layEvent = obj.event; //获得 lay-event 对应的值
        if(layEvent === 'detail'){
        	window.location.href='showQrcode.do?id='+data.id
        } 
    });
});

</script> 
</body>
</html>
