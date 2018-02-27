<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
$(function(){
	var id = $("#sessionid").val()
	var id_qna = $("#id_qna").val()
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
				$("#adminReply").css("visibility","visible")	
				$("#test1").append(data.title)
				$("#test2").append(data.regdate)
				$("#test3").append(data.content)
			}})
		}
	}})
	
	//관리자일때만 댓글폼이 나타나게 하는 ajax
	$.ajax({url:"getGrade.do", data:{"member_id":id}, success:function(data){
		if(data == 0){
			$("#commentform").css("visibility","visible")
			$("#adminDel").css("visibility","visible")
		}
	}})
		
	$("#commentBtn").click(function(){				//댓글 작성
		var data = $("#commentform").serializeArray()
		$.ajax({url:"insertAdminReply.do", data:data, success:function(data){
			alert("댓글작성 완료")
			location.href=""
		}})
	})

	$("#hiddenBtn").click(function(){				//숨기기
		if(confirm("이 질문을 숨기겠습니까?")){			
			$.ajax({url:"hidden_qnaBoard.do", data:{"board_id":board_id}, success:function(data){
				location.href="qnaList.do"
			}})
		}
	})
})
</script>
</head>
<body>
	<input type="hidden" value="${sessionScope.id }" id="sessionid">
	<input type="hidden" value="${qnaboard.b_ref }" id="ref">
	<input type="hidden" value="${qnaboard.member_id }" id="id_qna" name="id_qna">	
	<div data-role="content">
		<h2>QNA DETAIL</h2>
		<div style="background-color:#ddd; padding: 10px;" id="detail_qna">
			<div style="width: 50% ; float: left; ">No.${qnaboard.board_id } [${qnaboard.post_type}]</div>
			<div style="width: 50% ; float: right; font-size: 12px; text-align: right;"> 작성자 : ${qnaboard.member_id }<br>${qnaboard.regdate }</div>
			<div style="margin: 40px 0 0 0; font-size: 23px">${qnaboard.title}</div>
			<div style="margin: 10px 0 10px 0; word-break:break-all; word-wrap:break-word;">${qnaboard.content }</div>
			
			<div id="adminReply" style=" background-color:#eee; padding: 10px; visibility: hidden;">
				<div style="width:100%; display: inline-block;">
				<div id="test1" style='width: 50% ; float: left;'></div>
				<div id="test2" style='width: 50% ; float: right; font-size: 12px; text-align: right;'></div>
				</div>
				<div id="test3"  style="margin: 10px 0 10px 0; word-break:break-all; word-wrap:break-word;"></div>
				<div id="adminDel" style="text-align: right; visibility: hidden;">
					<a href="delete_qnaBoard.do?board_id=-${qnaboard.board_id }">삭제</a>
				</div>
			</div>
		</div>
		<div id="hiddenDiv" style="visibility: hidden; width:50%; ">
			<a href="#" id="hiddenBtn">게시물 숨기기</a>
		</div>
		<div id="controlDiv" style="visibility: hidden;text-align: right;">
			<a href="resources/dialog/qnaUpdate.jsp?board_id=${qnaboard.board_id }" data-rel="dialog">수정</a>
			<a href="delete_qnaBoard.do?board_id=${qnaboard.board_id }">삭제</a>
		</div>
		<form id="commentform" style="visibility:hidden;">
			<p>답글쓰기</p>
			<input type="text" name="title" placeholder="TITLE">
			<textarea name="content"  placeholder="CONTENT"></textarea>
			<input type="hidden" value="${qnaboard.board_id }" id="board_id" name="board_id">
			<div style="text-align : right;">
				<input type="button" id="commentBtn" value="답글등록" data-mini="true" data-inline="true">
			</div>
		</form>
	</div>
</body>
</html>