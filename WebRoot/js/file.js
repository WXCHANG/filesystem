var sum = 0;    // 数据条数
var code = 0;   // 状态
var num = sessionStorage.getItem("pageNum-file");   // 获取之前页面ID
var inquire = false;  
var url = getUrl();  // 获取服务器地址前缀

layui.config({
    base: '/base/lay/modules/'
}).use(['element','form','layer','laypage','table'], function() {
    var element = layui.element;
    var table = layui.table;
    var layer = layui.layer;
    var laypage = layui.laypage;
    var form = layui.form;

    // 加载
    layer.load();

    if ( num == null ) {
        num = 1;
    } 
    getInfo(num);

    var list = [];
    $.ajax({
        url: "/openPlatform/manager/selectpacnameandtype.do",
        async: false,
        success: function (data) {
            list = data.data;
            var d1 = $("#t1").siblings(".layui-unselect").find("dl");
            $("#t1").html('<option value="">全部</option>');
            d1.html('<dd lay-value="" class="layui-select-tips">全部</dd>');

            for (var i = 0; i < list.length; i++) {
                $("#t1").append('<option value="'+list[i].downloadId+'">'+list[i].downloadName+'</option>')
                d1.append('<dd lay-value="'+list[i].downloadId+'" class="">'+list[i].downloadName+'</dd>')
            }    
        },
        error: function () {
            layer.msg("文件位置列表获取失败，请刷新重试！")
        }
    })
    
    var d2 = $("#t2").siblings(".layui-unselect").find("dl");
  
    $('.t1 dd:not(".layui-select-tips")').bind("click",function () {   
        // 操作一级列表     
        var parent = $(this).parents('.layui-input-inline');
        var index = $(this).index();
        $(this).siblings().removeClass('layui-this');
        $(this).addClass('layui-this');
        parent.find('input').val($(this).text());
        $(".t2").find('input').val("");

        var list2 = list[index-1].k;    // 二级列表name
        var list3 = list[index-1].o;    // 二级列表id
        $("#t2").html('<option value="">全部</option>');
        d2.html('<dd lay-value="" class="layui-select-tips">全部</dd>');
        for (var i = 0; i < list2.length; i++) {
            $("#t2").append('<option value="'+list3[i]+'">'+list2[i]+'</option>')
            d2.append('<dd lay-value="'+list3[i]+'" class="">'+list2[i]+'</dd>')
        } 

        $('.t2 dd:not(".layui-select-tips")').bind("click",function () {          
            var parent = $(this).parents('.layui-input-inline');
            var index = $(this).index();
            $(this).siblings().removeClass('layui-this');
            $(this).addClass('layui-this');
            parent.find('input').val($(this).text());
        })   
    })


    form.on("select(title1)",function (data) {
        $("#t2").html('<option value="">全部</option>');
        d2.html('<dd lay-value="" class="layui-select-tips">全部</dd>');
    })

    form.on('submit(inquire)', function(data){          
        var fileType = $("#fileType").val(),
            t1 = $(".t1 dd.layui-this").attr('lay-value'),
            t2 = $(".t2 dd.layui-this").attr('lay-value');   
            console.log($("#t1").val())               
        inquireInfo(t1,t2,fileType,1);       
        inquire = true;            
        return false;
    });

});

$('#logTable').on('click', '.btn-dele',function () {
    $("#dele-file").one("show.bs.modal",function (event) {
        var button = $(event.relatedTarget);
        var path = button.data("whatever");
        var id = button.parent("td").attr("data-field")

        $("#deleBtn").unbind("click").on("click",function () {
            $(this).unbind("click")
            $(this).addClass("disabled");
            $.ajax({
                type: 'post',   
                url: '/openPlatform/manager/deleteFile.do',
                data: {
                    "lujing" : path,
                    "id": id,
                },
                async: false,   //同步，会阻塞操作
                complete: function (msg) {
                    $("#deleBtn").removeClass("disabled");
                    console.log('走完流程了');
                },
                success: function (data) {
                    if (data.flag == "success" ) {
                        layer.msg("删除成功！")
                        $("#dele-file").modal("hide");
                        window.location.reload();
                    } else {
                        $("#returnMessage").hide().html('<label class="label label-danger">删除失败!</label>').show(300);
                    }
                }, 
                error: function () {
                    $("#returnMessage").hide().html('<label class="label label-danger">删除失败!</label>').show(300);
                }
            })
        })
    })
})  

