<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.price_cart{
	font-size: 3.5vw;
	color: #95200C;
	font:bold;
}
.productName_cart{
	font-size:4.0vw;
}
</style>
<meta charset="UTF-8">

<title>Insert title</title>
<script type="text/javascript">
	$(function(){

		var selectedProduct = "";
		$("#checkAllBtn").click(function(){
			var listSize = eval( $("#listSize").val() )
			var chkSize = $("input[checked='checked']").size()
			
			if(listSize!=chkSize){
				$("input[type='checkbox']").each(function(index,item){
					if($(item).attr("checked")==null){
						$(this).attr("checked","checked")
					}
					$("input[type='checkbox']").attr("data-icon","checkbox-on")
					$("label").addClass("ui-checkbox-on")
					$("label").removeClass("ui-checkbox-off")
					$("label").attr("data-icon","checkbox-on")
					$(".ui-icon-checkbox-off").addClass("ui-icon-checkbox-on")
					$(".ui-icon-checkbox-off").removeClass("ui-icon-checkbox-off")
					
				})
			}else{
				$("input[type='checkbox']").each(function(index,item){
					$(item).removeAttr("checked")
				})
				$("label").attr("data-icon","checkbox-off")
				$("label").addClass("ui-checkbox-off")
				$("label").removeClass("ui-checkbox-on")
				$(".ui-icon-checkbox-on").addClass("ui-icon-checkbox-off")
				$(".ui-icon-checkbox-on").removeClass("ui-icon-checkbox-on")
					
			}
			
			var paymentPrice = 0
			
			selectedProduct =""
			
			$("input[checked='checked']").each(function(){
				var cnt = $(this).attr("cnt")
				paymentPrice += eval($("#totalPrice"+cnt).html())
				selectedProduct += $(this).attr("product_id")+" "
			})
			
			$("#paymentPrice").html(paymentPrice)
			$("#selectedProducts").html($("input[checked='checked']").size())
		})
		
		$(".reduceRentMonthBtn").click(function(){
			var cnt = $(this).attr("cnt")
			var price = eval( $("#price"+cnt).html() )
			var rent_month = eval( $("#rent_month"+cnt).val() ) -1
			
			if(rent_month>=0){
				$("#rent_month"+cnt).val(rent_month)
				$("#totalPrice"+cnt).html(price*rent_month)
				
				var paymentPrice = 0
			
				$("input[checked='checked']").each(function(){
					var cnt = $(this).attr("cnt")
					paymentPrice += eval($("#totalPrice"+cnt).html())
				})
				
				$("#paymentPrice").html(paymentPrice)
			}else{
				alert("0보다 작을 수 없습니다.")
			}
		})
		
		$(".increaseRentMonthBtn").click(function(){
			var cnt = $(this).attr("cnt")
			var price = eval( $("#price"+cnt).html() )
			var rent_month = eval( $("#rent_month"+cnt).val() ) +1
			
			$("#rent_month"+cnt).val(rent_month)
			$("#totalPrice"+cnt).html(price*rent_month)
			
			var paymentPrice = 0
			
			$("input[checked='checked']").each(function(){
				var cnt = $(this).attr("cnt")
				paymentPrice += eval($("#totalPrice"+cnt).html())
			})
			
			$("#paymentPrice").html(paymentPrice)
		})
		
		$("input[type='checkbox']").click(function(){
			if($(this).attr("checked")==null){
				$(this).attr("checked","checked")
			}else{
				$(this).removeAttr("checked")
			}
			
			var paymentPrice = 0
			selectedProduct = ""
			$("input[checked='checked']").each(function(){
				var cnt = $(this).attr("cnt")
				paymentPrice += eval($("#totalPrice"+cnt).html())
				selectedProduct += $(this).attr("product_id")+" "
			})
			$("#paymentPrice").html(paymentPrice)
			$("#selectedProducts").html($("input[checked='checked']").size())
		})
	})
