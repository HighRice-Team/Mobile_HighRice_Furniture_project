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
	$("#qnaBack").click(function(){
		history.back()
	})
	
	$("#updatebtn").click(function(){
		var data = $("#qnaform").serializeArray();
		$.ajax({url:"updateAjax_qnaBoard.do",data:data, success:function(data){
			if(data == 1){
				alert("수정 완료")
				location.href="detailQna.do?board_id="+$("#board_id").val();
			}
		}})
	})

})
</script>
</head>
<body>
	<div data-role="content">
		<form id="qnaform">
			<input type="hidden" value="${qb.board_id }" id="board_id" name="board_id">
			<table style="width: 100%">
				<tr>
					<td width="25%">제&nbsp;&nbsp;목 </td>
					<td width="*">
						<input type="text" data-mini="true" name="title" value="${qb.title }">
					</td>
				</tr>
			</table>
			<br>
			 내&nbsp;&nbsp;용
				<textarea name="content" style="height: 200px;" >${qb.content }</textarea>
			<br>
			<div class="ui-grid-a">
				<div class="ui-block-a">
					<input type="button" value="뒤로" id="qnaBack">
				</div>
				<div class="ui-block-b">
					<input type="button" value="등록" id="updatebtn">
				</div>
			</div>	
		</form>
	</div>
</body>
</html>