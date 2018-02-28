<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/join.css">
<script type="text/javascript">
function back() {
	location.href="main.do"
}	
</script>
</head>
<body>
	<div data-role="content">
		<div class="ui-grid-b join-process">
		    <div class="ui-block-a step"><p>약관동의</p></div>
		    <div class="ui-block-b step"><p>가입진행</p></div>
		    <div class="ui-block-c step point"><p>완료</p></div>
		</div>
		<div class="join-complete">
			<p>가입이 완료되었습니다.</p>
			<p>가입하신 정보로 로그인하여 주시기 바랍니다.</p>
			<div data-role="controlgroup" data-type="horizontal" data-corners="false" class="fr-button">
				<input type="button" value="메인으로" data-inline="true" onclick="back()">
			</div>
		</div>
	</div>
</body>
</html>