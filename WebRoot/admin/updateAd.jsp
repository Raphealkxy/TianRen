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

<title>雨涛电影后台管理 广告管理</title>

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
		<div id="main_right" style="margin: 10px; float: left; width:1120px; overflow:visible;">
			<fieldset>
				<legend>广告管理</legend>
				<s:iterator var="ad" value="#application.lstAd">
					<s:form action="ad" enctype="multipart/form-data" method="post"
						namespace="/">
						<s:if test="#ad.adId==1">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="LOGO" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>

						<s:if test="#ad.adId==2">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="头部广告" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==3">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="尾部广告1" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==4">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="尾部广告2" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>

						<s:if test="#ad.adId==5">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="右部广告1" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==6">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="右部广告2" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==7">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="右部广告3" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==8">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="右部广告4" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==9">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="右部广告5" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==10">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="动态广告1" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==11">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="动态广告2" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==12">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="动态广告3" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==13">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="动态广告4" />
							<s:textfield name="adHref" label="链接地址" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:submit value="确认修改" method="modifyAd" />
					</s:form>
					<s:if test="#ad.adId==1||#ad.adId==4||#ad.adId==9">
						<hr>
					</s:if>
				</s:iterator>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
