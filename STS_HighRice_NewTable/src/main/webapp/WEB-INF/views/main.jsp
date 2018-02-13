<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
<meta name="apple-mobile-web-app-capable" content="yes"/>
<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css" />
<link rel="stylesheet" href="resources/css/bitfr_style.css">
	
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(document).find("div[data-role='popupss']").each(function(index,item){
// 			$(this).parent().attr("class","ui-popup-container pop in ui-popup-active")
// 			$(this).parent().attr("style","max-width: 368px; top: 192.997px; left: 28px;")
// 			$(this).parent().attr("tabindex","0")
			
// 			$(document).find("#popupLogin-screen").attr("class","ui-popup-screen in")
		})
		
		$(".tab_content").hide();
		$(".tab_content:first").show();
		$(".tabs div").click(function() {
			if ($(".tabs div").hasClass("active")) {
				$(".tabs div").removeClass("active")
				$(this).addClass("active")
				$(".tab_content").hide()
				var activeTab = $(this).attr("rel");
				$("#" + activeTab).fadeIn()
			}
		});
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
		$("#logout_img").click(function() {
			if (confirm("로그아웃 하시겠습니까?")) {
				$.ajax({ url : "logout.do", success : function() {
					location.href = "";
				}})
			}
		});
	});
</script>
</head>
<body>
	<div data-role="page">
		<div data-role="header" class="fr-header">
			<a href="#menu" class="menu"><img src="resources/img/m/menu.png" class="menu-img"></a>
			<div class="logo-area"><a href="index.do" data-ajax="false"><img src="resources/img/m/logo.png" class="logo-img"></a></div>
		</div>
		
		<div data-role="content">

			<jsp:include page="${viewPage }" />
		</div><!-- end content -->
		
		
		<!-- Start panel -->
		<div data-role="panel" data-position="left" data-position-fixed="true"
			data-display="overlay" id="menu" class="menu-panel">
			<a href="#" data-rel="close"><img src="resources/img/m/close.png"
				class="close-img"></a>
			<c:if test="${not empty sessionScope.name}">
				<div>${sessionScope.name}님
					환영합니다. <a data-inline="true" href="#" data-rel="popup"
						data-position-to="window" data-transition="pop"> <img
						id="logout_img" src="resources/img/logout.png" class="log-img">
					</a>
				</div>
			</c:if>
			<c:if test="${empty sessionScope.name}">
				<div>
					로그인 <a data-inline="true" href="#popupLogin" data-rel="popup"
						data-position-to="window" data-transition="pop"> <img
						id="login_img" src="resources/img/login.png" class="log-img">
					</a>
				</div>
			</c:if>
			<div class="penel-div">
				<div data-role="navbar" data-position="inline">
					<ul>
						<li><a href="myPage.do?selectedMyPage=mP" data-ajax="false">My
								Page</a></li>
						<li><a href="#" data-ajax="false">SELL</a></li>
						<li><a href="cartList.do" data-ajax="false">CART</a></li>
					</ul>
					<c:if test="${not empty sessionScope.name}">
					</c:if>
				</div>
			</div>
			<div class="penel-div">
				<div class="tabs">
					<div rel="tab1" class="tab1 active">
						<P>Furniture</p>
					</div>
					<div rel="tab2" class="tab2">
						<p>Community</p>
					</div>
				</div>
				<div class="penel-div">
					<div id="tab1" class="tab_content">
						<ul data-role="listview">
							<li><p>
									<a href="#">DESK</a>
								</p></li>
							<li><p>
									<a href="#">SOFA</a>
								</p></li>
							<li><p>
									<a href="#">BED</a>
								</p></li>
							<li><p>
									<a href="#">CLOSET</a>
								</p></li>
						</ul>
					</div>
					<div id="tab2" class="tab_content">
						<ul data-role="listview">
							<li><p>
									<a href="#">QnA</a>
								</p></li>
							<li><p>
									<a href="#">FAQ</a>
								</p></li>
							<li><p>
									<a href="#">ABOUT US</a>
								</p></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- End panel -->
		<!-- Start login popup -->
		<div data-role="popup" id="popupLogin" data-position-to="window"
			class="login-popup">
			<div class="login-div">
				<a href="#" data-rel="back"><img
					src="resources/img/m/close.png" class="close-img"></a>
			</div>
			<form id="loginForm">
				<div class="ui-grid-a login-row">
					<div class="ui-block-a left">아이디</div>
					<div class="ui-block-b right">
						<input type="text" id="loginId" name="loginId"
							placeholder="username">
					</div>
				</div>
				<div class="ui-grid-a login-row">
					<div class="ui-block-a left">비밀번호</div>
					<div class="ui-block-b right">
						<input type="password" id="loginPwd" name="loginPwd"
							placeholder="password">
					</div>
				</div>
				<div id="loginCheck"></div>
				 
			</form>
			<div class="login-div">
				<a data-role="button" data-inline="true" data-mini="true"
					href="joinAccess.do" data-ajax="false">회원가입</a> <a data-ajax="false" data-role="button"
					data-inline="true" data-mini="true" href="findMember.do">id/pw
					찾기</a> <a data-role="button" data-inline="true" data-mini="true"
					href="#" id="loginBtn">로그인</a>
			</div>
		</div>
		<!-- End login popup -->
	</div>
</body>
</html>
