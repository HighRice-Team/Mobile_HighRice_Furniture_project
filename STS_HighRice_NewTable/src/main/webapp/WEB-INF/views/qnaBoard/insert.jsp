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
	
})
</script>
</head>
<body>
	<div data-role="content">
		<form id="qnaform" method="POST">
			<table style="width: 100%">
				<tr>
					<td width="25%">질문분류 </td>
					<td width="*">
						<select name="" data-mini="true">
							<option>물품문의</option>
							<option>배송문의</option>
							<option>주문/결제문의</option>
							<option>취소/환불문의</option>
							<option>기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="25%">제&nbsp;&nbsp;목 </td>
					<td width="*">
						<input type="text" data-mini="true" name="">
					</td>
				</tr>
			</table>
			<br>
			 내&nbsp;&nbsp;용
				<textarea name="" style="height: 200px;" ></textarea>
			<br>
			<div class="ui-grid-a">
				<div class="ui-block-a">
					<input type="button" value="뒤로">
				</div>
				<div class="ui-block-b">
					<input type="submit" value="등록" >
				</div>
				
			</div>
			
			
			
		</form>
	</div>
</body>
</html>