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
<link rel="stylesheet" href="resources/css/template.css">
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
      })
      $("#loginBtn").click(function() {
         $("#loginCheck").html("")
         var loginId = $("#loginId").val();
         var loginPwd = $("#loginPwd").val();
         var gotoPage
         var data = { "member_id" : loginId, "pwd" : loginPwd}
         $.ajax({ url : "login.do", data : data, success : function(data) {
            if (data == 1) {
               $(".ui-block-a").css("visibility", "visible");
               $("#login_img").attr("src", "resources/logout.png");
               var gotoPage = "<%=session.getAttribute("gotoPage")%>"
               if(gotoPage.length==4){
                  location.href=""
               }else if(gotoPage=="myPage.do"){
                  location.href=gotoPage+"?gotoPage="+gotoPage+"&&selectedMyPage=mP"
               }else{
                  location.href=gotoPage+"?gotoPage="+gotoPage
               }
               
            } else if (data == 0) {
               $("#loginCheck").html("비밀번호를 잘못 입력하셨습니다.")
            } else{
               $("#loginCheck").html("존재하지 않는 아이디입니다.")
            }
         }})
      })
      
      $("#logout_img").click(function() {
         if (confirm("로그아웃 하시겠습니까?")) {
            $.ajax({ url : "logout.do", success : function() {
               location.href = "";
            }})
         }
      })
      //로그인시 필터 적용
      var needToLogin = $("#needToLogin").val()
      if(needToLogin == 'plz'){
         document.getElementById("btnlogin2").click();
         $.ajax({url:"deleteSession.do", success:function(data){
         }})
      }
   })
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
         <a href="#menu" class="menu">
            <img src="resources/img/m/menu.png" class="menu-img">
         </a>
         <div class="logo-area">
            <a href="main.do" data-ajax="false">
               <img src="resources/img/m/logo.png" class="logo-img">
            </a>
         </div>
      </div>
      <div data-role="content">
         <jsp:include page="${viewPage }" />
      </div>
      
      <!-- Start panel -->
      <div data-role="panel" data-position="left" data-display="overlay" id="menu" >
      
		 <a href="#" data-rel="close">
            <img src="resources/img/m/close.png" class="close-img">
         </a>
         <c:if test="${empty sessionScope.name}">
            <div>로그인
               <a onclick="clearMsg()" data-inline="true" href="#popupLogin" data-rel="popup" data-position-to="window" data-transition="pop" id="btnlogin">
                  <img id="login_img" src="resources/img/login.png" class="log-img">
               </a>
               <a data-inline="true" href="#popupLogin" data-rel="popup" data-position-to="window" data-transition="pop" id="btnlogin2"></a>
            </div>
         </c:if>
         <c:if test="${not empty sessionScope.name}">
            <div>${sessionScope.name}님 환영합니다.
               <a data-inline="true" href="#" data-rel="popup" data-position-to="window" data-transition="pop">
                  <img id="logout_img" src="resources/img/logout.png" class="log-img">
               </a>
               <c:if test="${sessionScope.grade == '2'}">
                  <a data-ajax="false" href="todoList.do">Bitman</a>
               </c:if>
            </div>
         </c:if>
         <div data-role="navbar" data-position="inline" class="navbaraa">
            <ul>
               <li><a data-ajax="false" href="myPage.do?selectedMyPage=mP&&gotoPage=myPage.do">My Page</a></li>
               <li><a data-ajax="false" href="sellWrite.do?gotoPage=sellWrite.do">SELL</a></li>
               <li><a data-ajax="false" href="cartList.do?gotoPage=cartList.do">CART</a></li>
            </ul>
         </div>
         <div class="select-menu">
            <div class="tabs">
               <div rel="tab1" class="tab1 active">
                  <P>Furniture</p>
               </div>
               <div rel="tab2" class="tab2">
                  <p>Community</p>
               </div>
            </div>
            
            <div id="tab1" class="tab_content">
               <ul data-role="listview" data-icon="false">
                  <li><a data-ajax="false" href="product_list.do?category=DESK">DESK</a></li>
                  <li><a data-ajax="false" href="product_list.do?category=SOFA">SOFA</a></li>
                  <li><a data-ajax="false" href="product_list.do?category=BED">BED</a></li>
                  <li><a data-ajax="false" href="product_list.do?category=CLOSET">CLOSET</a></li>
               </ul>
            </div>
            
            <div id="tab2" class="tab_content">
               <ul data-role="listview" data-icon="false">
                  <li><a data-ajax="false" href="qnaBoard.do">QnA</a></li>
                  <li><a data-ajax="false" href="faq.do">FAQ</a></li>
                  <li><a data-ajax="false" href="aboutus.do">ABOUT US</a></li>
               </ul>
            </div>
         </div>
      </div>
      <!-- End panel -->
      
      <!-- Start login popup -->
      <div data-role="popup" id="popupLogin" data-position-to="window" class="login-popup">
         <div class="login-div">
            <a href="#" data-rel="back" >
            	<img src="resources/img/m/close.png" class="close-img">
            </a>
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
            <div id="loginCheck" style="color:red; font-size:12px; text-align: center">${needLoginMsg }</div> 
         </form>
         <div class="login-div">
            <a data-role="button" data-inline="true" data-mini="true" data-ajax="false" href="joinAccess.do">회원가입</a>
            <a data-role="button" data-inline="true" data-mini="true" data-ajax="false" href="findMember.do">id/pw 찾기</a>
            <a data-role="button" data-inline="true" data-mini="true" href="#" id="loginBtn">로그인</a>
         </div>
      </div>
      <!-- End login popup -->
   </div>
</body>
</html>