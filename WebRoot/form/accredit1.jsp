<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/base/layui/css/layui.css">
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/accredit1.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
    <script type="text/javascript"
	src="${pageContext.request.contextPath}/base/layui/layui.js"></script>
    <style>
    table tr,th{
       text-align: center !important; 
    }   
    #layPage{
        width: 500px;
        height: 50px;
        margin: 0 auto;
        display: flex;
        display: -webkit-box; /* OLD - iOS 6-, Safari 3.1-6 */ 
        display: -moz-box; /* OLD - Firefox 19- (buggy but mostly works) */ 
        display: -ms-flexbox; /* TWEENER - IE 10 */ 
        display: -webkit-flex; /* NEW - Chrome */ 
        flex-direction: row;
        justify-content: center;
    }
    
    .push{
		height: 60px;
       	width: 80%;
     	text-align: center;
  	    position: absolute;
    	bottom: 0;
	}
    </style>
</head>
<body>
  
     <div id="header">
        <p>CPSec文件列表</p>
    </div>

    <table id="userTable" class="layui-table layui-fluid" lay-size="sm">
        <thead class="layui-bg-gray">
            <tr class="">
                <th style="width:30px;">序号</th>
                <th>文件ID</th>
                <th>文件标识</th>
                <th>文件名</th>
                <th>媒体格式</th>
                <th>加密算法</th>
                <th>加密速率</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
  
    <div class="push">
        <span id="layPage"></span>
    </div>

</body>
<script type="text/javascript">
    var sum = 0;    // 数据条数
    var code = 0;   // 状态
    var num = sessionStorage.getItem("pageNum-file");   // 获取之前页面ID
    var inquire = false;  


    layui.config({
        base: '/base/lay/modules/'
    }).use(['element','form','layer','laypage','table'], function() {
        var element = layui.element;
        var table = layui.table;
        var layer = layui.layer;
        var laypage = layui.laypage;
        var form = layui.form;

        

        if ( num == null ) {
            num = 1;
        } 
        getInfo(num);

         
    });

/***

查询所有文件
n: 页数；

***/
function getInfo(n) { 
    sessionStorage.setItem("pageNum-file", n);  

    $.ajax({
        url: "../listAll.do",
        type: "post",
        datatype: "json",
        data: {
            "pagenum": n
        },
        async: false,  
        cache: false,  
        complete: function () {
            
        },
        success: function(data){
            if (data.flag == "success") {
                var list = data.Data;
                sum = data.countmessage;
                $("tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var a = i+1+(n-1)*10;   // 序号
                    $("tbody").append(
                        '<tr id="'+list[i].id+'">'+
                            '<td >'+a+'</td>'+
                            '<td data-field="id" >'+list[i].id+'</td>'+
                            '<td data-field="target" >'+list[i].target+'</td>'+
                            '<td data-field="name">'+list[i].name+'</td>'+
                            '<td data-field="type">'+list[i].type+'</td>'+
                            '<td data-field="algorithm">'+list[i].algorithm+'</td>'+  
                            '<td data-field="speed">'+list[i].speed+'</td>'+   
                            '<td data-field='+list[i].id+'>'+
                                '<button class="btn-dele layui-btn layui-btn-primary layui-btn-small"><a href="'+list[i].path+'" download="'+list[i].path+'">下载</a></button>'+
                                // '<button data-whatever="'+list[i].address+'" class="btn-dele layui-btn layui-btn-danger layui-btn-small"  data-toggle="modal" data-target="#dele-file">删除</button>'+
                            '</td>'+               
                        '</tr>'
                    )
                }
            }
            
        },
        error:function(){
            alert("请求失败！请检查您的网络环境！")
            // code = 1;
        }
    })  

    //分页
    layui.use('laypage', function(){
        var laypage = layui.laypage;      
        laypage.render({
            elem: 'layPage'     //分页容器的id
            ,layout: ['prev', 'page', 'next','limits','count']  //排版
            ,limit: 10      //每页显示数 
            ,limits: [10, 20, 30, 40, 50]   //条数选择项
            // ,curr: curr || 1 //获取起始页
            ,groups: 3      //连续出现的页数
            ,count: sum     //总条数
            ,curr: n      //当前页
            ,theme: '#1E9FFF'   //自定义选中色值
            ,skip: false    //开启跳页        
        });
    });

    // 点击切换分页；
    function onclick() {
        $("#layPage a").on("click",function () {
            var n = $(this).attr("data-page");
            if ( inquire == false ) {
                getInfo(n)
            } 
            onclick()
        })
    }
    onclick();
}

</script>
</html>