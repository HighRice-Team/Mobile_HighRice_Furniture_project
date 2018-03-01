<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/join.css">
<script type="text/javascript">

	$(function(){		
		 var sec = 1000;
	     var chk;
		$("#findId").click(function(){
			if($("#tel").val() == "" || ($("#tel").val()).length != 11){
	    		  $("#msg_joinCheck").html("전화 번호를 다시 입력해주세요.").css("color","red")
	    		  return
	    	  }
	    	  $.ajax({url:"chkphone.do", data:{phone:$("#tel").val()},success:function(data){
	    		  $("#msg_joinCheck").empty().css("color","block")
	 			  var i = 60;
	    		  
	    		  clearInterval(chk)
	    		  chk = setInterval(function(){
						
						$("#msg_joinCheck").html(i+" 초 남았습니다.")
						i--;
						if(i <= 0){
							 
							 $("#idChkForm").css("visibility","hidden")
							 $("#msg_joinCheck").html("인증 시간이 초과되었습니다.").css("color","red")
						  }
					  }, sec)
					    		  
	    		  $("#idChkForm").css("visibility","visible")
				  
	    		  $("#idChkbtn").click(function(){
	    			  if($("#idChkNum").val()==data){
	    				  clearInterval(chk)
	    				  $.ajax({url:"getIdByPhone.do", data:{name:$("#name").val() ,tel:$("#tel").val()}, success:function(m){
	    					  m = eval(m)
	    					  if(confirm("당신의 아이디는 "+m+"입니다. 비밀번호를 초기화 하시겠습니까?")){
		    					  $.ajax({url:"clearPwd.do", data:{member_id:m}, success:function(item){
		    						  alert("초기화된 번호 "+item)
		    						  location.href="main.do"
		    					  }})
		    				  }else{
		    					  alert("로그인 해 주시기 바랍니다.")
		    					  location.href="main.do"
		    				  } 
	    				  }})
	    				  
	    			  }else{
	    				  $("#msg_joinCheck").append("<div style='color:red;'>틀렸습니다.</div>")
	    			  }
	    		  })
	    	  }})
		})
	
	})

</script>
</head>
<body>

	<div data-role="content">
		<h1>번호인증</h1>

		
		<div class="ui-grid-a frjmin">
			<div class="ui-block-a">
				<label for = "name" style="margin-top: 10%;">이름</label>
			</div>
		    <div class="ui-block-b">
		    	<input type="text" id="name" name="name" required="required">
		    </div>
		</div>
		
		<div class="ui-grid-a frjmin">
			<div class="ui-block-a">
				<label for = "tel" style="margin-top: 10%;">핸드폰 번호</label>
			</div>
		    <div class="ui-block-b">
		    	<input type="text" id="tel" name="tel" required="required" placeholder="'-'빼고 입력해주세요">
		    </div>
		</div>
		<div id="msg_joinCheck"></div>
		<div class="ui-grid-a" id="idChkForm" style="visibility: hidden;">
			<div class="ui-block-a">
				<input type="number" id="idChkNum">
			</div>
			<div class="ui-block-b">
				<input type="button" id="idChkbtn" value="인증">
			</div>
		</div>		
		
		
		<input type="button" value="ID 찾기" id="findId" class="findInfo">
	</div>
</body>
</html>