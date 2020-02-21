function swithSkin(skinName){
	$("#"+skinName).addClass("icon iconfont icon-gou-copy selected")
	.siblings().removeClass("icon iconfont icon-gou-copy selected");
	$("#cssfile").attr("href","css/"+skinName+".css");
	$.cookie("MyCssSkin",skinName,{paht:'/',expires:30});
}
$(function(){
	var cookie_skin=$.cookie("MyCssSkin");
	if(cookie_skin){
		swithSkin(cookie_skin);
	}
	var li = $("#skin li");
	li.click(function(){
		swithSkin(this.id)
	})


})