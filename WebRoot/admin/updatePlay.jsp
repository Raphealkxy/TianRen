<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
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

<sx:head parseContent="true" />

<title>雨涛电影后台管理 场次管理</title>

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

<script type="text/javascript">
	dojo.addOnLoad(setStyle);
	function setStyle() {
		document.getElementsByName("playDay")[0].childNodes(1).style.width = "100px";
	}

	function change() {
		var playDay = dojo.widget.byId("playDay");
		var playEndTime = document.getElementById("playEndTime");
		var playHour = document.getElementsByName("playHour")[0];
		var playMinute = document.getElementsByName("playMinute")[0];
		var movieLong = document.getElementById("movieLong");
		var playPrice = document.getElementsByName("playPrice")[0];

		if (playDay.getValue() == "" || playDay.getValue().length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>请选择日期</b>";
		} else if (playHour.value == "" || playHour.value.length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>请选择时间</b>";
		} else if (playMinute.value == "" || playMinute.value.length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>请选择分钟</b>";
		} else if (playPrice.value == "" || playPrice.value.length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>请填写些票价</b>";
		} else {
			var date = playDay.getValue().split("-");
			year = date[0];
			month = date[1];
			day = date[2].substr(0, 2);
			hour = playHour.value;
			minute = playMinute.value;
			var endTime = new Date();
			endTime.setTime(new Date(year, month - 1, day, hour, minute)
					.getTime()
					+ 1000 * 60 * movieLong.value);
			playEndTime.innerHTML = "&nbsp;--&nbsp;"
					+ endTime.toLocaleString().replace(/:\d{1,2}$/, '')
							.replace(':', '时') + "分";
		}

		if (playDay.getValue() == "" || playDay.getValue().length == 0
				|| movieLong.value == "" || movieLong.value.length == 0
				|| playHour.value == "" || playHour.value.length == 0
				|| playMinute.value == "" || playMinute.value.length == 0
				|| playPrice.value == "" || playPrice.value.length == 0) {
			document.getElementById("submit").disabled = true;
		} else {
			document.getElementById("submit").disabled = false;
		}
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
			<fieldset style="line-height: 20px;">
				<legend>修改场次</legend>
				
				<fieldset>
					<legend>影片信息</legend>
					<table cellpadding="5px;">
						<tr>
							<th width="100">电影片名：</th>
							<td><s:property value="#request.play.movie.movieName" />
							</td>
							<td align="right">
								<s:if test="#session.admin.adminPrivilege.index('1')!=-1">
									<s:a action="movie" method="showMovie">
									<s:param name="movieId" value="#request.play.movie.movieId" />修改该影片信息</s:a>
								</s:if>
							</td>
						</tr>
						<tr>
							<th>电影导演：</th>
							<td><s:property value="#request.play.movie.movieDirector" />
							</td>
							<td rowspan="8"><s:generator separator=","
									val="#request.play.movie.moviePhoto">
									<s:iterator>
										<img src='<s:property />' border="0" />
									</s:iterator>
								</s:generator></td>
						</tr>
						<tr>
							<th>电影演员：</th>
							<td><s:property value="#request.play.movie.movieActor" />
							</td>
						</tr>
						<tr>
							<th>电影语言：</th>
							<td><s:property
									value="#request.play.movie.language.languageName" />
							</td>
						</tr>
						<tr>
							<th>电影类型：</th>
							<td><s:property value="#request.play.movie.kind.kindName" />
							</td>
						</tr>
						<tr>
							<th>电影片长：</th>
							<td><s:property value="#request.play.movie.movieLong" />分钟
							</td>
						</tr>
						<tr>
							<th>电影版本：</th>
							<td><s:property
									value="#request.play.movie.edition.editionName" />
							</td>
						</tr>
						<tr>
							<th>上映时间：</th>
							<td><s:date name="#request.play.movie.movieDate"
									format="yyyy年MM月dd日 E" />
							</td>
						</tr>
						<tr>
							<th style="vertical-align: top;">电影信息：</th>
							<td><s:property value="#request.play.movie.movieInfo" />
							</td>
						</tr>
					</table>
				</fieldset>
				<hr />
				<s:hidden id="movieLong" value="%{#request.play.movie.movieLong}" />
				<s:form theme="simple" action="play" namespace="/">
				<s:hidden name="playId" value="%{#request.play.playId}"/>
					<sx:datetimepicker name="playDay" id="playDay" label="添加场次"
						value="%{#request.play.playTime}" displayFormat="yyyy年MM月dd日"
						toggleType="explode" toggleDuration="400" />

					<s:select list="(24).{#this}" name="playHour" value="#request.hour"
						headerKey="" headerValue="--" onchange="change()" />时
				
						<s:select list="(6).{#this+'0'}" name="playMinute"
						value="#request.minute" headerKey="" headerValue="--"
						onchange="change()" />分
						
						<span id="playEndTime"></span>
					<br />
					票价:<s:textfield name="playPrice" value="%{#request.play.playPrice}"
						maxLength="3" style="width:30px;" onkeyup="change()" />元
					<br />
					<s:submit value="确认修改" id="submit" disabled="true" method="modifyPlay" />
				</s:form>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>