<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="Edit_Profile" data-role="page" data-close-btn="none" data-overlay-theme="b">
<script type="text/javascript">
	$(function(){
		$.ajax({url:"../../getMember_ajax.do",success:function(data){

			data = eval('('+data+')')

			$("#member_id").html(data.member_id);
			$("#name").html(data.name);
			$("#jumin").html(data.jumin);
			$("#account_no").val(data.account_no);
			$("#address3").val(data.address3);
			$("#tel").val(data.tel);
			$("#pwd_a").val(data.pwd_a);
			$("#pwd_q").val(data.pwd_q);
			$("#bank").val(data.bank);
			$("#roadAddrPart1").val(data.address);
			$("#addrDetail").val(data.address_detail);
		}});
		
		//회원정보 수정 ajax
		$("#Edit_Profile_btn").click(function(){
			var data = $("#Edit_Profile_form").serializeArray();
			$.ajax({
				url:"../../updateInfo_member.do",
				data:data,
				success:function(dat){
					if(dat==1)
					{
						alert("회원정보 수정에 성공하였습니다.");
						if($("#pageName").val()=="mp"){
							location.href="../../myPage.do?selectedMyPage=mP";
						}else if($("#pageName").val()=="ct"){
							var order_id = $("#order_id").val()
							var paymentPrice = $("#paymentPrice").val()
							var cntProduct = $("#cntProduct").val()
							location.href="../../goMultiplePayment.do?order_id="+order_id+"&paymentPrice="+paymentPrice+"&cntProduct="+cntProduct;
						}
						
						
					}
					else{
						alert("회원정보 수정에 실패하였습니다.");
					}
			}});
		});
	});
</script>
<script type="text/javascript">

	function goPopup() {
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("../../search.do", "pop",
				"width=270,height=120, scrollbars=yes, resizable=yes");

		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
	/** API 서비스 제공항목 확대 (2017.02) **/
	function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail,
			roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,
			detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn,
			buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.Edit_Profile_form.roadAddrPart1.value = roadAddrPart1;
		document.Edit_Profile_form.roadAddrPart2.value = roadAddrPart2;
		document.Edit_Profile_form.addrDetail.value = addrDetail;
		document.Edit_Profile_form.zipNo.value = zipNo;
	}
</script>
  <div data-role="header">
    <h2>회원정보 수정</h2>
  </div>
  <div data-role="content">
		<form id="Edit_Profile_form" name="Edit_Profile_form" method="post">
			<table border="1" cellpadding="5" cellspacing="0" width="100%">
				<tr>
					<td id="title" width="15%">아이디</td>
					<td colspan="3" id="member_id"><input type="hidden"
						id="id_mypage" name="member_id" value=""></td>
				</tr>


				<tr>
					<td id="title">이름</td>
					<td colspan="4" id="name" name="name"></td>
				</tr>

				<tr>
					<td id="title">주민번호</td>
					<td colspan="4" id="jumin" name="jumin"></td>
				</tr>

				<tr>
					<td id="title">계좌번호</td>
					<td>
						<select id="bank" name="bank" data-role="none">
							<option value="국민">국민</option>
							<option value="신한">신한</option>
							<option value="농협">농협</option>
							<option value="기업">기업</option>
							<option value="우리">우리</option>
						</select> 
						<input type="text" id="account_no" name="account_no" size="40"
							value="" required="required">
					</td>
						
				</tr>

				<tr>
					<td id="title">주소</td>
					<td>
						<input type="text" id="roadAddrPart1" size="55%"
							name="address" readonly="readonly"> 
						<input type="text" id="addrDetail" readonly="readonly"
							name="address_detail" size="55%">
						<input type="button"
							value="주소검색" onclick="goPopup();" data-theme="b"><br> 
					</td>
				</tr>
				<tr>
					<td id="title">핸드폰번호</td>
					<td colspan="4"><input type="text" id="tel" name="tel"
						size="50" value="" required="required"></td>
				</tr>
				<tr>
					<td id="title">비밀번호 힌트</td>
					<td colspan="4"><select id="pwd_q" name="pwd_q" data-role="none">
							<option value="자신의 보물 제1호는?">자신의 보물 제1호는?</option>
							<option value="자신의 출신 초등학교는?">자신의 출신 초등학교는?</option>
							<option value="인상깊게 읽은 책 이름은?">인상깊게 읽은 책 이름은?</option>
							<option value="가장 기억에 남는 선물은?">가장 기억에 남는 선물은?</option>

					</select></td>
				</tr>
				<tr>
					<td id="title">힌트 답</td>
					<td colspan="4"><input type="text" name="pwd_a" id="pwd_a"
						maxlength="50" value="" required="required"></td>
				</tr>
				<input type="hidden" id="roadAddrPart2" value="">
				<input type="hidden" id="confmKey" name="confmKey" value="">
				<input type="hidden" id="zipNo" name="zipNo">
				<input type="hidden" id="selectedMyPage" value="${selectedMyPage }">
				
			</table>
			<div class="ui-grid-a">
				<div class="ui-block-a">
					<input id="Edit_Profile_btn" type="button" value="변경" data-theme="b">
				</div>
				<div class="ui-block-b">
					<a href="#" data-rel="back" data-role="button" data-theme="b">취소</a>
				</div>
			</div>
		</form>
		<input type="hidden" id="pageName" value="<%=request.getParameter("pageName") %>">
		<input type="hidden" id="order_id" value="<%=request.getParameter("order_id") %>">
		<input type="hidden" id="paymentPrice" value="<%=request.getParameter("paymentPrice") %>">
		<input type="hidden" id="cntProduct" value="<%=request.getParameter("cntProduct") %>">
	</div>
</div>

	