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
			$.ajax({url : "signSave.do", method : "post", dataType : "json", data : {
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
	
	
	var json = ${json_return_Detail};
	
	$("#_id").val(json._id);
	$("#product_id").val(json.productInfo.product_id);
	$("#order_id").val(json.orderListInfo.order_id);
	
	$("#category").val(json.productInfo.category);
	
	$("#rent_start").val(json.orderListInfo.rent_start);
	$("#rent_end").val(json.orderListInfo.rent_end);
	$("#rent_month").val(json.orderListInfo.rent_month);
	
	$("#m_address").text(json.memberInfo.address+" / "+json.memberInfo.address_detail);
	$("#m_info").html("이름 : "+json.memberInfo.name+"<br>전화번호 : "+json.memberInfo.tel);
	$("#product_img").html("<img src='resources/img/product/"+json.productInfo.main_img+"' style='width: 100%'><br><br><p>가구상세 정보</p>가구이름 : "+json.productInfo.product_name+"<br>상태등급 : "+json.productInfo.quality+"<br><br>카테고리 : "+json.productInfo.category+"<br>월 대여가격 : "+json.productInfo.price+"<br><br>대여시작일 : "+json.orderListInfo.rent_start+"<br>대여 반납예정일 : "+json.orderListInfo.rent_end+"<br><br><br>");    
	
	
	
	$("input[type='checkbox']").click(function(){
		
		if($(this).attr("plus") != "plus"){
			$(this).attr("plus", "plus");
			
		}else{
			$(this).removeAttr("plus");
		}
		
	});
	
	
	$("input[name='quality_radio']").click(function(){
		$("input[name='quality_radio']").removeAttr("quality");
		$(this).attr("quality", "quality");
		
	});
	
	//체크리스트 및 가구정보입력 - 등급산출
	$("#check_btn").click(function(){
		
		var total = $("input[plus='plus']").length;
		var category = $("#category").val();
		var quality = $("input[quality='quality']").val();
		
		var price = json.productInfo.price;
		var index = 0.1; 
		var grade_index = 0.5;
		
		//form 태그에 실어놓기.
		$("#quality").val(quality);
	
		// 품질상태 지수.
		if(quality == 'A'){
			grade_index = 1.1;
		}else if(quality == 'B'){
			grade_index = 0.9;
		}else if(quality == 'C'){
			grade_index = 0.7;
		}
		
		// 월 렌트가격 default 반납 페널티.
		price = eval(price) *grade_index* 0.45;
		// 품질상태, 가구 분류와 구매가 입력이 모두 됬을 경우.
		if(quality){
			if(category){
				if(price){
					// 카테고리별 렌트가격 지수
					if(category == 'DESK'){
						index = 0.4;
					}else if(category == 'SOFA'){
						index = 0.9;
					}else if(category == 'BED'){
						index = 1.1;
					}else if(category == 'CLOSET'){
						index = 0.5;
					}
					// 체크리스트에 따른 가격 상승.
					index = index + (total/20);
					var month_price = price + (price * index);
					month_price = Math.ceil(month_price);
					$("#price").val(month_price);
					$("#quality_text").html("품질상태 : "+quality);
					$("#month_price_text").html("월 대여금액 : "+month_price);
					
				}else{
					alert("구매가를 입력해주세요.")
				}
			}else{
				alert("가구분류를 선택해주세요.");
			}
		}else{
			alert("품질상태를 선택해 주세요.")
		}
		
	});
	
	//검수완료 버튼 클릭.
	$("#returnConfirm_btn").click(function(){
		//상태측정
		if( $("#quality_text").text() != '' ){
			//사인유무
			if($("#sign").val() != ''){
				
				//submit
				var product_id = $("#product_id").val();
				var order_id = $("#order_id").val();
				
				var quality = $("#quality").val();
				var price = $("#price").val();

				var condition = "2차검수";
				
				var today = new Date();
				$("#confirm_date").val(today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate()+" "+today.getHours()+":"+today.getMinutes()+":"+today.getSeconds());
				var confirm_date = $("#confirm_date").val();
				
				var data = {"product_id":product_id,"order_id":order_id,"quality":quality,"price":price,"condition":condition}
				$.ajax({
					url:"returnConfirmAjax.do",
					data:data,
					success:function(data){
						if(data == '1'){
							$("#returnConfirm_form").submit();
						}
						
					}
				});
				//
				
			}else{
				alert("서명해 주세요.");
			}
			
		}else{
			alert("가구의 상태측정을 완료해 주세요.");
		}
		
		
	});
})
</script>
</head>
<body>
	<div data-role="content" style="text-align: center;">
		<div>
			<h3>고객주소</h3>
			<p id="m_address"></p>
		</div>
		<hr>
		<div>
			<h3>회원정보</h3>
			<p id="m_info"></p>
		</div>
		<hr>
		<div>
			<h3>가구정보</h3>
			<div id="product_img"></div>
		</div>
		<hr>
		<div>
			<h3>[가구 상태] Check list</h3>
			<input type="checkbox" id="checkbox1" value="1">
			<label for="checkbox1">구매한지 2년내의 가구이다.</label>
			
			<input type="checkbox" id="checkbox2" value="1">
			<label for="checkbox2">가구에 큰 흠집이 없다.</label>
			
			<input type="checkbox" id="checkbox3" value="1">
			<label for="checkbox3">페인트의 벗겨짐이 없다.</label>
			
			<input type="checkbox" id="checkbox4" value="1">
			<label for="checkbox4">기능에 이상이없다.</label>
			
			<input type="checkbox" id="checkbox5" value="1">
			<label for="checkbox5">파손된 부위가 없다.</label>
			
			<input type="checkbox" id="checkbox6" value="1">
			<label for="checkbox6">오염되지 않았다.</label>
			
			<br>
		</div>
		<hr>
		<div>
		<p style="text-align: left;">상태측정</p>
			<li data-role="fieldcontain"><br> 
				<h3>품질상태</h3>
				<div class="ui-grid-b">
					<div class="ui-block-a">
						<input type="radio" id="quality_A" name="quality_radio" value="A" data-mini="true">
						<label for="quality_A">A</label>
					</div>
					<div class="ui-block-b">
						<input type="radio" id="quality_B" name="quality_radio" value="B" data-mini="true">
						<label for="quality_B">B</label>
					</div>
					<div class="ui-block-c">
						<input type="radio" id="quality_C" name="quality_radio" value="C" data-mini="true">
						<label for=quality_C>C</label>
					</div>
				</div>
			</li>
		
			<input id="check_btn" type="button" data-inline="true" data-mini="true" value="결과확인">
		</div>
		<hr>
		<div>
			<h3>결과</h3>
			<p id="quality_text"></p>
			<p id="month_price_text"></p>
			
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
		<form id="returnConfirm_form" action="http://203.236.209.226:52273/return_update" method="post">
			<input type="hidden" name="product_id" id="product_id">
			<input type="hidden" name="order_id" id="order_id">
			
			<input type="hidden" id="_id" name="_id">
			<input type="hidden" id="sign" name="sign">
			
			<input type="hidden" id="quality" name="quality">
			<input type="hidden" id="category" name="category">
			<input type="hidden" id="price" name="price">

			<input type="hidden" id="rent_start" name="rent_start">
			<input type="hidden" id="rent_end" name="rent_end">
			<input type="hidden" id="rent_month" name="rent_month">
	
			<input type="hidden" id="confirm_date" name="confirm_date">
			
			
			<input id="returnConfirm_btn" type="button" value="검수완료">
		</form>
		
	</div>
</body>
</html>