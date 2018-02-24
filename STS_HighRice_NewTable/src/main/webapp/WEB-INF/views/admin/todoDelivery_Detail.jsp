<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/jian.css">
<script src="resources/js/signature_pad.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	var canvas = document.querySelector("canvas");
	var sign = new SignaturePad(canvas, {
		minWidth: 1,maxWidth: 2,
		penColor: "rgb(66, 133, 244)"
	});
	var ratio =  Math.max(window.devicePixelRatio || 1, 1);
	canvas.width = canvas.offsetWidth * ratio;
	canvas.height = canvas.offsetHeight * ratio;
	canvas.getContext("2d").scale(ratio, ratio);

	$("#clear").click(function(){
		sign.clear();
	})
	$("#save").click(function(){
		if (sign.isEmpty()) {
			alert("서명해 주세요.");
		}else {
			$.ajax({url : "signSave.do?req=delivery", method : "post", dataType : "json", data : {
				sign : sign.toDataURL()
			},success : function(r){
				
				$("#sign").val(r);
				alert("승인완료")
				
				sign.clear()
			},error : function(res){
				console.log(res)
			}})
		}
	})
	
	var json = ${json_delivery_Detail};
	
	$("#_id").val(json._id);
	$("#product_id").val(json.productInfo.product_id);
	$("#order_id").val(json.orderListInfo.order_id);
	
	$("#m_address").text(json.memberInfo.address+" / "+json.memberInfo.address_detail);
	$("#m_info").html("이름 : "+json.memberInfo.name+"<br>전화번호 : "+json.memberInfo.tel);
	$("#product_img").html("<img src='resources/img/product/"+json.productInfo.main_img+"' style='width: 100%'><br><br>가구이름 : "+json.productInfo.product_name+"<br>상태등급 : "+json.productInfo.quality+"<br>월 렌트가격 : "+json.productInfo.price+" 원<br><br>");
	
	//수취확인 버튼
	$("#deliveryConfirm_btn").click(function(){
		//서명이 완료되었다면,
		if($("#sign").val() != ''){
			
			var product_id = $("#product_id").val();
			var order_id = $("#order_id").val();
			
			var today = new Date();
			$("#confirm_date").val(today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate()+" "+today.getHours()+":"+today.getMinutes()+":"+today.getSeconds());
			var confirm_date = $("#confirm_date").val();

			var condition = "대여중";
			var data = {"product_id":product_id,"order_id":order_id,"condition":condition}
			$.ajax({
				url:"deliveryConfirmAjax.do",
				data:data,
				success:function(data){
					if(data == '1'){
						$("#deliveryConfirm_form").submit();
					}
					
				}
			});
			
		}else{
			alert("서명해 주세요.");
		}
		
	});
	
})
</script>
</head>
<body>
	<div data-role="content" style="text-align: center;">
		<div>
			<h3>가구정보</h3>
			<div id="product_img"></div>
		</div>
		<hr>
		<div>
			<h3>회원정보</h3>
			<p id="m_info"></p>
		</div>
		<hr>
		<div>
			<h3>고객주소</h3>
			<p id="m_address"></p>
		</div>
		<hr>
		<h3>서명</h3>
		<div id="signature-pad" class="m-signature-pad">
			<div class="m-signature-pad--body">
				<canvas></canvas>
			</div>
			<div class="sign-pad-footer">
				<div class="clear">
					<input type="button" data-inline="true" data-mini="true"id="clear" value="지우기">
				</div>
				<div class="save">
					<input type="submit" data-inline="true" data-mini="true" id="save" value="서명완료">
				</div>
			</div>
		</div>
		<hr>
		<form id="deliveryConfirm_form" action="http://203.236.209.226:52273/delivery_update" method="post">
			<input type="hidden" name="product_id" id="product_id">
			<input type="hidden" name="order_id" id="order_id">
			
			<input type="hidden" id="_id" name="_id">
			<input type="hidden" id="sign" name="sign">
			
			<input type="hidden" id="confirm_date" name="confirm_date">
			
			<input id="deliveryConfirm_btn" type="button" value="수취확인">
		</form>
		
	</div>
</body>
</html>