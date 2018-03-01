<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/join.css">
<script type="text/javascript">
   $(function(){
     
		//아이디 판별
      $("#chk_idBtn").click(function(){
    	 var member_id = $("#member_id").val()
    	 $.ajax({url:"getOne_member.do",data:{member_id:member_id}, success:function(data){
    		 data = eval("("+data+")")
    		 if(data == null){
    			 $("#idchk").html("<img src='resources/img/icon/checked.png' class='check-img'/>"+" 사용가능한 아이디입니다.")
    			 $("#idchk").css("color","blue")
    		 }
    		 else{
    			 $("#idchk").html("<img src='resources/img/icon/Xicon.png' class='check-img'>"+" 중복된 아이디입니다.")
    		     $("#idchk").css("color","red")
    		 }
    	 }})
      })
      
      
      //시간값
      var sec = 1000;

      //핸드폰 문자 서비스
      $("#chkphone").click(function(){
    	  $.ajax({url:"chkphone.do", data:{phone:$("#tel").val()},success:function(data){
    		  $("#chksec").empty().css("color","block")
 			  var i = 60;
    		  var chk = setInterval(function(){
					
					$("#chksec").html(i+" 초 남았습니다.")
					i--;
					if(i <= 0){
						 
						 $("#chkphonediv").css("display","none")
						 $("#chksec").html("인증 시간이 초과되었습니다.").css("color","red")
					  }
				  }, sec)
				    		  
    		  $("#chkphonediv").css("display","")
			  
    		  $("#chkphone2").click(function(){
    			  if($("#chknum").val()==data){
    				  clearInterval(chk)
    				  $("#chksec").html("인증되었습니다").css("color","blue")
    			  }else{
    				  $("#chksec").append("<div style='color:red;'>틀렸습니다.</div>")
    			  }
    		  })
    	  }})
		
			 
      })
      
     
           
      $("#insert_memberBtn").click(function(){
         if($("#member_id").val()=="")
         {
            alert("아이디를 입력해주세요.")
            return false;
         }
         
         if($("#chkPwdIcon2").attr("chkSame")!="true"){
            alert("비밀번호 확인을 해주세요.")
            return false;
         }
         
         if($("#roadAddrPart1").val()==""){
            alert("주소를 등록해 주세요.")
            return false;
         }
         if($("#chksec").html()!="인증되었습니다"){
        	 alert("인증을 완료해주세요")
        	 return false;
         }
         
      }) 
      
      //주민등록 번호 가지고 있는 함수
      $("#gender").change(function(){
    	  var a = ($("#juminnum").val()).split("-")
    	  str = ''
    	  $(a).each(function(index, data){
    		  str += data
    	  })
    	  str = str+$("#gender").val()
    	  $("#jumin").val(str)
      })
      
   })
   function goPopup(){
      // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
//        var pop = window.open("search.do","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
       
      // 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
       var pop = window.open("search.do","pop","scrollbars=yes, resizable=yes"); 
      }
      /** API 서비스 제공항목 확대 (2017.02) **/
   function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn
                     , detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo){
      // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
      document.form.roadAddrPart1.value = roadAddrPart1;
      document.form.roadAddrPart2.value = roadAddrPart2;
      document.form.addrDetail.value = addrDetail;
      document.form.zipNo.value = zipNo;
   }
      
   function chkPwd(){
    	var inputPwd = $("#inputPwd").val()  
    	var inputPwd2 = $("#inputPwd2").val()
    	
    	if(inputPwd.length>=8){
    		$("#chkPwdIcon1").html("<img src='resources/img/icon/checked.png' class='check-img'>")
    		if(inputPwd==inputPwd2){
    			$("#chkPwdIcon2").html("<img src='resources/img/icon/checked.png' class='check-img'>")
    			$("#chkPwdIcon2").attr("chkSame","true")
    		}else{
    			$("#chkPwdIcon2").html("<img src='resources/img/icon/Xicon.png' class='check-img'>")
    			$("#chkPwdIcon2").attr("chkSame","false")
    		}
    	}else{
    		$("#chkPwdIcon1").html("<img src='resources/img/icon/Xicon.png' class='check-img'>")
    	}

   }
	function back() {
		location.href="main.do"
	} 
