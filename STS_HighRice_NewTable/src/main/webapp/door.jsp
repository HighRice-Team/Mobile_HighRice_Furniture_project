<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, 
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
<link rel="stylesheet" href="resources/css/jquery.mobile-1.3.2.css" />
<title>Insert title here</title>
<style type="text/css">
#white{
	background-color: white;
}
</style>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="resources/js/jquery.mobile-1.3.2.js"></script>
<script type="text/javascript">
$(function(){
		$("#sellbtn").click(function(){
			location.href="sellWrite.do"
		})
		$("#rentbtn").click(function(){
			location.href="goPaymentInfo.do"
		})
	})
</script>
</head>
<body>

	
		<div data-role="content">
			<div id="white">
				<img src="resources/img/door.jpg" style="width: 100%; height: 50%;">
				<div>
					<div style="padding: 10px 10px 10px 10px;">
						<p>BIT FR Company는 대형 가구 처분과 렌탈에 불편함을 겪는 분들을 위해 매입 및 대여 서비스를 제공합니다.</p>
						<p>원하는 기간만큼 클릭 하나로 손쉽게 대형 가구를 빌리세요</p>
					</div>
					<img src="resources/img/service.jpg" style="width: 100%;">
						
				</div>
			</div>
			<div class="ui-grid-a" style="background-color: white;">
				<div class="ui-block-a" style="text-align: center">
					<img src="resources/img/sell2.jpg" id="sellbtn" style="cursor: pointer; width:100%;">
				</div>
				<div class="ui-block-b" style="text-align: center">
					<img src="resources/img/rent.jpg" id="rentbtn" style="cursor: pointer; width:100%;">
				</div>
			</div>
		</div>

</body>
</html>