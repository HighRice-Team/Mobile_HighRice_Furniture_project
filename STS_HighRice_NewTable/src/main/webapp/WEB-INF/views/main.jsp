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
<style type="text/css">
	div #container { margin-top: 20px;}
	ul.tabs { /*float:left;*/ list-style: none; /*margin-left:-45px;*/ margin-bottom: 30px;}
	ul.tabs li { float: left; width: 35% }
	.tab_container .tab_content { margin-top: 25px; }
	.tab_container .tab_content ul li { list-style: none; }
	ul.tabs li.active { background: #FFFFFF; border-bottom: 1px solid #FFFFFF; }
	div #container { margin: 30px; }
	div .log { margin-top: 50px; margin-right: 20px; }
	/* .logname { visibility: hidden; } */
	.nav { visibility: hidden; }
	/* .ui-icon-login{	background-image: url("../resources/login.png");} */
	
	/* join에 필요한 스타일 시트 jian */
	.p-1row {font-size: 12px; margin: 20px 0 0 0}
	.p-2row {font-size: 12px; margin: 12px 0 0 0}
	.fr-button { text-align: center; }
	.join-row .rate-2 { width: 20% }
	.join-row .rate-4 { width: 40% }
	.join-row .rate-6 { width: 60% }
	.join-row .rate-8 { width: 80% } 
	.frjmin .juminform { width: 47% }
	.frjmin .juminhyphen { width: 6% }
	.frjmin .juminhyphen .p { margin-top: 15px; text-align: center}
	.join-process { margin: 0 0 20px 0 }
	.join-process .step { height:50px; text-align: center; background-color: #ddd;}
	.join-process .point { background-color: #ccc;}
	.join-complete {background-color: #EAEAEA; text-align: center; font-size: 18px; padding: 20px 0 20px 0}
</style>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
<script type="text/javascript">
	$(function() {

		$(".tab_content").hide();
		$(".tab_content:first").show();

		$(".tabs li").click(function() {

			if ($(".tabs li").hasClass("active")) {
				$(".tabs li").removeClass("active").css("color", "#333");
				$(this).addClass("active").css("color", "darkred");
				$(".tab_content").hide()
				var activeTab = $(this).attr("rel");
				$("#" + activeTab).fadeIn()
			}
		});

		$("#loginBtn").click(function() {

			var member_id = $("#member_id").val();
			var pwd = $("#pwd").val();
			var data = {
				"member_id" : member_id,
				"pwd" : pwd
			}
			$.ajax({
				url : "login.do",
				data : data,
				success : function(data) {
					if (data == 1) {
						location.href = "";
						$(".ui-block-a").css("visibility", "visible");
						$("#login_img").attr("src", "resources/logout.png");
					} else if (data == 0) {
						$("#msg_footer").html("비밀번호 오류")
					} else {
						$("#msg_footer").html("존재하지 않는 아이디 입니다.")
					}
				}

			});
		});

		$("#logout_img").click(function() {
			if (confirm("로그아웃 하시겠습니까?")) {
				$.ajax({
					url : "logout.do",
					success : function() {
						
						location.href = "";
					}

				})
			}
		});

	});
</script>
</head>
<body>
	<div data-role="page">
		<div data-role="header">
			<h2>Menu</h2>
			<a href="#menu" data-icon="bars" data-iconpos="notext">Menu</a>
		</div>
		<div data-role="content">
			<jsp:include page="${viewPage }" />

			<div data-role="panel" data-position="left" data-display="overlay"
				id="menu">
				<ul data-role="listview">
					<li data-icon="delete"><a href="#" data-rel="close">Closemenu</a></li>
				</ul>

				<div class="log ui-grid-a">
					<c:if test="${not empty sessionScope.name }">
						<span class="ui-block-a logname">${sessionScope.name}님
							환영합니다.</span>

						<span class="ui-block-b"><a data-inline="true" href="#"
							data-rel="popup" data-position-to="window" data-transition="pop"><img
								id="logout_img" align="right" src="resources/img/logout.png"
								style="width: 30%"></a> </span>
					</c:if>
					<c:if test="${empty sessionScope.name }">
						<span class="ui-block-a">Please Login</span>
						<span class="ui-block-b"><a data-inline="true"
							href="#popupLogin" data-rel="popup" data-position-to="window"
							data-transition="pop"><img id="login_img" align="right"
								src="resources/img/login.png" style="width: 30%"></a> </span>
					</c:if>
				</div>

				<div style="margin-top: 20px;">
					<c:if test="${not empty sessionScope.name}">
						<div data-role="navbar" data-position="inline">
							<ul>
								<li><a href="#" data-ajax="false">My Page</a></li>
								<li><a href="#" data-ajax="false">SELL</a></li>
								<li><a href="#" data-ajax="false">CART</a></li>
							</ul>
						</div>
					</c:if>
				</div>

				<div id="container">
					<div style="width: 100%; text-align: center;">
						<ul class="tabs" data-role="listview"
							style="display: inline-block;">
							<li class="active" rel="tab1">Furniture</li>
							<li rel="tab2">Community</li>
						</ul>
					</div>
					<div class="tab_container">
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
						<!-- #tab1 -->
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
						<!-- #tab2 -->
					</div>
					<!-- .tab_container -->
				</div><!-- container end -->
			</div>
			<!-- end panel -->

			<div data-role="popup" id="popupLogin" data-position-to="window"
				style="width: 330px;">
				<div data-role="header">
					<h3 align="center">LOGIN</h3>
					<a href="#" data-role="button" data-rel="back" data-icon="delete"
						data-iconpos="notext" class="ui-btn-right">close</a>      
				</div>
				<div>
					<form id="loginForm">
						<table align="center" style="width: 100%;">
							<tr>
								<td>아이디:</td>
								<td><input type="text" id="member_id" name="member_id"
									placeholder="username"></td>

							</tr>
							<tr>
								<td>비민번호:</td>
								<td><input type="password" id="pwd" name="pwd"
									placeholder="password"></td>
							</tr>
							<tr>
								<td colspan="2" style="color: red" id="msg_footer"></td>
							</tr>
						</table>
						    
					</form>
					<div align="center">
						<!-- 				<input type = "button" value="로그인" id="loginBtn" class="ui-block-a"> -->
						<a href="#" id="loginBtn" data-role="button" data-inline="true"
							style="width: 27%;"><span>로그인</span></a> <a href="join.jsp"
							data-role="button" data-inline="true" style="width: 27%">조인</a> <a
							href="idseek.jsp" data-role="button" data-inline="true"
							style="width: 27%">찾기</a>
					</div></div><!--login form end -->
			</div><!-- popup end-->

		</div><!-- content end -->

		<div data-role="footer" data-position="fixed">
			<h2>비트캠프</h2>
		</div>

	</div><!-- page end -->

</body>
</html>