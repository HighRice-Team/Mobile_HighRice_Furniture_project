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
		//선택된 상품을 담을 변수, 주문 or 삭제를 위한 작업.
		var selectedOrder = "";
		//선택항목 삭제
		
		$("#deleteSelectedOrder").click(function(){
			
			var data = {"order_id":selectedOrder}
			$.ajax({
				url:"deleteOrders_orderlist.do",
				data:data,
				success:function(data){
					location.href="";
				}
			})
		})
		
		$("#buyAllProduct").click(function(){
			if($("input[type='checkbox']").length>0){
				var paymentPrice = 0;
				$("input[type='checkbox']").each(function(){
					var cnt = $(this).attr("cnt")
					paymentPrice += eval($("#totalPrice"+cnt).html())
					selectedOrder += $(this).attr("order_id")+","
				})
				
				$("#paymentPrice").html(paymentPrice)
				$("#selectedProducts").html($("input[type='checkbox']").size())
				
				$("input[type='checkbox']").each(function(index,item){
					var rent_month = $(item).attr("rent_month")
					var order_id = $(item).attr("order_id")
					var data = {"rent_month":rent_month,"order_id":order_id}
					$.ajax({
						url:"updateRentPeriodOrderListAjax.do",
						data:data
					})
				})
				
				location.href="goMultiplePayment.do?order_id="+selectedOrder+"&paymentPrice="+$("#paymentPrice").html()+"&cntProduct="+$("input[type='checkbox']").length;
			}else{
				alert("주문 할 상품이 존재하지 않습니다.")
			}
			
		})
		
		$("#buySelectProduct").click(function(){
			if($("input[checked='checked']").length>0){
				$("input[checked='checked']").each(function(index,item){
					var rent_month = $(item).attr("rent_month")
					var order_id = $(item).attr("order_id")
					var data = {"rent_month":rent_month,"order_id":order_id}
					$.ajax({
						url:"updateRentPeriodOrderListAjax.do",
						data:data
					})
				})
				
				location.href="goMultiplePayment.do?order_id="+selectedOrder+"&paymentPrice="+$("#paymentPrice").html()+"&cntProduct="+$("input[checked='checked']").length;
			}else{
				alert("선택 된 상품이 없습니다.")
			}
		})
		
		//전체선택
		$("#checkAllBtn").click(function(){
			var listSize = eval( $("#listSize").val() )
			var chkSize = $("input[checked='checked']").size()
			
			if(listSize!=chkSize){
				$("input[type='checkbox']").each(function(index,item){
					if($(item).attr("checked")==null){
						$(this).attr("checked","checked")
						selectedOrder += $(this).attr("order_id")+","
					}
					$("label").removeClass("ui-checkbox-off")
					$("label").addClass("ui-checkbox-on")
					$(".ui-icon-checkbox-off").addClass("ui-icon-checkbox-on")
					$(".ui-icon-checkbox-off").removeClass("ui-icon-checkbox-off")
				})
			}else{
				$("input[type='checkbox']").each(function(index,item){
					$(item).removeAttr("checked")
				})
				$("label").removeClass("ui-checkbox-on")
				$("label").addClass("ui-checkbox-off")
				$(".ui-icon-checkbox-on").addClass("ui-icon-checkbox-off")
				$(".ui-icon-checkbox-on").removeClass("ui-icon-checkbox-on")
				selectedOrder=""
			}
			
			var paymentPrice = 0
			
			selectedOrder =""
			
			$("input[checked='checked']").each(function(){
				var cnt = $(this).attr("cnt")
				paymentPrice += eval($("#totalPrice"+cnt).html())
				selectedOrder += $(this).attr("order_id")+","
			})
			
			$("#paymentPrice").html(paymentPrice)
			$("#selectedProducts").html($("input[checked='checked']").size())
		})
		
		//개월수 감소
		$(".reduceRentMonthBtn").click(function(){
			var cnt = $(this).attr("cnt")
			var price = eval( $("#price"+cnt).html() )
			var rent_month = eval( $("#rent_month"+cnt).val() ) -1
			
			if(rent_month>=6){
				$("#rent_month"+cnt).val(rent_month)
				$("#totalPrice"+cnt).html(price*rent_month)
				$("#chkbox"+cnt).attr("rent_month",rent_month)
				
				var paymentPrice = 0
			
				$("input[checked='checked']").each(function(){
					var cnt = $(this).attr("cnt")
					paymentPrice += eval($("#totalPrice"+cnt).html())
				})
				
				$("#paymentPrice").html(paymentPrice)
			}else{
				alert("6보다 작을 수 없습니다.")
			}
		})
		
		//개월수 증가
		$(".increaseRentMonthBtn").click(function(){
			var cnt = $(this).attr("cnt")
			var price = eval( $("#price"+cnt).html() )
			var rent_month = eval( $("#rent_month"+cnt).val() ) +1
			
			$("#rent_month"+cnt).val(rent_month)
			$("#totalPrice"+cnt).html(price*rent_month)
			$("#chkbox"+cnt).attr("rent_month",rent_month)
			
			var paymentPrice = 0
			
			$("input[checked='checked']").each(function(){
				var cnt = $(this).attr("cnt")
				paymentPrice += eval($("#totalPrice"+cnt).html())
			})
			
			$("#paymentPrice").html(paymentPrice)
		})
		
		//체크박스 선택
		$("input[type='checkbox']").click(function(){
			if($(this).attr("checked")==null){
				$(this).attr("checked","checked")
			}else{
				$(this).removeAttr("checked")
			}
			
			var paymentPrice = 0
			selectedOrder = ""
			$("input[checked='checked']").each(function(){
				var cnt = $(this).attr("cnt")
				paymentPrice += eval($("#totalPrice"+cnt).html())
				selectedOrder += $(this).attr("order_id")+","
				
				
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
					<input id="deleteSelectedOrder" type="button" value="선택 삭제" data-mini="true" data-inline="true" data-corners="false" style="text-align: center;">
				</div>
			</div>
		
		
			
<!-- 			---------------------------------------------------------------------------------- -->
			<c:forEach var="list" items="${list }" varStatus="cnt">
				<div class="products" style="background-color: white; margin: 2%;" data-corners="true">
					<input type="checkbox" name="chkbox${cnt.count}" id="chkbox${cnt.count }" cnt="${cnt.count }" order_id="${list.order_id }" data-theme="c" rent_month="${list.rent_month }">
					<label for="chkbox${cnt.count }" data-corners="false">&nbsp;</label>

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
					<a data-role="button" style="text-align: center;" data-theme="a" id="buySelectProduct">선택상품주문</a>
				</div>
				<div class="ui-block-b">
					<a data-role="button" style="text-align: center;" data-theme="a" id="buyAllProduct">전체상품주문</a>
				</div>
			</div>

</body>
</html>