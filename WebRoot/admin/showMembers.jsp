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

<title>雨涛电影后台管理 用户管理</title>

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

<script type="text/javascript" charset="utf-8">
	function changePageSize(obj) {
		var pageSize = obj.value;
		var movieName = document.getElementsByName("memberName")[0].value;
		location = "./member!searchMembersByPage.action?pageSize=" + pageSize+"&searchWord=" + movieName;
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
		<div id="main_right" style="margin: 10px; float: left; width:1120px; overflow:auto;">
			<fieldset>
				<legend>用户管理</legend>
				<h4>
					<s:a href="admin/saveMember.jsp">添加用户</s:a>
				</h4>
				<hr />
				<s:form action="member" method="post" namespace="/">
					<s:textfield name="memberName" value="%{#request.searchWord}"
						label="用户名" />
					<s:textfield style="display:none;" />
					<s:submit value="搜索" method="searchMembersByPage" />
				</s:form>
				<hr />
				<table width="100%" cellpadding="5px;" border="1">
					<tr>
						<th>电子邮箱</th>
						<th>姓名</th>
						<th>密码</th>
						<th>性别</th>
						<th>电话</th>
						<th>操作</th>
					</tr>
					<s:iterator var="member" value="#request.searchMembersByPage.data">
						<tr align="center">
							<td><s:property value="#member.memberEmail" />
							</td>
							<td><s:property value="#member.memberName" />
							</td>
							<td><s:property value="#member.memberPwd" />
							</td>
							<td><s:if test="#member.memberGender">男</s:if> <s:else>女</s:else>
							</td>
							<td><s:property value="#member.memberPhone" />
							</td>
							<td><s:a action="member" method="findMemberById">
									<s:param name="memberId" value="#member.memberId" />修改</s:a><br />
								<s:a action="member" method="removeMember"
									onclick="return confirm('您确定要删除该用户？')">
									<s:param name="memberId" value="#member.memberId" />删除</s:a>
							</td>
						</tr>
					</s:iterator>
				</table>

				请选择：第
				<s:iterator var="i" begin="1"
					end="%{#request.searchMembersByPage.totalPages}">
					<s:if test="#request.searchMembersByPage.currentPage != #i ">
						<s:a action="member" method="searchMembersByPage" namespace="/"
							style="color:blue;">
							<s:param name="currentPage" value="#i" />
							<s:param name="pageSize"
								value="#request.searchMembersByPage.pageSize" />
							<s:param name="searchWord" value="#request.searchWord" />
							<s:property value="#i" />
						</s:a>
					</s:if>

					<s:if test="#request.searchMembersByPage.currentPage == #i">
						<strong style="color:red;"><s:property value="#i" /> </strong>
					</s:if>
				</s:iterator>
				页 共
				<s:property value="#request.searchMembersByPage.totalRows" />
				位用户
				<s:select list="(10).{#this+1}" name="pageSize" label="每页显示条数"
					value="#request.searchMembersByPage.pageSize"
					onchange="changePageSize(this)" />
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
