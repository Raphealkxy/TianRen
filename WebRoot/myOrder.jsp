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

<title>雨涛电影 我的订单</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/myOrder.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/left.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/TianRen/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/TianRen/scripts/global.js"></script>

<script type="text/javascript">
	function showfalgTime(i) {
		var ticketFlag=document.getElementById("ticketFlag"+i).value;
		if(!eval(ticketFlag)){
			document.getElementById("flagTime" + i).innerHTML = "超时";
			document.getElementById("operate" + i).innerHTML = "已失效";
			return;
		}
		var playTime = document.getElementById("playTime" + i).innerHTML;

		var playDay = playTime.replace(/年/g, '-').replace(/月/g, '-').replace(
				/日/g, '').replace(/ /, '-').replace(/时/g, '-')
				.replace(/分/g, '');
		playDay = playDay.split("-");
		var endDay = new Date(playDay[0], playDay[1] - 1, playDay[2],
				playDay[3] - 3, playDay[4], 0);

		var now = new Date();
		if (now < endDay) {
			var hours = Math.floor((endDay - now) / 1000 / 3600);
			var minutes = Math.floor((endDay - now) / 1000 / 60 % 60);
			var seconds = Math.floor((endDay - now) / 1000 % 60);
			document.getElementById("flagTime" + i).innerHTML = hours + "小时"
					+ minutes + "分" + seconds + "秒";
			document.getElementById("hiddenOperate" + i).style.display="block";
		} else {
			document.getElementById("flagTime" + i).innerHTML = "超时";
			document.getElementById("operate" + i).innerHTML = "已失效";
		}
	}
	//加载函数
	window.onload = function() {
		for ( var i = 1; i <= parseInt(document.getElementById("size").value); i++) {
			window.setInterval("showfalgTime(" + i + ");", 1000);
		}
	};
</script>
</head>

<body>
	<s:if test="#request.ticketsByMemberByPage==null">
		<script>
			location = "ticket!showOrder.action";
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
			&nbsp;&gt;&nbsp;
			<a href="myOrder.jsp" class="aToptxt">我的订单</a>
		</div>

		<div id="main_left">
			<s:include value="left.jsp"></s:include>
		</div>

		<div id="main_right">
			<fieldset style="padding:10px;">
				<div id="main_right_top">我的电影订单</div>
				<div id="main_right_middle">
					<table width="100%" border="0" cellspacing="0" cellpadding="5">
						<tr>
							<th scope="col">订单编号</th>
							<th scope="col">电影名称</th>
							<th scope="col">场次时间</th>
							<th scope="col">座位号</th>
							<th scope="col">订单时间</th>
							<th scope="col">订单金额</th>
							<th scope="col">订单状态</th>
							<th scope="col">剩余退票时间</th>
							<th scope="col">操 作</th>
						</tr>
						<s:hidden id="size"
							value="%{#request.ticketsByMemberByPage.data.size()}" />
						<s:if test="#request.ticketsByMemberByPage.data.size()==0">
							<tr>
								<td colspan="9" align="center">暂无记录</td>
							</tr>
						</s:if>
						<s:else>
							<s:iterator var="ticket"
								value="#request.ticketsByMemberByPage.data" status="s">
								<tr align="center">
									<td><s:property value="#ticket.ticketCode" />
									</td>
									<td><s:property value="#ticket.play.movie.movieName" />(<s:property
											value="#ticket.play.movie.edition.editionName" />)</td>
									<td id="playTime<s:property value="#s.index+1"/>"><s:date
											name="#ticket.play.playTime" format="yyyy年MM月dd日 HH时mm分" />
									</td>
									<td><s:property value="#ticket.ticketSeat" />号</td>
									<td id="ticketDate<s:property value="#s.index+1"/>"><s:date
											name="#ticket.ticketDate" format="yyyy年MM月dd日 HH时mm分" />
									</td>
									<td><s:property value="#ticket.ticketPrice" />元</td>
									<td><s:hidden id="ticketFlag%{#s.index+1}"
											value="%{#ticket.ticketFlag}" /> <s:if
											test="#ticket.ticketFlag">已付款</s:if> <s:else>已退票</s:else></td>
									<td id="flagTime<s:property value="#s.index+1"/>"></td>
									<td id="operate<s:property value="#s.index+1"/>">
									<div id="hiddenOperate<s:property value="#s.index+1"/>" style="display: none;">
											<s:a action="ticket" method="returnTicket" onclick=" return confirm('确认退票？'); ">
												<s:param name="ticketId" value="#ticket.ticketId" />
												<s:param name="currentPage"
													value="#request.ticketsByMemberByPage.currentPage" />退票</s:a>
													</div>
										</td>
								</tr>
							</s:iterator>
						</s:else>
					</table>
					<div style="text-align:right; clear:both;">
						<s:if test="#request.ticketsByMemberByPage.data!=null">
					请选择：第
								<s:iterator var="i" begin="1"
								end="#request.ticketsByMemberByPage.totalPages">

								<s:if test="#request.ticketsByMemberByPage.currentPage != #i">
									<s:a action="ticket" method="showOrder" namespace="/"
										style="color:blue;">
										<s:param name="currentPage" value="#i" />
										<s:property value="#i" />
									</s:a>
								</s:if>

								<s:if test="#request.ticketsByMemberByPage.currentPage == #i">
									<strong style="color:red;"><s:property value="#i" />
									</strong>
								</s:if>
							</s:iterator>
								页
							</s:if>
					</div>
				</div>
			</fieldset>
		</div>

	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

</body>

</html>
