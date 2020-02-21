var sum = 0;    // 数据条数
var code = 0;   // 状态
var num = sessionStorage.getItem("pageNum-log");   // 获取页面ID(全部数据)
var searchNum = 0;  

layui.config({
    base: '/base/lay/modules/'
}).use(['element','form','layer','laypage','table'], function() {
    var element = layui.element;
    var table = layui.table;
    var layer = layui.layer;
    var laypage = layui.laypage;
    var form = layui.form;

    // 加载
    // $(".showbox").stop(true).animate({'margin-top':'300px','opacity':'1'},200);
    if ( num == null ) {
        num = 1;
    } 
    getInfo(num);

    //  监听，propertychange——IE；
    $('.layui-form input').bind('input propertychange', function() { 

        if ( $("#startTime").val().length > 0   &&   $("#endTime").val().length > 0   &&   $("#user").length > 0) {           
            $("#search").removeClass("layui-btn-disabled")
        }
    })

    form.on('submit(search)', function(data){
        var startTime = $("#startTime").val(),
            endTime = $("#endTime").val(),
            user = $("#user").val();
        
        if ( startTime.length > 0   &&   endTime.length > 0   &&   user.length > 0) {           
            searchInfo(user,startTime,endTime,1);       
            searchNum = 1;
        } else {
            return false;
        }
        return false;
    })
});

/***

查询所有日志
n: 页数；

***/
function getInfo(n) { 
    sessionStorage.setItem("pageNum-log", n);   
    
    $.ajax({
        url: "/openPlatform/manager/selectDiary.do",
        type: "post",
        data: {
            "pagenum": n
        },
        dataType:"json",
        async: false,  
        cache: false,  
        complete: function () {
          // 关闭loading
          // $(".showbox").stop(true).animate({'margin-top':'250px','opacity':'0'},400);
        },
        success: function(data){
            if (data.code == "0") {
                var list = data.data;
                sum = data.count;

                $("tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var a = i+1+(n-1)*10;
                    $("tbody").append(
                        '<tr id="'+list[i].diaryid+'">'+
                            '<td>'+a+'</td>'+
                            '<td data-field="diaryid">'+list[i].diaryid+'</td>'+
                            '<td data-field="username">'+list[i].username+'</td>'+
                            '<td data-field="time">'+list[i].time+'</td>'+
                            '<td data-field="event">'+list[i].event+'</td>'+                     
                        '</tr>'
                    )
                }
            }
        },
        error:function(){
            alert("请求失败！请检查您的网络环境！")
            code = 1;
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
            ,curr: n     //当前页
            ,theme: '#1E9FFF'   //自定义选中色值
            ,skip: false    //开启跳页       
        });
    });
    // 点击切换分页；
    function onclick(){
        $("#layPage a").on("click",function () {
            var n = $(this).attr("data-page");
            if ( searchNum == 0 ) {
                getInfo(n);
            } else {
                searchInfo(user,startTime,endTime,n);
            }
           
            onclick();
        })        
    }
    onclick()
    
}

/***

条件查询日志
user: 账号；
time1: 开始时间；
time2: 结束时间；
n: 页数；

***/
function searchInfo(user,time1,time2,n) { 
    $.ajax({
        url: "/openPlatform/manager/selectDiary.do",
        type: "post",
        datatype: "json",
        data: {
            "name": user,
            "time1": time1,
            "time2": time2,
            "pagenum": n,
        },
        async: false,
        complete: function () {
          // 关闭loading
          // $(".showbox").stop(true).animate({'margin-top':'250px','opacity':'0'},400);
        },
        success: function(data){
            if (data.code == "0") {
                var list = data.data;
                sum = data.count;

                $("tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var a = i+1+(n-1)*10;
                    $("tbody").append(
                        '<tr id="'+list[i].diaryid+'">'+
                            '<td>'+a+'</td>'+
                            '<td data-field="diaryid">'+list[i].diaryid+'</td>'+
                            '<td data-field="username">'+list[i].username+'</td>'+
                            '<td data-field="time">'+list[i].time+'</td>'+
                            '<td data-field="event">'+list[i].event+'</td>'+                     
                        '</tr>'
                    )
                }
            }
        },
            error:function(){
                alert("请求失败！请检查您的网络环境！")
                code = 1;
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
            ,curr: n     //当前页
            ,theme: '#1E9FFF'   //自定义选中色值
            ,skip: false    //开启跳页       
        });
    });

    // 点击切换分页；
    function onclick(){
        $("#layPage a").on("click",function () {
            var n = $(this).attr("data-page");

            if ( searchNum == 0 ) {
                getInfo(n);
            } else {
                searchInfo(user,time1,time2,n);
            }
            onclick();
        })        
    }
    onclick()
}