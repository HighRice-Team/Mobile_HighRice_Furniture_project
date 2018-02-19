<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/join.css">
<script type="text/javascript">
   $(function(){
      var intervalObject   // Timer역할을 할 Interval객체
      var ranNum   // 인증번호를 위한 임의의 난수
      var samePwd=0;
      var timer = 180

      $("#chk_idBtn").click(function(){
    	 
         if($("#member_id").val()!=""){
            clearInterval(intervalObject)
            var member_id = $("#member_id").val()
            var data = {"member_id":member_id}
            //var chkEmail = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
            var chkEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; 
            //var chkEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            if(!chkEmail.test($("#member_id").val())) {
                $("#confirmText_join").html(" *이메일 형식이 맞지 않습니다.")                      
                return false;
            }
            
            $.ajax({
               url:"getOne_member.do",
               data:data,
               success:function(data){
                  data = eval("("+data+")")
                  if(data==null){
                     $("#confirmText_join").html(" *사용 가능. 입력한 이메일로 인증번호를 발송했습니다.")
                     $("#chkArea").removeClass("hidden")
                     $("#msg_join2").empty()	
                     timer = 180
                     var min = Math.floor(timer/60)
                     var sec = timer%60
                           
                     intervalObject = setInterval(function(){
                              
                    	$("#timerView").html(min+"분"+" "+sec+"초 남았습니다.")
                     	timer--
                     	min = Math.floor(timer/60)
                     	sec = Math.round(timer%60)
                              
                     	if(timer==-2){
                     		clearInterval(intervalObject)
                     		$("#timerView").html("인증시간 초과. 다시 시도해주시길 바랍니다.")
                     	}
                     }, 1000);
                     
                     ranNum = Math.floor(Math.random()*10000)
                     
                     if(ranNum<1000)
                     {   ranNum = ranNum + 1000   }
                     
                     var confirmData = {"member_id":member_id,"confirmText":ranNum}
                     
                     $.ajax({
                        url:"sendMail.do",
                        data:confirmData,
                        success:function(data){
                 
                        }
                     })
                     
                  }else{
                     $("#confirmText_join").html(" *이미 존재하는 아이디입니다.")
                  }
               }
            })
         }else{
        	 $("#confirmText_join").html("아이디를 이메일 형식으로 입력하고, 이메일 인증을 바랍니다.")
         }
      })
      
      $(document).on("click","#chk_confirmTextBtn",function(){
         var input_confirmText = $("#input_confirmText").val()
         if(input_confirmText==ranNum&&timer>-2){
            $("#confirmText_join").empty()
            $("#emailIcon").html("<img src='resources/img/icon/checked.png' class='check-img' style='overflow:visible'>")
            $("#memberIdForDb").val($("#member_id").val())
            $("#chkArea").addClass("hidden")
            $("#input_confirmText").val(null)
            clearInterval(intervalObject)
         }else if(input_confirmText!=ranNum){
        	 $("#msg_join2").html("인증번호 오류")
         }
      })
           
      $("#insert_memberBtn").click(function(){     
         if($("#emailIcon").html()=="")
         {
            alert("아이디 이메일 인증을 해주시길 바랍니다.")
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
</head>
<body>    
	<div data-role="content">
		<div class="ui-grid-c join-process">
		    <div class="ui-block-a step"><p>약관동의</p></div>
		    <div class="ui-block-b step"><p>인증</p></div>
		    <div class="ui-block-c step point"><p>가입진행</p></div>
		    <div class="ui-block-d step"><p>완료</p></div>
		</div>
		<form action="insert_member.do" name="form" id="form" method="post" data-ajax="false">
			<div class="ui-grid-c join-row">
		    	<div class="ui-block-a rate-2"><p class="p-1row">아이디</p></div>
		   		<div class="ui-block-b rate-5"><input type="email" id="member_id" required="required" placeholder="email 형식"></div>
		    	<div class="ui-block-c rate-1"><input type="button" id="chk_idBtn" value="중복확인" data-mini="true" data-inline="true" data-corners="false" style="margin-top: 10px; overflow: visible;"></div>
		    	<div class="ui-block-d rate-1" id="emailIcon" style="overflow: visible;"></div>
			</div>
			
			<div class="ui-grid-a join-row">
				<div class="ui-block-a rate-2"></div>
		   		<div class="ui-block-b rate-8">
		   			<div id="confirmIdArea_join" style="color: red;">
						<span id="confirmText_join" style="font-size: 2.9vw;"></span>
						<div class="ui-grid-b join-row hidden" id="chkArea">
							<div class="ui-block-a rate-4"><input type="password" id="input_confirmText"></div>
							<div class="ui-block-b rate-2"><input type="button" data-mini="true" data-inline="true" value="인증" data-corners="false" id="chk_confirmTextBtn"></div>
							<div class="ui-block-c rate-4"><span id="timerView" style="font-size: 2.9vw;"></span><span id="msg_join2"/></div>
						</div>
					</div>
		   		</div>
			</div>
			
			<div class="ui-grid-c join-row">
		    	<div class="ui-block-a rate-2"><p class="p-1row">비밀번호</p></div>
		   		<div class="ui-block-b rate-6"><input type="password" id="inputPwd"required="required" oninput="chkPwd()"></div>
		   		<div class="ui-block-c rate-2" id="chkPwdIcon1" style="align-content: left;"></div>
			</div>
			<div class="ui-grid-c join-row">
		    	<div class="ui-block-a rate-2"><p class="p-2row">비밀번호<br>확인</p></div>
		   		<div class="ui-block-b rate-6"><input type="password" id="inputPwd2" name="pwd"  required="required" oninput="chkPwd()"></div>
		   		<div class="ui-block-c rate-2" id="chkPwdIcon2" style="align-content: left;" ></div>
			</div>
			
			
			<div class="ui-grid-a join-row">
		    	<div class="ui-block-a rate-2"><p class="p-2row">이름</p></div>
		   		<div class="ui-block-b rate-8"><input type="text" id="name" name="name" required="required"></div>
			</div>
			<div class="ui-grid-a join-row">
		    	<div class="ui-block-a rate-2"><p class="p-2row">주민번호</p></div>
		   		<div class="ui-block-b rate-8"><input type="text" maxlength="6" id="juminnum" value="${jumin1 }-*******" readonly="readonly"></div>
			</div>
			<div class="ui-grid-a join-row">
		    	<div class="ui-block-a rate-2"><p class="p-2row">핸드폰번호</p></div>
		   		<div class="ui-block-b rate-8"><input type="text" name="tel" id="tel" required="required"></div>
			</div>	
		    <p class="p-2row">계좌번호</p>
			<div class="ui-grid-a join-row">
		    	<div class="ui-block-a rate-4">
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
		   		<div class="ui-block-b rate-2"><a data-role="button" data-ajax="false" data-mini="true"  data-corners="false" data-inline="true" onclick="goPopup()">검색</a></div>
			</div>
			
			<input type="text" id="addrDetail" name="address_detail" readonly="readonly" required="required">
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
		    	<div class="ui-block-a rate-2"><p class="p-2row">힌트 답</p></div>
		   		<div class="ui-block-b rate-8"><input type="text" id="pwd_a" name="pwd_a" required="required"></div>
			</div>
			<input type="hidden" id="roadAddrPart2"  value="">
			<input type="hidden" id="confmKey" name="confmKey" value=""  >
			<input type="hidden" id="zipNo" name="zipNo" >
			<input type="hidden" name="member_id" id="memberIdForDb">
			<input type="hidden" name="jumin" value="${v.jumin }">
			<div data-role="controlgroup" data-type="horizontal" data-corners="false" class="fr-button">
				<input type="button" value="취소" onclick="back()">
				<input type="submit" value="가입" id="insert_memberBtn">
			</div>

		</form>
	</div>
</body>
</html>