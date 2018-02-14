<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,
			maximum-scale=1.0, minimum-scale=1.0,
			user-scalable=no"/>
<style type="text/css">
.boardli{
	cursor: pointer;
}
</style>
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$(".boardli").click(function(){
		location.href="detailQna.do?board_id="+$(this).find(".board_id").html()
	})
	
	$(".boardli").each(function(index, item){
		var b_ref = $(this).find("#ref").val()
		$.ajax({url:"getCountRef_qnaboard.do", data:{"b_ref":b_ref},success:function(data){
			if(data > 1){
				$(item).find("#comment").html("답변완료").css("color", "red")
			}
		}})
	})
	
	
})
</script>
</head>
<body>
	<div data-role="content">
		<h3 style="text-align: center">QNA</h3>
		<a href="insertQna.do" data-role="button" data-icon="forward" data-iconpos="right" data-ajax="false" data-corners="false" style="text-align: center;">글쓰기</a>
		<br>
		<ul data-role="listview">
			<c:forEach items="${list }" var="qb">
			<li class="boardli" style="font-size: 3.3vw;">
				<span class="board_id">${qb.board_id }</span><span style="margin-left: 10% ">${qb.title }</span>&nbsp;&nbsp;<span id="comment"></span>
					<input type="hidden" id="ref" value="${qb.b_ref }">
					<div style="float: right; margin-top: -3%;">
						<div class="ui-grid-a">
							${qb.member_id }
						</div>
						<div class="ui-grid-a">${qb.regdate }</div>
					</div>
			</li>
			</c:forEach>
			
		</ul>
	</div>
</body>
</html>