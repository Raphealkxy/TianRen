<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:iterator var="ad" value="#application.lstAd">
			<s:if test="#ad.adId>4&&#ad.adId<10">
				<s:a href="%{#ad.adHref}">
					<s:generator separator="," val="#ad.adImg">
						<s:iterator>
							<img src='<s:property />' border="0" width="230"/>
						</s:iterator>
					</s:generator>
				</s:a>
			</s:if>
		</s:iterator>