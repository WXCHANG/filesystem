<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

<head>
    <title>许可证申请</title>
	<meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/credential1.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/base/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/credential.js"></script>
</head>

<body>
    <div id="header">
        <p>许可证申请</p>
    </div>
    <div class="content">
        <div class="content1">
            <fieldset>
                <legend>许可证信息</legend>
                <div>
                    <form id="cre_info">
                        <ul>
                            <li>
                                <label for="input1">内容名称：</label>
                                <input type="text" id="input1">
                                <label for="input13 ">证书密钥：</label>
                                <input type="text " name="key" id="input13" value="1234567890DYEHDK">
                            </li>
                            <li>
                                <label for="input3">内容标识：</label>
                                <input type="text" name="target" id="input3" value="CPSecDRM-VIDEO-00001">
                                <label for="input4 ">支持设备：</label>
                                <select class="se1">
                                    <option>PC</option>
                                    <option>PVR</option>
                                    <option>MP3</option>
                                    <option>MP4</option>
                                </select>
                            </li>
                            <li>
                                <label for="input5 ">播放次数：</label>
                                <input type="text " name="num" id="input5 ">
                                <label for="input6 ">媒体类型：</label>
                                <input type="text " name="type" id="input6 ">
                            </li>
                            <li>
                                <label for="input7 ">证书版本：</label>
                                <input type="text " name="version" id="input7" value="1.0.0">
                                <label for="input8 ">优先等级：</label>
                                <input type="text " id="input8 " value="1">
                            </li>
                            <li>
                                <label for="input9 ">创建时间：</label>
                                <input type="text " id="input9 ">
                                <label for="input10 ">有效期限：</label>
                                <input type="text " name="userfuldate" id="input10 ">
                            </li>
                            <li>
                                <label for="input11 ">许可证ID：</label>
                                <input type="text " name="licenceid" id="input11" value="CPSecDRM-LICENSE-00001">
                                <label for="input12 ">文件ID：</label>
                                <input type="text " name="fileid" id="input12 ">
                            </li>
                            <li class="hardware">
                                <label for="inputs" class="hardware1">硬件绑定：</label>
                                <input type="text " id="inputs" value="08:00:20:0A:8C:6D">
                                <span>支持在PC,PVR,MP3,MP4等设备上的安全集成</span>
                                <input type="radio">
                                <span>是</span>
                                <input type="radio">
                                <span>否</span>
                            </li>
                            <li class="li8">
                                <span>License获取方式：</span>
                                <input type="radio">
                                <span>直接</span>
                                <input type="radio">
                                <span class="s1">间接</span>
                            </li>
                            <li>
                                <span>License转让：</span>
                                <input type="radio">
                                <span>支持</span>
                                <input type="radio">
                                <span>不支持</span>
                            </li>
                            <li class="apply ">
                                <button id="applyBtn">申请</button>
                            </li>
                        </ul>
                    </form>
            </fieldset>
            </div>
        </div>
        <!--    <div class="content2 ">
            <fieldset>
                <legend>密钥用法</legend>
                <form>
                    <ul>
                        <li>
                            <input type="checkbox " name=" ">
                            <span class="span1 ">数字签名-Digital Signature</span>
                            <input type="checkbox " name=" ">
                            <span>证书签名-Key CertSign</span>
                        </li>
                        <li>
                            <input type="checkbox " name=" ">
                            <span class="span2 ">不可否认-Non Repudiation</span>
                            <input type="checkbox " name=" ">
                            <span>CRL签名-Crl Sign</span>
                        </li>
                        <li>
                            <input type="checkbox " name=" ">
                            <span class="span3 ">密钥加密-Key Encipherment</span>
                            <input type="checkbox " name=" ">
                            <span>仅仅加密-Encipher Only</span>
                        </li>
                        <li>
                            <input type="checkbox " name=" ">
                            <span class="span4 ">数据加密-Data Encipherment</span>
                            <input type="checkbox " name=" ">
                            <span>仅仅加密-Decipher Only</span>
                        </li>
                    </ul>
                </form>
            </fieldset>
        </div> -->
    </div>
</body>

</html>