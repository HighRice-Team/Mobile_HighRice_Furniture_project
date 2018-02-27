<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.boardli{
	cursor: pointer;
}
</style>
<script type="text/javascript">
$(function(){
	//디테일로 보내는 함수
	$(".boardli").click(function(){
		location.href="qnaDetail.do?board_id="+$(this).find(".board_id").html()
	})
	
	//댓글이 달렸는지 안달렸는지 판별하는 함수
	$(".boardli").each(function(index, item){
		var b_ref = $(this).find("#ref").val()
		$.ajax({url:"getCountRef_qnaboard.do", data:{"b_ref":b_ref},success:function(data){
			if(data > 1){
				$(item).find("#comment").html("답변완료").css("color", "red")
			}
		}})
	})
})
function qnaInsert() {
	location.href="qnaInsert.do"
}
</script>
</head>
<body>
	<div data-role="content">
		<div style="margin: -15px; font-size:20px; font-weight: bold;">QNA</div>
		<div style="margin: -15px; text-align: right;">
			<input type="button" value="글쓰기" onclick="qnaInsert()" data-mini="true" data-inline="true" data-corners="false"/>
		</div>
		<ul data-role="listview" style="padding: 20px 0 0 0">
			<c:forEach items="${list }" var="qb">
				<li class="boardli" style="font-size: 3.3vw;">
					<input type="hidden" id="ref" value="${qb.b_ref }">
					<span class="board_id">${qb.board_id }</span>
					<span style="margin-left: 10px ">${qb.title }</span>
					<span id="comment"></span>
					<span style="float: right; margin:-2px -10px 0 0; font-size: 10px">
						<p>${qb.member_id }</p>
						<p>${qb.regdate }</p>
					</span>
				</li>
			</c:forEach>
		</ul>
	</div>
</body>
</html>