<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
<meta name="apple-mobile-web-app-capable" content="yes"/>
<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
<title>MOBILE WEB TEST</title>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css" />
<style type="text/css">
	.fr-button { text-align: center; }
	
	.join-process { margin: 0 0 20px 0 }
	.join-process .step { height:50px; text-align: center; background-color: #ddd;}
	.join-process .point{ background-color: #ccc;}
	
	.join-complete {background-color: #EAEAEA; text-align: center; font-size: 18px; padding: 20px 0 20px 0}
</style>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#goMain").click(function(){
		location.href = "index.do";
	})
})	
</script>
</head>
<body>
	<div data-role="page">       
		<div data-role="header">	    
			<h1>JOINasdasd</h1>
		</div>
		<div data-role="content">
			<div class="ui-grid-c join-process">
			    <div class="ui-block-a step"><p>약관동의</p></div>
			    <div class="ui-block-b step"><p>인증</p></div>
			    <div class="ui-block-c step"><p>가입진행</p></div>
			    <div class="ui-block-d step point"><p>완료</p></div>
			</div>
			<div class="join-complete">
				<p>가입이 완료되었습니다.</p>
				<p>가입하신 정보로 로그인하여 주시기 바랍니다.</p>
				<div data-role="controlgroup" data-type="horizontal" data-corners="false" class="fr-button">
					<input type="button" value="메인으로" data-inline="true" id="goMain">
					<input type="button" value="로그인" id="insert_memberBtn">
				</div>
			</div>
		</div>
	</div>
</body>
</html>