<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<fieldset>
	<legend>管理菜单</legend>
	<ul style="line-height: 20px;">
		<s:iterator var="lstPrivilege" value="#session.lstPrivilege">
			<s:if test="#lstPrivilege==1">
				<li><s:a action="movie" method="searchMoviesByPage"
						namespace="/">影片管理</s:a></li>
			</s:if>
			<s:if test="#lstPrivilege==2">
				<li><s:a action="play" method="findPlaiesByTimeByPage"
						namespace="/">场次管理</s:a></li>
			</s:if>
			<s:if test="#lstPrivilege==3">
				<li><s:a action="member" method="searchMembersByPage"
						namespace="/">用户管理</s:a></li>
			</s:if>
			<s:if test="#lstPrivilege==4">
				<li><s:a href="admin/showTickets.jsp">票务管理</s:a></li>
			</s:if>
			<s:if test="#lstPrivilege==5">
				<li><s:a href="admin/updateAd.jsp">广告管理</s:a></li>
			</s:if>
			<s:if test="#lstPrivilege==6">
				<li><s:a action="admin" method="searchAdmin" namespace="/">管理员管理</s:a>
				</li>
			</s:if>
		</s:iterator>
	</ul>
</fieldset>