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
</style>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
<script type="text/javascript">
	function agree() {
		var chk1 = document.form.chk1.checked;
		var chk2 = document.form.chk2.checked;
		var num = 0;
		if (chk1 == true && chk2 == true) {
			num = 1;
		}
		if (num == 1) {
			document.form.submit();
		} else {
			alert("개인정보 약관에 동의하셔야 합니다.");
		}
	}
	function back() {
		location.href="testMain.do"
	}
</script>
<title>join</title>
</head>
<body>
	<div data-role="page">       
		<div data-role="header">	    
			<h1>JOIN</h1>
		</div>
		<div data-role="content">
			<div class="ui-grid-c join-process">
			    <div class="ui-block-a step point"><p>약관동의</p></div>
			    <div class="ui-block-b step"><p>인증</p></div>
			    <div class="ui-block-c step"><p>가입진행</p></div>
			    <div class="ui-block-d step"><p>완료</p></div>
			</div>
			<form action="joinCheck.do" name="form" method="get" data-ajax="false">
				<div data-role="collapsible" data-collapsed="false" data-content-theme="d">
					<h5>동의해줘 첫번째</h5>
					<div>
						<p>가. 수집하는 개인정보의 항목첫째, 회사는 회원가입, 원활한 고객상담, 각종 서비스의 제공을 위해 최초 회원가입 당시 아래와 같은 최소한의 개인정보를 필수항목으로 수집하고 있습니다.</p>
						<input type="checkbox" name="chk1" id="chk1"/>
	 					<label for="chk1">개인정보 수집 및 이용에 동의합니다.</label>
					</div>
				</div>
				<div data-role="collapsible" data-content-theme="d">
					<h3>동의해줘 두번째</h3>
					<div>
						<p>가. 수집하는 개인정보의 항목첫째, 회사는 회원가입, 원활한 고객상담, 각종 서비스의 제공을 위해 최초 회원가입 당시 아래와 같은 최소한의 개인정보를 필수항목으로 수집하고 있습니다.</p>
						<input type="checkbox" name="chk2" id="chk2"/>
	 					<label for="chk2">개인정보 수집 및 이용에 동의합니다.</label>
					</div>
				</div>
			
				<div data-role="controlgroup" data-type="horizontal" data-corners="false" class="fr-button">
					<input type="button" value="취소" onclick="back()"/>
					<input type="button" value="동의" onclick="agree()"/>
				</div>
			</form>
		</div>
	</div>
</body>
</html>