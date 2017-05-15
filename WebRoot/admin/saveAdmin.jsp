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

<title>雨涛电影后台管理 添加管理员</title>

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
	var nameFlag = false, pwdFlag = false, privilegeFlag = false;
	//权限验证
	function privilegeClick() {
		var privilegeMsg = document.getElementById("privilegeMsg");
		var objPrivilege = document.getElementsByName("adminPrivilege");
		for ( var i = 0; i < objPrivilege.length; i++) {
			if (objPrivilege[i].checked == true) {
				privilegeFlag = true;
			}
		}
		if (!privilegeFlag) {
			privilegeMsg.innerHTML = "请选择管理权限！";
			privilegeFlag = false;
			checkSubmit();
		} else {
			privilegeMsg.innerHTML = "";
			privilegeFlag = true;
			checkSubmit();
		}
	}

	function nameBlur() {
		var objName = document.getElementsByName("adminName")[0];
		var nameMsg = document.getElementById("nameMsg");
		if (objName.value.length == 0 || objName.value == "") {
			nameMsg.innerHTML = "对不起，请输入管理员登录名！";
			nameFlag = false;
			checkSubmit();
		} else {
			//(1) : xmlhttp 的创建
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			//(2) : 指定交互路径
			xmlhttp.open("post", "admin!IsExistAdminName.action?AdminName="
					+ objName.value, true);
			//(3) : 指定回调函数
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { //如果成功交互且服务器正常 , 开始处理
					//获得服务器的响应数据
					var res = eval('(' + xmlhttp.responseText + ')');
					if (res) {
						nameMsg.innerHTML = "对不起，该管理员已被注册";
						nameFlag = false;
						checkSubmit();
					} else {
						nameMsg.innerHTML = "";
						nameFlag = true;
						checkSubmit();
					}
				} else {
					nameMsg.innerHTML = "请稍等...";
				}
			};
			//(4) : 开始交互 ， 发送请求
			xmlhttp.send();
		}
	}

	function pwdBlur() {
		var objPwd = document.getElementsByName("adminPwd")[0];
		var pwdMsg = document.getElementById("pwdMsg");
		if (objPwd.value.length == 0 || objPwd.value == "") {
			pwdMsg.innerHTML = "请填写您的密码";
			pwdFlag = false;
			checkSubmit();
		} else {
			pwdMsg.innerHTML = "";
			pwdFlag = true;
			checkSubmit();
		}
	}

	function checkSubmit() {
		if (nameFlag && pwdFlag && privilegeFlag) {
			document.getElementById("submit").disabled = false;
		} else {
			document.getElementById("submit").disabled = true;
		}
	}

	function resetClick() {
		var nameMsg = document.getElementById("nameMsg");
		nameMsg.innerHTML = "对不起，请输入管理员登录名！";
		var pwdMsg = document.getElementById("pwdMsg");
		pwdMsg.innerHTML = "请填写您的密码";
		var privilegeMsg = document.getElementById("privilegeMsg");
		privilegeMsg.innerHTML = "请选择管理权限！";
		document.getElementById("submit").disabled = true;
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
				<legend>添加管理员</legend>
				<s:form action="admin" namespace="/" style="position: relative;">
					<s:textfield name="adminName" label="管理员登录名" style="width:200px;"
						onblur="nameBlur()" />
					<span id="nameMsg"
						style="position:absolute; top:10px; left:310px; color:red; width:100%;"></span>
					<s:password name="adminPwd" label="管理员密码" style="width:200px;"
						onblur="pwdBlur()" />
					<span id="pwdMsg"
						style="position:absolute; top:35px; left:310px; color:red; width:100%;"></span>
					<s:checkboxlist
						list="#{1:'影片管理',2:'场次管理',3:'用户管理',4:'票务管理',5 : '广告管理',6:'管理员管理'}"
						listKey="key" listValue="value" name="adminPrivilege"
						label="管理员权限" onclick="privilegeClick()" />
					<s:reset value="重置" style="float:left;" onclick="resetClick();" />
					<s:submit value="确认保存" method="saveAdmin" id="submit"
						disabled="true" />
				</s:form>
				<span id="privilegeMsg" style="color:red;"></span>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
