<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, 
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css" />
<title>Insert title here</title>

<style type="text/css">
#white{
	background-color: white;
}

.close-img {height: 30px; float: right}
.login-row .left {width: 30%; padding: 15px 0 0 0}
.login-row .right {width: 70%}
.login-popup {width: 300px; padding: 20px}
.login-popup .login-div {width: 100%; display: inline-block; text-align: center}
</style>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
<script type="text/javascript">
$(function(){
		
		$("#rentbtn").click(function(){
			location.href="index.do"
		})
		
		
		<%
			String needToLogin = (String)session.getAttribute("needToLogin");
		%>
	
		var needToLogin = '<%= needToLogin%>'
		
		$("#sellbtn").click(function(){
			if(needToLogin != 'plz'){
				$("#popupLogin").popup("open")
			}else{
				location.href="sellWrite.do"
			}
				
		})
	
		
		$("#btnclose").click(function(){
			$("#popupLogin").popup("close")
		})
		
		
		$("#loginBtn").click(function() {
			var loginId = $("#loginId").val();
			var loginPwd = $("#loginPwd").val();
			var data = { "member_id" : loginId, "pwd" : loginPwd }
			$.ajax({ url : "login.do", data : data, success : function(data) {
				if (data == 1) {
					location.href = "";
					$(".ui-block-a").css("visibility", "visible");
					$("#login_img").attr("src", "resources/logout.png");
				} else if (data == 0) {
					$("#loginCheck").html("비밀번호를 잘못 입력하셨습니다.")
				} else {
					$("#loginCheck").html("존재하지 않는 아이디입니다.")
				}
			}});
		});
	
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
		
		<!-- Start login popup -->
			<div data-role="popup" id="popupLogin" data-position-to="window" class="login-popup">
				<div class="login-div">
					<a href="#" id="btnclose" data-rel="back" ><img src="resources/img/m/close.png" class="close-img"></a>
				</div>
				<form id="loginForm" >
				   	<div class="ui-grid-a login-row">
				    	<div class="ui-block-a left">아이디</div>
				   		<div class="ui-block-b right">
				   			<input type="text" id="loginId" name="loginId" placeholder="username">
				   		</div>
					</div>
					<div class="ui-grid-a login-row">
				    	<div class="ui-block-a left">비밀번호</div>
				   		<div class="ui-block-b right">
				   			<input type="password" id="loginPwd" name="loginPwd" placeholder="password">
				   		</div>
					</div>
					<div id="loginCheck"></div> 
				</form>
				<div class="login-div">
					<a data-role="button" data-inline="true" data-mini="true" href="joinAccess.do">회원가입</a>
					<a data-role="button" data-inline="true" data-mini="true" href="findMember.do">id/pw 찾기</a>
					<a data-role="button" data-inline="true" data-mini="true" href="#" id="loginBtn">로그인</a>
				</div>
			</div>
			<!-- End login popup -->

</body>
</html>