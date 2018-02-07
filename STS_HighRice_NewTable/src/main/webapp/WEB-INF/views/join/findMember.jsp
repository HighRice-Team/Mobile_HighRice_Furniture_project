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
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".findInfo").click(function(){
       if($("#name").val()!=""&&$("#jumin").val()!=""){
          var name = $("#name").val()
          var jumin = $("#jumin1").val()+"-"+$("#jumin2").val()
          //올바른 주민등록번호 인지 검사.
          var chkJumin = Number(jumin.substr(13,1)) == 11-((2*Number(jumin.substr(0,1))+3*Number(jumin.substr(1,1))+4*Number(jumin.substr(2,1))+5*Number(jumin.substr(3,1))+6*Number(jumin.substr(4,1))+7*Number(jumin.substr(5,1))+8*Number(jumin.substr(7,1))+9*Number(jumin.substr(8,1))+2*Number(jumin.substr(9,1))+3*Number(jumin.substr(10,1))+4*Number(jumin.substr(11,1))+5*Number(jumin.substr(12,1)))%11)
          if(chkJumin){
             data = {"name":name,"jumin":jumin}
             $.ajax({
                url:"getId_member.do",
                type:"POST",
                data:data,
                success:function(data){
                   if(data!="")
                   {
                      if(confirm("가입한 ID : "+data +"\n비밀번호를 찾으시겠습니까?")){
                         $.ajax({
                            url:"sendMail.do",
                            data:{"member_id":data},
                            success:function(re){
                               alert("비밀번호를 메일로 발송하였습니다.")
                            }
                         })
                      }
                   }else{
                      alert("가입 된 정보가 없습니다.")
                   }
                }
             })
          }else{
             $("#msg_joinCheck").html("* 올바르지 않는 주민등록번호 입니다.")
          }
       }else{
          alert("입력정보를 모두 작성해주시길 바랍니다.")
       }
    })
})
function login() {
	location.href="testMain.do"
}
</script>
</head>
<body>
	<div data-role="page">       
		<div data-role="header">	    
			<h1>JOIN_JUMIN</h1>
		</div>
		<div data-role="content">
			<h1>회원정보 입력</h1>
			
			<div data-role="fieldcontain">
				<label for="name">이름 </label>
				<input type="text" id="name" required="required">
			</div>
		
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
						
			<label id="msg_joinCheck" style="color: red;"></label>


			<div data-role="controlgroup" data-type="horizontal" data-corners="false" class="fr-button">
				<input type="button" value="로그인" onclick="login()">
     		 	<input type="button" value="ID/PW 찾기" id="findId" class="findInfo">
			</div>
		</div>
	</div>
</body>
</html>