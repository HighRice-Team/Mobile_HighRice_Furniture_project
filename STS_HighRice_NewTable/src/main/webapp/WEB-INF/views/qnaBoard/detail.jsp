<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,
			maximum-scale=1.0, minimum-scale=1.0,
			user-scalable=no"/>
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	var id = $("#sessionid").val()
	
	$("#updateComent").click(function(){
		var id_qna = $("#id_qna").html()
		
		if(id = id_qna){
			location.href="update_qnaBoard.do?board_id="+$("#board_id").html()
		}else{
			alert("본인만 수정 가능합니다.")
		}
		
	})
	
	$("#delComment").click(function(){
		alert("삭제완료")
	})
})
</script>
</head>
<body>
<input type="hidden" value="${sessionScope.id }" id="sessionid">
	<div data-role="content">
		<h2>QNA DETAIL</h2>
		<div style="border: solid 1px; border-color: gray;">
			<div class="ui-grid-a" style="margin-left: 2%; margin-top: 3%;">
				<div class="ui-block-a">제목 : ${qnaboard. title}</div>
				<div class="ui-block-b"></div>
				<div class="ui-block-a" style="width: 40%;">번호 : <span id="board_id">${qnaboard.board_id }</span></div>
				<div class="ui-block-b">질문분류 : ${qnaboard.post_type}</div>
				<div class="ui-block-a" style="width: 40%;" id="id_qna">작성자 : ${qnaboard.member_id }</div>
				<div class="ui-block-b" >작성일 : ${qnaboard_regdate }</div>
			</div>
			<hr style="width: 95%">
			<br>
			<p style="margin-left: 2%; margin-right: 3%">${qnaboard.content }</p>
			<div style="text-align: right;">
				<button data-inline="true" id="updateComent">수정</button>
				<button data-inline="true" id="delComment">삭제</button>
			</div>
		</div>
		<br>
		<div id="comment"></div>
		<form id="commentform">
		<div style="border: solid 1px; border-color: gray;">
			<h3 style="text-align: center;">답글 쓰기</h3>
				<table style="width: 100%">
					<tr>
						<td width="25%" style="text-align: center;">제목</td>
						<td width="*"><input type="text" data-mini="true" name=""></td>
					</tr>
					<tr>
						<td width="25%" style="text-align: center;">내용</td>
						<td width="*"><textarea name=""></textarea></td>
					</tr>
				</table>
				
					
		</div>
		<br>
		<input type="button" name="" data-mini="true" value="답글 등록" data-inline="true">
		</form>
	</div>
	
</body>
</html>