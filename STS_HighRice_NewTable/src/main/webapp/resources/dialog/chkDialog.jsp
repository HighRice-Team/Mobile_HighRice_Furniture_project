<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div id="chk_pwd" data-role="page" data-close-btn="none" data-overlay-theme="b" data-prosition="fullscreen" >
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
function chkPwd(){
	var inputPwd = document.getElementById("chkPwd").value;
	if(inputPwd=="<%=session.getAttribute("pwd")%>"){
		var order_id = document.getElementById("order_id").value
		var paymentPrice = document.getElementById("paymentPrice").value
		var data = {"paymentPrice":paymentPrice,"order_id":order_id}
		
		$.ajax({
			url:"../../MultiplePayment.do",
			data:data,
			success:function(data){
				if(data=="결제완료"){
					location.href="myPage.do"
				}else{
					$("#msg").html("*"+data)
					$("#msg").css("visibility","")
				}
			}
		})
	}else{
		$("#msg").html("*비밀번호 오류")
		$("#msg").css("visibility","")
	}
}
</script>
  	<div data-role="header">
  		<a data-rel="back" data-icon="back" data-iconpos="notext"></a>
    	<h2>비밀번호 입력</h2>
  	</div>
  	<div data-role="content">
		<input type="password" id="chkPwd">
		<span style="visibility: hidden; color: red; padding-left: 5%;" id="msg">asdsassd</span>
		<input type="button" onclick="chkPwd()" id="inputPwd" value="결제하기" data-mini="true">
	</div>
	<input type="hidden" id="order_id" value="<%=request.getParameter("order_id")%>">
	<input type="hidden" id="paymentPrice" value="<%=request.getParameter("paymentPrice")%>">

</div>

	