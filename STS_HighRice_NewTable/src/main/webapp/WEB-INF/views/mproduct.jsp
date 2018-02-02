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
<style type="text/css">
#product_box a{
	text-decoration: none;
	color: black;
	font-weight: normal;
}

#product_box{
	font-size: 2.3vw;
}

.small{
	font-size: 1.3vw;
}

.ui-block-a{
	padding: 0px 0px 7px 0px;
}

.ui-block-b{
	padding: 0px 0px 7px 0px;
}
.product_img{
	padding: 3px 3px 0px 3px;
}

#category{
	margin: 0px;
	padding: 0px;
}
</style>
<script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.2.1/jquery.mobile-1.2.1.min.js"></script>
<script type="text/javascript">


$(function(){

	
})
</script>
</head>
<body>
	<div id="" data-role="page">
	
		<div data-role="header">
			<h3>HEADER</h3>
		</div>
		
		<div data-role="content" style="text-align: center; position: relative;">
			<h3 id="category">${category}</h3>
			<div data-role="fieldcontain" style="width: 100%; display: inline-block;">
				<div style="width: 46%; float: right; margin-top: 20px;">
					<select id="sort" name="sort">
						<option data-placeholder="true">How to sort</option>
						<option value="품질등급순">품질등급순</option>
						<option value="높은가격순">높은가격순</option>
						<option value="낮은가격순">낮은가격순</option>
					</select>
				</div>
			</div>
			<div></div>
			<div></div>
			<div></div>
			<div style="width: 100%; display: inline-block;" id="product_box" >
				<c:forEach items="${list}" var="list" varStatus="status">
				<a href="detailProduct.do?product_id=${list.product_id}">
				<div style="width: 48%; background-color: #DDDDDD; float: left; margin: 1%; text-align: center;">
					<c:if test="${status.count%2==1}">
						<div class="ui-block-a"  style=" width:100%;">
							<div class="product_img">
								<img src="resources/img/product/${list.main_img}" width="100%"><br>
							</div>
							<p>${list.product_name}</p>
							QUALITY: ${list.quality}<br>
							PRICE: insertComma(${list.price})<font class="small">WON</font>/<font class="small">MONTH</font><br>
						</div>
					</c:if>
					<c:if test="${status.count%2==0}">
						<div class="ui-block-b"  style="width:100%;">
							<div class="product_img">
								<img src="resources/img/product/${list.main_img}" width="100%"><br>
							</div>
							<p>${list.product_name}</p>
							QUALITY: ${list.quality}<br>
							PRICE: ${list.price}<font class="small">WON</font>/<font class="small">MONTH</font><br>
						</div>
					</c:if>
				</div>
				</a>
				</c:forEach>
			</div>
			<div>		
				<c:forEach var="pageNum" begin="1" end="${pageMax }">
					<a href="mproduct.do?pageNum=${pageNum }&category=${category}&order=${order}" style="font-size: 1.15vw;">${pageNum}</a>
				</c:forEach>
			</div>
		</div>
		
		<div data-role="footer" data-position="fixed">
			<h3>FOOTER</h3>
		</div>
	</div>
</body>
</html>