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
	$(function(){
		$("#joinChkBtn").click(function(){
			if($("#jumin1").val()!="" && $("#jumin2").val()!=""){
				var jumin = $("#jumin1").val()+"-"+$("#jumin2").val()
				var chkJumin = Number(jumin.substr(13,1)) == 11-((2*Number(jumin.substr(0,1))+3*Number(jumin.substr(1,1))+4*Number(jumin.substr(2,1))+5*Number(jumin.substr(3,1))+6*Number(jumin.substr(4,1))+7*Number(jumin.substr(5,1))+8*Number(jumin.substr(7,1))+9*Number(jumin.substr(8,1))+2*Number(jumin.substr(9,1))+3*Number(jumin.substr(10,1))+4*Number(jumin.substr(11,1))+5*Number(jumin.substr(12,1)))%11) //주민등록번호 유효성 검사
				if(chkJumin){
					data = {"jumin":jumin}
					$.ajax({
						url:"getId_member.do",
						type:"POST",
						data:data,
						success:function(data){
							if(data!=""){
								alert("이미 가입된 회원입니다.")
							}else{
								$("#jumin").val(jumin)
								$("#jumin1").val()
								$("#F").submit();
							}
						}
					})
				}else{
					$("#msg_joinCheck").html("* 올바르지 않는 주민등록번호 입니다.")
				}
			}else{
				alert("주민등록 번호를 작성해주시길 바랍니다.")
			}
		})
		
		$("#findMemberBtn").click(function(){
			location.href="findMember.do"
		})
	})
</script>
</head>
<body>
	<div data-role="page">       
		<div data-role="header">	    
			<h1>JOIN</h1>
		</div>
		<div data-role="content">
			<div class="ui-grid-c join-process">
			    <div class="ui-block-a step"><p>약관동의</p></div>
			    <div class="ui-block-b step point"><p>인증</p></div>
			    <div class="ui-block-c step"><p>가입진행</p></div>
			    <div class="ui-block-d step"><p>완료</p></div>
			</div>
			
			<form id="F" action="joinCheck.do" method="post" data-ajax="false">
				<label>주민번호</label>
				<div class="ui-grid-b">
				    <div class="ui-block-a" style="width: 47%">
				    	<input type="text" id="jumin1" name="jumin1" required="required" maxlength="6">
				    </div>
				    <div class="ui-block-b" style="width: 6%">
				    	<div style="margin-top: 15px; text-align: center;">-</div>
				    </div>
				    <div class="ui-block-c" style="width: 47%">
				    	<input type="password" id="jumin2" name="jumin2" required="required" maxlength="7">
				    </div>
				</div>
	
				<label id="msg_joinCheck" style="color: red; font-size: 13px"></label>
				<input type="hidden" name="jumin" id="jumin" value="">
				
			</form>
			<div data-role="controlgroup" data-type="horizontal" data-corners="false" class="fr-button">
				<input type="button" value="ID/PW 찾기" id="findMemberBtn">
				<input type="button" value="다음" id="joinChkBtn">
			</div>
		</div>
	</div>
 	
</body>
</html>