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

<title>雨涛电影 放映时刻表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/time.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/right.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />
<script src="SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<link href="SpryAssets/SpryTabbedPanels.css" rel="stylesheet"
	type="text/css" />

<script type="text/javascript" src="/TianRen/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/TianRen/scripts/global.js"></script>

<script type="text/javascript">
	var todayName = "",tomorrowName="", todayTime = "",tomorrowTime="", todayEdition = "",tomorrowEdition="";
	var todayTabbedPanels,tomorrowTabbedPanels;
	
	function changeCSS(obj){
		for(var i=0;i< obj.parentNode.getElementsByTagName("a").length;i++){
			obj.parentNode.getElementsByTagName("a")[i].style.removeAttribute("backgroundColor");
			obj.parentNode.getElementsByTagName("a")[i].style.color="#3399FF";
		}
		
		obj.style.backgroundColor="#3399FF";
		obj.style.color="white";
	}
	
	function setTodayNameClick(flag,obj){
		changeCSS(obj);
		
		todayName=flag;
		todayTabbedPanels = 1;
		showTimeTableClick(todayTabbedPanels);
	}
	function setTodayTimeClick(flag,obj) {
		changeCSS(obj);
		
		todayTime = flag;
		todayTabbedPanels = 1;
		showTimeTableClick(todayTabbedPanels);
	}
	function setTodayEditionClick(flag,obj) {
		changeCSS(obj);
		
		todayEdition = flag;
		todayTabbedPanels = 1;
		showTimeTableClick(todayTabbedPanels);
	}
	function setTomorrowNameClick(flag,obj){
		changeCSS(obj);
		
		tomorrowName=flag;
		tomorrowTabbedPanels = 2;
		showTimeTableClick(tomorrowTabbedPanels);
	}
	function setTomorrowTimeClick(flag,obj) {
		changeCSS(obj);
		
		tomorrowTime = flag;
		tomorrowTabbedPanels = 2;
		showTimeTableClick(tomorrowTabbedPanels);
	}
	function setTomorrowEditionClick(flag,obj) {
		changeCSS(obj);
		
		tomorrowEdition = flag;
		tomorrowTabbedPanels = 2;
		showTimeTableClick(tomorrowTabbedPanels);
	}

	function showTimeTableClick(TabbedPanels) {
		//(1) : xmlhttp 的创建
		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}

		//(2) : 指定交互路径		
		var name,time,edition;
		if(TabbedPanels==1){
			name=todayName;
			time=todayTime;
			edition=todayEdition;
		}else{
			name=tomorrowName;
			time=tomorrowTime;
			edition=tomorrowEdition;
		}
		
		xmlhttp.open("post", "play!showPlayTableByCondition.action?name="
				+ encodeURI(name) + "&time=" + time + "&edition=" + edition
				+ "&TabbedPanels=" + TabbedPanels, true);
		//(3) : 指定回调函数
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var json_data = eval('(' + xmlhttp.responseText + ')'); // 获取Json 数据
				
				//获取层
				var show_json = document.getElementById("json"+TabbedPanels);
					
				if(show_json.firstChild !=null) {
					show_json.removeChild(show_json.firstChild);
				}
				
				if (json_data != null && json_data.length > 0) { // 确保数据有效性
					
				
					//创建表格
					var table = document.createElement("table");
					table.border=1;
					table.cellSpacing=0;
					table.cellPadding=5;
					table.width=700;
				
					for( var i  = 0 ; i< json_data.length ; i++) {
						for(var j=0;j<json_data[i].lstPlaies.length;j++){
							var tr = table.insertRow(i+j);
							tr.align="center";
							if(j==0){						
								//创建列  
								var th = tr.document.createElement("th");					
								th.rowSpan=json_data[i].lstPlaies.length;
								var aMovieName=document.createElement("a");
								aMovieName.href="play!showOneMoviePlaies.action?movieName="+encodeURI(json_data[i].mapMovie.movieName);
								var movieName = document.createTextNode(json_data[i].mapMovie.movieName);
								aMovieName.appendChild(movieName);
								var movieKind=document.createTextNode(json_data[i].mapMovie.movieKindName);					
								var movieLong=document.createTextNode(json_data[i].mapMovie.movieLong+"分钟");
								
								th.appendChild(aMovieName);
								th.appendChild(document.createElement("br"));
								th.appendChild(movieKind);
								th.appendChild(document.createElement("br"));
								th.appendChild(movieLong);
								tr.appendChild(th);
							}
							
							var col;
							if(j==0){
								col=1;
							}else{
								col=0;
							}
							
							var td2 = tr.insertCell(0+col);
							var playTime = document.createTextNode(json_data[i].lstPlaies[j].playTime);
							td2.appendChild(playTime);
							tr.appendChild(td2);
								
							var td3=tr.insertCell(1+col);
							var ticketNum= document.createTextNode("余"+(450-json_data[i].lstPlaies[j].ticketNum)+"/450总");
							td3.appendChild(ticketNum);
							tr.appendChild(td3);
								
							var td4=tr.insertCell(2+col);
							var language = document.createTextNode(json_data[i].lstPlaies[j].language);
							td4.appendChild(language);
							tr.appendChild(td4);
								
							var td5=tr.insertCell(3+col);
							var edition = document.createTextNode(json_data[i].lstPlaies[j].edition);
							td5.appendChild(edition);
							tr.appendChild(td5);
								
							var td6=tr.insertCell(4+col);
							var playPrice = document.createTextNode("￥"+json_data[i].lstPlaies[j].playPrice+"元");
							td6.appendChild(playPrice);
							tr.appendChild(td6);
								
							var td7=tr.insertCell(5+col);
							var a = document.createElement("a");
							a.href="play!showSeat.action?playId="+json_data[i].lstPlaies[j].playId;
							var word=document.createTextNode("我要购票");
							a.appendChild(word);
							td7.appendChild(a);
							tr.appendChild(td7);
							
						}
					}
					
					show_json.appendChild(table);
				}
			}
		};
		//(4) : 开始交互 ， 发送请求
		xmlhttp.send();
	}
