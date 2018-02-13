<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

p{
   font-size: 13px;
}

.small{
   font-size: 1.8vw;
}

.ui-block-a{
   padding: 0px 0px 7px 0px;
}

.ui-block-b{
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
<!-- <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script> -->
<script type="text/javascript">
$(function(){
	$(".updateBtn_product").click(function(){
		var board_id = $(this).attr("board_id")
		var cnt = $(this).attr("cnt")
		var selectBox;
		var data = {"board_id":board_id}
		//SelectBox 가져오기.
		$.ajax({
			url:"getSelect_qnaBoard.do",
			data:data,
			success:function(data){
				selectBox = data		
			}
		})
		$.ajax({
			url:"getDetail_qnaBoard.do",
			data:data,
			success:function(data){
				data = eval("("+data+")")
				$("#reple"+cnt).empty()
				var post_typeDiv = $("<div></div>").html(selectBox);
				var titleDiv = $("<div></div>").html("<input type='text' value='"+data.title+"'>");
				var regdateDiv = $("<div></div>").html("<input type='text' value='"+data.regdate+"'>");
				var contentDiv = $("<div></div>").html("<textarea>"+data.content+"</textarea>")
				var updateBtnDiv = $("<div></div>").html("<input type='button' value='수정'><input type='button' value='취소'>")
				
				$("#reple"+cnt).append(post_typeDiv, titleDiv, regdateDiv, contentDiv, updateBtnDiv)
			}
		})
		
	})	
   $("#insert").click(function(){
      var data = $("#insertForm").serializeArray();
      $.ajax({url:"insert_qnaBoard.do",data:data,success:function(data){
         $("#title").val("");
         $("#content").val("");
         location.reload();
      }});
   });
   
   var product_id = $("#product_id").val()
      var price = $("#price").val()
      
      $("#pp").html(Intl.NumberFormat().format(price))
      
      $("#rentMonth").change(function(){
      
         var rentMonth = $("#rentMonth").val()
         
         $("body").removeClass("ui-mobile-viewport-transitioning")
         $("#tot_p").html(Intl.NumberFormat().format(rentMonth * price)+" WON")
         
         
      })
      
      $("#gotopayment").click(function(){
         alert($("#rentMonth").val())
         if($("#rentMonth").val() != "0"){
            location.href = "goPaymentInfo.do?product_id="+product_id+"&rentMonth="+$("#rentMonth").val()
         }else{
            alert("6개월 이상 선택해주세요")
         }
      })
      
      $("#goToCart").click(function(){
    	  
         var data = {"rent_month":$("#rentMonth").val(),"product_id":product_id};
            
            $.ajax({
                url:"insertOrderListAjax.do",
                data:data,
                success:function(data){
                   if(data >= 1){
                      if(confirm("이미 등록한 상품입니다. 장바구니로 이동하시겠습니까?")){
                         location.href="cartList.do";
                      }                   
                   }else{
                	   
                	   if($("#rentMonth").val() != "0"){
                		   if(confirm("장바구니에 추가하였습니다. 장바구니로 이동하시겠습니까?")){
                               location.href="cartList.do";
                           }
                       }else{
                          alert("6개월 이상 선택해주세요")
                       }
                      
                   }
                }    
           	})
      })
})

</script>
</head>
<body>
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
            <p style="padding: 0; margin: 0 0 2% 1%;">상품 등급 : ${vo.quality}</p>
            <p style="padding: 0; margin: 3% 0 1% 1%;">대 여 비   : <span id="pp"></span>원</p>
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
                  <p class="tot_p" style="font-size: 18px; font-weight: bold;">선택 기간 총 대여 금액</p>
               </div>
               <div class="ui-block-b" style="width: 25%;">
                  <p class="tot_p" id="tot_p" style="font-size: 18px; font-weight: bold; text-align: right; color: red;">0</p>
               </div>
            </div>
         </div>
         
         <c:if test="${vo.member_id != sessionScope.id}">
            <div class="ui-grid-a">
               <div class="ui-block-a" data-corners="false">
                  <a id="gotopayment" data-role="button" data-theme="a" data-corners="false">BUY NOW<br><hr>구매하기</a>
               </div>
               <div class="ui-block-b" data-corners="false">
                  <a id="goToCart" data-role="button" data-corners="false">ADD TO CART<br><hr>장바구니</a>
               </div>
            </div>
         </c:if>
         <c:if test="${vo.member_id == sessionScope.id}">&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;
            나의 물건 입니다.&nbsp;&nbsp;&nbsp;
            </c:if>
      </div>
   </div>
   <hr>
   <div style="background-color: grey;">
      <img src="resources/img/product/${vo.sub_img}" style="width: 100%;">
   </div>
   
   <div id="qna" class="ui-grid-a" style="margin: 0 0 0 0; padding: 0 0 0 0;">
      <div class="ui-block-a" style="width: 30%; margin: 0 0 0 0; padding: 0 0 0 0;">
         <select id="rentMonth"  data-inline="true" data-mini="true" data-inline="true" data-corners="false">
            <option selected="selected">문의 분류</option>
            <option value="물품문의">물품문의</option>
            <option value="주문/결제문의">주문/결제문의</option>
            <option value="배송문의">배송문의</option>
            <option value="취소/환불문의">취소/환불문의</option>
            <option value="기타문의">기타문의</option>
         </select>
      </div>
      <div class="ui-block-b" style="width: 70%; margin: 0 0 0 0; padding: 0 0 0 0;">
         <input type="text" data-mini="true" style="width: 80%; margin: 0 0 0 0; padding: 0 0 0 5%;" placeholder="제목을 입력하세요.">
      </div>
   </div>
   <textarea placeholder="문의 내용을 입력하세요."></textarea>
   <hr>
   <div id="productReplyList" style="float:center">
   		<c:forEach var="list" items="${list }" varStatus="cnt" >
   			<c:if test="${list.product_id==product_id&&list.b_level!=3 }">
   				<div style="width:95%; background-color:#E5E5E1; margin:0 5% 5% 5%; padding:2% 2% 2% 2%;">
                   <div id="reple${cnt.count }">
	                   <div style="width:100%; display:inline-block;">
	                   		<div style="width:49.5%; float:left; font-size:11px;">
	                   			문의 분류: ${list.post_type}<br><c:if test="${list.b_level==0}"><b>제목: </c:if><c:if test="${list.b_level==1}">[답변완료] </c:if>${list.title}</b>
	                   		</div>
	                   		<div style="width:49%; float:right; text-align:right; font-size:11px;">
	                   			작성자: ${list.member_id}<br>등록일: ${list.regdate}
	                   		</div>
	                   </div>
	                   <div style="width:100%; display:inline-block;">
	                   		<div style="width:90%;">
	                   			${list.content}
	                   		</div>
	                   </div>
	                   
	                   <c:if test="${list.member_id==sessionScope.id&&list.b_level==0}">
						   <div style="width:100%; text-align:right;">
		                   		<input type="button" value="수정" class="updateBtn_product" board_id="${list.board_id }" cnt=${cnt.count }>
		                   		<input type="button" value="삭제" class="deleteBtn_product" board_id="${list.board_id }" cnt=${cnt.count }>
		                   </div>
	                   </c:if>
	                   
	                   <c:if test="${list.b_level==1}">
		                   <div style="width:95%; background-color:#EEEEEE; margin:5% 5% 5% 5%; padding-bottom:1%;">
		                   		<div style="width:90%;">
		                   			답글내용<br>관리자입니다.<br>BITFR을 이용해 주셔서 감사합니다.
		                   		</div>		
		                   </div>
	                   </c:if>
                   </div>
                </div>
   			</c:if>
   		</c:forEach>
   </div>
</body>
</html>