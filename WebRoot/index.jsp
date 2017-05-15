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

<title>雨涛电影 首页</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/index.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/right.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />
<script src="SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<link href="SpryAssets/SpryTabbedPanels.css" rel="stylesheet"
	type="text/css" />
	
<script type="text/javascript" src="/TianRen/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/TianRen/scripts/global.js"></script>

<script type="text/javascript">
	function clickButton(movieName) {
		location = "play!showOneMoviePlaies.action?movieName=" + encodeURI(movieName);
	}
</script>

</head>

<body>

	<s:if test="!#session.cookieFlag">
		<script>
			location = "member!prepareLogin.action";
		</script>
	</s:if>
	<s:if
		test="#request.beforeMovieByPage==null||#request.afterMovieByPage==null">
		<script>
			location = "movie!showBeforeAndAfterMovieByPageOnIndex.action";
		</script>
	</s:if>
	<div id="header">
		<s:include value="head.jsp" />
	</div>
	<div id="main">
		<div id="main_top">
			<s:iterator var="ad" value="#application.lstAd">
				<s:if test="#ad.adId==2">
					<a href="%{#ad.adHref}">
						<s:generator separator="," val="#ad.adImg">
							<s:iterator>
								<img src='<s:property />' border="0" width="1000"/>
							</s:iterator>
						</s:generator>
					</a>
				</s:if>
			</s:iterator>
		</div>
		<div id="main_left">
			<div id="main_left_top">

				<s:iterator var="ad" value="#application.lstAd">
					<s:if test="#ad.adId==10">
						<s:hidden id="ad1Img" value="%{#ad.adImg}" />
						<s:hidden id="ad1Href" value="%{#ad.adHref}" />
					</s:if>
					<s:if test="#ad.adId==11">
						<s:hidden id="ad2Img" value="%{#ad.adImg}" />
						<s:hidden id="ad2Href" value="%{#ad.adHref}" />
					</s:if>
					<s:if test="#ad.adId==12">
						<s:hidden id="ad3Img" value="%{#ad.adImg}" />
						<s:hidden id="ad3Href" value="%{#ad.adHref}" />
					</s:if>
					<s:if test="#ad.adId==13">
						<s:hidden id="ad4Img" value="%{#ad.adImg}" />
						<s:hidden id="ad4Href" value="%{#ad.adHref}" />
					</s:if>
				</s:iterator>

				<DIV id="focusNewsArea">
					<DIV id="focusScrollArea">
						<DIV id="play" class="focusImgArea">
							<a target=_self href="javascript:goUrl()"> <span class="f14b">
									<script type="text/javascript">
										imgUrl1 = document
												.getElementById("ad1Img").value;
										imgtext1 = "广告01";
										imgLink1 = escape(document
												.getElementById("ad1Href").value);
										imgUrl2 = document
												.getElementById("ad2Img").value;
										imgtext2 = "广告02";
										imgLink2 = escape(document
												.getElementById("ad2Href").value);
										imgUrl3 = document
												.getElementById("ad3Img").value;
										imgtext3 = "广告03";
										imgLink3 = escape(document
												.getElementById("ad3Href").value);
										imgUrl4 = document
												.getElementById("ad4Img").value;
										imgtext4 = "广告04";
										imgLink4 = escape(document
												.getElementById("ad4Href").value);

										var focus_width = 760;
										var focus_height = 260;
										var text_height = 0;
										var swf_height = focus_height
												+ text_height;

										var pics = imgUrl1 + "|" + imgUrl2
												+ "|" + imgUrl3 + "|" + imgUrl4;
										var links = imgLink1 + "|" + imgLink2
												+ "|" + imgLink3 + "|"
												+ imgLink4;
										var texts = imgtext1 + "|" + imgtext2
												+ "|" + imgtext3 + "|"
												+ imgtext4;

										document
												.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ focus_width +'" height="'+ swf_height +'">');
										document
												.write('<param name="allowScriptAccess" value="sameDomain"><param name="movie" value="focus.swf"><param name="quality" value="high"><param name="bgcolor" value="#F0F0F0">');
										document
												.write('<param name="menu" value="false"><param name=wmode value="opaque">');
										document
												.write('<param name="FlashVars" value="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'">');
										document
												.write('<embed src="pixviewer.swf" wmode="opaque" FlashVars="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'" menu="false" bgcolor="#F0F0F0" quality="high" width="'+ focus_width +'" height="'+ focus_height +'" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
										document.write('</object>');
									</script> </span> </a><span id=focustext class=f14b> </span>
						</DIV>
					</DIV>
				</DIV>
			</div>

			<div id="main_left_middle">
				<div id="TabbedPanels1" class="TabbedPanels">
					<ul class="TabbedPanelsTabGroup">
						<li class="TabbedPanelsTab" tabindex="0">正在热播</li>
						<li class="TabbedPanelsTab" tabindex="0">即将上映</li>
					</ul>
					<div class="TabbedPanelsContentGroup">
						<div class="TabbedPanelsContent" style="width:100%;height:auto;">
							<s:iterator var="movie" value="#request.beforeMovieByPage.data">
								<ul class="main_left_middle_ul">
									<li><s:a action="play" method="showOneMoviePlaies">
											<s:param name="movieName" value="#movie.movieName" />
											<s:generator separator="," val="#movie.moviePhoto">
												<s:iterator>
													<img src='<s:property />' border="0" width="160px" />
												</s:iterator>
											</s:generator>
										</s:a></li>
									<li><b> <s:a action="play" method="showOneMoviePlaies">
												<s:param name="movieName" value="#movie.movieName" />
												<s:property value="#movie.movieName" />
											</s:a> </b></li>
									<li><b> <s:date name="#movie.movieDate"
												format="yyyy年MM月dd日" /> </b></li>
									<li><s:property
											value="#movie.movieInfo.substring(0,30)+'...'" /></li>
									<li><s:property value="#movie.movieActor" /></li>
									<li><input type="button" value="我要购票"
										onclick="clickButton('<s:property value="%{#movie.movieName}"/>')"
										style="float:right;" /></li>
								</ul>
							</s:iterator>
						</div>
						<div class="TabbedPanelsContent" style="width:100%;height:auto;">
							<s:iterator var="movie" value="#request.afterMovieByPage.data">
								<ul class="main_left_middle_ul">
									<li><s:a action="play" method="showOneMoviePlaies">
											<s:param name="movieName" value="#movie.movieName" />
											<s:generator separator="," val="#movie.moviePhoto">
												<s:iterator>
													<img src='<s:property />' border="0" width="160px" />
												</s:iterator>
											</s:generator>
										</s:a></li>
									<li><b> <s:a action="play" method="showOneMoviePlaies">
												<s:param name="movieName" value="#movie.movieName" />
												<s:property value="#movie.movieName" />
											</s:a> </b></li>
									<li><b> <s:date name="#movie.movieDate"
												format="yyyy年MM月dd日" /> </b></li>
									<li><s:property
											value="#movie.movieInfo.substring(0,30)+'...'" /></li>
									<li><s:property value="#movie.movieActor" /></li>
									<li><input type="button" value="我要购票"
										onclick="clickButton('<s:property value="%{#movie.movieName}"/>')"
										style="float:right;" /></li>
								</ul>
							</s:iterator>
						</div>
					</div>
				</div>
			</div>

			<div id="main_left_bottom">
				<s:iterator var="ad" value="#application.lstAd">
					<s:if test="#ad.adId==3">
						<s:a href="%{#ad.adHref}">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" width="760" />
								</s:iterator>
							</s:generator>
						</s:a>
					</s:if>
				</s:iterator>
			</div>

		</div>

		<div id="main_right">
			<s:include value="right.jsp"></s:include>
		</div>

		<div id="main_bottom">
			<s:iterator var="ad" value="#application.lstAd">
				<s:if test="#ad.adId==4">
					<s:a href="%{#ad.adHref}">
						<s:generator separator="," val="#ad.adImg">
							<s:iterator>
								<img src='<s:property />' border="0" />
							</s:iterator>
						</s:generator>
					</s:a>
				</s:if>
			</s:iterator>
		</div>
	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

	<script type="text/javascript">
<!--
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
//-->
  </script>
</body>
</html>
