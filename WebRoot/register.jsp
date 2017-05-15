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

<title>雨涛电影 注册</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/register.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/TianRen/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/TianRen/scripts/global.js"></script>

<script type="text/javascript">
	var emailFlag = false, pwdFlag = false, comPwdFlag = false,checkCodeFlag=false,look=false;
	
	function changeValidateCode(obj) {		
		var timenow = new Date().getTime();
		obj.src = "rand.action?d=" + timenow;
		
		checkCodeFlag=false;
		document.getElementsByName("checkCode")[0].value="";
		checkCodeMsg.innerHTML = "请填写验证码";
		checkSubmit();
	}

	
	var xmlhttp;
	function emailblur(obj) {
		var emailMsg = document.getElementById("emailMsg");
		var emailReg = /^([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+.[a-zA-Z]{2,3}$/;
		if(obj.value.length == 0 || obj.value == ""){
			emailMsg.innerHTML = "请填写您常用的邮箱作为账号";
			emailFlag=false;
			checkSubmit();
		}
		else if(!emailReg.test(obj.value)){				
			emailMsg.innerHTML="邮箱格式不正确";
			emailFlag=false;
			checkSubmit();
		}else{
			//(1) : xmlhttp 的创建
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}

			//(2) : 指定交互路径
			var memberEmail = document.getElementsByName("memberEmail")[0].value;

			xmlhttp.open("post",
					"member!IsExistMemberEmail.action?memberEmail="
							+ memberEmail, true);
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

	function pwdkeyup(obj) {
		var pwdMsg = document.getElementById("pwdMsg");
		if (obj.value.length<6||obj.value.length>20) {
			pwdMsg.innerHTML = "密码长度6-20位字母或者数字";
			pwdFlag = false;
		} else {
			pwdMsg.innerHTML = "密码合法.";
			pwdFlag = true;
		}

		var comPwdMsg = document.getElementById("comPwdMsg");
		if (obj.value != document.getElementsByName("comPwd")[0].value) {
			comPwdMsg.innerHTML = "2次密码不一致,请确认.";
			comPwdFlag = false;
		} else {
			comPwdMsg.innerHTML = "密码一致.";
			comPwdFlag = true;
		}
		checkSubmit();
	}

	function comPwdblur(obj) {
		var comPwdMsg = document.getElementById("comPwdMsg");
		if (obj.value.length == 0 || obj.value == "") {
			comPwdMsg.innerHTML = "密码长度6-20位字母或者数字";
			comPwdFlag = false;
		} else if (obj.value != document.getElementsByName("memberPwd")[0].value) {
			comPwdMsg.innerHTML = "2次密码不一致,请确认.";
			comPwdFlag = false;
		} else {
			comPwdMsg.innerHTML = "密码一致.";
			comPwdFlag = true;
		}
		checkSubmit();
	}

	function comPwdfocus(obj) {
		document.getElementById("submit").disabled = true;
	}
	
	function checkCodeblur(obj){
		if(obj.value.length != 0 || obj.value != "") {
			//(1) : xmlhttp 的创建
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}

			//(2) : 指定交互路径
			var checkCode = document.getElementsByName("checkCode")[0].value;

			xmlhttp.open("post",
					"member!checkCode.action?checkCode="
							+ checkCode, true);
			//(3) : 指定回调函数
			xmlhttp.onreadystatechange = checkCodeSubmit;
			//(4) : 开始交互 ， 发送请求
			xmlhttp.send();
		}else{
			var checkCodeMsg = document.getElementById("checkCodeMsg");
			checkCodeMsg.innerHTML = "请填写验证码";
			pwdFlag=false;
			checkSubmit();
		}
	}
	
	function checkClickLook(obj){
		if(obj.checked){
			look=true;
		}else{
			look=false;
		}
		checkSubmit();
	}
	
	function checkCodeSubmit(){
		var checkCodeMsg = document.getElementById("checkCodeMsg");

		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { //如果成功交互且服务器正常 , 开始处理
			//获得服务器的响应数据
			var res = eval('(' + xmlhttp.responseText + ')');

			if (res) {
				checkCodeMsg.innerHTML = "验证码正确";
				checkCodeFlag = true;
				checkSubmit();
			} else {
				checkCodeMsg.innerHTML = "验证码不正确";
				checkCodeFlag = false;
				checkSubmit();
			}
		} else {
			checkCodeMsg.innerHTML = "请稍等...";
			checkCodeFlag = false;
			checkSubmit();
		}
	}

	function checkSubmit() {
		if (emailFlag && pwdFlag && comPwdFlag&&checkCodeFlag&&look) {
			document.getElementById("submit").disabled = false;
		} else {
			document.getElementById("submit").disabled = true;
		}
	}
</script>
</head>

<body>
	<div id="header">
		<s:include value="head.jsp"></s:include>
	</div>
	<div id="main">
		<fieldset>
			<legend>注册</legend>
			<s:form action="member" method="post" namespace="/"
				style="margin-left:300px; width:600px; position: relative;">
				<s:textfield name="memberEmail" label="* 电子邮箱" style="width:200px;"
					onblur="emailblur(this)" />
				<span id="emailMsg"
					style="position:absolute; top:10px; left:310px; color:red;">请填写您常用的邮箱作为账号</span>
				<s:radio list="#{true:'男',false:'女'}" listKey="key"
					listValue="value" value="true" name="memberGender" label="* 性别" />
				<s:password name="memberPwd" label="* 创建登录密码" style="width:200px;"
					onkeyup="pwdkeyup(this)" />
				<span id="pwdMsg"
					style="position:absolute; top:60px; left:310px; color:red;">输入登录密码，密码长度6-20位字母或者数字</span>
				<s:password name="comPwd" label="* 确认登录密码" style="width:200px;"
					onblur="comPwdblur(this)" onfocus="comPwdfocus(this)" />
				<span id="comPwdMsg"
					style="position:absolute; top:85px; left:310px; color:red;">输入确认登录密码，密码长度6-20位字母或者数字</span>
				<s:textfield name="checkCode" label="* 验证码" style="width:120px;" onblur="checkCodeblur(this)"/>
				<img src="rand.action" onclick="changeValidateCode(this)"
					title="看不清 点击换一张"
					style="border:1px #000000 solid; position: absolute; top:105px; left:240px;" />
					<span id="checkCodeMsg"
					style="position:absolute; top:110px; left:310px; color:red;"></span>
				<s:checkbox name="look" label="我已看过并同意" onclick="checkClickLook(this)" />
				<s:a style="position:absolute; top:135px; left:210px;">《用户协议》</s:a>
				<s:submit value="立即注册" method="register" id="submit" disabled="true"></s:submit>
			</s:form>
		</fieldset>
	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

</body>
</html>
