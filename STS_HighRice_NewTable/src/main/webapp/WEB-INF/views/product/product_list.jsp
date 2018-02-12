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
<style type="text/css">

#product_box a{
	text-decoration: none;
	color: black;
	font-weight: normal;
}

#page a{
	text-decoration: none;
	color: black;
	font-size: 2.5vw;
}

#product_box{
	font-size: 3vw;
}

.small{
	font-size: 1.8vw;
}

.product_img{
	padding: 3px 3px 0px 3px;
}

#category{
	margin: 0px;
	padding: 0px;
}
</style>
<script type="text/javascript">
	
$(function(){

})
</script>
</head>
<body>
	
	<div data-role="content" style="text-align: center; position: relative;">
		<a href="product_list.do?category=${category}"><h3 id="category">${category}</h3></a>
		<div data-role="fieldcontain" style="width: 100%; display: inline-block;">
			<div style="float: right;">
				<form>
				<select id="sort" name="sort" onchange="window.open(value,'_self')" data-mini="true" data-inline="true">
					<option data-placeholder="true">How to sort</option>
					<%-- <option value="product_list.do?pageNum=${pageNum}&category=${category}&sort=${quality}">품질등급순</option> --%>
					<option value="product_list.do?category=${category}&sort=quality">품질등급순</option>				
					<option value="product_list.do?category=${category}&sort=price_max">높은가격순</option>
					<option value="product_list.do?category=${category}&sort=price_min">낮은가격순</option>
				</select>
				</form>
			</div>
		</div>
		<div></div>
		<div></div>
		<div></div>
		<div style="width: 100%; display: inline-block;" id="product_box" >
			<c:forEach items="${list}" var="list" varStatus="status">
			<a href="product_detail.do?product_id=${list.product_id}" data-ajax="false">
			<div style="width: 48%; background-color: #DDDDDD; float: left; margin: 1%; text-align: center; padding-bottom: 10px;">
				<div>
					<div class="product_img">
						<img src="resources/img/product/${list.main_img}" width="100%"><br>
					</div>
					<p>${list.product_name}</p>
					QUALITY: ${list.quality}<br>
					PRICE: ${price_with[status.index]}<font class="small">WON</font>/<font class="small">MONTH</font><br>
				</div>
			</div>
			</a>
			</c:forEach>
		</div>
		<div id="page">		
			<c:forEach var="pageNum" begin="1" end="${pageMax }">
				<a href="product_list.do?pageNum=${pageNum }&category=${category}&sort=${sort}">${pageNum}&nbsp;&nbsp;&nbsp;</a>
			</c:forEach>
		</div>
	</div>
		
</body>
</html>