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

<title>雨涛电影后台管理 票务管理</title>

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
				<legend>票务管理</legend>
				<s:form action="ticket" method="post" namespace="/">
					<s:textfield name="ticketCode" label="订单号" style="width:400px;" />
					<s:textfield style="display:none;" />
					<s:submit value="搜索" method="searchTickets" />
				</s:form>
				<hr />
				<s:if test="#request.baseInfo!=null">
					<table width="100%" cellpadding="5px;" border="1">
						<tr>						
							<th>订票时间</th>
							<td><s:date name="#request.baseInfo.ticketDate"
									format="yyyy年MM月dd日 E HH时mm分" />
							</td>
							<th>票价</th>
							<td><s:property value="#request.baseInfo.ticketPrice" />元
							</td>
						</tr>
						<tr>
							<th>用户名</th>
							<td><s:property
									value="#request.baseInfo.member.memberName" /></td>
							<th>用户邮箱</th>
							<td><s:property
									value="#request.baseInfo.member.memberEmail" /></td>
						</tr>
						<tr>
							<th>电影</th>
							<td><s:property
									value="#request.baseInfo.play.movie.movieName" />（<s:property
									value="#request.baseInfo.play.movie.edition.editionName" />）<s:property
									value="#request.baseInfo.play.movie.language.languageName" />
							</td>
							<th>场次时间</th>
							<td><s:date name="#request.baseInfo.play.playTime"
									format="yyyy年MM月dd日 E HH时mm分" /></td>
						</tr>
					</table>
					<table width="100%" cellpadding="5px;" border="1">
					<tr>
						<th>已订票</th>
						<th>已退票</th>
					</tr>
					<tr align="center">
						<s:if test="#request.lstTickets!=null">
							<td><s:iterator var="ticket" value="#request.lstTickets">
									<s:property value="#ticket.ticketSeat" />号座位
							</s:iterator></td>
						</s:if>
						<s:else>
							<td>无</td>
						</s:else>
						<s:if test="#request.lstReturnTickets!=null">
							<td><s:iterator var="ticket"
									value="#request.lstReturnTickets">
									<s:property value="#ticket.ticketSeat" />号座位
							</s:iterator></td>
						</s:if>
						<s:else>
							<td>无</td>
						</s:else>
					</tr>
				</table>
				</s:if>
				<s:else>
					<table width="100%" cellpadding="5px;" border="1">
						<tr>
							<th>暂无信息</th>
						</tr>
					</table>
				</s:else>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>

