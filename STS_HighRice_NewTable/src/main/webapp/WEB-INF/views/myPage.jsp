<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">

</style>
<script type="text/javascript">
	$(function(){
		$("#goCart_btn").click(function(){
			location.href="cartList.do";
		});
		
		//회원정보 수정에 대한 confirm
		$("#edit_profile").click(function(){
			if($("#current_pwd").val() == <%=session.getAttribute("pwd")%>){
				document.getElementById("go_edit_profile").click();
			}else{
				alert("비밀번호를 확인해 주세요.")
			}	
		});
		$("#change_pwd").click(function(){
			if($("#current_pwd").val() == <%=session.getAttribute("pwd")%>){
				document.getElementById("go_change_pwd").click();
			}else{
				alert("비밀번호를 확인해 주세요.")
			}	
		});
		
	});
</script>
<script type="text/javascript">
	
</script>

</head>
<body>
	<h3 style="text-align: center;">My Page</h3>
	<!-- head -->
	<hr>
		<p style="text-align: center;">저희 BIT FR 가구점을 이용해 주셔서 감사합니다.<br>${member.name } 님은 <c:if test="${grade==1 }">[일반]</c:if><c:if test="${grade==0 }">[관리자]</c:if> 회원이십니다.<br><br>무통장입금으로 50,000원 이상 구매시 1%을 추가적립 받으실 수 있습니다.</p>
	<hr>
	
	<fieldset class="ui-grid-b">	
		<div class="ui-block-a" style="padding: 5px;"><a href="myOrderList.do" id="oL" data-ajax="false"><img src="resources/img/Mypage_img/MyPage_btn2.png" width="100%"></a></div>
		<div class="ui-block-b" style="padding: 5px;"><a href="sellList.do" id="sL" data-ajax="false"><img src="resources/img/Mypage_img/MyPage_btn3.png" width="100%"></a></div>
		<div class="ui-block-c" style="padding: 5px;"><a href="sellWrite.do" id="s" data-ajax="false"><img src="resources/img/Mypage_img/MyPage_btn5.png" width="100%"></a></div>
	</fieldset>
	<hr>
	<fieldset class="ui-grid-d">	
		<div class="ui-block-a" align="center" style="border-right: 5px solid grey">입금완료<br>${rent1 }건</div>
		<div class="ui-block-b" align="center" style="border-right: 5px solid grey">배송중<br>${rent2 }건</div>
		<div class="ui-block-c" align="center" style="border-right: 5px solid grey">대여중<br>${rent3 }건</div>
		<div class="ui-block-d" align="center" style="border-right: 5px solid grey">반납<br>${rent4 }건</div>
		<div class="ui-block-e" align="center" >나의 물건<br>${sell_total }건</div>		
	</fieldset>

	<!-- head -->
	
	<!-- 마이페이지 -->
	<c:if test="${selectedMyPage=='mP' }">
		<hr>
		<p style="text-align: center; font-size: large;">${member.name } 님의 정보</p>
		<br>
		<fieldset class="ui-grid-a">
			<div class="ui-block-a" align="center" style="border-right: 5px solid grey">장바구니<br>${cart_cnt } 건<br><div id="goCart_btn" data-role="button" data-inline="true">나의 장바구니</div></div>
			<div class="ui-block-b" align="center" >페이백<br>${member.payback } 원<br><div data-role="button" data-inline="true">반환하기</div></div>
			<!-- 반환버튼 추후 구현. -->				
		</fieldset>
		<br><hr>
		<!-- 최근 문의 게시물 -->
		<div style="background-color: #E8E8E8">
			<br>
			<h3 style="text-align: left: ; color: #4E5495">나의 문의 내역</h3>
			<hr>
			<p style="text-align: left: ; color: #696567">질문분류/제목/작성날짜</p>
	
			<c:if test="${resentBoard==null }">
				<h3>문의 내역이 없습니다.</h3>
			</c:if>
			<c:if test="${resentBoard!=null }">
				<!-- 게시판을 리스트형식으로 보여줄 예정. -->
			</c:if>
	
		</div>
		<br>
		<!-- 회원정보변경 -->
		<hr>
		<div style="background-color: #E8E8E8">
		<br>
		<h3 style="text-align: left:; color: #4E5495">회원정보</h3>
		<hr>
			<table>
			<tr><td width="30%">아이디 :</td><td colspan="2" width="40%">${member.member_id }</td></tr>
			<tr><td width="30%">전화번호 :</td><td colspan="2" width="40%">${member.tel }</td></tr>
			<tr><td width="30%">주소 :</td><td colspan="2" width="40%">${member.address }${member.address_detail }</td></tr>
			<tr><td width="30%">현재 비밀번호 :</td><td colspan="2" width="40%"><input id="current_pwd" type="password"></td></tr>
			
			<tr><td colspan="3">
				<a id="edit_profile" href="#" data-rel="dialog" data-role="button" data-inline="true">회원정보 수정</a>
				<a id="change_pwd" href="#" data-rel="dialog" data-role="button" data-inline="true">비밀번호 변경하기</a>
				<!-- hidden a tag -->
				<a id="go_edit_profile" style="visibility: hidden;" href="resources/dialog/Edit_Profile.jsp?pageName=mp" data-rel="dialog"></a>
				<a id="go_change_pwd" style="visibility: hidden;" href="resources/dialog/Change_pwd.jsp" data-rel="dialog"></a>
			</td></tr>
			
			</table>
		</div>

	</c:if>

	
	
	<!-- // -->
	
	
	
	
</body>
</html>