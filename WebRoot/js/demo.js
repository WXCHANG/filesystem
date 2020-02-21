function getInfo(n) {	
	$.ajax({
		url: "/openPlatform/manager/listallManager.do",
		type: "get",
		data: "pagenum="+n,
		async: false,  
		cache: false,  
		contentType: false,  
		processData: false,
		success: function(data){
			console.log(data)
					
			if (data.flag == "success") {
				var list = data.data;
				sum = data.count;

				layui.config({
				    base: 'base/'
				}).use(['element','form','layer','laypage','table'], function() {
			  		var element = layui.element;
			        var table = layui.table;
			        var layer = layui.layer;
			        var laypage = layui.laypage;

			        //表格
			        table.render({
			        	elem: 'userTable'
			        	,loading: true
					    ,limit: 10 
					    ,url: list //数据接口
					    ,page: true //开启分页
					    ,cols: [[ //表头
					      {field: 'managerid', title: 'ID', width:80, fixed: 'left'}
					      ,{field: 'username', title: '用户名', width:80}
					      ,{field: 'password', title: '密码', width:80}
					      ,{field: 'permissions', title: '权限', width:80} 
					    ]]
			        })


					//分页
					laypage.render({
						elem: 'layPage' 	//分页容器的id
						,layout: ['prev', 'page', 'next','limits','count'] 	//排版
						,limit: 10 		//每页显示数 
						,limits: [10, 20, 30, 40, 50] 	//条数选择项
						// ,curr: curr || 1 //获取起始页
						,groups: 3 		//连续出现的页数
						,count: sum 	//总条数
						,theme: '#1E9FFF' 	//自定义选中色值
						,skip: false 	//开启跳页
						,jump: function(obj, first){
					      	if(!first){
					        	layer.msg('第'+ obj.curr +'页');
					      	}
					    }
					});
					// function onclick() {
					// 	$("#layPage a").on("click",function () {
					// 		var num = $(this).attr("data-page");
					// 		console.log(num)
					// 		getInfo(num)
					// 		onclick();
					// 	})
					// }
					// onclick();
					
				});
				$("td[data-role='2']").text("编辑人员");
				$("td[data-role='3']").text("审批人员");
			}
		},
		complete: function () {
        	// $("#add-honorUser").modal("hide");
        },
        error:function(){
            alert("请求失败！请检查您的网络环境！")
        }
	})

	function f2(){
		alert(n); 
		alert(sum);
	}

	return f2;
}



	var n = 1,  // 页数
	sum = 0;    // 数据条数

	getInfo(1)
	
	

		
