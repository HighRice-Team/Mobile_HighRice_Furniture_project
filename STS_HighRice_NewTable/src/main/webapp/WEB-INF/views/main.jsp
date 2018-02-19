<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, 
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>Untitled Document</title>
<!-- 상품 Style -->
<style type="text/css">
#name {
	font-size: 1.15vw;
}
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

#product_box{
   font-size: 3vw;
}

.small{
   font-size: 1.8vw;
}

.product_img{
   padding: 3px 3px 0px 3px;
}

</style>
<!-- 이미지슬라이드 Style -->
<style type="text/css">
.slide-box {
	width: 100%;
	height: 100%;
	margin: auto;
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
</style>

<script type="text/javascript">
	//product
	$(function() {
		//창을 띄울 때 상품들의 이미지 크기를 조정.
		$(".category_img").css("width", $("#product_box").width() * 0.225)
		$(".category_img").css("height", $("#product_box").width() * 0.225)

		//창의 크기가 변동 될 때 상품들의 이미지 크기를 조정.
		$(window).resize(function() {
			$(".category_img").css("width", $("#product_box").width() * 0.225)
			$(".category_img").css("height", $("#product_box").width() * 0.225)
		})
		
	

	});
</script>
<script type="text/javascript">
	// 이미지 슬라이드 함수.
	
		
	
	$(function() {
		var auto_slide;
		var auto_time = 1000; // 슬라이드 시간 1000 = 1초
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
			$(".slide-box img").eq(no).css({
				"left" : "-100%"
			}).stop().animate({
				"left" : "0%"
			});
			$(".slide-box img").eq(auto_num).stop().animate({
				"left" : "100%"
			});
			auto_num = no;
		}
		$(".slide-box").hover(function() { // 마우스 오버시 슬라이드 멈춤
			clearInterval(auto_slide);
		}, function() { // 마우스 아웃시 다시 시작
			auto_slide = setInterval(function() {
				slide_start()
			}, auto_time);
		});
		
		
	
		

	});
</script>
<c:if test="">

</c:if>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- Multi slider -->
<script type="text/javascript">
	$( function() {
	    $( "#slider-range" ).slider({
	      range: true,
	      min: 0,
	      max: 10000,
	      values: [ 3000, 6000 ],
	      slide: function( event, ui ) {
	        $( "#amount" ).val( ui.values[ 0 ] + " 원 - " + ui.values[ 1 ] + " 원");
	        $("#min").val(ui.values[ 0 ]);
	        $("#max").val(ui.values[ 1 ]);
	      }
	    });
	    $( "#amount" ).val( $( "#slider-range" ).slider( "values", 0 ) +
	      " 원 - " + $( "#slider-range" ).slider( "values", 1 ) + " 원");
	    
	    $("#min").val($( "#slider-range" ).slider( "values", 0 ));
        $("#max").val($( "#slider-range" ).slider( "values", 1 ));
        
    	
	    
	  });
</script>
<script type="text/javascript">
//filter button
	$(function(){
		$("#submit_btn").click(function(){
			$("#filter_form").submit();
		});
		$("#cancel_btn").click(function(){
			location.href="main.do";
		});
		
		
		
		
	});
</script>

</head>

<body>
	<div data-role="content">
		<!-- 이미지 슬라이드 -->
		<div class="slide-box"
			style="width: 100%; height: 150px; position: relative;">
			<a href="#"><img src="resources/img/slide1.jpg" alt="slide"></a>
			<a href="#"><img src="resources/img/slide2.jpg" alt="slide"></a>
			<a href="#"><img src="resources/img/slide3.jpg" alt="slide"></a>
			<a href="#"><img src="resources/img/slide4.jpg" alt="slide"></a>
		</div>

		<div style="text-align: center">
			<c:if test="${category == null}">
				<p><div><h3>전체 가구 목록</h3></div>
			</c:if>
			<c:if test="${category != null}">
				<p><div><h3>${category} 목록</h3></div>
			</c:if>
			
		</div>
		<!-- filter category -->
		<div data-role="navbar" data-position="inline">
			<ul>
				<li><a href="main.do?category=SOFA" data-ajax="false">SOFA</a></li>
				<li><a href="main.do?category=BED" data-ajax="false">BED</a></li>
				<li><a href="main.do?category=CLOSET" data-ajax="false">CLOSET</a></li>
				<li><a href="main.do?category=DESK" data-ajax="false">DESK</a></li>
			</ul>
		</div>
		<br>

		<!-- filter form -->
		<div data-role="collapsible" data-theme="d" data-collapsed-icon="search" data-expanded-icon="search" data-iconpos="right">
			<h3>Filter</h3>
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
						<p>
							<input type="text"
								id="amount" readonly="readonly"
								style="border: 0; color: #f6931f; font-weight: bold;">
						</p>

						<div id="slider-range"></div>
						<br>


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
		<div style="width: 100%; display: inline-block;" id="product_box" >
            <c:forEach items="${list}" var="list" varStatus="status">
            <a href="product_detail.do?product_id=${list.product_id}" data-ajax="false">
            <div style="width: 48%; background-color: #DDDDDD; float: left; margin: 1%; text-align: center; padding-bottom: 10px;">
               <div>
                  <div class="product_img">
                     <img src="resources/img/product/${list.main_img}" width="100%"><br>
                  </div>
                  <p>${list.product_name}</p>
                  <p>Category: ${list.category }</p>
                  QUALITY: ${list.quality}<br>
                  PRICE: ${price_with[status.index]}<font class="small">WON</font>/<font class="small">MONTH</font><br>
               </div>
            </div>
            </a>
            </c:forEach>
         </div>
         
         <!--페이징처리 부분 -->
         <div id="page" style="text-align: center">
            <c:forEach var="pageNum" begin="1" end="${pageMax }">
               <a href="main.do?pageNum=${pageNum }&category=${category}&quality=${quality}&max=${max }&min=${min }" data-ajax="false">${pageNum}&nbsp;&nbsp;&nbsp;</a>
            </c:forEach>
         </div>
	</div>
	<!-- content end -->


</body>
</html>

