<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.img{
	width:100px;
	height: 100px;
}

#page a{
   text-decoration: none;
   color: black;
   font-size: 2.5vw;
}
</style>
<script type="text/javascript">
$(function(){
		
		$(".sell").click(function(){
			if($(this).find(".condition").html() == "등록"){
				location.href="sellDetail.do?product_id="+$(this).find("#product_id").val();
			}
			else{
				alert("등록 상태에 있는 물품만 변경할 수 있습니다.")
			}
			
		})
	  		   
	})
</script>
</head>
<body>

		<div data-role="content">
			<h2 style="text-align: center;">${member_id }님의 가구</h2>
			<br>
			<c:forEach var="p" items="${list }">
				<a href="#" data-role="button" data-icon="forward" data-iconpos="right" class="sell" data-corners="false">
					<h3 style="text-align: center;">${p.product_name }</h3>
					<input type="hidden" value="${p.product_id }" id="product_id">
					<table style="width:100%;">
						<tr>
							
							<td rowspan="3">
								<c:if test="${not empty p.main_img}">
									<img src="resources/img/product/${p.main_img }" class="img">
								</c:if>
								
								<c:if test="${empty p.main_img}">
									<img src="resources/img/noImage.png" class="img">
								</c:if>
							</td>
							
							
							<td>${p.category }</td>
						</tr>
						<tr style="text-align: center;">
							<td>${p.quality }&nbsp;/&nbsp;${p.price }&nbsp;원</td>
						</tr>
						<tr style="text-align: center;">
							<td>상태 : <span class="condition">${p.condition }</span></td>
						</tr>				
					</table>
			</a>
			</c:forEach>
			<div style="text-align: center;">
				<c:forEach var="i"  begin="1" end="${totalPage }">
					<span id="page" style="font-size: 20px;"><a href="sellList.do?page=${i }" data-ajax="false">${i }</a></span>&nbsp;&nbsp;&nbsp;
				</c:forEach>
			</div>
				
		</div>


</body>
</html>