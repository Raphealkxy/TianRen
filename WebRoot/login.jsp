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

<title>雨涛电影 登录</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter"
	content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit"
	content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/login.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/TianRen/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/TianRen/scripts/global.js"></script>

<script type="text/javascript">
	function emailBlur(obj) {
		var msg = document.getElementById("msg");
		if (obj.value == "" || obj.value.length == 0) {
			obj.style.color = "gray";
			obj.value = "邮箱";
			msg.innerHTML = "";
		} else {
			var emailReg = /^([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+.[a-zA-Z]{2,3}$/;
			if (!emailReg.test(obj.value)) {
				msg.innerHTML = "邮箱格式不正确";
			} else {
				msg.innerHTML = "";
			}
		}
	}

	function emailFocus(obj) {
		if (obj.value == "邮箱") {
			obj.value = "";
			obj.style.color = "black";
		}
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
		var memberEmail = document.getElementsByName("memberEmail")[0].value;
		var memberPwd = document.getElementsByName("memberPwd")[0].value;
		var auto = document.getElementsByName("auto")[0].value;

		xmlhttp.open("post", "member!login.action?memberEmail=" + memberEmail
				+ "&memberPwd=" + memberPwd + "&auto=" + auto, true);
		//(3) : 指定回调函数
		xmlhttp.onreadystatechange = handler;
		//(4) : 开始交互 ， 发送请求
		xmlhttp.send();

	}

	function handler() {
		var msg = document.getElementById("msg");

		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { //如果成功交互且服务器正常 , 开始处理
			//获得服务器的响应数据
			if (xmlhttp.responseText == "online") {
				msg.innerHTML = "该用户已登录，不可同时再次登录！";
			} else {
				var res = eval('(' + xmlhttp.responseText + ')');
				if (!res) {
					msg.innerHTML = "用户名或密码错误！";
				}else {
					var url = window.location.toString();
					if (url.slice(url.lastIndexOf("/") + 1) == "login.jsp") {
						window.location = "index.jsp";
					} else {
						window.history.back();
						window.location.reload();
					}
				}
			}

		} else {
			msg.innerHTML = "请稍等...";
		}
	}
</script>

</head>

<body>
	<div id="header">
		<s:include value="head.jsp"></s:include>
	</div>
	<div id="main">
		<fieldset style="width:300px; float:right; margin-right:50px;">
			<legend>登录 Login</legend>
			<form onkeypress="if(event.keyCode==13){func();}">
				<s:textfield name="memberEmail" label="账　号" value="邮箱"
					style="width:200px; color:gray; margin:5px;"
					onfocus="emailFocus(this)" onblur="emailBlur(this)" />
				<br />
				<s:password name="memberPwd" label="密　码"
					style="width:200px; margin:5px;" />
				<br />
				<s:checkbox name="auto" label="30天内自动登录" fieldValue="false"
					style="margin:5px;" />
				<br /> <input type="button" value="登录" style="margin:5px;"
					onclick="func()" />
			</form>
			您还没有雨涛电影的帐号，
			<s:a href="register.jsp">立即注册</s:a>
			<br /> <span id="msg" style="color:red; font-size: 20;"></span>
		</fieldset>
	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

</body>
</html>
