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

<title>雨涛电影后台管理 影片管理</title>

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
		<div id="main_right" style="margin: 10px; ">
			<fieldset>
				<legend>影片及场次管理</legend>
				<s:form action="movie" enctype="multipart/form-data" method="post"
					namespace="/" style="position: relative;">
					<s:hidden name="movieId" value="%{#request.movie.movieId}"/>
					<s:textfield name="movieName" label="电影片名"
						value="%{#request.movie.movieName}" style="width:800px;" />
					<s:textfield name="movieDirector" label="电影导演"
						value="%{#request.movie.movieDirector}" style="width:800px;" />
					<s:textfield name="movieActor" label="电影演员"
						value="%{#request.movie.movieActor}" style="width:800px;" />
					<s:radio list="#application.lstLanguage" listKey="languageId"
						listValue="languageName" name="languageId"
						value="%{#request.movie.language.languageId}" label="电影语言" />
					<s:select list="#application.lstKind" name="kindId"
						value="%{#request.movie.kind.kindId}" listKey="kindId"
						listValue="kindName" label="电影类型" />
					<s:file name="upload" label="上传图片" style="width:800px;" />
					<s:textfield name="movieLong" label="电影片长" maxlength="3"
						value="%{#request.movie.movieLong}" style="width:30px;" />
					<span style="position:absolute; top:170px; left:120px;">分钟</span>
					<s:radio list="#application.lstEdition" listKey="editionId"
						listValue="editionName"
						value="%{#request.movie.edition.editionId}" name="editionId"
						label="电影版本" />
					<s:textarea name="movieInfo" label="电影信息" rows="10" cols="100"
						value="%{#request.movie.movieInfo}" />
					<sx:datetimepicker name="movieDate" label="上映时间"
						value="%{#request.movie.movieDate}" />

					<s:submit value="保存修改" method="modifyMovie"></s:submit>

				</s:form>
				<s:iterator value="#request.lstPlaies" status="s" var="play">
						电影场次<s:property value="%{#s.index+1}" />:<s:date
						name="#play.playTime" format="yyyy年MM月dd日 E HH:mm" />
						<s:a action="play" method="findPlay">
						<s:param name="playId" value="#play.playId"/>
						修改该场次</s:a>
					<br />
				</s:iterator>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
