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

<title>雨涛电影 修改密码</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/updatePwd.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/left.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/TianRen/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/TianRen/scripts/global.js"></script>

<script type="text/javascript">
	var oldPwdflag = false, newPwdflag = false, comPwdflag = false;
	function oldPwdblur(obj) {
		if (obj.value.length != 0 || obj.value != "") {
			//(1) : xmlhttp 的创建
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}

			//(2) : 指定交互路径			
			xmlhttp.open("post", "member!checkOldMemberPwd.action?memberPwd="
					+ obj.value, true);
			//(3) : 指定回调函数
			xmlhttp.onreadystatechange = checkOldPwd;
			//(4) : 开始交互 ， 发送请求
			xmlhttp.send();
		} else {
			oldPwdflag = false;
			checkSubmit();
		}

	}

	function newPwdkeyup(obj) {
		var newPwdMsg = document.getElementById("newPwdMsg");
		if (obj.value.length<6||obj.value.length>20) {
			newPwdMsg.innerHTML = "密码长度6-20位字母或者数字";
			newPwdflag = false;
		} else {
			newPwdMsg.innerHTML = "密码合法.";
			newPwdflag = true;
		}

		var comPwdMsg = document.getElementById("comPwdMsg");
		if (obj.value != document.getElementsByName("comPwd")[0].value) {
			comPwdMsg.innerHTML = "2次密码不一致,请确认.";
			comPwdflag = false;
		} else {
			comPwdMsg.innerHTML = "密码一致.";
			comPwdflag = true;
		}
		checkSubmit();
	}

	function comPwdblur(obj) {
		var comPwdMsg = document.getElementById("comPwdMsg");
		if (obj.value.length == 0 || obj.value == "") {
			comPwdMsg.innerHTML = "密码长度6-20位字母或者数字";
			comPwdflag = false;
		} else if (obj.value != document.getElementsByName("memberPwd")[0].value) {
			comPwdMsg.innerHTML = "2次密码不一致,请确认.";
			comPwdflag = false;
		} else {
			comPwdMsg.innerHTML = "密码一致.";
			comPwdflag = true;
		}
		checkSubmit();
	}

	function comPwdfocus(obj) {
		document.getElementById("submit").disabled = true;
	}

	function checkOldPwd() {
		var oldPwdMsg = document.getElementById("oldPwdMsg");

		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { //如果成功交互且服务器正常 , 开始处理
			//获得服务器的响应数据
			var res = eval('(' + xmlhttp.responseText + ')');

			if (!res) {
				oldPwdMsg.innerHTML = "您输入的原密码不正确，请检查，注意区分大小写";
				oldPwdflag = false;
				checkSubmit();
			} else {
				oldPwdMsg.innerHTML = "";
				oldPwdflag = true;
				checkSubmit();
			}
		} else {
			oldPwdMsg.innerHTML = "请稍等...";
			oldPwdflag = false;
			checkSubmit();
		}
	}

	function checkSubmit() {
		if (oldPwdflag && newPwdflag && comPwdflag) {
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
		<div id="main_top">
			<a href="index.jsp" class="aToptxt">天仁电影</a>
			&nbsp;&gt;&nbsp;
			<a href="memberCenter.jsp" class="aToptxt">用户中心</a>
			&nbsp;&gt;&nbsp;
			<a href="updatePwd.jsp" class="aToptxt">修改密码</a>
		</div>
		<div id="main_left">
			<s:include value="left.jsp"></s:include>
		</div>

		<div id="main_center">
			<fieldset style="padding: 10px;">
				<div>修改密码</div>
				<s:form action="member"
					style="width:600px; margin:auto; position: relative;">
					<s:password name="oldPwd" label="> 输入原密码" onblur="oldPwdblur(this)" />
					<span id="oldPwdMsg"
						style="position:absolute; top:10px; left:250px; color:red;">请输入原密码，注意区分大小写</span>
					<s:password name="memberPwd" label="> 输入新密码"
						onkeyup="newPwdkeyup(this)" />
					<span id="newPwdMsg"
						style="position:absolute; top:35px; left:250px; color:red;">密码长度6-20位字母或者数字</span>
					<s:password name="comPwd" label="> 重复输入" onblur="comPwdblur(this)"
						onfocus="comPwdfocus(this)" />
					<span id="comPwdMsg"
						style="position:absolute; top:60px; left:250px; color:red;">密码长度6-20位字母或者数字</span>
					<s:submit id="submit" value="提交修改" method="modifyMemberPwd"
						disabled="true"></s:submit>
				</s:form>
			</fieldset>

		</div>

	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

</body>
</html>
