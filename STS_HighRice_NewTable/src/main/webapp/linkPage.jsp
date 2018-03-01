<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색결과</title>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		var inflow_info = window.navigator.userAgent.toLowerCase();
		
		var device = "";
		// 사용자의 디바이스 정보 판별.
		if(inflow_info.indexOf("windows") >= 0){
			device = "[PC]윈도우";
		}else if(inflow_info.indexOf("macintosh") >= 0){
			device = "[PC]맥";
		}else if(inflow_info.indexOf("iphone") >= 0){
			device = "[Mobile]아이폰";
		}else if(inflow_info.indexOf("android") >= 0){
			device = "[Mobile]안드로이드";
		}
		
		<%
			String keyword = request.getParameter("keyword");
			String portal = request.getParameter("portal");
		%>
		
		var keyword = '<%=keyword%>';
		var portal = '<%=portal%>'
		
		var a = $("<a href='main.do'></a>");
		var p = $("<p></p>");
		
		// 로그 기록하기.
		$.ajax({
			url : "upload_inflowLog.do",
			type : "post",
			data: {"device":device,"portal":portal,"keyword":keyword},
			success : function(data){
				if(data != ''){
					$(a).append("최고의 중고가구 거래 사이트 : 비트 가구대여점");
					$(p).append("'"+keyword+"' 으로 검색된 결과입니다.");
					
					$("#result").append( a , p);
				}
			}
		});
		
	});
	
</script>
</head>
<body>
	<h3>검색결과</h3>
	<div id="result">
	</div>
</body>
</html>