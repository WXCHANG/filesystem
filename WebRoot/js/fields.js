/*function queryFields() {
    $.ajax({
        url: "queryColumns.do",
        type: "get",
        success: function (data){
            $(".text-body").html("");
            var list = data.data
            for (var i = 0; i < list.length; i++) {
                var x = i+1
                $(".text-body").append(
                    '<fieldset class="columnName'+i+'">'
                        +'<legend>字段'+x+'</legend>'
                        +'<div id="editTitle" class="bv-form layui-form form-horizontal" method="post">'
                            +'<div class="layui-form-item form-group has-feedback">'
                                +'<label class="layui-form-label col-sm-2 input-required">'+list[i].columnName+'</label>'
                                +'<div class="col-sm-9 inputBox"></div>'
                            +'</div>'
                        +'</div> '
                    +'</fieldset>')
                switch (list[i].type){
                    case "1":
                        $(".columnName"+i+" .inputBox").html('<input type="text" class="form-control layui-input" id="" name="columnName'+x+'" readonly>')
                        break;
                    case "2":
                        $(".columnName"+i+" .inputBox").html('<input type="file" class="form-control layui-input" id="" name="columnName'+x+'" readonly>')
                        break;
                    case "3":
                        $(".columnName"+i+" .inputBox").html('<textarea class="form-control layui-input" id="" name="columnName'+x+'" readonly></textarea>')
                        break;
                    default:
                        return;
                   
                }
            }
        },
        error: function (){

        }
    })
}*/

$(function () {
	// queryFields();
    $("#editFields").bootstrapValidator({
        message: '输入值不合法',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            field1: {
                message: '字段名不合法',
                validators: {
                    notEmpty: {
                        message: '字段名不能为空'
                    },
                    regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '字段名只能由字母、汉字和数字组成。'
                    }
                }
            },
            field2: {
                message: '字段名不合法',
                validators: {
                    notEmpty: {
                        message: '字段名不能为空'
                    },
                    regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '字段名只能由字母、汉字和数字组成。'
                    }
                }
            },
            field3: {
                message: '字段名不合法',
                validators: {
                    notEmpty: {
                        message: '字段名不能为空'
                    },
                    regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '字段名只能由字母、汉字和数字组成。'
                    }
                }
            },
            field4: {
                message: '字段名不合法',
                validators: {
                    notEmpty: {
                        message: '字段名不能为空'
                    },
                    regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '字段名只能由字母、汉字和数字组成。'
                    }
                }
            },
            field5: {
                message: '字段名不合法',
                validators: {
                    notEmpty: {
                        message: '字段名不能为空'
                    },
                    regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '字段名只能由字母、汉字和数字组成。'
                    }
                }
            },
            field6: {
                message: '字段名不合法',
                validators: {
                    notEmpty: {
                        message: '字段名不能为空'
                    },
                    regexp: {
                        regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
                        message: '字段名只能由字母、汉字和数字组成。'
                    }
                }
            },
            // value5: {
            //     message: '字段名不合法',
            //     validators: {
            //         notEmpty: {
            //             message: '字段名不能为空'
            //         },
            //         // regexp: {
            //         //     regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
            //         //     message: '字段名只能由字母、汉字和数字组成。'
            //         // }
            //     }
            // }
        }
    });           

    $("#editBtn").click(function () {
        var bv = $('#editFields').data('bootstrapValidator');
        bv.validate();
        if (bv.isValid()) {
            $.ajax({
                url: "setFields.do",  // 提交接口
                type: "post",
                data: $('#editFields').serialize(),
                success: function (data) {                      
                    if ( data.code == 0) {
                        alert("添加成功！")
                        var _parent = window.parent;
                        setTimeout(function () {
                            _parent.location.reload();
                        },500)
                    }  
                },
                error: function () {
                    // 失败操作
                    alert("失败！");
                }
            })
        }
    })
})