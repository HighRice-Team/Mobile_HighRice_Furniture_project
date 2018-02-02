<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, 
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
<link rel="stylesheet" href="resources/css/jquery.mobile-1.3.2.css" />
<title>Insert title here</title>
<style type="text/css">
img{
	width:200px;
	height: 200px;
}
</style>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="resources/js/jquery.mobile-1.3.2.js"></script>
<script type="text/javascript">
$(function(){
	  
	   
	  
	})
	
</script>
</head>
<body>

	<div data-role="page">
		<div data-role="header">
			<h2>SELL List</h2>
		</div>
		<div data-role="content">
			<p style="text-align: right;">${member_id }님의 가구</p>
			<br>
			<c:forEach var="p" items="${list }">
				<a href="#" data-role="button" data-icon="forward" data-iconpos="right">
					<h3 style="text-align: center;">${p.product_name }</h3>
					<table style="width:100%;">
						<tr>
							<td rowspan="2"><img src="resources/img/product/${p.main_img }"></td>
							<td>${p.category }</td>
						</tr>
						<tr style="text-align: center;">
							<td >CONDTION : ${p.condition }</td>
						</tr>				
					</table>
			</a>
			</c:forEach>
				
		</div>
		<div data-role="footer" data-position="fixed">
			<h2>Team HighRice</h2>
		</div>
	</div>

</body>
</html>