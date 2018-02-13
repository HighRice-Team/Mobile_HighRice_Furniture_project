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
				alert("승인완료")
				sign.clear()
			},error : function(res){
				console.log(res)
			}})
		}
	})
})
</script>
</head>
<body>
	<div data-role="content" style="text-align: center;">
		<div>
			<h3>고객주소</h3>
			<p>서울시 어쩌고~</p>
		</div>
		<hr>
		<div>
			<h3>회원정보</h3>
			<p>어쩌고 저쩌고~	</p>
		</div>
		<hr>
		<div>
			<h3>가구정보</h3>
			<img src="resources/img/product/b1.jpg" style="width: 100%">
		</div>
		<hr>
		<div>
			<h3>check list</h3>
			<input type="checkbox" id="checkbox1">
			<label for="checkbox1">체크체크 랄랄라</label>
			
			<input type="checkbox" id="checkbox2">
			<label for="checkbox2">체크체크 랄랄라</label>
			
			<input type="checkbox" id="checkbox3">
			<label for="checkbox3">체크체크 랄랄라</label>
			
			<input type="checkbox" id="checkbox4">
			<label for="checkbox4">체크체크 랄랄라</label>
		</div>
		<hr>
		<div>
			<h3>구매가</h3>
			<input type="number">
			<input type="button" data-inline="true" data-mini="true" value="결과확인">
		</div>
		<hr>
		<div>
			<h3>결과</h3>
			<p>grade : B</p>
			<p>가격 : 얼마얼마</p>
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
		<input type="submit" value="검수완료">
	</div>
</body>
</html>