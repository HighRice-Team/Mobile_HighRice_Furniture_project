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
				var div1 = $("<div></div>").css({"width": "90%", "background-color":"#E5E5E1", "margin":"0 5% 5% 5%", "padding-bottom":"1%"})
				var div2 = $("<div></div>").css({"width": "49%", "float": "left"})
				var post_type = $("<p></p>").html(qb.post_type);
				var div3 = $("<div></div>").css({"width": "49%", "float": "right", "text-align":"right"})
				var title = $("<p></p>").append(($("<a></a>").attr("href", "detail.do?board_id="+qb.board_id)).html(qb.title))		
				if(qb.b_level == 1){
					title = $("<p></p>").append(($("<a></a>").attr("href", "detail.do?board_id="+qb.board_id)).html("[답변완료]_"+qb.title))		
				}
				var div4 = $("<div></div>").css("width","90%")
				var content = $("<p></p>").css("margin","5% 5% 5% 5%").html(qb.content)
				var updateBtn =$("<input>").attr({"type":"button", "value":"수정"})
				var deleteBtn =$("<input>").attr({"type":"button", "value":"삭제"})
				
				var product_id = qb.product_id
				var member_id = $("<p></p>").html(qb.member_id)
				
				$(updateBtn).toggle(
					function(){
						$(title).remove();
						$(content).remove();
						title = $("<p></p>").append($("<input>").attr({"type":"text", "id":"updateTitle", "value":qb.title}))
						content = $("<p></p>").append($("<input>").attr({"type":"text", "id":"updateContent", "value":qb.content}))

						$(div2).append(post_type)
						$(div3).append(title)
						$(div4).append(content)
						$(div1).append(div2, div3, div4)
						
						$("#productReplyList").append(div1,updateBtn,deleteBtn)
						
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
				if (qb.product_id==$("#product_id").val() &&  qb.b_level!=3) { //상세페이지의 product_id 값이랑 비교
					$("#productReplyList").append(post_type,title,member_id,regdate,content);
					if (qb.member_id == "a3" &&  qb.b_level==0) { //세션에 저장된 member_id 값이랑 비교
						$("#productReplyList").append(post_type,title,member_id,regdate,content,updateBtn,deleteBtn);
					}
				}
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
				<p style="padding: 0; margin: 3% 0 1% 1%;">대 여 비   : ${list.price}원</p>
				<div class="ui-grid-a" style="padding: 0; margin: 0; font-size: 13px;">
					<div class="ui-block-a" style="width: 69px; padding: 2% 0 0 1%">
						대여 기간 :
					</div>
					<div class="ui-block-b">
						<select id="rentMonth" style="margin: 0 0 0 0; padding: 0 0 0 0;" data-inline="true" data-mini="true" data-inline="true" data-corners="false">
							<option selected="selected">6개월 이상 필수 선택</option>
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
						<p class="tot_p" style="font-size: 18px; font-weight: bold; text-align: right; color: red;">0</p>
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