<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#comment {border: solid 1px; border-color:gray; margin: 5% 5% 5% 5%;}
#comment h3 {text-align: left; margin-left: 5%;}
#comment div{text-align: right; margin-right: 5%;}
#comment p{margin-left: 5%;}
</style>
<script type="text/javascript">
$(function(){
	var id = $("#sessionid").val()
	var id_qna = $("#id_qna").html()
	var b_ref = $("#ref").val()
	var board_id = $("#board_id").val()

	$.ajax({url:"getCountRef_qnaboard.do", data:{"b_ref":b_ref}, success:function(data){
		if(id == id_qna){
			$("#controlDiv").css("visibility","visible")
		}
		if(data > 1){
			$("#controlDiv").remove()
			if(id == id_qna){
				$("#hiddenDiv").css("visibility","visible")
			}
			$.ajax({url:"getComment.do", data:{"b_ref":b_ref}, success:function(data){
				data = eval("("+data+")")
				
				var div = $("<div id='comment'></div>")
				var h3 = $("<h3></h3>").html(data.title)
				var date = $("<div id='regdate'></div>").html(data.regdate)
				var content = $("<p></p>").html(data.content)
				
				$(div).append(h3, date, content)
				$("#detail_qna").append(div)
			}})
		}
	}})
	
	//관리자일때만 댓글폼이 나타나게 하는 ajax
	$.ajax({url:"getGrade.do", data:{"member_id":id}, success:function(data){
		if(data == 0){
			$("#commentform").css("visibility","visible")	
		}
	}})
		
	//댓글 작성
	$("#commentBtn").click(function(){
		var data = $("#commentform").serializeArray()
		$.ajax({url:"insertAdminReply.do", data:data, success:function(data){
			alert("댓글작성 완료")
			location.href=""
		}})
	})
	
	//수정
	$("#updateBtn").click(function(){
		if(id == id_qna){
			location.href="update_qnaBoard.do?board_id="+board_id
		}else{
			alert("본인만 수정 가능합니다.")
		}
		
	})
	
	//삭제
	$("#deleteBtn").click(function(){
		if(id == id_qna){
			location.href="delete_qnaBoard.do?board_id="+board_id
		}else{
			alert("본인만 수정 가능합니다.")
		}
	})
	
	$("#hiddenBtn").click(function(){
		if(confirm("이 질문을 숨기겠습니까?")){
			$.ajax({url:"hidden_qnaBoard.do", data:{"board_id":board_id}, success:function(data){
				alert("숨겼습니다.")
			}})
		}
	})
	
})
</script>
</head>
<body>
	<input type="hidden" value="${sessionScope.id }" id="sessionid">
	<input type="hidden" value="${qnaboard.b_ref }" id="ref">
	<div data-role="content" >
		<h2>QNA DETAIL</h2>
		<div style="border: solid 1px;" id="detail_qna">
			<div class="ui-grid-a" style="margin-left: 2%; margin-top: 3%;">
				<div class="ui-block-a">제목 : ${qnaboard. title}</div>
				<div class="ui-block-b"></div>
				<div class="ui-block-a" style="width: 40%;">번호 : ${qnaboard.board_id }</div>
				<div class="ui-block-b">질문분류 : ${qnaboard.post_type}</div>
				<div class="ui-block-a" style="width: 40%;">작성자 : <span id="id_qna">${qnaboard.member_id }</span></div>
				<div class="ui-block-b" >작성일 : ${qnaboard.regdate }</div>
			</div>
			<p style="margin-left: 2%; margin-right: 3%">${qnaboard.content }</p>
		</div>
		<div id="controlDiv" style="visibility: hidden;">
			<input type="button" id="updateBtn" value="수정" data-mini="true" data-inline="true">
			<input type="button" id="deleteBtn" value="삭제" data-mini="true" data-inline="true">
		</div>
		<div id="hiddenDiv" style="visibility: hidden;">
			<input type="button" id="hiddenBtn" value="숨기기" data-mini="true" data-inline="true">
		</div>
		<form id="commentform" style="visibility:hidden;">
			<p>답글쓰기</p>
			<input type="hidden" value="${qnaboard.board_id }" id="board_id" name="board_id">
			<input type="text" name="title">
			<textarea name="content"></textarea>
		
			<input type="button" id="commentBtn" value="답글등록" data-mini="true" data-inline="true">
		</form>
	</div>
</body>
</html>