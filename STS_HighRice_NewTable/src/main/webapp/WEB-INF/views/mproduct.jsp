<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,
			maximum-scale=1.0, minimum-scale=1.0,
			user-scalable=no"/>
<meta name="apple-mobile-web-capable" content="yes"/>
<meta name="apple-moblie-web-status-bar-style" content="black"/>
<title>Insert title here</title>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css" />
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script><script type="text/javascript">
//창을 띄울 때 상품들의 이미지 크기를 조정.
$(".product_img").css("width", $("#product_box").width() * 0.24)
$(".product_img").css("height", $("#product_box").width() * 0.24)

//창의 크기가 변동 될 때 상품들의 이미지 크기를 조정.
$(window).resize(function() {
	$(".product_img").css("width", $("#product_box").width() * 0.24)
	$(".product_img").css("height", $("#product_box").width() * 0.24)
})
$(function(){
	$(".product_img").css("width", $("#product_box").width() * 0.24)
	$(".product_img").css("height", $("#product_box").width() * 0.24)
	$(window).resize(function() {
		$(".product_img").css("width", $("#product_box").width() * 0.24)
		$(".product_img").css("height", $("#product_box").width() * 0.24)
	})
})
</script>
<script src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
</head>
<body>
	<div id="" data-role="page">
	
		<div data-role="header">
			<h3>HEADER</h3>
		</div>
		
		<div data-role="content" style="text-align: center;">
			<h3 id="category"></h3>
			<div data-role="fieldcontain" style="width: 100%">
				<div style="width: 45%; float: left;">
					<label for="sort">Select: </label>
				</div>
				<div style="width: 45%; float: left;">
					<select id="sort" name="sort">
						<option data-placeholder="true">How to sort</option>
						<option value="품질등급순">품질등급순</option>
						<option value="높은가격순">높은가격순</option>
						<option value="낮은가격순">낮은가격순</option>
					</select>
				</div>
			</div>
			<!-- <div id="product_box" class="ui-grid-a" style="width: 100%; float: left;"> -->
			<c:forEach items="${list}" var="list" varStatus="status">
			<div id="product_box" class="ui-grid-a" style="width: 45%; background-color: #DDDDDD; float: left; border: 5px solid; border-color: white; padding-top: 3px;">
				<c:if test="${status.count%2==1}">
					<div class="ui-block-a">
					<img src="resources/img/product/${list.main_img}" class="product_img"><br>
					ITEM NAME<br>
					QUALITY: A<br>
					10,000WON/MONTH<br>
					</div>
				</c:if>
				<c:if test="${status.count%2==0}">
					<div class="ui-block-b">
					${list.product_name}
					<img src="resources/img/product/${list.main_img}" class="product_img"><br>
					ITEM NAME<br>
					QUALITY: B<br>
					12,000WON/MONTH<br>
					</div>
				</c:if>
				</div>
			</c:forEach>
			</div>
		</div>
		<div data-role="footer" data-position="fixed">
			<h3>FOOTER</h3>
		</div>
		
	</div>
</body>
</html>