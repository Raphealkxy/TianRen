<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>雨涛电影后台管理 修改管理员信息</title>
    
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

  </head>
  
  <body>
    <div id="header">
		<s:include value="adminHead.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_left" style="float:left; width:180px; margin: 10px;">
			<s:include value="adminLeft.jsp"></s:include>
		</div>
		<div id="main_right" style="margin: 10px; float:left;">
			<fieldset>
				<legend>修改管理员信息</legend>
				<s:form action="admin" namespace="/">
					<s:hidden name="adminId" value="%{#request.admin.adminId}" />
					<s:textfield name="adminName" label="管理员登录名" style="width:200px;"
						value="%{#request.admin.adminName}" />
					<s:password name="adminPwd" label="管理员密码" style="width:200px;"
						value="%{#request.admin.adminPwd}" />
					<s:checkboxlist list="#{1:'影片管理',2:'场次管理',3:'用户管理',4:'票务管理',5 : '广告管理',6:'管理员管理'}"
						listKey="key" listValue="value" name="adminPrivilege"
						label="管理员权限" value="%{#request.lstPrivilege}"></s:checkboxlist>
					<s:submit value="保存修改" method="modifyAdmin"></s:submit>
				</s:form>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
  </body>
</html>