/***

查询所有文件
n: 页数；

***/
function getInfo(n) { 
    sessionStorage.setItem("pageNum-file", n); 
    layer.load();  

    $.ajax({
        url: "/openPlatform/manager/listallFile.do",
        type: "post",
        datatypw: "json",
        data: {
            "pagenum": n
        },
        async: false,  
        cache: false,  
        complete: function () {
            
        },
        success: function(data){
            if (data.flag == "success") {
                var list = data.data;
                sum = data.count;

                $("tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var a = i+1+(n-1)*10;   // 序号
                    $("tbody").append(
                        '<tr id="'+list[i].id+'">'+
                            '<td>'+a+'</td>'+
                            '<td data-field="id">'+list[i].id+'</td>'+
                            '<td data-field="name">'+list[i].filename+'</td>'+
                            '<td data-field="type">'+list[i].type2+'</td>'+
                            '<td data-field="address">'+list[i].address+'</td>'+  
                            '<td data-field="time">'+list[i].time+'</td>'+   
                            '<td data-field='+list[i].id+'>'+
                                '<button class="btn-dele layui-btn layui-btn-primary layui-btn-small"><a href="'+url+list[i].address+'">下载</a></button>'+
                                '<button data-whatever="'+list[i].address+'" class="btn-dele layui-btn layui-btn-danger layui-btn-small"  data-toggle="modal" data-target="#dele-file">删除</button>'+
                            '</td>'+               
                        '</tr>'
                    )
                }
            }
            // 关闭loading
            layer.closeAll('loading');
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

/***

条件查询历史文件
type1：类型1（文件所在区域）,
type2：类型2（文件所在下载块）,
pacname：端类名,
pagenum: 页码；

***/
function inquireInfo(type1,type2,pacname,pagenum) {
    $.ajax({
        url: "/openPlatform/manager/selectallFile.do",
        type: "post",
        data: {
            "type1": type1,
            "type2": pacname,
            "pacname": type2,
            "pagenum": pagenum,
        },
        async: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.flag == "success") {
                var list = data.data;
                sum = data.count;
                $("tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var a = i+1+(pagenum-1)*10;   // 序号
                    $("tbody").append(
                        '<tr id="'+list[i].id+'">'+
                            '<td>'+a+'</td>'+
                            '<td data-field="id">'+list[i].id+'</td>'+
                            '<td data-field="name">'+list[i].filename+'</td>'+
                            '<td data-field="type">'+list[i].type2+'</td>'+
                            '<td data-field="address">'+list[i].address+'</td>'+  
                            '<td data-field="time">'+list[i].time+'</td>'+   
                            '<td data-field='+list[i].id+'>'+
                                '<button data-whatever="'+list[i].address+'" class="btn-dele layui-btn layui-btn-primary layui-btn-small"  data-toggle="modal">下载</button>'+
                                '<button data-whatever="'+list[i].address+'" class="btn-dele layui-btn layui-btn-danger layui-btn-small"  data-toggle="modal" data-target="#dele-file">删除</button>'+
                            '</td>'+               
                        '</tr>'
                    )
                }
            }
        },
        error: function () {
            layer.msg("请求失败！请检查您的网络环境！");
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
            ,curr: num      //当前页
            ,theme: '#1E9FFF'   //自定义选中色值
            ,skip: false    //开启跳页
            // ,jump: function(obj, first){
         //         if(!first){
         //         layer.msg('第'+ obj.curr +'页');
         //         }
         //    }
        });
    });

    // 点击切换分页；
    function onclick() {
        $("#layPage a").on("click",function () {
            var n = $(this).attr("data-page");
            if ( inquire == false ) {
                getInfo(n)
            } else {
                inquireInfo(type1,type2,pacname,n)
            }
            onclick();
        })
    }
    onclick();
    
}
