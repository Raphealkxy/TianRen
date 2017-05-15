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

<title>雨涛电影后台管理 管理员管理</title>

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
</head>

<body>
	<div id="header">
		<s:include value="adminHead.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_left" style="float:left; width:180px; margin: 10px;">
			<s:include value="adminLeft.jsp"></s:include>
		</div>
		<div id="main_right"
			style="margin: 10px; float: left; width:1120px; overflow:auto;">
			<fieldset>
				<legend>管理员管理</legend>
				<h4>
					<s:a href="admin/saveAdmin.jsp">添加管理员</s:a>
				</h4>
				<hr />
				<table width="100%" cellpadding="5px;" border="1">
					<tr>
						<th>管理员登录名</th>
						<th>管理员密码</th>
						<th>管理权限</th>
						<th>操作</th>
					</tr>
					<s:iterator var="admin" value="#request.lstAdmin">
						<tr align="center">
							<td><s:property value="#admin.adminName" /></td>
							<td><s:property value="#admin.adminPwd" /></td>
							<td><s:generator separator="," val="#admin.adminPrivilege"
									converter="%{privilegeConverter}">
									<s:iterator status="row">
										<s:if test="#row.index!=0">
											<br />
											<s:property />
										</s:if>
										<s:else>
											<s:property />
										</s:else>
									</s:iterator>
								</s:generator></td>
							<td><s:a action="admin" method="findAdminById">
									<s:param name="adminId" value="#admin.adminId" />修改</s:a><br /> <s:a
									action="admin" method="removeAdmin"
									onclick="return confirm('您确定要删除该管理员？')">
									<s:param name="adminId" value="#admin.adminId" />删除</s:a></td>
						</tr>
					</s:iterator>
				</table>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>