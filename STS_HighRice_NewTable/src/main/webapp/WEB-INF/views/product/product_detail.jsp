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
<!-- <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script> -->
<script type="text/javascript">
$(function(){
	

	//댓글 수정
	   $(".updateBtn_product").click(function(){
	      var board_id = $(this).attr("board_id")
	      var cnt = $(this).attr("cnt")
	      var selectBox;
	      var data = {"board_id":board_id}
	      //SelectBox 가져오기.
//	       $.ajax({
//	          url:"getSelect_qnaBoard.do",
//	          data:data,
//	          success:function(data){
//	             selectBox = data      
//	          }
//	       })
	      
	      $.ajax({
	         url:"getDetail_qnaBoard.do",
	         data:data,
	         success:function(data){
	            data = eval("("+data+")")
	            $("#reple"+cnt).empty()
	            var titleDiv = $("<input type='text' id='title_up' value='"+data.title+"'>");
	            var regdateDiv = $("<div></div>").attr("style", "text-align: right;").html("등록일  "+ data.regdate);
	            var contentDiv = $("<textarea id='content_up'></textarea>").html(data.content)
	            var btnDiv = $("<div></div>").attr("style", "text-align: right;")
	            var updateBtn = $("<input type='button' value='수정'>").click(function(){
	               var item = {board_id:data.board_id, title:$("#title_up").val(), content:$("#content_up").val() }
	               $.ajax({url:"updateAjax_qnaBoard.do", data:item, success:function(data){
	                  location.href=""
	               }})
	            })
	            var deleteBtn = $("<input type='button' value='취소'>").click(function(){
	               location.href=""
	            })
	            
	            $(btnDiv).append(updateBtn, deleteBtn)
	            
	            $("#reple"+cnt).append(regdateDiv, titleDiv, contentDiv, btnDiv)
	            
	            
	            titleDiv.textinput();
	            contentDiv.textinput();
	            updateBtnDiv.button();
	            deleteBtn.button();
	         }
	      })
	      
	   })   
	   //삭제
	   $(".deleteBtn_product").click(function(){
	      var data = {board_id : $(this).attr("board_id")}
	      $.ajax({url:"delete_qnaBoardAjax.do", data:data, success:function(data){
	         location.href=""
	      }})
	   })
	   
   $("#insertBoard").click(function(){
      var data = $("#insertForm").serializeArray();
      $.ajax({url:"insert_qnaBoard.do",data:data,success:function(data){
         location.href=""
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
                		if(confirm("장바구니에 추가하였습니다. 장바구니로 이동하시겠습니까?")){
                            location.href="cartList.do";
                        }    
                   }
                }    
           	})
      })
      
      //관리자일때만 댓글폼이 나타나게 하는 ajax
	$.ajax({url:"getGrade.do", data:{"member_id":$("#sessionId").val()}, success:function(data){
		if(data == 0){
			$(".commentform").css("display","")
		
		}
	}})
	// 댓글 등록
	$(".commentbtn").click(function(){
		var data = $(".commentform").serializeArray()
		$.ajax({url:"insertAdminReply.do", data:data, success:function(data){
			alert("댓글작성 완료")
			location.href=""
		}})
	})
	
	//댓글 보여주기
	$(".ref").each(function(index, item){
		
		$.ajax({url:"getCountRef_qnaboard.do", data:{"b_ref":$(item).val()}, success:function(data){
			if(data > 1){
				$.ajax({url:"getComment.do", data:{"b_ref":$(item).val()}, success:function(data){
					data = eval("("+data+")")
	 				var replyDate = $("<div id='regdate'></div>").css({"width": "100%", "float": "right", "text-align": "right", "display" : "inline-block", "font-size" : "11px"}).html("등록일: "+data.regdate)
	 				var replyTitle = $("<div></div>").html("<p>"+data.title+"</p>")
	 				var replyContent = $("<div></div>").html("<p>"+data.content+"</p>")

	 				$(item).parent().parent().parent().find("#detail_reply").append(replyDate, replyTitle, replyContent)
	 				$(item).parent().empty()
							
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
	         <input type="text" name="title" data-mini="true" style="width: 100%; margin: 0 0 0 0; padding: .7em 0 0 5%;" placeholder="제목을 입력하세요.">
	      </div>
	   </div>
	   <div class="ui-grid-a" style="text-overflow: clip; margin-right: 0;">
	        <div class="ui-block-a" style="width: 82%" data-corners="false">
	             <textarea style="width:100%;" name="content" placeholder="문의 내용을 입력하세요."></textarea>
	        </div>
 	        <div class="ui-block-b" style="width: 17%; padding-top: .7em; text-align: right" data-corners="false">
	             <a href="#" data-role="button" data-corners="false" data-mini="true" data-inline="true" id="insertBoard">등록</a>
	        </div>
       </div>
   </form>
   <hr>
   <div id="productReplyList" style="float:center" width="100%">
   		<c:forEach var="list" items="${list }" varStatus="cnt" >	
   				<div id="reple${cnt.count }" style="width:94%; background-color:#E5E5E1; margin:2%; padding: 1%;">
                   <div>
	                   <div style="width:100%; display:inline-block;">
	                   		<div style="width:49.5%; float:left; font-size:11px;">
	                   			문의 분류: ${list.post_type}<br>
	                   		</div>
	                   		<div style="width:49%; float:right; text-align:right; font-size:11px;">
	                   			작성자: ${list.member_id}<br>등록일: ${list.regdate}
	                   		</div>
	                   </div>
	                   <div style="width:100%; display:inline-block;">
	                   		<p><c:if test="${list.b_level==0}">제목: </c:if><c:if test="${list.b_level==1}">[답변완료] </c:if>${list.title}</p>
	                   		<div style="width:90%;">
	                   			${list.content}
	                   		</div><br>
	                   		<c:if test="${list.member_id==sessionScope.id&&list.b_level==0}">
							   	<div style="width:100%; float: right; text-align: right; display: inline-block;">
			                   		<input type="button" value="수정" class="updateBtn_product" board_id="${list.board_id }" cnt=${cnt.count } data-mini="true" data-inline="true" data-corners="false">
			                   		<input type="button" value="삭제" class="deleteBtn_product" board_id="${list.board_id }" cnt=${cnt.count } data-mini="true" data-inline="true" data-corners="false">
			                   	</div>
	                   		</c:if>
	                   </div>
	                   <div>
	                   <form class="commentform" style="display: none;">
	                   		<input type="hidden" value="${list.b_ref }" class="ref">
							<input type="hidden" value="${list.board_id }" name="board_id">
							<input type="hidden" value="${list.product_id }">
							<table style="width: 100%">
								<tr>
									<td colspan="2" style="font-size: 3.3vw; font-weight: bold;">답글 작성</td>
								</tr>
								<tr>
									<td width="20%" style="text-align: center;">제목</td>
									<td width="*"><input type="text" data-mini="true" name="title"></td>
								</tr>
								<tr>
									<td width="20%" style="text-align: center;">내용</td>
									<td width="*"><textarea name="content"></textarea></td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: right;">
										<input type="submit" class="commentbtn" data-mini="true" value="답글 등록" data-corners="false" data-inline="true">
									</td>
								</tr>
							</table>
						</form>
						</div>
 		                <div id="detail_reply" style="width:85%; background-color:#EEEEEE; padding: 2% 0% 2% 2%; margin:2% 2% 2% 12.5%;">
		                		
		                </div>
                   </div>
                </div>
   		</c:forEach>
   </div>
</body>
</html>
