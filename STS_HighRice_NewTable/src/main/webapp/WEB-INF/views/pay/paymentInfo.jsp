<%@page import="com.bit_fr.vo.MemberVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<<<<<<< HEAD
=======
<meta name="viewport" content="width=device-width, initial-scale=1.0, 
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
>>>>>>> branch 'master' of https://github.com/HighRice-Team/Mobile_HighRice_Furniture_project.git
<title>Insert title here</title>
<style type="text/css">
	
</style>
<<<<<<< HEAD

=======
>>>>>>> branch 'master' of https://github.com/HighRice-Team/Mobile_HighRice_Furniture_project.git
<script type="text/javascript">
$(function(){
		var price = eval($("#price").html())
		var month = eval($("#month").html())
		var product_id = $("#product_id").val()
	
		$("#totalPrice").html(Intl.NumberFormat().format(month * price)).css("color","red")
		$(".second").hide()
		$(".first").show()
		
		$("#btnmem").click(function(){
			
			var name = $("#name").val()
			var roadAddrPart1 = $("#roadAddrPart1").val()
			var addrDetail = $("#addrDetail").val()
			var tel = $("#tel").val()
			
			$("#tdname").html(name)
			$("#tdaddress").html(roadAddrPart1+"&nbsp;"+addrDetail)
			$("#tdtel").html(tel)
			
			 $(".second").show()
			 $(".first").hide()
						 
			 
		})
		
		$("#cancel").click(function(){
			location.href="product_detail.do?product_id="+product_id
		})
		
		$("#btnpay").click(function(){
			var payPwd = $("#payPwd").val()
			var orignPwd = $("#orignPwd").val()
			var member_id = $("#member_id_pay").val()
			
			var roadAddrPart1 = $("#roadAddrPart1").val()
			var addrDetail = $("#addrDetail").val()
			var tel = $("#tel").val()
			
			if(payPwd == orignPwd){
				$.ajax({url:"updateAddr_member.do", data:{address:roadAddrPart1, address_detail:addrDetail, tel:tel, member_id:member_id}, success:function(data){
				}})
				
				$.ajax({url : "paymentOkAjax.do", data : {rentMonth:month, product_id:product_id, paymentOne:price*month}, success : function(data) {
						if( data == '1'){
            					paymentOk_msg = "결제가 성공적으로 완료되었습니다.";
            					alert(paymentOk_msg);
            					if(confirm("마이페이지로 이동하시겠습니까?") == true){
            						location.href="myPage.do";
            					}else{
            						location.href="index.do";
            					}
            					
            					
                			}else if( data == '-10'){
                				paymentOk_msg = "잔액이 부족합니다.";
                				alert(paymentOk_msg);
                				location.href="";
                			}else{
            					paymentOk_msg = "결제에 실패하였습니다.";
            					alert(paymentOk_msg);
            					location.href="";
            				}
					}
					
				});
				
			}else{
				alert("비밀번호가 틀렸습니다.")
			}
		})
		
		$("#cancel2").click(function(){
			 $(".second").hide()
			 $(".first").show()
		})
		
})
	function goPopup(){
			// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		    var pop = window.open("search.do","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
		    
			// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
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
	
</script>
</head>
<body>


		<div data-role="content">
			<div style="text-align: center;">
				<h2 style="margin-top: -1px;">결제</h2>
			</div>
			<hr>
			
			<div class="ui-grid-a">
				<div class="ui-block-a" style="width:45%; margin-top: 20px;">
					<img src="resources/img/product/${productVo.main_img }" style="width: 100%;">
				</div>
				<div class="ui-block-b" style=" width:50%; margin-left: 5px">
				<div style="padding-left: 10px; padding-top: 10px;">
					<h4 style="margin-bottom: 4px; margin-top: 2px">${productVo.product_name}</h4>
					상품등급 : ${productVo.quality }<br>
					판매가 : <span id="price">${productVo.price }</span><br>
					대여개월수 : <span id="month">${rentMonth }</span><br>
					<p>총 대여금액 </p>
					<div style="text-align: right;">
						<span id="totalPrice" style="margin-bottom: 0px;"></span>
						<span>WON</span>
					</div>
				</div>
				</div>
			</div>
			<hr>
			<div id="pay"></div>
				<h3>배송지 정보 입력</h3>	
				<div class="first">
					<table style="width:100%" class="addrinput">
						<tr>
							<td style="width:20%;">이름</td>
							<td width="90%" colspan="2"><input type="text" name="name" id="name" value="${memberVo.name }" data-mini="true" data-inline="true" readonly="readonly"></td>
						</tr>
						<tr>
							<td width="20%">주소</td>
							<td width="65%"><input type="text" name="address" id="roadAddrPart1" value="${memberVo.address }" data-mini="true" data-inline="true"></td>
							<td width="*"><input type="button" id="btnAddr" onclick="goPopup()" value="주소검색" data-mini="true"></td>
						</tr>
						<tr>
							<td width="20%">&nbsp;</td>
							<td width="*" colspan="2"><input type="text" name="address_detail" id="addrDetail" value="${memberVo.address_detail }" data-mini="true" data-inline="true"></td>		
						</tr>
						<tr>
							<td width="20%">연락처</td>
							<td width="65%"><input type="text" name="tel" id="tel" value="${memberVo.tel }" data-mini="true" data-inline="true"></td>
						</tr>
					</table>
					<div style="text-align: center;">
						<input type="button" id="btnmem" value="확인" data-inline="true" data-icon="check">
						<input type="button" id="cancel" value="취소" data-inline="true" data-icon="delete">
					</div>
				</div>
				<div class="second">
					<table style="width:100%" class="addrinput">
						<tr>
							<td style="width:20%;">이름</td>
							<td width="90%" id="tdname"></td>
						</tr>
						<tr>
							<td width="20%">주소</td>
							<td width="65%" id="tdaddress"></td>
							
						</tr>
						<tr>
							<td width="20%">연락처</td>
							<td width="65%" id="tdtel"></td>
						</tr>
					</table>
					<hr>
					<h3>결제확인 비밀번호</h3>
					<input type="password" name = "payPwd" id="payPwd">
					<input type="hidden" id="orignPwd" value=${memberVo.pwd }>
					<input type="hidden" id="member_id_pay" value=${memberVo.member_id }>
					<input type="hidden" id="product_id" value="${productVo.product_id }">
					<div style="text-align: center;">
						
						<input type="button" id="btnpay" value="결제" data-inline="true" data-icon="check">
						<input type="button" id="cancel2" value="취소" data-inline="true" data-icon="delete">
					</div>
				</div>
		</div>


</body>
</html>