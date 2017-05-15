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

<title>雨涛电影 用户中心</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/memberCenter.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/left.css" type="text/css" rel="stylesheet" />
<link href="styles/right.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/TianRen/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/TianRen/scripts/global.js"></script>

</head>

<body>
	<s:if test="#request.lstTickets==null">
		<script>
			location = "ticket!showTodayOrder.action";
		</script>
	</s:if>

	<div id="header">
		<s:include value="head.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_top">
			<a href="index.jsp" class="aToptxt">雨涛电影</a>
			&nbsp;&gt;&nbsp;
			<a href="memberCenter.jsp" class="aToptxt">用户中心</a>
		</div>
		<div id="main_left">
			<s:include value="left.jsp"></s:include>
		</div>

		<div id="main_center">
			<div id="main_center_top">
				<fieldset>
					<table width="560" border="0" align="left" cellpadding="5"
						cellspacing="0">
						<tr>
							<th width="140" scope="col">
								<fieldset style="padding-top:10px;">
									<s:a href="updateInfo.jsp">
										<s:if test="#session.curMember.memberPhoto==null">
											<img src="images/user_male.jpg" title="点击修改头像" width="130px"
												style="margin-top:10px;" />
										</s:if>
										<s:else>
											<s:generator separator=","
												val="#session.curMember.memberPhoto">
												<s:iterator>
													<img src='<s:property />' title="点击修改头像" border="0"
														width="130px" />
												</s:iterator>
											</s:generator>
										</s:else>
									</s:a>
								</fieldset></th>
							<th align="center" valign="middle" scope="col" style="font-size:20px;">欢迎您，<s:if
									test="#session.curMember.memberName==null">
									<s:property value="#session.curMember.memberEmail" />
								</s:if> <s:else>
									<s:property value="#session.curMember.memberName" />
									<s:if test="#session.curMember.memberGender==1">先生</s:if>
									<s:else>女士</s:else>
								</s:else>
							</th>
						</tr>
					</table>
					<hr style="clear:both;" />
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">交易提醒：</td>
							<td><s:if test="#request.lstTickets.size()==0">无</s:if> <s:else>
									<table border="0" cellpadding="5" cellspacing="0">

										<s:iterator var="ticket" value="#request.lstTickets" status="index">
											<tr>
												<td>（<s:property value="#index.index+1"/>）订单号：<s:property value="#ticket.ticketCode" />
												</td>
												<td>电影：<s:property value="#ticket.play.movie.movieName" />(<s:property
														value="#ticket.play.movie.edition.editionName" />) <br />场次时间：<s:date
														name="#ticket.play.playTime" format="MM月dd日 HH时mm分" /><br />座位号：<s:property
														value="#ticket.ticketSeat" />号</td>
											</tr>
										</s:iterator>

									</table>
								</s:else></td>
						</tr>
					</table>
				</fieldset>
			</div>

			<div id="main_center_bottom">
				<fieldset style="padding: 10px;">
					<span>近期影片推荐</span>
					<s:a href="movies.jsp" style="float:right;">更多热门电影</s:a>
					<s:iterator var="movie" value="#request.afterMovieByPage.data">
						<hr />
						<table width="100%" border="0" cellspacing="0" cellpadding="5">
							<tr>
								<td rowspan="3"><s:a href="#">
										<s:generator separator="," val="#movie.moviePhoto">
											<s:iterator>
												<img src='<s:property />' border="0" width="160px" />
											</s:iterator>
										</s:generator>
									</s:a></td>
								<td><b><s:a>
											<s:property value="#movie.movieName" />
										</s:a> </b>上映日期：<s:date name="#movie.movieDate" format="yyyy年MM月dd日" />
								</td>
							</tr>
							<tr>
								<td>主演：<s:property value="#movie.movieActor" /></td>
							</tr>
							<tr>
								<td><s:property value="#movie.movieInfo" />
								</td>
							</tr>
							<tr>
								<td align="center"><s:a action="play"
										method="showOneMoviePlaies">
										<s:param name="movieName" value="#movie.movieName" />立即购票</s:a>
								</td>
								<td><s:a action="play" method="showOneMoviePlaies">
										<s:param name="movieName" value="#movie.movieName" />介绍</s:a> | <s:a
										action="play" method="showOneMoviePlaies">
										<s:param name="movieName" value="#movie.movieName" />排片表</s:a>
								</td>
							</tr>
						</table>
					</s:iterator>
				</fieldset>
			</div>

		</div>

		<div id="main_right">
			<s:include value="right.jsp"></s:include>
		</div>

	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

</body>
</html>
