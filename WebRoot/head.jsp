<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div id="header_menu">
	<div id="header_menu_left">
		&nbsp;
		<a href="index.jsp" class="aToptxt">雨涛电影</a>
	</div>
	<div id="header_menu_right">
		<s:if test="#session.curMember==null">
			<a href="register.jsp" class="aToptxt">注册</a><span>|</span>
	        <a href="login.jsp" class="aToptxt">登录</a><span>|</span>
		</s:if>
		<s:else>
        	<span>欢迎您，
        	<s:if test="#session.curMember.memberName==null||#session.curMember.memberName==''">
				<s:property value="#session.curMember.memberEmail" />
			</s:if>
			<s:else>
				<s:property value="#session.curMember.memberName" />
				<s:if test="#session.curMember.memberGender==1">先生</s:if>
				<s:else>女士</s:else>
			</s:else></span><span>|</span>       	   	
        	<a class="aToptxt" style="cursor: hand; " onclick="location='member!logout.action';">退出</a><span>|</span>
        	<a href="memberCenter.jsp" class="aToptxt">用户中心</a><span>|</span>
		</s:else>
		
		<a href="#" class="aToptxt">帮助中心</a>&nbsp;
	</div>
</div>

<div id="header_middle">

	<div id="header_middle_left">
	<marquee id="marquee" behavior="alternate" direction="right" >
		<s:iterator var="ad" value="#application.lstAd">
			<s:if test="#ad.adId==1">
				<s:a href="%{#ad.adHref}">
					<s:generator separator="," val="#ad.adImg">
						<s:iterator>
							<img src='<s:property />' border="0" height="75" onMouseOut="document.getElementById('marquee').start()" onMouseOver="document.getElementById('marquee').stop()"/>
						</s:iterator>
					</s:generator>
				</s:a>
			</s:if>
		</s:iterator>
		</marquee>	
	</div>

	<div id="header_middle_right">
		<s:form action="play" theme="simple">
			<s:textfield name="movieName" value="请输入影片名称查询场次"
					style="width:200px; color:gray; margin:5px;" onfocus="if (this.value == '请输入影片名称查询场次') {this.value = '';this.style.color = 'black';}" onblur="if (this.value == '' || this == 0) {this.style.color = 'gray';this.value = '请输入影片名称查询场次';}" />
			<s:textfield style="display:none;" />
			<s:submit value="搜索" method="showPlayTable"  style="vertical-align: middle;"/>
		</s:form>
	</div>
</div>

<div id="header_bottommenu">
	<a href="index.jsp" class="aMenuTxt">首页</a>
	|
	<a href="time.jsp" class="aMenuTxt">放映时刻表</a>
	|
	<a href="movies.jsp" class="aMenuTxt">电影</a>
</div>