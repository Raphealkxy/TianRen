window.onbeforeunload = function() {
	var n = window.event.screenX - window.screenLeft;
	var b = n > document.documentElement.scrollWidth - 20;
	if ((b && window.event.clientY < 0) || window.event.altKey
			|| window.event.ctrlKey) {
		//window.event.returnValue = ""; //这里可以放置你想做的操作代码   
		location = "/TianRen/close!closeClient.action";
	}
};

$(document).ready(function() {
	$(".aToptxt").mouseover(function() {
		$(this).css({
			"background" : "#3399FF",
			"color" : "#e8f0f6"
		});
		$(this).animate({
			fontSize : "19px"
		});
	});
	$(".aToptxt").mouseout(function() {
		$(this).css({
			"color" : "#3399FF",
			"background" : ""
		});
		$(this).animate({
			fontSize : "12px"
		});
	});

	$(".aMenuTxt").mouseover(function() {
		$(this).css({
			"background" : "#3399FF",
			"color" : "#e8f0f6"
		});
		$(this).animate({
			fontSize : "30px"
		});
	});
	$(".aMenuTxt").mouseout(function() {
		$(this).css({
			"color" : "#3399FF",
			"background" : ""
		});
		$(this).animate({
			fontSize : "16px"
		});
	});
});