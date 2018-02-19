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
			$("#loginCheck").html("")
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
		
		//로그인시 필터 적용
		var needToLogin = $("#needToLogin").val()
		
		if(needToLogin == 'plz'){
			document.getElementById("btnlogin2").click();
			$.ajax({url:"deleteSession.do", success:function(data){
				
			}})
		}
		
		
		//처음 들어왔을때 라이트박스
		var on = $("#onsite").val()
		
		if(on != 1){
			document.getElementById("btnon").click();
		}
		
		$("#imgsell").click(function(){
			if(needToLogin == 'plz'){
				document.getElementById("btnlogin2").click();
			}else{
				$.ajax({url:"onsite.do", success:function(data){
					location.href="sellWrite.do"
				}})
			}
		})
		
		$("#imgrent").click(function(){
			$.ajax({url:"onsite.do", success:function(data){
				location.href="index.do"
			}})
		})
		
		$("#clobtn").click(function(){
			$.ajax({url:"onsite.do", success:function(data){
				location.href="index.do"
			}})
		})
		
	});
	
	function clearMsg(){
		$("#loginCheck").html("")
	}

</script>
</head>
<body>
<input type="hidden" value="${sessionScope.on }" id="onsite">
<input type="hidden" value="${sessionScope.needToLogin }" id="needToLogin">

	
	<div data-role="page">
		<div data-role="header" class="fr-header">
			<a href="#menu" class="menu"><img src="resources/img/m/menu.png" class="menu-img"></a>

			<div class="logo-area"><a href="index.do" data-ajax="false"><img src="resources/img/m/logo.png" class="logo-img"></a></div>

		</div>
		
		<div data-role="content">
			<jsp:include page="${viewPage }" />
		</div>
		
		
		<!-- Start panel -->
			<div data-role="panel" data-position="left" data-display="overlay" id="menu" class="menu-panel">
				<a href="#" data-rel="close"><img src="resources/img/m/close.png" class="close-img"></a>	
 				<c:if test="${not empty sessionScope.name}">
					<div>${sessionScope.name}님 환영합니다.
						<a data-inline="true" href="#" data-rel="popup" data-position-to="window" data-transition="pop">
							<img id="logout_img" src="resources/img/logout.png" class="log-img">
						</a>
					</div>
				</c:if>
				<c:if test="${empty sessionScope.name}">
					<div>로그인
						<a onclick="clearMsg()" data-inline="true" href="#popupLogin" data-rel="popup" data-position-to="window" data-transition="pop" id="btnlogin">
							<img id="login_img" src="resources/img/login.png" class="log-img">
						</a>
						<a data-inline="true" href="#popupLogin" data-rel="popup" data-position-to="window" data-transition="pop" id="btnlogin2"></a>
					</div>
				</c:if>
				<div class="penel-div">
					<div data-role="navbar" data-position="inline">
						<ul>
							<li><a href="myPage.do?selectedMyPage=mP" data-ajax="false">My Page</a></li>
							<li><a href="sellList.do" data-ajax="false">SELL</a></li>
							<li><a href="cartList.do" data-ajax="false">CART</a></li>
						</ul>
						<c:if test="${not empty sessionScope.name}">
						</c:if>
					</div>
				</div>
				<div class="penel-div">
					<div class="tabs">
						<div rel="tab1" class="tab1 active" >
							<P>Furniture</p>
						</div>
						<div rel="tab2" class="tab2">
							<p>Community</p>
						</div>
					</div>
					<div class="penel-div">
						<div id="tab1" class="tab_content" >
							<ul data-role="listview">
								<li><p><a href="product_list.do?category=DESK" data-ajax="false">DESK</a></p></li>
								<li><p><a href="product_list.do?category=SOFA" data-ajax="false">SOFA</a></p></li>
								<li><p><a href="product_list.do?category=BED" data-ajax="false">BED</a></p></li>
								<li><p><a href="product_list.do?category=CLOSET" data-ajax="false">CLOSET</a></p></li>
							</ul>
						</div>
						<div id="tab2" class="tab_content">
							<ul data-role="listview">
								<li><p><a href="qna.do" data-ajax="false">QnA</a></p></li>
								<li><p><a href="faq.do" data-ajax="false">FAQ</a></p></li>
								<li><p><a href="aboutus.do" data-ajax="false">ABOUT US</a></p></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- End panel -->
			
			
			<!-- Start login popup -->
			<div data-role="popup" id="popupLogin" data-position-to="window" class="login-popup">
				<div class="login-div">
					<a href="index.do" data-rel="close"><img src="resources/img/m/close.png" class="close-img"></a>
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
					<div id="loginCheck">${needLoginMsg }</div> 
				</form>
				<div class="login-div">
					<a data-role="button" data-inline="true" data-mini="true" href="joinAccess.do">회원가입</a>
					<a data-role="button" data-inline="true" data-mini="true" href="findMember.do">id/pw 찾기</a>
					<a data-role="button" data-inline="true" data-mini="true" href="#" id="loginBtn">로그인</a>
				</div>
			</div>
			<!-- End login popup -->
			
			<!-- lightBox Popup -->
			<div data-role="popup" id="light" data-icon="delete" data-overlay-theme="a">
				 <a href="#" data-role="button" data-theme="c" data-icon="delete" data-iconpos="notext" class="ui-btn-right" id="clobtn">Close</a>
				<img src="resources/img/sell2.jpg" id="imgsell">
				<img src="resources/img/rent.jpg" id="imgrent">
			</div>
			<!--for trigger lightBox -->
			<a href="#light" data-rel="popup" data-position-to="window" data-transition="fade" id="btnon"></a>
			
		
	</div>
</body>
</html>