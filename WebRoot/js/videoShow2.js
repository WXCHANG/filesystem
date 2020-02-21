/*查询剩余播放次数*/
function getTime(id) {
    $.ajax({
        type: 'post',
        url: '../selectVideonum.do',
        data: {
            "id": id
        },
        async: false,
        success: function(data) {

            var remain = data.num;
            console.log(remain)
            $('#remain').val(remain);
            localStorage.setItem('total',data.total);
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            console.log(XMLHttpRequest.status);
            console.log(XMLHttpRequest.readyState);
            console.log(textStatus);

        }
    })
}


$(function() {

    /*限制播放时间*/
    var now = new Date().getHours();
  /*  if (now < 9 || now > 18) {
        alert('当前不在视频播放时间，请于09:00-18:00之间访问!');
        window.open("about:blank", "_self").close()
    }*/

    /*获取剩余次数*/
    var id = localStorage.getItem('id');
    getTime(id);
    /*获取视频地址*/
    var src = localStorage.getItem('src');
    var total = localStorage.getItem('total');
    $('video').attr('src', src);
    /*限制播放次数*/
    //自定义弹出框
    window.alert = function(str, str2, str3, str4, str5, str6) {
    	//alert(total);
        var shield = document.createElement("DIV");
        shield.id = "shield";
        shield.style.position = "absolute";
        shield.style.left = "45%";
        shield.style.top = "40%";
        shield.style.width = "420px";
        shield.style.height = "150px";
        shield.style.marginLeft = "-140px";
        shield.style.marginTop = "-110px";
        shield.style.zIndex = "25";
        var alertFram = document.createElement("DIV");
        alertFram.id = "alertFram";
        alertFram.style.position = "absolute";
        alertFram.style.width = "420px";
        alertFram.style.height = "150px";
        alertFram.style.left = "45%";
        alertFram.style.top = "40%";
        alertFram.style.marginLeft = "-140px";
        alertFram.style.marginTop = "-110px";
        alertFram.style.textAlign = "center";
        alertFram.style.lineHeight = "150px";
        alertFram.style.zIndex = "300";
        strHtml = "<ul style=\"list-style:none;margin:0px;padding:0px;width:100%\">\n";
        strHtml += " <li style=\"background:#CFCFCF;text-align:center;font-size:13px;height:45px;line-height:45px;color:#333\">" + str + "</li>\n";
        strHtml += " <li style=\"background:#CFCFCF;text-align:right;padding-right:109px;font-size:13px;height:30px;line-height:30px;color:#333\">" + str2 + "<input type=\"text\" value="+total+">　次</li>\n";
        strHtml += " <li style=\"background:#CFCFCF;text-align:right;padding-right:135px;font-size:13px;height:30px;line-height:30px;color:#333\">" + str3 + "<input type=\"text\" value=\"NONE\"></li>\n";
        strHtml += " <li style=\"background:#CFCFCF;text-align:right;padding-right:135px;font-size:13px;height:30px;line-height:30px;color:#333\">" + str4 + "<input type=\"text\" value=\"ALL\"></li>\n";
        strHtml += " <li style=\"background:#CFCFCF;text-align:right;padding-right:96px;font-size:13px;height:30px;line-height:30px;color:#333\">" + str5+ "<input type=\"text\" value=\"3\">　个月</li>\n";
        strHtml += " <li style=\"background:#CFCFCF;text-align:right;padding-right:94px;font-size:13px;height:30px;line-height:30px;color:#333\">" + str6 + "<input type=\"text\" value=\"1000\">　DRC</li>\n";
         strHtml += " <li style=\"background:#CFCFCF;text-align:center;font-weight:bold;height:45px;line-height:45px; border-top:1px solid #333;\"><input type=\"button\" value=\"确认\" onclick=\"doOk()\" style=\"width:80px;height:26px;background:#626262;color:white;border:1px solid white;font-size:14px;line-height:20px;outline:none;margin-top: 4px\"/><input type=\"button\" value=\"取消\" onclick=\"doOk()\" style=\"width:80px;height:26px;background:#626262;color:white;margin-left:20px;border:1px solid white;font-size:14px;line-height:20px;outline:none;margin-top: 4px\"/></li>\n";
        strHtml += "</ul>\n";
        alertFram.innerHTML = strHtml;
        document.body.appendChild(alertFram);
        document.body.appendChild(shield);
        this.doOk = function() {
            alertFram.style.display = "none";
            shield.style.display = "none";
            //window.open("about:blank", "_self").close()
            window.location.href="../home/homeVideoPage.jsp"
        }
        alertFram.focus();
        document.body.onselectstart = function() { return false; };
    }

    var times = $('#remain').val();
    if (times == 0) {
        alert("已达到最大观看次数！若要继续观看，请用DRC币购买！", "播放次数：","播放区间：", "播放设备：", "许可证有效期：", "购买费用：")
    }



    /*已经播放次数*/
    // var num = localStorage.getItem("times");
    // $('#finish').val(num);

    /*剩余次数*/
    // var remainNum = 5 - num
    // $('#remain').val(remainNum);

    // /*切换账户权限*/
    // var usernames = localStorage.getItem("username");

    // if (num > 1 & usernames > 1) {
    //     alert("试用账户只能试看一次")
    //     window.open("about:blank", "_self").close()
    // }


})