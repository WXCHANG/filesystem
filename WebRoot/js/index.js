$(function () {
		$(".layui-nav-child dd").on("click",function () {
		
			$(".layui-nav-child dd").removeClass("layui-this");
			$(this).addClass("layui-this");
			var id = $(this).attr("id");
			var parentId = $(this).parents("li").attr("id");
			// var src = parentId+"/"+iframeUrl[parentId][id];
			
			if(id.indexOf("DRM")==0){
				var src = parentId+"/"+id+".html";
			}else if(id.indexOf("CPSecVideo")==0){//跳转版权链视频页
				var src="video_web/videos1.html"
			}else if(id.indexOf("CPSecEntry")==0){//跳转版权链信息录入页
				var src="video_web/accredit0.html"
			}else if(id.indexOf("CPSecFile")==0){//跳转版权链文件列表页
				var src="video_web/accredit1.html"
			}else if(id.indexOf("CPSecCertificate")==0){//跳转版权链证书申请页
				var src="video_web/credential1.html"
			}else if(id.indexOf("WaterMark")==0){//跳转版权链证书申请页
				var src="watermark/step.html"
			}else if(id.indexOf("licences")==0){//跳转视频token页面
				var src="showLicensesJsp.do"
			}
			else{
				var src = parentId+"/"+id+".jsp";
			}
			$(".layui-tab-content iframe").attr({"src":src});
		})
})