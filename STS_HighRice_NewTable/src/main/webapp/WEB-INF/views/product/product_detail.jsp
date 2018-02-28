<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<style type="text/css">

#product_box a{
   text-decoration: none;
   color: black;
   font-weight: normal;
}

#page a{
   text-decoration: none;
   color: black;
   font-size: 2.5vw;
}

/* p{
   font-size: 13px;
} */

.small{
   font-size: 1.8vw;
}

.ui-block-a .ui-block-b{
   padding: 0px 0px 7px 0px;
}

.product_img{
   padding: 3px 3px 0px 3px;
}

#category{
   margin: 0px;
   padding: 0px;
}
</style>
<script type="text/javascript">
$(function(){
	var product_id = $("#product_id").val()
	var price = $("#price").val()
	
	$("#pp").html(Intl.NumberFormat().format(price))
	$("#rentMonth").change(function() {
		var rentMonth = $("#rentMonth").val()
		$("body").removeClass("ui-mobile-viewport-transitioning")
		$("#tot_p").html(Intl.NumberFormat().format(rentMonth * price)+" WON")
	})
	
	$("#gotopayment").click(function() {
		if($("#rentMonth").val() != "0") {
			location.href = "goPaymentInfo.do?product_id="+product_id+"&rentMonth="+$("#rentMonth").val()
		}else {
			alert("6개월 이상 선택해주세요")
		}
	})
	
	$("#goToCart").click(function() {
		var data = {"rent_month":$("#rentMonth").val(),"product_id":product_id};
		
		<%
 			String loginChk_02 = "";
 		
 			if( session.getAttribute("id") != null){
 				loginChk_02 = (String)session.getAttribute("id");
 			}
 		%>
 		var id = null;
 		id = '<%=loginChk_02%>';
 		
 		if(id == '') {
 	    	alert("로그인이 필요한 서비스입니다.")
 	    	return;
		}
		$.ajax({url:"insertOrderListAjax.do", data:data, success:function(data){
			if(data >= 1){
				if(confirm("이미 등록한 상품입니다. 장바구니로 이동하시겠습니까?")){
					location.href="cartList.do";
				}                   
			}else{ 
				if(confirm("장바구니에 추가하였습니다. 장바구니로 이동하시겠습니까?")){
					location.href="cartList.do";
				}    
			}
		}})
	})

	$("#insertBoard").click(function() {
		var data = $("#insertForm").serializeArray();
		$.ajax({url:"productQnaInsert.do",data:data,success:function(data){
			$("#title").val("");
			$("#content").val("");
			location.reload();
		}});
	});

	$(".b_ref").each(function(index, item){
		var cnt = $(this).attr("cnt")
		$.ajax({url:"getCountRef_qnaboard.do", data:{"b_ref":$(item).val()}, success:function(data){
			if(data > 1){
				$.ajax({url:"getComment.do", data:{"b_ref":$(item).val()}, success:function(data){
					data = eval("("+data+")")
					$("#adminReply"+cnt).css("visibility","visible")
					
					$("#test1"+cnt).append(data.title)
					$("#test2"+cnt).append(data.regdate)
					$("#test3"+cnt).append(data.content)
				}})
			}
		}})
		
		
	})
})
</script>
</head>
<body>
	<input type="hidden" id="sessionId" value="${sessionScope.id }">
   <div data-role="content" style="text-align: center; position: relative; padding: 5% 7% 5% 7%">

      <h3 id="category">${vo.category}</h3>
      <br>
      <div>
         <img src="resources/img/product/${vo.main_img}" style="width: 100%">
      </div>
      <div style="width: 100%; float: left; text-align: left;">
         <input type="hidden" value="${vo.product_id }" id="product_id">
         <input type="hidden" value="${vo.price }" id="price">
         <br>
         <h2>${vo.product_name }</h2>
         <hr>
         <div style="display: inline;">
            <p style="padding: 0; margin: 0 0 2% 1%; font-size: 13px">상품 등급 : ${vo.quality}</p>
            <p style="padding: 0; margin: 3% 0 1% 1%; font-size: 13px">대 여 비   : <span id="pp"></span>원</p>
            <div class="ui-grid-a" style="padding: 0; margin: 0; font-size: 13px;">
               <div class="ui-block-a" style="width: 69px; padding: 2% 0 0 1%">
                	  대여 기간 :
               </div>
               <div class="ui-block-b">
                  <select id="rentMonth" style="margin: 0 0 0 0; padding: 0 0 0 0;" data-inline="true" data-mini="true" data-inline="true" data-corners="false">
                     <option selected="selected" value="0">6개월 이상 필수 선택</option>
                     <option value=6>6개월</option>
                     <option value=7>7개월</option>
                     <option value=8>8개월</option>
                     <option value=9>9개월</option>
                     <option value=10>10개월</option>
                     <option value=11>11개월</option>
                     <option value=12>1년</option>
                  </select>
               </div>
            </div>
            <hr>
            <div class="ui-grid-a">
               <div class="ui-block-a" style="width: 70%">
                  <p class="tot_p" style="font-size: 18px; font-weight: bold;">총 대여 금액</p>
               </div>
               <div class="ui-block-b" style="width: 25%;">
                  <p class="tot_p" id="tot_p" style="font-size: 18px; font-weight: bold; text-align: right; color: red;">0</p>
               </div>
            </div>
         </div>
         
         <c:if test="${vo.member_id != sessionScope.id}">
            <div class="ui-grid-a">
               <div class="ui-block-a" data-corners="false">
                  <a id="gotopayment" data-role="button" data-theme="a" data-corners="false">BUY<br>NOW<br><hr>구매하기</a>
               </div>  
               <div class="ui-block-b" data-corners="false">
                  <a id="goToCart" data-role="button" data-corners="false">ADD TO<br>CART<br><hr>장바구니</a>
               </div>
            </div>
         </c:if>
         <c:if test="${vo.member_id == sessionScope.id}">
         	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;나의 물건 입니다.&nbsp;&nbsp;&nbsp;
		 </c:if>
      </div>
   </div>
   <hr>
   <div style="background-color: grey;">
      <img src="resources/img/product/${vo.sub_img}" style="width: 100%;">
   </div>
   
   
	<form id="insertForm">
		<input type="hidden" name = "product_id" value="${vo.product_id }">
		<div id="qna" class="ui-grid-a" style="margin: .5em 0 0 0; padding: 0 0 0 0;">
			<div class="ui-block-a" style="width: 37%">
				<select name="post_type"  data-inline="true" data-mini="true"  data-inset="false" data-inline="true" data-corners="false">
					<option selected="selected">문의 분류</option>
					<option value="물품문의">물품문의</option>
					<option value="주문/결제문의">주문/결제문의</option>
					<option value="배송문의">배송문의</option>
					<option value="취소/환불문의">취소/환불문의</option>
					<option value="기타문의">기타문의</option>
				</select>
			</div>
			<div class="ui-block-b" style="width: 62.5%;">
				<input type="text" name="title" id="title" data-mini="true" style="width: 100%; margin: 0 0 0 0; padding: .7em 0 0 5%;" placeholder="제목을 입력하세요.">
			</div>
	   </div>
	   <div class="ui-grid-a" style="text-overflow: clip; margin-right: 0;">
	        <div class="ui-block-a" style="width: 82%" data-corners="false">
				<textarea style="width:100%;" name="content" id="content" placeholder="문의 내용을 입력하세요."></textarea>
	        </div>
 	        <div class="ui-block-b" style="width: 17%; padding-top: .7em; text-align: right" data-corners="false">
	             <a href="#" data-role="button" data-corners="false" data-mini="true" data-inline="true" id="insertBoard">등록</a>
	        </div>
       </div>
   </form>
   
   
   <hr>
	<div id="productReplyList" style="float:center" width="100%">
		<c:forEach var="list" items="${list }" varStatus="cnt" >
			<input type="hidden" class="b_ref" value="${list.b_ref }" cnt="${cnt.count }">
			<div id="reple${cnt.count }">
				<div style="background-color:#ddd; padding: 10px; margin: 0 0 10px 0" id="detail_qna">
					<div style="width: 50% ; float: left; ">No${list.board_id }. ${list.post_type}</div>
					<div style="width: 50% ; float: right; font-size: 12px; text-align: right;"> 작성자 : ${list.member_id }<br>${list.regdate }</div>
					<div style="margin: 40px 0 0 0; font-size: 18px">
						<a href="qnaDetail.do?board_id=${list.board_id }">${list.title}</a>	
					</div>
					<div style="margin: 10px 0 10px 0; word-break:break-all; word-wrap:break-word;">${list.content }</div>
					<c:if test="${list.member_id==sessionScope.id&&list.b_level==0}">
						<div id="controlDiv" style="text-align: right;">
							<a href="productQnaDelete.do?board_id=${list.board_id }&product_id=${vo.product_id }">삭제</a>
						</div>
					</c:if>
					<div id="adminReply${cnt.count}" style=" background-color:#eee; padding: 10px; visibility: hidden;">
						<div style="width:100%; display: inline-block;">
							<div id="test1${cnt.count}" style='width: 50% ; float: left;'></div>
							<div id="test2${cnt.count}" style='width: 50% ; float: right; font-size: 12px; text-align: right;'></div>
						</div>
						<div id="test3${cnt.count}"  style="margin: 10px 0 10px 0; word-break:break-all; word-wrap:break-word;"></div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>
