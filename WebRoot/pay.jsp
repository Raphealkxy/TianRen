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

<title>雨涛电影 支付</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/pay.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/TianRen/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/TianRen/scripts/global.js"></script>

</head>

<body>
	<div id="header">
		<s:include value="head.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_top">
			<a href="index.jsp" class="aToptxt">天仁电影</a>&nbsp;&gt;&nbsp;<a href="time.jsp" class="aToptxt">购票</a>&nbsp;&gt;&nbsp;<a>完成支付</a>
		</div>

		<div id="main_bottom">
			<fieldset>
				<img src="images/v2_pay_nav.gif" style="margin-top:20px" />
				<div id="main_bottom_left">
					<ul>
						<li>您选择了：</li>
						<li><b>影片： <s:property
									value="#request.play.movie.movieName" />(<s:property
									value="#request.play.movie.edition.editionName" />)</b>
						</li>
						<li>场次：<s:date name="#request.play.playTime"
								format="yyyy-MM-dd HH:mm" />
						</li>
						<li>数量：<s:property value="#request.chooseSeatsNum.length" />张</li>
						<li>
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td valign="top">座位信息：</td>
									<td><ul style="display: inline;">
											<s:iterator var="seat" value="#request.chooseSeatsNum"
												status="s">
												<li><s:property value="#seat" />号座位</li>
											</s:iterator>
										</ul>
									</td>
								</tr>
							</table></li>
						<li>票价：<s:property value="#request.ticketPrice" />元</li>
					</ul>
					<br /> 总价：
					<s:property
						value="#request.ticketPrice*#request.chooseSeatsNum.length" />
					元
				</div>
				<div id="main_bottom_right">
					<s:form action="ticket" style="margin:30px; float:right;"
						namespace="/">
						<s:hidden name="playId" value="%{#request.play.playId}" />
						<s:hidden name="ticketPrice" value="%{#request.ticketPrice}" />
						<s:iterator var="seat" value="#request.chooseSeatsNum">
							<s:hidden name="chooseSeatsNum" value="%{#seat}" />
						</s:iterator>
						<s:submit value="确认付款" method="addTickets" />
					</s:form>
				</div>
			</fieldset>

		</div>

	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

</body>
</html>