</script>
</head>
<body id="cart_body">
		
			<div class="ui-grid-c" style="padding-top: 2%;">
				<div class="ui-block-a" style="margin-left: 5%;">
					<input id="checkAllBtn" type="button" value="전체 선택 " data-inline="true" data-mini="true" data-corners="false" style="text-align: center;">
				</div>
				<div class="ui-block-b">
					<input type="button" value="선택 삭제" data-mini="true" data-inline="true" data-corners="false" style="text-align: center;">
				</div>
			</div>
		
		
			
<!-- 			---------------------------------------------------------------------------------- -->
			<c:forEach var="list" items="${list }" varStatus="cnt">
				<div class="products" style="background-color: white; margin: 2%;" data-corners="true">
					<input type="checkbox" name="chkbox${cnt.count}" id="chkbox${cnt.count }" cnt="${cnt.count }" product_id="${list.pr }" data-theme="c">
					<label for="chkbox${cnt.count }" data-corners="false">${list.product_name }</label>

					<div class="ui-grid-a">
						<div class="ui-block-a" style="width: 31%; padding-left: 5%; padding-top: 5%;">
							<img src="resources/img/product/${list.main_img }" width="100%">
						</div>
						<div class="ui-block-b" style="width: 64%; padding-top: 5%;">
							<div style="padding-left: 20%;">
								<span class="productName_cart" ><b>${list.product_name }</b></span>
							</div>
							<div style="padding-left: 20%;">
								<p class="price_cart">가격 : <span id="price${cnt.count }">${list.price}</span> / Month</p>
							</div>
							<div class="ui-grid-c">
								<div class="ui-block-a" style="width: 31%;">
									<span>대여 기간</span>
								</div>
								<div class="ui-block-b" style="width: 23%">
									<center><input type="button" class="reduceRentMonthBtn" value="-" data-mini="true" data-inline="true" data-corners="false" cnt="${cnt.count }"></center>
								</div>
								<div class="ui-block-c" style="width: 23%">
									<center><input type="number" id="rent_month${cnt.count }" value="${list.rent_month }" data-mini="true" data-inline="true" style="text-align: center; align-content: center;" readonly="readonly"></center>
								</div>
								<div class="ui-block-d" style="width: 23%">
									<center><input type="button" class="increaseRentMonthBtn" value="+" data-mini="true" data-inline="true" data-corners="false" cnt="${cnt.count }"></center>
								</div>
							</div>
							<div class="ui-grid-a">
								<div class="ui-block-a" style="width: 30%;">&nbsp;</div>
								<div class="ui-block-b" style="width: 70%;">
									<h4>합계 : <span id="totalPrice${cnt.count }">${list.price * list.rent_month }</span>원</h4>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			<input type="hidden" id="listSize" value="${listSize }">
<!-- 			---------------------------------------------------------------------------------------------------- -->
			<div style="width: 93%; margin: 3%; padding:1%; background-color: white;">
				<center><p style="color: #3A75C3; font-size:3.5vw; font-weight: bold;">주문 결제 정보</p></center>
			</div>
			<div class="ui-grid-a">
				<div class="ui-block-a" style="padding-left: 5%;">총 상품금액</div>
				<div class="ui-block-b" style="text-align: right; padding-right: 5%;"><span id="paymentPrice">0</span>원</div>
			</div>
			<div class="ui-grid-a">
				<div class="ui-block-a" style="padding-left: 5%;">상품 수</div>
				<div class="ui-block-b" style="text-align: right; padding-right: 5%;"><span id="selectedProducts">0</span>건</div>
			</div>
			<div class="ui-grid-a" style="margin-bottom: 10%; margin-top: 5%;">
				<div class="ui-block-a">
					<a data-role="button" style="text-align: center;" data-theme="a">선택상품주문</a>
				</div>
				<div class="ui-block-b">
					<a data-role="button" style="text-align: center;" data-theme="a">전체상품주문</a>
				</div>
			</div>
</body>
</html>