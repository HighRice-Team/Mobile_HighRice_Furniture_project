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
	p {font-size: 12px; margin: 20px 0 0 0}
	.p-2row { margin: 12px 0 0 0}
	.fr-button { text-align: center; }
	
	.join-row .rate-2 {width: 20%}
	.join-row .rate-4 {width: 40%}
	.join-row .rate-6 {width: 60%}
	.join-row .rate-8 {width: 80%}

	.join-process { margin: 0 0 20px 0 }
	.join-process .step { height:50px; text-align: center; background-color: #ddd;}
	.join-process .point{ background-color: #ccc;}
</style>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
</head>
<body>
	<div data-role="page">       
		<div data-role="header">	    
			<h1>JOIN</h1>
		</div>
		<div data-role="content">
			<div class="ui-grid-c join-process">
			    <div class="ui-block-a step"><p>약관동의</p></div>
			    <div class="ui-block-b step"><p>인증</p></div>
			    <div class="ui-block-c step point"><p>가입진행</p></div>
			    <div class="ui-block-d step"><p>완료</p></div>
			</div>
			<form action="insert_member.do" name="form" id="form" method="post" data-ajax="false">
				<div class="ui-grid-b join-row">
			    	<div class="ui-block-a rate-2"><p>아이디</p></div>
			   		<div class="ui-block-b rate-6"><input type="email" id="member_id" required="required" placeholder="email 형식"></div>
			    	<div class="ui-block-c rate-2"><input type="button" id="chk_idBtn" data-icon="home"></div>
				</div>
				<div id="confirmText_join"></div>	
				<div class="ui-grid-a join-row">
			    	<div class="ui-block-a rate-2"><p>비밀번호</p></div>
			   		<div class="ui-block-b rate-8"><input type="password" id="inputPwd" required="required"></div>
				</div>
				<div class="ui-grid-a join-row">
			    	<div class="ui-block-a rate-2"><p class="p-2row">비밀번호<br>확인</p></div>
			   		<div class="ui-block-b rate-8"><input type="password" id="inputPwd2"  required="required"></div>
				</div>
				<div id="chk_confirmPwd" style="color: red;"></div>
				<div class="ui-grid-a join-row">
			    	<div class="ui-block-a rate-2"><p>이름</p></div>
			   		<div class="ui-block-b rate-8"><input type="text" id="name" name="name" required="required"></div>
				</div>
				<div class="ui-grid-a join-row">
			    	<div class="ui-block-a rate-2"><p>주민번호</p></div>
			   		<div class="ui-block-b rate-8"><input type="text" maxlength="6" id="juminnum" value="${jumin1 }-*******" readonly="readonly"></div>
				</div>
				<div class="ui-grid-a join-row">
			    	<div class="ui-block-a rate-2"><p>핸드폰번호</p></div>
			   		<div class="ui-block-b rate-8"><input type="text" name="tel" id="tel" required="required"></div>
				</div>	
			    <p>계좌번호</p>
				<div class="ui-grid-a join-row">
			    	<div class="ui-block-a rate-4">
						<select name="bank" id="bank" place data-corners="false">
							<option>신한은행</option>
							<option>기업은행</option>
							<option>농협은행</option>
							<option>국민은행</option>
							<option>카카오뱅크</option>
						</select>
					</div>
			   		<div class="ui-block-b rate-6"><input type="text" id="account_no" name="account_no" required="required"></div>
				</div>
				<p>주소</p>
				<div class="ui-grid-a join-row">
			    	<div class="ui-block-a rate-8"><input type="text" id="roadAddrPart1" name="address" readonly="readonly" value="test_test_test" required="required"></div>
			   		<div class="ui-block-b rate-2"><input type="button" onclick="goPopup();"  data-icon="home"></div>
				</div>
				<input type="text" id="addrDetail" name="address_detail" readonly="readonly" value="1234" required="required">
				<div class="ui-grid-a join-row">
			   		<div class="ui-block-a rate-2"><p class="p-2row">비밀번호<br>힌트</p></div>
			    	<div class="ui-block-b rate-8">
						<select name="pwd_q" id="pwd_q">
							<option>가장 기억에 남는 선물은?</option>
							<option>자신의 보물 제1호는?</option>
							<option>인상 깊게 읽은 책 이름은?</option>
							<option>자신의 출신 초등학교는?</option>
						</select>
					</div>
				</div>
				<div class="ui-grid-a join-row">
			    	<div class="ui-block-a rate-2"><p>힌트 답</p></div>
			   		<div class="ui-block-b rate-8"><input type="text" id="pwd_a" name="pwd_a" required="required"></div>
				</div>
				<input type="hidden" id="roadAddrPart2"  value="">
				<input type="hidden" id="confmKey" name="confmKey" value=""  >
				<input type="hidden" id="zipNo" name="zipNo" >
				<input type="hidden" name="pwd" id="pwd">
				<input type="hidden" name="member_id" id="memberIdForDb">
				<input type="hidden" name="jumin" value="${v.jumin }">
				<div data-role="controlgroup" data-type="horizontal" data-corners="false" class="fr-button">
					<input type="button" value="취소" id="resetInsertBtn">
					<input type="submit" value="가입" id="insert_memberBtn">
				</div>
			</form>
		</div>
	</div>
</body>
</html>