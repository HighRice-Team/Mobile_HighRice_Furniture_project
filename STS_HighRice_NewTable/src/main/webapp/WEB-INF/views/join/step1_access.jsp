<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/join.css">
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
		location.href="main.do"
	}
</script>
</head>
<body>
	<div data-role="content">
		<div class="ui-grid-b join-process">
		    <div class="ui-block-a step point"><p>약관동의</p></div>
		    <div class="ui-block-b step"><p>가입진행</p></div>
		    <div class="ui-block-c step"><p>완료</p></div>
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
</body>
</html>