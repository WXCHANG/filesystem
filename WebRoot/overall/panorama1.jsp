<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>轮播图</title>
    <style>
        #loopDiv{
            /* width: 790px;
            height: 340px;
            position: relative; */
            width: 98%;
            margin: 0 auto;
            text-align: center;
        }
         
        #list{
            list-style: none;
         
            position: absolute;
            bottom: 20px;
            left: 42%;
        }
        #list li{
            float: left;
            width: 20px;
            height: 20px;
            line-height: 20px;
            text-align: center;
            border-radius: 50%;
            background: #aaa;
            margin-right: 10px;
        }
        .chooseBut{
            width: 50px;
            height: 80px;
            background-color: rgba(0,0,0,0.2);
            color: #fff;
            font-size: 30px;
            line-height: 80px;
            text-align: center;
            display: none;
        }
        #left{
            position: absolute;
            left: 0px;
            top: 45%;
        }
        #right{
            position: absolute;
            right: 0px;
            top: 45%;
        }
        #pic{
        	width: 100%;
        }
    </style>
</head>
<body>
    <div id="loopDiv">
        <ul id="list">
            <li>1</li>
            <li>2</li>
            <li>3</li>
            <li>4</li>
        </ul>
        <div id="left"><</div>
		<img alt="" src="../img/panorama0.png" id="pic">
        <div id="right">></div>
    </div>
    <script type="text/javascript">
        var jsDivBox = document.getElementById("loopDiv");
        //图片节点
        var jsImg = document.getElementById("pic");
        //左右按钮节点
        var jsLeft = document.getElementById("left");
        var jsRight = document.getElementById("right");
        //获取所有的li
        var jsUl = document.getElementById("list");
        var jsLis = jsUl.getElementsByTagName("li");
        //让第一个小圆点变为红色
        jsLis[0].style.backgroundColor = "red";
         
        //显示当前的图片下标
        var currentPage = 0;
         
        //启动定时器
        var timer = setInterval(func, 1500);
        function func() {
            currentPage++;
            changePic();
         
        }
        function changePic() {
            if (currentPage == 4) {
                currentPage = 0;
            }
            if (currentPage == -1) {
                currentPage = 3;
            }
            //更换图片
            //"img/1.jpg"
            jsImg.src = "../img/panorama" + currentPage + ".png";
            //将所有的小圆点颜色清空
            for (var i = 0; i < jsLis.length; i++) {
                jsLis[i].style.backgroundColor = "#aaa";
            }
            //改变对应小圆点为红色
            jsLis[currentPage].style.backgroundColor = "red";
        }
         
        //鼠标进入
        jsDivBox.addEventListener("mouseover", func1, false);
        function func1() {
            //停止定时器
            clearInterval(timer);
            //显示左右按钮
            jsLeft.style.display = "block";
            jsRight.style.display = "block";
        }
        //鼠标移出
        jsDivBox.addEventListener("mouseout", func2, false);
        function func2() {
            //重启定时器
            timer = setInterval(func, 1500);
         
            //隐藏左右按钮
            jsLeft.style.display = "none";
            jsRight.style.display = "none";
        }
             
        //点击左右按钮
        jsLeft.addEventListener("click", func3, false);
        function func3() {
            currentPage--;
            changePic();
        }
        jsLeft.onmouseover = function() {
            this.style.backgroundColor = "rgba(0,0,0,0.6)";
        }
        jsLeft.onmouseout = function() {
            this.style.backgroundColor = "rgba(0,0,0,0.2)";
        }
        jsRight.addEventListener("click", func4, false);
        function func4() {
            currentPage++;
            changePic();
        }
        jsRight.onmouseover = function() {
            this.style.backgroundColor = "rgba(0,0,0,0.6)";
        }
        jsRight.onmouseout = function() {
            this.style.backgroundColor = "rgba(0,0,0,0.2)";
        }
                 
        //进入小圆点
        for (var j = 0; j < jsLis.length; j++) {
            jsLis[j].onmouseover = function() {
                currentPage = parseInt(this.innerHTML) - 1;
                changePic();
            };
        }
    </script>
</body>
</html>