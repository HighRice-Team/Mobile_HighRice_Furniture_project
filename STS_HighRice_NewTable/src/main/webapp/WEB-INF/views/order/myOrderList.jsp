<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.img{
	width:80%;
/* 	height: 30%; */
}

#page a{
   text-decoration: none;
   color: black;
   font-size: 2.5vw;
}

#sellprice{
	color: red;
}

.date_font{
	font-size: x-small;
	font-style: italic;
	margin: 1px;
}
</style>
<script type="text/javascript">
	$(function(){
		//검색기능
		$("#submit_btn").click(function(){
			$("#seach_form").submit();
		});
		$("#cancel_btn").click(function(){
			location.href="myOrderList.do";
		});
		//
		
		$(".state").click(function(){
			
			if($(this).find(".condition").text() == "입금완료"){
				$("#pop_payed").popup("open");
			}
			else if($(this).find(".condition").text() == "대여중"){
				$("#pop_rent").popup("open");
			}
			else if($(this).find(".condition").text() == "배송중"){
				$("#pop_ing").popup("open");
			}
			
		});
		// 상태값에 따른 기능 요청
		
		$(".state_fn").click(function() {
			var order_id = $(this).find("input[type=hidden]").val();
			if ($(this).find(".condition").text() == "환불요청") {
				
				var result_alert = confirm("환불요청을 하시겠습니까?");

				if (result_alert == true) {
					order_condition_changeRequest(order_id,'환불요청');
				} 
				
			} else if ($(this).find(".condition").text() == "반납요청") {

				var result_alert = confirm("반납요청을 하시겠습니까?");

				if (result_alert == true) {
					order_condition_changeRequest(order_id,'반납요청');
				} 
				
			} else if ($(this).find(".condition").text() == "수취확인") {
			// 수취확인 기능은 비트맨으로 이동.
				var result_alert = confirm("수취확인을 하시겠습니까?");

				if (result_alert == true) {
					order_condition_changeRequest(order_id,'대여중');
				} 
				
			}

		});

		$(".state").each(function(index, item) {
			if ($(this).find(".condition").text() == "반납" || $(this).find(".condition").text() == "취소") {
				$(this).addClass("ui-disabled")
				$(this).button();

			}
		});

		$("#pop_payed_close").click(function() {
			$("#pop_payed").popup("close");
		});

		$("#pop_rent_close").click(function() {
			$("#pop_rent").popup("close");
		});

		$("#pop_ing_close").click(function() {
			$("#pop_ing").popup("close");
		});

	});
</script>
<script type="text/javascript">
	function order_condition_changeRequest(order_id,condition){
		$.ajax({
			url:"order_condition_changeRequest.do",
			data:{'order_id':order_id,'changeRequest':condition},
			success:function(data) {
				alert(condition+"이 완료 되었습니다.");
				location.reload();
			}
		});
	}
	
