<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
#name {
	font-size: 1.15vw;
}

#product_box a {
	text-decoration: none;
	color: black;
	font-weight: normal;
}

#page a {
	text-decoration: none;
	color: black;
	font-size: 2.5vw;
}

#product_box {
	font-size: 3vw;
}

.small {
	font-size: 1.8vw;
}

.product_img {
	padding: 3px 3px 0px 3px;
}

.slide-box {
	width: 100%;
	height: 150px;
	margin: 0;
	overflow: hidden;
	position: relative;
}

.slide-box img {
	width: 100%;
	height: 100%;
	display: block;
	position: absolute;
	top: 0px;
	left: -100%;
}

.list-title {
	font-size: 20px;
	font-weight: bold;
}
.filter-img	{height: 20px; float: right}

</style>
<script type="text/javascript">
   $(function() {
	   $(".ui-slider-track").css("width","100%")
	   
	   $("a[role='slider']").click(function(){
		   alert("asdasd")
	   })
	   
	   $(".imgSize").each(function(index,item){
		  item.height = (item.width*1.029)
	   })
	   
	   
      var auto_slide;
      var auto_time = 2800; // 슬라이드 시간 1000 = 1초
      var auto_num = 0; 

      $(".slide-box img").eq(auto_num).css({
         "left" : "0%"
      }); // 처음로드시 첫이미지 보이기
      auto_slide = setInterval(function() {
         slide_start()
      }, auto_time);

      function slide_start() { // 슬라이드 구현
         var no = auto_num + 1;
         if (no >= $(".slide-box img").length) {
            no = 0;
         }
         $(".slide-box img").eq(no).css({"left" : "-100%"}).stop().animate({"left" : "0%"});
         $(".slide-box img").eq(auto_num).stop().animate({"left" : "100%"});
         auto_num = no;
      }
      $(".slide-box").hover(function() { // 마우스 오버시 슬라이드 멈춤
         clearInterval(auto_slide);
      }, function() { // 마우스 아웃시 다시 시작
         auto_slide = setInterval(function() {slide_start()}, auto_time);
      });
      
      
      //창을 띄울 때 상품들의 이미지 크기를 조정.
      $(".category_img").css("width", $("#product_box").width() * 0.225)
      $(".category_img").css("height", $("#product_box").width() * 0.225)

		//창의 크기가 변동 될 때 상품들의 이미지 크기를 조정.
		$(window).resize(function() {
			$(".category_img").css("width", $("#product_box").width() * 0.225)
			$(".category_img").css("height", $("#product_box").width() * 0.225)
			$(".imgSize").each(function(index,item){
			  item.height = (item.width*1.029)
		    })
		})
		
		
		$("#submit_btn").click(function(){
			$("#filter_form").submit();
		});
		$("#cancel_btn").click(function(){
			location.href="main.do";
		});
		
		
	    $( "#slider-range" ).slider({range: true, min: 0, max: 10000, values: [ 3000, 6000 ], slide: function( event, ui ) {
			$("#amount").val( ui.values[ 0 ] + " 원 - " + ui.values[ 1 ] + " 원");
			$("#min").val(ui.values[ 0 ]);
			$("#max").val(ui.values[ 1 ]);
		}});
		$( "#amount" ).val( $( "#slider-range" ).slider( "values", 0 ) + " 원 - " + $( "#slider-range" ).slider( "values", 1 ) + " 원");
		$("#min").val($( "#slider-range" ).slider( "values", 0 ));
		$("#max").val($( "#slider-range" ).slider( "values", 1 )); 
		
		
		
		//처음 들어왔을때 라이트박스
		var on = $("#onsite").val()
		
		if(on != 1){
			//시세가져오기.
			$.ajax({
				url:"getAveragePrice_FromWebsite_AJAX.do",
				success:function(data){
					var price_avg = eval("("+data+")");
					$("#BED_AveragePrice").text(price_avg.BED_AveragePrice + " 원");
					$("#SOFA_AveragePrice").text(price_avg.SOFA_AveragePrice + " 원");
					$("#CLOSET_AveragePrice").text(price_avg.CLOSET_AveragePrice + " 원");
					$("#DESK_AveragePrice").text(price_avg.DESK_AveragePrice + " 원");
				}
			});
			document.getElementById("btnon").click();
		}
		$("#lightbox_sell").click(function(){
			if(needToLogin == 'plz'){
				document.getElementById("btnlogin2").click();
			}else{
				$.ajax({url:"onsite.do", success:function(data){
					location.href="sellWrite.do?gotoPage=sellWrite.do"
				}})
			}
		})
		$("#lightbox_rent").click(function(){
			$.ajax({url:"onsite.do", success:function(data){
				location.href="main.do"
			}})
		})
		//페이징 처리 전용
		 $(".spanNum").each(function(index, item){
    	  if($(item).html() == $("#inNum").val()){
    		  $(item).css("color","red")
    		  $(item).parent().removeAttr("href")
    	  }
      	})
	});

	function closelightbox() {
		$.ajax({url:"onsite.do", success:function(data){
			location.href="main.do"
		}})
	}
