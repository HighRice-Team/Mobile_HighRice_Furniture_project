<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script>
$(function(){
	$("#paymentBtn").click(function(){
		prompt("aa")
	})
	$("#resetBtn").click(function(){
		history.go(-1)
	})
})
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="text-align: center;">
		<h2>결제</h2><hr>
	</div>
	
	
	<div>
		<ul data-role="listview" data-inset="true">
			<li style="padding-left: 5%; ">
				<a href="#memberDialog" data-rel="dialog">
					<h2>회원정보</h2>
					<span>이름 : ${member.name }</span><br>
					<span>주소 : ${member.address }${member.address_detail }</span>
				</a>	
			</li>
		</ul>
		
		<div style="width: 100%; border: 1px solid #BBBBBB; border-radius: 5px; margin-bottom: 15px;">
			<h2 style="padding-left: 5%;">상품목록</h2>
				<div>
					<c:forEach var="list" items="${list }">
						<div class="ui-grid-c" style="background-color: white; margin: 5px; font-size: 3.0vw; border-radius: 10px;">
							<div class="ui-block-a" style="width: 15%; margin-left: 2%;"><img src="resources/img/product/${list.main_img }" width="100%"></div>
							<div class="ui-block-b" style="width: 35%; margin-top: 5%;"><b style="margin-left: 15px;">${list.product_name }</b></div>
							<div class="ui-block-c" style="width: 20%; margin-top: 5%;"><b style="margin-left: 15px; color: grey;">[ ${list.rent_month }개월 ]</b></div>
							<div class="ui-block-d" style="width: 25%; margin-top: 5%;"><b style="margin-left: 15px; color: #3442B5;">${list.price*list.rent_month }원</b></div>
						</div>
					</c:forEach>
				</div>
		</div>
		
		<div class="ui-grid-a" style="width: 100%; border: 1px solid #BBBBBB; border-radius: 5px; margin-bottom: 10px;">
			<div class="ui-block-a" style="padding-left: 5%; ">
				<h2>최종결제금액</h2>
			</div>
			<div class="ui-block-b">
			</div>
			<div class="ui-block-a" style="padding-left: 8%;">
				<span>상품 수</span>
			</div>
			<div class="ui-block-b" style="text-align: right; padding-right: 15%;">
				<span><b>${cntProduct }건</b></span>
			</div>
			<div class="ui-block-a" style="padding-left: 8%;">
				<span>총 상품가격</span>
			</div>
			<div class="ui-block-b" style="text-align: right; padding-right: 15%;">
				<span><b>${paymentPrice }원</b></span>
			</div>
			<div class="ui-block-a" style="padding-left: 5%;">
				<hr>
			</div>
			<div class="ui-block-b" style="padding-right: 5%;">
				<hr>
			</div>
			<div class="ui-block-a" style="padding-left: 5%;">
				<h2>총 결제금액</h2>
			</div>
			<div class="ui-block-b" style="text-align: right; padding-right: 15%; color: #C33C2F; ">
				<h2><b>${paymentPrice }원</b></h2>
			</div>
		</div>
	</div>
	
	<div class="ui-grid-a">
		<div class="ui-block-a">
			<a data-role="button" data-corners="false" data-theme="a" id="resetBtn">취소</a>
		</div>
		<div class="ui-block-b">
			<a href="resources/dialog/chkDialog.jsp?order_id=${order_id}&paymentPrice=${paymentPrice}" data-rel="dialog" data-role="button" data-corners="false" data-theme="a">결제하기</a>
		</div>
	</div>
	
	
</body>
</html>