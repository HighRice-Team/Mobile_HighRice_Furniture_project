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
		<h2>QNA DETAIL</h2>
		<div style="border: solid 1px; border-color: gray;">
			<div class="ui-grid-a">
				<div class="ui-block-a">제목 : 배송문의</div>
				<div class="ui-block-b"></div>
				<div class="ui-block-a">번호 : 1120</div>
				<div class="ui-block-b">질문분류 : 배송문의</div>
				<div class="ui-block-a">작성자 : a1</div>
				<div class="ui-block-b">작성일 : 2018-01-26</div>
			</div>
			<hr style="width: 95%">
			<br>
			<p style="margin-left: 5%; margin-right: 5%">배송은 어느정도 소요되나요? 결제를 오늘 할 예정인데 배송 소요일이 궁금합니다.</p>
			<div style="text-align: right;">
				<button data-inline="true" >수정</button>
				<button data-inline="true" >삭제</button>
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
		<input type="button" name="" data-mini="true" value="답글 등록" data-inline="true">
		</form>
	</div>
	
</body>
</html>