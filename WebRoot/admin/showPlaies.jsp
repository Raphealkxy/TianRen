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
		document.getElementById("beginDay").childNodes(1).style.width = "100px";
		document.getElementById("endDay").childNodes(1).style.width = "100px";
		
	}
	function changePageSize(obj) {
		var pageSize = obj.value;
		var beginDay = dojo.widget.byId("beginDay");
		var endDay = dojo.widget.byId("endDay");
		
		window.location.href = "/TianRen/play!findPlaiesByTimeByPage.action?pageSize="
				+ pageSize + "&beginDay=" + beginDay.getValue()+"&endDay"+endDay.getValue();
	}
</script>
</head>

<body>
	<div id="header">
		<s:include value="adminHead.jsp" />
	</div>
	<div id="main">
		<div id="main_left" style="float:left; width:180px; margin: 10px;">
			<s:include value="adminLeft.jsp" />
		</div>
		<div id="main_right" style="margin: 10px; float: left; width:1120px; overflow: auto;">
			<fieldset>
				<legend>场次管理</legend>
				<h4>
					<s:a href="admin/savePlay.jsp">场次录入</s:a>
				</h4>
				<hr />
				<s:form theme="simple" action="play" namespace="/">
					<sx:datetimepicker name="beginDay" id="beginDay" label="场次时间范围"
						value="%{#request.beginTime}" displayFormat="yyyy年MM月dd日"
						toggleType="explode" toggleDuration="400" />&nbsp;--&nbsp;
					<sx:datetimepicker name="endDay" id="endDay"
						value="%{#request.endTime}" displayFormat="yyyy年MM月dd日"
						toggleType="explode" toggleDuration="400" />
					<br />
					<s:submit value="搜索" method="findPlaiesByTimeByPage"></s:submit>
				</s:form>
				<hr />
				<table width="100%" cellpadding="5px;" border="1">
					<tr>
						<th>现有场次</th>
						<th>电影片长</th>
						<th>电影片名</th>
						<th>电影语言</th>
						<th>电影版本</th>
						<th>上映时间</th>
						<th>操作</th>
					</tr>
					<s:iterator var="play" value="#request.plaiesByTimeByPage.data">
						<tr align="center">
							<td><s:date name="#play.playTime"
									format="yyyy年MM月dd日 E HH时mm分" />
							</td>
							<td><s:property value="#play.movie.movieLong" />分钟</td>
							<td><s:property value="#play.movie.movieName" />
							</td>
							<td><s:property value="#play.movie.language.languageName" />
							</td>
							<td><s:property value="#play.movie.edition.editionName" />
							</td>
							<td><s:date name="#play.movie.movieDate"
									format="yyyy年MM月dd日 E" />
							</td>
							<td><s:a action="play" method="findPlay">
									<s:param name="playId" value="#play.playId" />修改场次</s:a><br /> <s:a
									action="play" method="romevePlay"
									onclick="return confirm('您确定要删除该场次？')">
									<s:param name="playId" value="#play.playId" />删除场次</s:a>
							</td>
						</tr>
					</s:iterator>
				</table>

				请选择：第
				<s:iterator var="i" begin="1"
					end="#request.plaiesByTimeByPage.totalPages">
					<s:if test="#request.plaiesByTimeByPage.currentPage != #i ">
						<s:a action="movie" method="findPlaiesByTimeByPage" namespace="/"
							style="color:blue;">
							<s:param name="currentPage" value="#i" />
							<s:param name="pageSize"
								value="#request.plaiesByTimeByPage.pageSize" />
							<s:param name="beginDay" value="#request.beginTime" />
							<s:param name="endDay" value="#request.endTime" />
							<s:property value="#i" />
						</s:a>
					</s:if>

					<s:if test="#request.plaiesByTimeByPage.currentPage == #i">
						<strong style="color:red;"><s:property value="#i" /> </strong>
					</s:if>
				</s:iterator>
				页 共
				<s:property value="#request.plaiesByTimeByPage.totalRows" />
				部影片
				<s:select list="(10).{#this+1}" name="pageSize" label="每页显示条数"
					value="#request.plaiesByTimeByPage.pageSize"
					onchange="changePageSize(this)" />

			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp" />
	</div>
</body>
</html>