</script>
</head>

<body>
	<s:if
		test="#request.todayLstMapTime==null||#request.tomorrowLstMapTime==null">
		<script>
			location = "play!showPlayTable.action";
		</script>
	</s:if>
	<%
		Calendar cd = Calendar.getInstance();
		int hour = cd.get(Calendar.HOUR_OF_DAY);
		int todayMonth = cd.get(Calendar.MONTH) + 1;
		int today = cd.get(Calendar.DATE);
		cd.add(Calendar.DATE, 1);
		int tomorrowMonth = cd.get(Calendar.MONTH) + 1;
		int tomorrow = cd.get(Calendar.DATE);
	%>
	<div id="header">
		<s:include value="head.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_top">
			&nbsp; <a href="index.jsp" class="aToptxt">首页</a>&nbsp;&gt;&nbsp;<a href="time.jsp" class="aToptxt">放映时刻表</a>
		</div>
		<div id="main_left">

			<div id="main_left_middle">
				<div id="TabbedPanels1" class="TabbedPanels">
					<ul class="TabbedPanelsTabGroup">
						<li class="TabbedPanelsTab" tabindex="0">今日上映&nbsp;<%=todayMonth%>月<%=today%>日</li>
						<li class="TabbedPanelsTab" tabindex="0">明日上映&nbsp;<%=tomorrowMonth%>月<%=tomorrow%>日</li>
					</ul>
					<div class="TabbedPanelsContentGroup">
						<div class="TabbedPanelsContent">
							<table width="700">
								<tr>
									<td>影片： <a onclick="setTodayNameClick('',this)"
										style="cursor: hand; background-color:#3399FF; color:white;">[全部]</a>
										<s:iterator var="mapTime" value="#request.todayLstMapTime"
											status="s">
											<a id="todayName<s:property value="#s.index+1"/>"
												onclick="setTodayNameClick('<s:property value="#mapTime['mapMovie']['movieName']" />',this)"
												style="cursor: hand; color:#3399FF;"><s:property
													value="#mapTime['mapMovie']['movieName']" /> </a>&nbsp;
										</s:iterator></td>
								</tr>
								<tr>
									<td>时间： <a onclick="setTodayTimeClick('',this)"
										style="cursor: hand; background-color:#3399FF; color:white;">[全部]</a>
										<%
											if (hour < 12) {
										%> <a id="todayTime1" onclick="setTodayTimeClick('am',this)"
										style="cursor: hand; color:#3399FF;">上午</a> <%
 	};
 	if (hour < 18) {
 %> <a id="todayTime2" onclick="setTodayTimeClick('pm',this)"
										style="cursor: hand; color:#3399FF;">下午</a> <%
 	};
 %> <a id="todayTime3" onclick="setTodayTimeClick('night',this)"
										style="cursor: hand; color:#3399FF;">晚上</a>
									</td>
								</tr>
								<tr>
									<td>版本： <a onclick="setTodayEditionClick('',this)"
										style="cursor: hand; background-color:#3399FF; color:white;">[全部]</a>
										<s:iterator var="edition" value="#application.lstEdition"
											status="s">
											<a id="todayEdition<s:property value="#s.index+1"/>"
												onclick="setTodayEditionClick('<s:property value="#edition.editionId" />',this)"
												style="cursor: hand; color:#3399FF;"> <s:property
													value="#edition.editionName" /> </a>&nbsp;
										</s:iterator></td>
								</tr>
							</table>
							<div id="json1">
								<table border="1" cellspacing="0" cellpadding="5" width="700">

									<s:iterator var="mapTime" value="#request.todayLstMapTime">

										<s:iterator var="play" value="#mapTime['lstPlaies']"
											status="s">
											<tr align="center">
												<s:if test="#s.index==0">
													<th
														rowspan="<s:property value="#mapTime['lstPlaies'].size()"/>"
														scope="row"><s:a action="play"
															method="showOneMoviePlaies">
															<s:param name="movieName"
																value="#mapTime['mapMovie']['movieName']" />
															<s:property value="#mapTime['mapMovie']['movieName']" />
														</s:a> <br /> <s:property
															value="#mapTime['mapMovie']['movieKindName']" /> <br />
														<s:property value="#mapTime['mapMovie']['movieLong']" />分钟</th>
												</s:if>

												<td><s:date name="#play.playTime" format="HH:mm" /></td>
												<td>余<s:property value="450-#play.tickets.size()" />/450总</td>
												<td><s:property
														value="#play.movie.language.languageName" /></td>
												<td><s:property value="#play.movie.edition.editionName" />
												</td>
												<td>￥<s:property value="#play.playPrice" />元</td>
												<td><s:a action="play" method="showSeat">
														<s:param name="playId" value="#play.playId" />我要购票</s:a>
												</td>
											</tr>

										</s:iterator>
									</s:iterator>
								</table>
							</div>
						</div>
						<div class="TabbedPanelsContent">
							<table width="700">
								<tr>
									<td>影片： <a onclick="setTomorrowNameClick('',this)"
										style="cursor: hand; background-color:#3399FF; color:white;">[全部]</a>
										<s:iterator var="mapTime" value="#request.tomorrowLstMapTime"
											status="s">
											<a id="tomorrowName<s:property value="#s.index+1"/>"
												onclick="setTomorrowNameClick('<s:property value="#mapTime['mapMovie']['movieName']" />',this)"
												style="cursor: hand; color:#3399FF;"> <s:property
													value="#mapTime['mapMovie']['movieName']" /> </a>&nbsp;
										</s:iterator></td>
								</tr>
								<tr>
									<td>时间： <a onclick="setTomorrowTimeClick('',this)"
										style="cursor: hand; background-color:#3399FF; color:white;">[全部]</a>&nbsp;<a
										id="tomorrowTime1" onclick="setTomorrowTimeClick('am',this)"
										style="cursor: hand; color:#3399FF;">上午</a>&nbsp;<a
										id="tomorrowTime2" onclick="setTomorrowTimeClick('pm',this)"
										style="cursor: hand; color:#3399FF;">下午</a>&nbsp;<a
										id="tomorrowTime2"
										onclick="setTomorrowTimeClick('night',this)"
										style="cursor: hand; color:#3399FF;">晚上</a></td>
								</tr>
								<tr>
									<td>版本： <a onclick="setTomorrowEditionClick('',this)"
										style="cursor: hand; background-color:#3399FF; color:white;">[全部]</a>
										<s:iterator var="edition" value="#application.lstEdition"
											status="s">
											<a id="tomorrowEdition<s:property value="#s.index+1"/>"
												onclick="setTomorrowEditionClick('<s:property value="#edition.editionId" />',this)"
												style="cursor: hand; color:#3399FF;"> <s:property
													value="#edition.editionName" /> </a>&nbsp;
										</s:iterator></td>
								</tr>
							</table>
							<div id="json2">
								<table border="1" cellspacing="0" cellpadding="5" width="700">

									<s:iterator var="mapTime" value="#request.tomorrowLstMapTime">
										<s:iterator var="play" value="#mapTime['lstPlaies']"
											status="s">
											<tr align="center">
												<s:if test="#s.index==0">
													<th
														rowspan="<s:property value="#mapTime['lstPlaies'].size()"/>"
														scope="row"><s:a action="play"
															method="showOneMoviePlaies">
															<s:param name="movieName"
																value="#mapTime['mapMovie']['movieName']" />
															<s:property value="#mapTime['mapMovie']['movieName']" />
														</s:a> <br /> <s:property
															value="#mapTime['mapMovie']['movieKindName']" /> <br />
														<s:property value="#mapTime['mapMovie']['movieLong']" />分钟</th>
												</s:if>

												<td><s:date name="#play.playTime" format="HH:mm" /></td>
												<td>余<s:property value="450-#play.tickets.size()" />/450总</td>
												<td><s:property
														value="#play.movie.language.languageName" /></td>
												<td><s:property value="#play.movie.edition.editionName" />
												</td>
												<td>￥<s:property value="#play.playPrice" />元</td>
												<td><s:a action="play" method="showSeat">
														<s:param name="playId" value="#play.playId" />我要购票													
													</s:a>
												</td>
											</tr>

										</s:iterator>
									</s:iterator>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>

		<div id="main_right">
			<s:include value="right.jsp"></s:include>
		</div>

	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

	<script type="text/javascript">
		var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
	</script>
</body>
</html>
