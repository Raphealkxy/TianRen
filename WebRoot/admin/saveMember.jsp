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

<title>雨涛电影后台管理 添加用户</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link rel="stylesheet" href="/TianRen/styles/global.css" type="text/css" />

<script type="text/javascript" src="/TianRen/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/TianRen/scripts/global.js"></script>

<script type="text/javascript">
	var emailFlag = false, pwdFlag = false;
	var xmlhttp;
	function emailBlur(obj) {
		var emailMsg = document.getElementById("emailMsg");
		var emailReg = /^([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+.[a-zA-Z]{2,3}$/;
		
		if (obj.value.length == 0 || obj.value == "") {
			emailMsg.innerHTML = "请填写您常用的邮箱作为账号";
			emailFlag = false;
			checkSubmit();
		} else if (!emailReg.test(obj.value)) {
			emailMsg.innerHTML = "邮箱格式不正确";
			emailFlag = false;
			checkSubmit();
		}  else {
			//(1) : xmlhttp 的创建
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}

			//(2) : 指定交互路径
			xmlhttp
					.open("post",
							"member!IsExistMemberEmail.action?memberEmail="
									+ obj.value, true);
			//(3) : 指定回调函数
			xmlhttp.onreadystatechange = checkEmail;
			//(4) : 开始交互 ， 发送请求
			xmlhttp.send();
		}
	}

	function checkEmail() {
		var emailMsg = document.getElementById("emailMsg");

		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { //如果成功交互且服务器正常 , 开始处理
			//获得服务器的响应数据
			var res = eval('(' + xmlhttp.responseText + ')');

			if (res) {
				emailMsg.innerHTML = "对不起，该邮箱已被注册";
				emailFlag = false;
				checkSubmit();
			} else {
				emailMsg.innerHTML = "";
				emailFlag = true;
				checkSubmit();
			}
		} else {
			emailMsg.innerHTML = "请稍等...";
			emailFlag = false;
			checkSubmit();
		}
	}

	function pwdBlur(obj) {
		var pwdMsg = document.getElementById("pwdMsg");
		if (obj.value.length == 0 || obj.value == "") {
			pwdMsg.innerHTML = "请填写您的密码";
			pwdFlag = false;
			checkSubmit();
		}else if (obj.value.length<6||obj.value.length>20) {
			pwdMsg.innerHTML = "密码长度6-20位字母或者数字";
			pwdFlag = false;
		} else {
			pwdMsg.innerHTML = "";
			pwdFlag = true;
		}
		checkSubmit();
	}

	function checkSubmit() {
		if (emailFlag && pwdFlag) {
			document.getElementById("submit").disabled = false;
		} else {
			document.getElementById("submit").disabled = true;
		}
	}
</script>
</head>

<body>
	<div id="header">
		<s:include value="adminHead.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_left" style="float:left; width:180px; margin: 10px;">
			<s:include value="adminLeft.jsp"></s:include>
		</div>
		<div id="main_right" style="margin: 10px; float: left;">
			<fieldset>
				<legend>添加用户</legend>
				<s:form action="member" namespace="/"
					style="position: relative;">
					<s:textfield name="memberEmail" label="电子邮箱" style="width:200px;"
						onblur="emailBlur(this)" />
					<span id="emailMsg"
						style="position:absolute; top:10px; left:310px; color:red; width:100%; background:none;"></span>
					<s:textfield name="memberName" label="姓名" style="width:200px;" />
					<s:password name="memberPwd" label="密码" style="width:200px;"
						onblur="pwdBlur(this)" />
					<span id="pwdMsg"
						style="position:absolute; top:65px; left:310px; color:red; width:100%; background:none;"></span>
					<s:radio list="#{true:'男',false:'女' }" listKey="key"
						listValue="value" value="true" name="memberGender" label="性别" />
					<s:textfield name="memberPhone" label="电话" style="width:200px;" />
					<s:submit value="确认保存" method="saveMember" id="submit" disabled="true"></s:submit>
				</s:form>

			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
