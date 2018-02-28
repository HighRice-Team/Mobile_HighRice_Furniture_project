<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="update_qna" data-role="page" data-close-btn="none" data-overlay-theme="b">
	<script type="text/javascript">
	$(function(){
		var board_id = $("#board_id").val()
		
		$.ajax({url:"../../qnaUpdate.do?board_id="+board_id,success:function(data){
			data = eval('('+data+')')
			$("#title").val(data.title)
			$("#content").val(data.content)
		}});
		
		$("#updateOkBtn").click(function(){
			var data = {"board_id": board_id,"title": $("#title").val(),"content":$("#content").val()}
			$.ajax({url:"../../qnaUpdateOk.do", data:data, success:function(data){
				location.href="../../qnaDetail.do?board_id="+board_id;
			}}) 
		})
	})
	</script>
	<div data-role="content">
		<input type="hidden" value="${board_id.board_id }" id="board_id" name="board_id">
		<input type="text" id="title" name="title">
		<textarea id="content" name="content" style="height: 200px;"></textarea>
		<input type="button" value="수정" id="updateOkBtn">	
	</div>
</div>