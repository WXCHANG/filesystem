var sum = 0;    // 数据条数
var code = 0;   // 状态
var num = sessionStorage.getItem("pageNum");   // 获取之前页面ID

layui.config({
    base: 'base/'
}).use(['element','form','layer','laypage','table'], function() {
	var element = layui.element;
    var table = layui.table;
    var layer = layui.layer;
    var laypage = layui.laypage;

    
	if ( num == null ) {
		num = 1;
	} 
	getInfo(num)

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
		// ,curr: curr || 1 //获取起始页
		,groups: 3 		//连续出现的页数
		,count: sum 	//总条数
		,curr: num  	//当前页
		,theme: '#1E9FFF' 	//自定义选中色值
		,skip: false 	//开启跳页
		// ,jump: function(obj, first){
	 //      	if(!first){
	 //        	layer.msg('第'+ obj.curr +'页');
	 //      	}
	 //    }
	});

	// 点击切换分页；
	function onclick() {
		$("#layPage a").on("click",function () {
			var n = $(this).attr("data-page");
			getInfo(n)
			onclick();
		})
	}
	onclick();
});

		
$(function () {
	// var addform = $('#userForm');
	// var editform = $('#userForm');
	$('#userForm').bootstrapValidator({
        message: '输入值不合法',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            username: {
                message: '账号不合法',
                validators: {
                    notEmpty: {
                        message: '账号不能为空'
                    },
                    stringLength: {
                        min: 3,
                        max: 30,
                        message: '请输入3到30个字符'
                    },
                    regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '用户名只能由汉字,字母和数字组成'
                    }
                }
            }
            ,password: {
                message: '密码不合法',
                validators: {
                    notEmpty: {
                        message: '密码不能为空'
                    },
                    stringLength: {
                        min: 6,
                        max: 10,
                        message: '密码长度6-10位。'
                    },
                    regexp: {
                        regexp: /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,10}$/,
                        message: '密码必须且只含有数字和字母。 '
                    }
                }
            }
            ,permissions: {
            	message: '权限不合法',
            	validators: {
                    notEmpty: {
                        message: '权限不能为空'
                    }
                }
            }
        }
    });
    $('#edit-userForm').bootstrapValidator({
        message: '输入值不合法',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            password: {
                message: '密码不合法',
                validators: {
                    notEmpty: {
                        message: '密码不能为空'
                    },
                    stringLength: {
                        min: 6,
                        max: 10,
                        message: '密码长度6-10位。'
                    },
                    regexp: {
                        regexp: /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,10}$/,
                        message: '密码必须且只含有数字和字母。 '
                    }
                }
            }
            ,permissions: {
            	message: '权限不合法',
            	validators: {
                    notEmpty: {
                        message: '权限不能为空'
                    }
                }
            }
        }
    });

	// 添加账号
    $("#addBtn").click(function () {
        //进行表单验证
        var bv = $("#userForm").data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
            $(this).addClass("disabled");
            //发送ajax请求
            $.ajax({
                url: '/openPlatform/manager/addManager.do',
                async: false,	//同步，会阻塞操作
                type: 'post',	//PUT DELETE POST
                data: $("#userForm").serialize(),
                complete: function (msg) {
                	$("#addBtn").removeClass("disabled");
                    console.log('走完流程了');
                },
                success: function (data) {
                    if ( data.flag == "success" ) {   // 添加成功
                        $("#add-user").modal("hide");
                        layer.msg("添加成功");
                        sessionStorage.setItem("pageNum", 1);  // 添加成功后跳回首页
                        window.location.reload(); 
                    } else if ( data.msg == "账号正在使用！" ) {  //账号正在使用
                    	$("#returnMessage").hide().html('<label class="label label-danger">账号正在使用！</label>').show(300);
                    } else if ( data.msg == "账号已禁用！" ) {  //账号禁用
                       
                        $("#add-user").modal("hide");

                        // 解禁
                        $("#lifted").modal("show");
                        $('#subBtn').one("click",function () {
                            $(this).addClass("disabled");
                            $.ajax({
                                type: 'post',   
                                url: '/openPlatform/manager/replayManager.do',
                                data: {
                                    "username" : data.username,
                                },
                                async: false,   //同步，会阻塞操作
                                complete: function () {
                                    $("#subBtn").removeClass("disabled");
                                    console.log('走完流程了');
                                },
                                success: function (data) {
                                    if (data.flag == "success" ) {
                                        layer.msg("解禁成功！")
                                        $("#lifted").modal("hide");
                                        window.location.reload(); 
                                    } else {
                                        $("#returnMessage").hide().html('<label class="label label-danger">解除禁用失败!</label>').show(300);
                                    }
                                }, 
                                error: function () {
                                    layer.msg("请求失败！请检查您的网络环境！")
                                }
                            })
                        })
                    }
                }, 
                error: function () {
                    layer.msg("请求失败！请检查您的网络环境！")
                }
            })
        }
    });
    // 删除
    $('body').unbind("click").on("click",".btn-dele",function () {
    	
    	$("#dele-user").on("show.bs.modal",function (event) {
			var button = $(event.relatedTarget);
			var user = button.data("whatever");

			$("#deleBtn").unbind("click").on("click",function () {
                $(this).unbind("click")
				$(this).addClass("disabled");
				$.ajax({
	                type: 'post',	
					url: '/openPlatform/manager/disabledManager.do',
	                data: {
	                	"username" : user,
	                },
	                async: false,	//同步，会阻塞操作
	                complete: function (msg) {
	                	$("#deleBtn").removeClass("disabled");
	                    console.log('走完流程了');
	                },
	                success: function (data) {
	                    console.log(data);
	                    if (data.flag == "success" ) {
	                    	layer.msg("删除成功！")
	                        $("#dele-user").modal("hide");
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
    // 编辑
    $("table").unbind("click").on("click",".btn-edit",function () {
    	$("#edit-user").on("show.bs.modal",function (event) {
			var button = $(event.relatedTarget);
			var id = button.data("whatever");
			var parents = button.parents("tr");
			var user = parents.find("td[data-field = username]").html();
			var pwd = parents.find("td[data-field = password]").html();
			var permit = parents.find("td[data-field = permissions]").html();

			$("input[name='username']").val(user);
			$("input[name='password']").val(pwd);
			if ( permit == '编辑') {
				$("[value=2][name=permission1]:checkbox").prop("checked", true);
			}
			if ( permit == '审批') {
				$("[value=3][name=permission2]:checkbox").prop("checked", true);
			}
			if ( permit == '编辑，审批') {
				$("[name=permission1]:checkbox").prop("checked", true);
				$("[name=permission2]:checkbox").prop("checked", true);
			}

			$("#editBtn").on("click",function () {
				var bv = $("#edit-userForm").data('bootstrapValidator');
		        bv.validate();
		        if (bv.isValid()) {
                    $("#editBtn").unbind("click");
					$("#editBtn").addClass("disabled");
					$.ajax({
		                type: 'post',	
						url: '/openPlatform/manager/updateManager.do',
		                data: $("#edit-user form").serialize(),
		                async: false,	//同步，会阻塞操作
		                complete: function (msg) {
		                	$("#editBtn").removeClass("disabled");
		                    console.log('走完流程了');
		                },
		                success: function (data) {
		                    console.log(data);
		                    if (data.flag == "success" ) {
		                    	layer.msg("编辑成功")
		                        $("#edit-user").modal("hide");
		                        window.location.reload();
		                    } else {
		                        $("#returnMessage").hide().html('<label class="label label-danger">编辑失败!</label>').show(300);
		                    }
		                }, 
		                error: function () {
		                    $("#returnMessage").hide().html('<label class="label label-danger">请求失败！请检查您的网络环境！</label>').show(300);
		                }
					})
				}
			})
		})
    })

    // 重置
    $('.modal').on('hide.bs.modal', function () {
    	var form = $(this).find("form");
    	if ( form.length > 0 ) {	    	
	        // form.reset();
	        $('.modal input:not([type="checkbox"])').val('');
	        
	        $("[name=permission1]:checkbox").prop("checked", false);
	        $("[name=permission2]:checkbox").prop("checked", false);
	        form.data('bootstrapValidator').resetForm(); 
	        // location.reload();   		
    	}
    })
})


function getInfo(n) {	
	sessionStorage.setItem("pageNum", n); 	
	// 加载
    $("#AjaxLoading").stop(true).animate({'margin-top':'300px','opacity':'1'},200);
	$.ajax({
		url: "/openPlatform/manager/listallManager.do",
		type: "post",
		data: {
            "pagenum": n
        },
        dataType: "json",
		async: false,  
		cache: false,  
		complete: function () {
			// 关闭loading
			$("#AjaxLoading").stop(true).animate({'margin-top':'250px','opacity':'0'},400);
        },
		success: function(data){
			if (data.code == "0") {
				var list = data.data;
				sum = data.count;

				$("tbody").html("");
				for (var i = 0; i < list.length; i++) {
					var a = i+1+(n-1)*10;
					$("tbody").append(
						'<tr id="'+list[i].managerid+'">'+
							'<td>'+a+'</td>'+
			               	'<td data-field="managerid">'+list[i].managerid+'</td>'+
			                '<td data-field="username">'+list[i].username+'</td>'+
			                '<td data-field="password">'+list[i].password+'</td>'+
			                '<td data-field="permissions" data-role='+list[i].permissions+'></td>'+
			                '<td data-field='+list[i].managerid+'>'+
			                	'<button data-whatever="'+list[i].username+'" class="btn-edit layui-btn layui-btn-normal layui-btn-small"  data-toggle="modal" data-target="#edit-user">编辑</button>'+
			                    '<button data-whatever="'+list[i].username+'" class="btn-dele layui-btn layui-btn-danger layui-btn-small"  data-toggle="modal" data-target="#dele-user">删除</button>'+
			                '</td>'+
			            '</tr>'
					)
				}
				$("td[data-role='2']").text("编辑");
				$("td[data-role='3']").text("审批");
				$("td[data-role='4']").text("编辑，审批");
			}
		},
        error:function(){
            alert("请求失败！请检查您的网络环境！")
            code = 1;
        }
	})

	function f2(){
		alert(sum);
		alert(code);
	}

	return f2;
}