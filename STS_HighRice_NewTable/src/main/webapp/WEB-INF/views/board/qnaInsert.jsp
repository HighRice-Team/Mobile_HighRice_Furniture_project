<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	$(function(){$("#qnaBack").click(function(){history.back()})})
</script>
</head>
<body>
	<div data-role="content">
		<form id="qnaform" method="POST" data-ajax="false">
			<table style="width: 100%">
				<tr>
					<td width="25%">질문분류 </td>
					<td width="*">
						<select name="post_type" data-mini="true">
							<option value="물품문의">물품문의</option>
							<option value="배송문의">배송문의</option>
							<option value="주문/결제문의">주문/결제문의</option>
							<option value="취소/환불문의">취소/환불문의</option>
							<option value="기타">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="25%">제&nbsp;&nbsp;목 </td>
					<td width="*">
						<input type="text" data-mini="true" name="title">
					</td>
				</tr>
			</table>
			<br>
			 내&nbsp;&nbsp;용
			<textarea name="content" style="height: 200px;" ></textarea>
			<br>
			<div class="ui-grid-a">
				<div class="ui-block-a">
					<input type="button" value="뒤로" id="qnaBack">
				</div>
				<div class="ui-block-b">
					<input type="submit" value="등록" data-ajax="false">
				</div>
			</div>
		</form>
	</div>
</body>
</html>