</script>
</head>
<body>
<input type="hidden" id="inNum" value="${pageNum }">
   <div data-role="content">
      <div class="slide-box">
         <a href="#"><img src="resources/img/slide1.jpg" alt="slide"></a>
         <a href="#"><img src="resources/img/slide2.jpg" alt="slide"></a>
         <a href="#"><img src="resources/img/slide3.jpg" alt="slide"></a>
         <a href="#"><img src="resources/img/slide4.jpg" alt="slide"></a>
      </div>
      <div style="text-align: center">
         <c:if test="${category == null}">
            <p class="list-title">전체 가구 목록
         </c:if>
         <c:if test="${category != null}">
            <p class="list-title">${category} 목록
         </c:if>
      </div>
      <!-- filter category -->
      <div data-role="navbar" data-position="inline">
         <ul>
            <li><a data-ajax="false" href="main.do?category=SOFA">SOFA</a></li>
            <li><a data-ajax="false" href="main.do?category=BED">BED</a></li>
            <li><a data-ajax="false" href="main.do?category=CLOSET">CLOSET</a></li>
            <li><a data-ajax="false" href="main.do?category=DESK">DESK</a></li>
         </ul>
      </div>
      <!-- filter form -->
      <div data-role="collapsible" data-collapsed-icon="false" data-iconpos="none">
         <h3>Filter<img src="resources/img/filter.png" class="filter-img"></h3>
         <form action="main.do" id="filter_form" method="post" data-ajax="false">
            <ul data-role="listview" data-inset="true">
               <li data-role="fieldcontain">
                  <label>상품 품질 :</label>
                  <div class="ui-grid-b">
                     <div class="ui-block-a">
                        <input type="radio" id="quality_a" name="quality" value="A">
                        <label for="quality_a">A</label>
                     </div>
                     <div class="ui-block-b">
                        <input type="radio" id="quality_b" name="quality" value="B">
                        <label for="quality_b">B</label>
                     </div>
                     <div class="ui-block-c">
                        <input type="radio" id="quality_c" name="quality" value="C">
                        <label for="quality_c">C</label>
                     </div>
                  </div>
               </li>
               <li data-role="fieldcontain">
                  <label>월 대여가격 :</label><br><br>
                  <p><input type="text" id="amount" readonly="readonly" style="border: 0; color: #f6931f; font-weight: bold;"></p>
                  <div id="slider-range"></div>
                  	<div data-role="rangeslider" style="width: 100%;">
					  <input name="range-4a" id="range-4a" min="0" max="10000" value="3000" type="range" style="display: none;" />
					  <input name="range-4b" id="range-4b" min="0" max="10000" value="6000" type="range" style="display: none;"/>
					</div>
               </li>
               
               <li data-role="fieldcontain">
                  <input type="hidden" name="category" id="category" value="${category}" >
                  <input type="hidden" name="min" id="min">
                  <input type="hidden" name="max" id="max">
                  
                  <div class="ui-grid-a">
                     <div class="ui-block-a">
                        <input type="button" id="submit_btn" value="정렬하기" data-theme="b" >
                     </div>
                     <div class="ui-block-b">
                        <input type="button" id="cancel_btn" value="취소하기" data-theme="b">
                     </div>
                  </div>
               </li>
            </ul>
         </form>
      </div>

		<!--상품목록 -->
		<div style="width: 100%; display: inline-block;" id="product_box">
			<c:forEach items="${list}" var="list" varStatus="status">
				<a href="product_detail.do?product_id=${list.product_id}"
					data-ajax="false">
					<div style="width: 48%; background-color: #DDDDDD; float: left; margin: 1%; text-align: center; padding-bottom: 10px;">
						<div class="product_img">
							<img src="resources/img/product/${list.main_img}" width="100%" class="imgSize" onchange="resizeImg()">
						</div>
						<p>${list.product_name}</p>
						<p>Category: ${list.category }</p>
						QUALITY: ${list.quality}<br> PRICE:
						${price_with[status.index]}<font class="small">WON</font>/<font
							class="small">MONTH</font><br>
					</div>
				</a>
			</c:forEach>
		</div>

		<!--페이징처리 부분 -->
		<div id="page" style="text-align: center">
			<c:if test="${pageNum > page}">
				<a
					href="main.do?pageNum=${pageEnd-page}&category=${category}&quality=${quality}&max=${max }&min=${min }"
					data-ajax="false">◀ &nbsp;&nbsp;&nbsp;</a>
			</c:if>
			<c:forEach var="pageNum" begin="${pageStart }" end="${pageEnd }">
				<a
					href="main.do?pageNum=${pageNum }&category=${category}&quality=${quality}&max=${max }&min=${min }"
					data-ajax="false"><span class="spanNum">${pageNum}</span>&nbsp;&nbsp;&nbsp;</a>
			</c:forEach>
			<c:if test="${pageEnd < pageMax}">
				<a
					href="main.do?pageNum=${pageEnd+1 }&category=${category}&quality=${quality}&max=${max }&min=${min }"
					data-ajax="false">▶</a>
			</c:if>
		</div>
	</div>

	<!--for trigger lightBox-->
	<a href="#light" data-rel="popup" data-position-to="window"
		data-transition="fade" id="btnon" data-inline="true"></a>

	<!-- lightBox Popup -->
	<div data-role="popup" id="light" data-icon="delete" data-theme="none" style="width: 300px; height: 300px;">
		<div style="background-image: url('resources/img/lightbox.png'); background-size: 300px; height: 300px">	
			<img src="resources/img/m/close_w.png" class="close-img" style="padding: 10px" onclick="closelightbox()">
			<div style="padding-top: 160px; text-align: center;">
				<img src="resources/img/lightbox_rent.png" style="width: 45%;"
					id="lightbox_rent"> <img
					src="resources/img/lightbox_sell.png" style="width: 45%;"
					id="lightbox_sell">
			</div>
		</div>
		<!-- 오늘의 중고거래 시세. -->
		<div
			style="background-color: black; height: 100px; color: white; opacity: 0.8;">

			<center>
				<table style="text-align: center; font-size: small;">
					<tr style="padding: 2px;">
						<td colspan="4"><p style="font-size: medium;">오늘의 중고장터 시세</p></td>
					</tr>
					<tr>
						<td>BED</td>
						<td style="padding-left: 10px;" id="BED_AveragePrice"></td>
						<td style="padding-left: 5px;">SOFA</td>
						<td style="padding-left: 5px;" id="SOFA_AveragePrice"></td>
					</tr>
					<tr>
						<td>CLOSET</td>
						<td style="padding-left: 10px;" id="CLOSET_AveragePrice"></td>
						<td style="padding-left: 5px;">DESK</td>
						<td style="padding-left: 5px;" id="DESK_AveragePrice"></td>
					</tr>
				</table>
			</center>
		</div>
	</div>
</body>
</html>
