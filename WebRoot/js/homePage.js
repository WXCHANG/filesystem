function getImageInfo(serverPath) {
	var page=$("#currPage").val();
    var size=$("#limit").val();
    $.ajax({
        type: "post",
        url: '../showCalligraVideo.do',
        data: {
            "type": 1,
            "page":page,
            "limit":size
           
        },
        async: false,
        success: function(data) {
            var list = data.origins
            if (data.flag == "success") {
            	$('#imageDiv').html(" ");
            	 $("#currPage").val(data.page);//重新赋值当前页
            	    $("#limit").val(data.limit);//重新赋值本页条数
            	    var page=data.page;
            	    var limit=data.limit;
            	    total=data.totalCount;
                for (var i = 0; i < list.length; i++) {
                    path = serverPath+list[i].file;
   	             $('#imageDiv').append(
							'<div class="img"'+
								'<div class="photo">' +
									'<a target="_blank" onclick="window.location.href=\'./detail.html?id='+list[i].id+'\'">' +
									'<img src="'+path+'">' +
									'</a>'+
									'<div class="title">'+
											/*'<table>'+
												'<tr>'+
												'<td><span class="span" style="font-size:20px; color:red;">¥2000.00</span></td>'+
												'<td></td>'
												+'</tr>'+
												'<tr>'+
												'<td><span class="span1" style="font-size:13px;">【'+list[i].value8+'】</span></td>'+
												'<td><span class="span1" style="font-size:13px;">'+list[i].name+'</span></td>'
												+'</tr>'+
												'<tr>'+
												'<td><span class="span1" style="font-size:13px;">'+list[i].quality+'&nbsp;'+list[i].value7+'</span></td>'+
												'<td><span class="span1" style="font-size:13px;">'+list[i].identifier+'&nbsp;'+list[i].value7+'</span></td>'
												+'</tr>'+
												
											'</table>'+*/
											/*'<span class="span" style="font-size:20px; color:red;">¥'+(Number(list[i].identifier)+ Number(1000))+'.00</span><br/>' + */
											/*'<span class="span1" style="font-size:13px;">list[i].value8 </span>'+'&nbsp;' + */
											'<span class="span1" style="font-size:13px;">'+
											list[i].name +
											'</span>' +
											'<br/>' +
											'<span class="span1" style="font-size:13px;">'+list[i].area+'&nbsp;&nbsp;'+list[i].quality +'&nbsp;&nbsp;'+list[i].identifier+'</span>' +
									'</div>'+
							     '</div>'+
					         '</div>'
					)
                }
            }

         
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            console.log(XMLHttpRequest.status);
            console.log(XMLHttpRequest.readyState);
            console.log(textStatus);

        }
    })
}

//分页
function toPage(serverPath){
    layui.use('laypage', function(){
          var laypage = layui.laypage;
           laypage.render({
                    elem: 'page' //注意，这里的 page 是 ID，不用加 # 号
                    ,//数据总数，从服务端得到
                    limits:[10,20,30,40,50],
                    prev:"<<",
                    next:">>",
                    theme:"#0099ff",
                    layout: ['count', 'prev', 'page', 'next', 'limit', 'skip'],
                    count:total,
                    curr:page,
                    limit:limit,
                  
                    jump:function(data, first){
                        var page=data.curr;
                        $("#currPage").val(page);
                        var limt=data.limit;
                        $("#limit").val(limt);
                        if(!first){ //点击右下角分页时调用
                        	getImageInfo(serverPath);
                        }
                    }
        });
    })
}

