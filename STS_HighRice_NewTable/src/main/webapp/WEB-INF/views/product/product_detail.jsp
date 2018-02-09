<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1.0,
         maximum-scale=1.0, minimum-scale=1.0,
         user-scalable=no"/>
<meta name="apple-mobile-web-capable" content="yes"/>
<meta name="apple-moblie-web-status-bar-style" content="black"/>
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
   qnaBoardList();
   function qnaBoardList() {
      $.ajax({url:"getAll_qnaBoard.do",success:function(data){
         var arr = eval("("+data+")")
         $.each(arr, function(index, qb){
            var product_id = qb.product_id
            
            var div_board = $("<div></div>").css({"width": "95%", "background-color":"#E5E5E1", "margin":"0 5% 5% 5%", "padding":"2% 2% 2% 2%"})
            var div_top = $("<div></div>").css({"width": "100%", "display":"inline-block"})
            var div_content = $("<div></div>").css({"width": "100%", "display":"inline-block"})
            var div_btn = $("<div></div>").css({"width": "100%", "text-align":"right"})
            var div_reply = $("<div></div>").css({"width": "95%", "background-color":"#EEEEEE", "margin":"5% 5% 5% 5%", "padding-bottom":"1%"})
                     
            var posttype_title = $("<div></div>").css({"width": "49.5%", "float": "left", "font-size": "11px"}).html("문의 분류: "+qb.post_type+"<br><b>제목: "+qb.title+"</b>")
            var member_regdate = $("<div></div>").css({"width": "49%", "float": "right", "text-align":"right", "font-size": "11px"}).html("작성자: "+qb.member_id+"<br>등록일: "+qb.regdate)
            var content = $("<div></div>").css("width", "90%").html(qb.content)
            var updateBtn =$("<input>").attr({"type":"button", "value":"수정"})
            var deleteBtn =$("<input>").attr({"type":"button", "value":"삭제"})
            
            $(div_top).append(posttype_title, member_regdate)
             $(div_content).append(content)
            $(div_btn).append(updateBtn, deleteBtn)
            
            $(div_board).append(div_top, div_content)
            
            if(qb.b_level == 1){
               posttype_title = $("<p></p>").html(qb.post_type+"<br>[답변완료] "+qb.title)
               var reply_content = $("<div></div>").css("width", "90%").html("답글내용<br>관리자입니다.<br>BITFR을 이용해 주셔서 감사합니다.")
               $(div_reply).append(reply_content)
               $(div_board).append(div_reply)
            }
            
            if (qb.product_id==$("#product_id").val() &&  qb.b_level!=3) { //상세페이지의 product_id 값이랑 비교
               $("#productReplyList").append(div_board);
               if (qb.member_id == "a3" &&  qb.b_level==0) { //세션에 저장된 member_id 값이랑 비교
                  $(div_board).append(div_btn);
                  $("#productReplyList").append(div_board);
               }
            }
            
             $(updateBtn).toggle(
               function(){
                  $(posttype_title).remove()
                  $(member_regdate).remove()
                  $(content).remove()
                  var reply_update = $("<div></div>").addClass("ui-grid-a")
                  
                  var posttype = $("<div></div>").addClass("ui-block-a").css("width", "30%").html("문의 분류 셀렉트 들어갈 곳")
                  var title = $("<div></div>").addClass("ui-block-b").css("width", "70%").append($("<input>").attr({"type":"text", "id":"updateTitle", "name":"title", "value":qb.title}))
                  var content = $("<textarea></textarea").attr({"id":"updateContent", "name":"content"}).val(qb.content)
                  $(posttype_title).append(posttype, title)
                  $("#productReplyList").append(posttype_title, content)
      
                  
               },function(){
                  var data = {"board_id": qb.board_id,"title": $("#updateTitle").val(),"content":$("#updateContent").val()}
                  $.ajax({url:"update_qnaBoard.do", data:data, success:function(data){
                     $(title).remove();
                     $(content).remove();
                     title = $("<p></p>").html(qb.title);
                     content = $("<p></p>").html(qb.content);
                     $("#productReplyList").append(post_type,title,member_id,regdate,content,updateBtn,deleteBtn);
                     location.reload();
                  }})
               }
            )
            $(deleteBtn).click(function(){
               $.ajax({url:"delete_qnaBoard.do?board_id="+qb.board_id,success:function(data){
                  location.reload();
               }})      
            })
         })
      }})
   }
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
         
         if($("#rentMonth").val() != 0){
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
})

</script>
</head>
<body>
   <div data-role="content" style="text-align: center; position: relative; padding: 5% 7% 5% 7%">
      <h3 id="category">${list.category}</h3>
      <br>
      <div>
         <img src="resources/img/product/${list.main_img}" style="width: 100%">
      </div>
      
      <div style="width: 100%; float: left; text-align: left;">
         <input type="hidden" value="${list.product_id }" id="product_id">
         <input type="hidden" value="${member_id }" id="member_id" value="a3">
         <input type="hidden" value="${list.price }" id="price">
         <br>
         <h2>${list.product_name }</h2>
         <hr>
         <div style="display: inline;">
            <p style="padding: 0; margin: 0 0 2% 1%;">상품 등급 : ${list.quality}</p>
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
         
         <c:if test="${list.member_id != sessionScope.id}">
            <div class="ui-grid-a">
               <div class="ui-block-a" data-corners="false">
                  <a href="#" data-role="button" data-theme="a" data-corners="false">BUY NOW<br><hr>구매하기</a>
               </div>
               <div class="ui-block-b" data-corners="false">
                  <a href="#" data-role="button" data-corners="false">ADD TO CART<br><hr>장바구니</a>
               </div>
            </div>
         </c:if>
         <c:if test="${list.member_id == sessionScope.id}">&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;
            나의 물건 입니다.&nbsp;&nbsp;&nbsp;
            </c:if>
      </div>
   </div>
   <hr>
   <div style="background-color: grey;">
      <img src="resources/img/product/${list.sub_img}" style="width: 100%;">
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
   </div>
</body>
</html>