</script>
</head>
<body>
	<div data-role="content">
		<h2 style="text-align: center;">${member.name }님의 주문내역</h2>
		<br>
		
		<!-- filter form -->
		<div data-role="collapsible" data-theme="d" data-collapsed-icon="search" data-expanded-icon="search" data-iconpos="right">
			<h3>검색하기</h3>
			<form action="myOrderList.do" id="seach_form" method="post" data-ajax="false">
				<ul data-role="listview" data-inset="true">
					<li data-role="fieldcontain">
						<br><label>상태 분류 :</label><br>
						<div class="ui-grid-c">
							<div class="ui-block-a">
								<input type="radio" id="condition_pay" name="condition" value="입금완료">
								<label for="condition_pay">입금완료</label>
							</div>
							<div class="ui-block-b">
								<input type="radio" id="condition_rent" name="condition" value="대여중">
								<label for="condition_rent">대여중</label>
							</div>
							<div class="ui-block-c">
								<input type="radio" id="condition_ing" name="condition" value="배송중">
								<label for="condition_ing">배송중</label>
							</div>
							<div class="ui-block-d">
								<input type="radio" id="condition_complete" name="condition" value="반납">
								<label for="condition_complete">반납</label>
							</div>
						</div>
					</li>

					<li data-role="fieldcontain">
						<br><label>가구분류 :</label><br>
						<div class="ui-grid-c">
							<div class="ui-block-a">
								<input type="radio" id="DESK" name="category" value="DESK">
								<label for="DESK">DESK</label>
							</div>
							<div class="ui-block-b">
								<input type="radio" id="SOFA" name="category" value="SOFA">
								<label for="SOFA">SOFA</label>
							</div>
							<div class="ui-block-c">
								<input type="radio" id="BED" name="category" value="BED">
								<label for=BED>BED</label>
							</div>
							<div class="ui-block-d">
								<input type="radio" id="CLOSET" name="category" value="CLOSET">
								<label for="CLOSET">CLOSET</label>
							</div>
						</div>
					</li>
					
					<li data-role="fieldcontain">
						
						<div class="ui-grid-a">
							<div class="ui-block-a">
								<input type="button" id="submit_btn" value="검색하기" data-theme="b" >
							</div>
							<div class="ui-block-b">
								<input type="button" id="cancel_btn" value="취소하기" data-theme="b">
							</div>
						</div>
					</li>
					
				</ul>
				
			</form>
		</div>
		<c:forEach var="p" items="${list }">
			<c:if test="${p.orderlist_condition != '물품게시'}">
				<div style="border: 1px solid; border-color: gray; margin-bottom: 15px; padding: 5px;">
					<h3 style="text-align: center; padding-top: -50%; padding-bottom: -50%;">${p.product_name }</h3>
					<table style="width: 100%; background-color: white;">
						<tr>
							<td rowspan="3"><c:if test="${not empty p.main_img}">

									<img src="resources/img/product/${p.main_img }" class="img">

								</c:if> <c:if test="${empty p.main_img}">

									<img src="resources/img/noImage.png" class="img">

								</c:if></td>

							<td style="text-align: center;">${p.category }</td>
						</tr>
						<tr style="text-align: center;">
							<td>${p.quality } 등급<br>결제금액 : <span id="sellprice">${p.price*p.rent_month }&nbsp;</span><hr>
							<p class="date_font">결제일 : ${fn:substring(p.pay_date , 0,10)}</p>
							<p class="date_font">대여시작일 : ${fn:substring(p.rent_start , 0,10)}</p>
							<p class="date_font">반납예정일 : ${fn:substring(p.rent_end , 0,10)}</p>
							</td>
						</tr>

						<tr style="text-align: center;">

							<td>
								<a href="#" data-role="button" data-icon="info"
								data-iconpos="right" class="state" data-mini="true">상태 : <span
									class="condition">${p.orderlist_condition }</span></a>
								<c:if test="${p.orderlist_condition == '입금완료'}">
									<a href="#" data-role="button" data-icon="alert"
									data-iconpos="right" class="state_fn" data-mini="true"><span class="condition">환불요청</span><input type="hidden"
										value="${p.order_id }" id="order_id"></a>	
								</c:if>	
								<c:if test="${p.orderlist_condition == '대여중'}">
									<a href="#" data-role="button" data-icon="alert"
									data-iconpos="right" class="state_fn" data-mini="true"><span class="condition">반납요청</span><input type="hidden"
										value="${p.order_id }" id="order_id"></a>	
								</c:if>	
								<%-- <c:if test="${p.orderlist_condition == '배송중'}">
									<a href="#" data-role="button" data-icon="alert"
									data-iconpos="right" class="state_fn" data-mini="true"><span class="condition">수취확인</span><input type="hidden"
										value="${p.order_id }" id="order_id"></a>	
								</c:if>	 --%>
							</td>
						</tr>
					</table>
				</div>
			</c:if>
		</c:forEach>

	</div><!-- end -->

	<!-- popup -->
	<div id="pop_payed" data-role="popup" class="ui-content">
		<a href="#" id="pop_payed_close" data-role="button" data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
  		고객님의 상품이 배송 준비 중입니다.
	</div>
	<div id="pop_rent" data-role="popup" class="ui-content">
		<a href="#" id="pop_rent_close" data-role="button" data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
  		현재 대여중인 상품입니다.<br><p style="font-size: small; font-style: italic; color: red;">반납요청이 가능합니다.</p>
	</div>
	<div id="pop_ing" data-role="popup" class="ui-content">
		<a href="#" id="pop_ing_close" data-role="button" data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
  		빠른 시일내에 배송하겠습니다.
	</div>

</body>
</html>