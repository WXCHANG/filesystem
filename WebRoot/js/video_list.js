function getInfo(pagenum, dif) {
    $.ajax({
        type: "post",
        url: '../ListAllFiles.do',
        data: {
            "pagenum": pagenum,
            "dif": dif
        },
        async: false,
        success: function(data) {
            var list = data.Data
            var list1 = data.Path
            if (data.flag == "success") {
            	$('ul').html(" ");
                for (var i = 0; i < list.length; i++) {
                    /*$('.layui-row').append(

                        '<div class="layui-col-md3">' +
                        '<div class="photo">' +
                        '<a href="videoShow.html" >' +
                        '<video src="'+list1[i]+'" id="'+list[i].id+'" style="object-fit:fill">' +
                         '</video>' +

                        '</a>' +

                        '<div class="title">' +

                        '<span class="span1">' +
                        '标题：' +
                        '</span>' +
                        '<span class="span1">' +
                        list[i].name +
                        '</span>' +
                        '<br/>' +

                        '<span class="span1">' +
                        '视频格式：' +
                        '</span>' +
                        '<span class="span1">' +
                        list[i].type +
                        '</span>' +


                        '</div>' +
                        '</div>' +
                        '</div>'

                    )*/
					$("ul").append(
					 "<li>"+
							'<a href="videoShow.html" >' +
								'<video src="../'+list1[i]+'" id="'+list[i].id+'" style="object-fit:fill">' +
								'</video>' +
							'</a>' +
							'<div class="title">'+
								'<span class="span1">' +
									'标题：' +
									'</span>' +
									'<span class="span1">' +
									list[i].name +
									'</span>' +
									'<br/>' +

									'<span class="span1">' +
									'视频格式：' +
									'</span>' +
									'<span class="span1">' +
									list[i].type +
									'</span>' +
							'</div>'+
					'</li>'
					)
                }
            }

           /* 
            layui.config({
                base: 'base/'
            }).use(['element', 'form', 'layer', 'laypage', 'table'], function() {
                var element = layui.element;
                var table = layui.table;
                var layer = layui.layer;
                var laypage = layui.laypage;

                //分页
                laypage.render({
                    elem: 'layPage' //分页容器的id
                        ,
                    layout: ['prev', 'page', 'next', 'limits', 'count'] //排版
                        ,
                    limit: 10 //每页显示数 
                        ,
                    groups: 3 //连续出现的页数
                        ,
                    count: data.count //总条数
                        ,
                    curr: pagenum,
                    theme: '#1E9FFF' //自定义选中色值
                        ,
                    skip: true //开启跳页
                        ,
                    jump: function(obj, first) {
                        if (!first) {
                            $('tbody').html('');
                            getInfo(obj.curr);
                        }
                    }
                });
            });*/
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            console.log(XMLHttpRequest.status);
            console.log(XMLHttpRequest.readyState);
            console.log(textStatus);

        }
    })
}

$(function(){

	getInfo(1,1)	


    //获取并存储当前视频的id和路径
    $('a').on('click',function(){
        id=$(this).children('video').attr('id');
        src=$(this).children('video').attr('src');
        localStorage.setItem('id',id);
        localStorage.setItem('src',src);
    })

})