</script>
<style type="text/css">
.check-img {height: 20px; margin: 17px 0 0 10px}
</style>
</head>
<body>    
	<div data-role="content">
		<div class="ui-grid-b join-process">
		    <div class="ui-block-a step"><p>약관동의</p></div>
		    <div class="ui-block-b step point"><p>가입진행</p></div>
		    <div class="ui-block-c step"><p>완료</p></div>
		</div>
		<form action="insert_member.do" name="form" id="form" method="post" data-ajax="false">
			<div class="ui-grid-c join-row">
		    	<div class="ui-block-a rate-2"><p class="p-1row">아이디</p></div>
		   		<div class="ui-block-b" style="width: 70%">
		   			<div class="ui-grid-a">
			   			<div class="ui-block-a" style="width: 75%"><input type="text" name="member_id" id="member_id" required="required"></div>
			   			<div class="ui-block-b" style="width: 25%; margin: 5px 0 0 0 ; float: right;">
			   				<input type="button" id="chk_idBtn" value="확인" data-mini="true" data-inline="true" data-corners="false" style="overflow: visible;">
			   			</div>
		   			</div>
		   		</div>
			</div>
			<div class="ui-grid-a join-row">
				<div class="ui-block-a rate-2"></div>
				<div class="ui-block-b rate-8"><div id="idchk"></div></div>
			</div>
			
			
			<div class="ui-grid-c join-row">
		    	<div class="ui-block-a rate-2"><p class="p-1row">비밀번호</p></div>
		   		<div class="ui-block-b "style="width: 70%"><input type="password" id="inputPwd"required="required" placeholder="비밀번호는 8자 이상" oninput="chkPwd()"></div>
		   		<div class="ui-block-c rate-2" id="chkPwdIcon1" style="align-content: left; width:  10% "></div>
			</div>
			<div class="ui-grid-c join-row">
		    	<div class="ui-block-a rate-2"><p class="p-2row">비밀번호<br>확인</p></div>
		   		<div class="ui-block-b" style="width: 70%"><input type="password" id="inputPwd2" name="pwd"  required="required" oninput="chkPwd()" placeholder="위와 같아야 합니다."></div>
		   		<div class="ui-block-c" id="chkPwdIcon2" style="align-content: left;width:  10% " ></div>
			</div>
			
	 
			<div class="ui-grid-a join-row">
		    	<div class="ui-block-a rate-2"><p class="p-2row">이름</p></div>
		   		<div class="ui-block-b rate-8"><input type="text" id="name" name="name" required="required"></div>
			</div>
			<div class="ui-grid-c join-row">
		    	<div class="ui-block-a rate-2"><p class="p-2row">주민번호</p></div>
		   		<div class="ui-block-b rate-4"><input type="date" id="juminnum" style="text-align: center;"></div>
		   		<div class="ui-block-c" style="width: 10%;"><input type="number" min="1" max="6" id='gender'></div>
		   		<div class="ui-block-d rate-2" style="margin-top: 5%">******</div>
			</div>
			<div class="ui-grid-b join-row">
		    	<div class="ui-block-a rate-2"><p class="p-2row">핸드폰번호</p></div>
		   		<div class="ui-block-b rate-6"><input type="text" name="tel" id="tel" required="required" placeholder="'-'빼고 입력해주세요"></div>
		   		<div class="ui-block-c rate-2"><input type="button" data-inline="true" data-corners="false" data-mini="true" value="인증" id="chkphone" ></div>
			</div>	
			<div id="chkphonediv" class="ui-grid-b" style="display: none;">
				<div class="ui-block-a rate-2"></div>
		   		<div class="ui-block-b rate-6"><input type="number" id="chknum"></div>
		   		<div class="ui-block-c rate-2"><input type="button" data-inline="true" data-corners="false" data-mini="true" value="번호입력" id="chkphone2" ></div>
			</div>
				<div id="chksec"></div>
		    <p class="p-2row">계좌번호</p>
			<div class="ui-grid-a join-row">
		    	<div class="ui-block-a rate-4" style=" margin: 5px 5px 0 -5px ; ">
					<select name="bank" id="bank" data-corners="false" data-mini="true">
						<option>신한은행</option>
						<option>기업은행</option>
						<option>농협은행</option>
						<option>국민은행</option>
						<option>카카오뱅크</option>
					</select>
				</div>
		   		<div class="ui-block-b rate-6"><input type="text" id="account_no" name="account_no" required="required"></div>
			</div>
			<p class="p-2row">주소</p>
			<div class="ui-grid-a join-row">
		    	<div class="ui-block-a rate-8"><input type="text" id="roadAddrPart1" name="address" readonly="readonly" required="required"></div>
		   		<div class="ui-block-b rate-2" style=" margin: 5px -10px 0 0 ; float: right;"><a data-role="button" data-ajax="false" data-mini="true"  data-corners="false" data-inline="true" onclick="goPopup()">검색</a></div>
			</div>
			
			<input type="text" id="addrDetail" name="address_detail" readonly="readonly" required="required">
			<div class="ui-grid-a join-row">
		   		<div class="ui-block-a rate-2"><p class="p-2row">비밀번호<br>힌트</p></div>
		    	<div class="ui-block-b rate-8" >
					<select name="pwd_q" id="pwd_q"  data-corners="false">
						<option>가장 기억에 남는 선물은?</option>
						<option>자신의 보물 제1호는?</option>
						<option>인상 깊게 읽은 책 이름은?</option>
						<option>자신의 출신 초등학교는?</option>
					</select>
				</div>
			</div>
			<div class="ui-grid-a join-row">
		    	<div class="ui-block-a rate-2"><p class="p-2row">힌트 답</p></div>
		   		<div class="ui-block-b rate-8"><input type="text" id="pwd_a" name="pwd_a" required="required"></div>
			</div>
			<input type="hidden" id="roadAddrPart2"  value="">
			<input type="hidden" id="confmKey" name="confmKey" value=""  >
			<input type="hidden" id="zipNo" name="zipNo" >
			<input type="hidden" name="jumin" id="jumin">
			<div data-role="controlgroup" data-type="horizontal" data-corners="false" class="fr-button">
				<input type="button" value="취소" onclick="back()">
				<input type="submit" value="가입" id="insert_memberBtn">
			</div>
		</form>
	</div>
</body>
</html>
