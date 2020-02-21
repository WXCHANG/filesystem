<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
 
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>轮播图</title>
    <style type="text/css">
        #tab {
    overflow: hidden;
    width: 100%;
    height: 100%;
    position: relative;
    float: left;
}
 
#tab>img:not(:first-child) {
    display: none;
}
    </style>
  <script>
        var interval;
        var pos = 0;
        window.onload = function() {
            var images = document.getElementsByTagName('img');
            var tab = document.getElementById("tab");
            tab.onmouseover = function() {
                clearInterval(interval);
            }
            tab.onmouseout = function() {
                run(images);
            }
            run(images);
        }
        var run = function(images) {
            interval = setInterval(function() {
                images[pos].style.display = 'none';
                pos = ++pos == images.length ? 0 : pos;
                images[pos].style.display = 'inline';
            }, 1500);
        }
    </script>
</head>
 
<body>
	<audio src="../music/昼夜-真的爱你 钢琴版.mp3" autoplay="autoplay"></audio>
    <div id="tab">
        <a href="http://www.leeworld.com"><img src="../img/exterior0.png" width="100%" height="100%" /></a>
        <a href="http://www.leeworld.com"><img src="../img/exterior1.png" width="100%" height="100%" /></a>
        <a href="http://www.leeworld.com"><img src="../img/exterior2.png" width="100%" height="100%" /></a>
        <a href="http://www.leeworld.com"><img src="../img/exterior3.png" width="100%" height="100%" /></a>
        <a href="http://www.leeworld.com"><img src="../img/exterior4.png" width="100%" height="100%" /></a>
    </div>
</body>
 
</html>
