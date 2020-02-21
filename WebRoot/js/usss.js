$(function(){
    /*生成验证码*/
    create_code();

    //登录页面的提示文字
    //账户输入框失去焦点
    (function login_validate(){
       

        /*验证码输入框失去焦点*/
        $("#key").blur(function(){
            var code1=$('#key').val().toLowerCase();
            var code2=$("#phoKey").text().toLowerCase();
            if(code1!=code2){
                $(this).addClass("errorC");
                $("#errorC").html("验证码输入错误!!!");
                $(this).next().next().css("display","block");
               // $(".sub input").prop('disabled', true);
            }
            else
            {
            	 $("#errorC").html("");
              
            }
        })
    })();
});
//函数 create_code() 用于生成验证码：
function create_code() {
    function shuffle() {
        var arr = ['1', 'r', 'Q', '4', 'S', '6', 'w', 'u', 'D', 'I', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
            'q', '2', 's', 't', '8', 'v', '7', 'x', 'y', 'z', 'A', 'B', 'C', '9', 'E', 'F', 'G', 'H', '0', 'J', 'K', 'L', 'M', 'N', 'O', 'P', '3', 'R',
            '5', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
        return arr.sort(function () {
            return (Math.random() - .5);
        });
    };
    shuffle();
    function show_code() {
        var ar1 = '';
        var code = shuffle();
        for (var i = 0; i < 5; i++) {
            ar1 += code[i];
        }
        ;
        //var ar=ar1.join('');
        $("#phoKey").text(ar1);
    };
    show_code();
    $("#phoKey").click(function () {
        show_code();
    });
}

//文本框默认提示文字
function textFocus(el) {
    if (el.defaultValue == el.value) { el.value = ''; el.style.color = '#333'; }
}
function textBlur(el) {
    if (el.value == '') { el.value = el.defaultValue; el.style.color = '#999'; }
}
