<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<base href="<%=basePath%>">

<title>雨涛电影后台管理 登录</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<meta http-equiv="Page-Enter"
	content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit"
	content="revealTrans(duration=5, transition=23)">

<link rel="stylesheet" href="/TianRen/styles/global.css" type="text/css" />

<script type="text/javascript" src="/TianRen/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/TianRen/scripts/global.js"></script>

<script type="text/javascript">
	function changeValidateCode(obj) {
		var timenow = new Date().getTime();
		obj.src = "rand.action?d=" + timenow;
	}

	var xmlhttp;
	function func() {
		//(1) : xmlhttp 的创建
		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}

		//(2) : 指定交互路径
		var adminName = document.getElementsByName("adminName")[0].value;
		var adminPwd = document.getElementsByName("adminPwd")[0].value;
		var checkCode = document.getElementsByName("checkCode")[0].value;
		xmlhttp.open("post", "admin!login.action?adminName=" + adminName
				+ "&adminPwd=" + adminPwd + "&checkCode=" + checkCode, true);
		//(3) : 指定回调函数
		xmlhttp.onreadystatechange = handler;
		//(4) : 开始交互 ， 发送请求
		xmlhttp.send();

	}

	function handler() {
		var msg = document.getElementById("msg");

		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { //如果成功交互且服务器正常 , 开始处理
			//获得服务器的响应数据
			var res = eval('(' + xmlhttp.responseText + ')');
			
			if (res == 1) {
				msg.innerHTML = "验证码错误！";
			} else if (res == 2) {
				msg.innerHTML = "用户名或密码错误！";
			} else if (res == 4) {
				msg.innerHTML = "该管理员已登录，不可同时再次登录！";
			} else {
				location = "/TianRen/admin/adminIndex.jsp";
			}
		} else {
			msg.innerHTML = "请稍等...";
		}
	}

	function submit(e) {
		alert("a");
		if (e.keyCode == 13) {
			func();
		}

	}
</script>
</head>

<body>
	<div id="header">
		<div>
			<h1 style="text-align: center; margin: 10px;">雨涛电影后台管理</h1>
		</div>
		<hr style="clear:both; " />
	</div>
	<div id="main" style="margin: 20px;">
		<fieldset>
			<legend>登录</legend>
			<form method="post" onkeypress="if(event.keyCode==13){func();}">
				<s:textfield name="adminName" label="用户名" style="width:200px;" />
				<br />
				<br />
				<s:password name="adminPwd" label="密　码" style="width:200px;" />
				<br />
				<br />
				<s:textfield name="checkCode" label="验证码" style="width:120px;" />
				<img src="rand.action" onclick="changeValidateCode(this)"
					title="看不清 点击换一张"
					style="border:1px #000000 solid; vertical-align: bottom;"> <br />
				<br /> <input type="button" value="登录" onclick="func()" />
			</form><br/>
			<span id="msg" style="color:red; font-size: 20;"></span>
		</fieldset>

	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
