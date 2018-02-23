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
<style type="text/css">

#comment{
	border: solid 1px; border-color:gray; 
	margin: 5% 5% 5% 5%;
}

#comment h3 {text-align: left; margin-left: 5%;}
#comment div{text-align: right; margin-right: 5%;}
#comment p{margin-left: 5%;}
 
</style>
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	var id = $("#sessionid").val()
	var id_qna = $("#id_qna").html()
	var b_ref = $("#ref").val()
	var board_id = $("#board_id").val()
	
	//댓글 작성
	$("#commentbtn").click(function(){
		var data = $("#commentform").serializeArray()
		$.ajax({url:"insertAdminReply.do", data:data, success:function(data){
			alert("댓글작성 완료")
			location.href=""
		}})
	})
	
	//수정
	$("#updateComent").click(function(){
		alert(id +"|"+ id_qna)
		if(id == id_qna){
			location.href="update_qnaBoard.do?board_id="+board_id
		}else{
			alert("본인만 수정 가능합니다.")
		}
		
	})
	//삭제
	$("#delComment").click(function(){
		if(id == id_qna){
			location.href="delete_qnaBoard.do?board_id="+board_id
		}else{
			alert("본인만 수정 가능합니다.")
		}
	})

	//댓글관련 처리하는 함수
	$.ajax({url:"getCountRef_qnaboard.do", data:{"b_ref":b_ref}, success:function(data){
		if(data > 1){
			$("#updateComent").css("visibility","hidden")
			$("#delComment").css("visibility","hidden")
			$("#commentbtn").css("visibility","hidden")
			$("#commentform").empty()
			
			$.ajax({url:"getComment.do", data:{"b_ref":b_ref}, success:function(data){
				data = eval("("+data+")")
				
				var div = $("<div id='comment'></div>")
				var h3 = $("<h3></h3>").html(data.title)
				var date = $("<div id='regdate'></div>").html(data.regdate)
				var content = $("<p></p>").html(data.content)
				
				$(div).append(h3, date, content)
				$("#detail_qna").append(div)
				
			}})
			
			
			var hidden = $("<button></button>").html("숨기기").attr("data-inline","true")
			if(id = id_qna){
				$("#hiddendiv").append(hidden)
				$(hidden).button()
				
				//댓글 등록 시 글쓴이가 이 글을 숨길수 있음
				$(hidden).click(function(){
					if(confirm("이 질문을 숨기겠습니까?")){
						$.ajax({url:"hidden_qnaBoard.do", data:{"board_id":board_id}, success:function(data){
							alert("숨겼습니다.")
						}})
					}
				})
			}
			
		}
	}})
	
	//관리자일때만 댓글폼이 나타나게 하는 ajax
	$.ajax({url:"getGrade.do", data:{"member_id":id}, success:function(data){
		if(data == 0){
			$("#commentform").css("visibility","visible")
			
		}
	}})
	
	
	
	
})
</script>
</head>
<body>
<input type="hidden" value="${sessionScope.id }" id="sessionid">
<input type="hidden" value="${qnaboard.b_ref }" id="ref">
	<div data-role="content" >
		<h2>QNA DETAIL</h2>
		<div style="border: solid 1px; border-color: gray;" id="detail_qna">
			<div class="ui-grid-a" style="margin-left: 2%; margin-top: 3%;">
				<div class="ui-block-a">제목 : ${qnaboard. title}</div>
				<div class="ui-block-b"></div>
				<div class="ui-block-a" style="width: 40%;">번호 : ${qnaboard.board_id }</div>
				<div class="ui-block-b">질문분류 : ${qnaboard.post_type}</div>
				<div class="ui-block-a" style="width: 40%;">작성자 : <span id="id_qna">${qnaboard.member_id }</span></div>
				<div class="ui-block-b" >작성일 : ${qnaboard.regdate }</div>
			</div>
			<hr style="width: 95%">
			<br>
			<p style="margin-left: 2%; margin-right: 3%">${qnaboard.content }</p>
			<div style="text-align: right;">
				<a data-role="button" data-inline="true" id="updateComent">수정</a>
				<a data-role="button" data-inline="true" id="delComment">삭제</a>
			</div>

		</div>
		<br>
		<div id="hiddendiv"></div>
		<form id="commentform" style="visibility:hidden;">
		<div style="border: solid 1px; border-color: gray;">
			<h3 style="text-align: center;">답글 쓰기</h3>
				<input type="hidden" value="${qnaboard.board_id }" id="board_id" name="board_id">
				<table style="width: 100%">
					<tr>
						<td width="25%" style="text-align: center;">제목</td>
						<td width="*"><input type="text" data-mini="true" name="title"></td>
					</tr>
					<tr>
						<td width="25%" style="text-align: center;">내용</td>
						<td width="*"><textarea name="content"></textarea></td>
					</tr>
				</table>
				
					
		</div>
		<br>
		<input type="button" id="commentbtn" data-mini="true" value="답글 등록" data-inline="true">
		</form>
		
	</div>
	
</body>
</html>