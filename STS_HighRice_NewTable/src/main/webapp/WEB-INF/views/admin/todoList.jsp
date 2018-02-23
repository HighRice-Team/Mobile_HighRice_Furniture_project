<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	$(function() {
		$(".todo-list").hide();
		$(".todo-list:first").show();
		$(".todo-category div").click(function() {
			if ($(".todo-category div").hasClass("active")) {
				$(".todo-category div").removeClass("active")
				$(this).addClass("active")
				$(".todo-list").hide()
				var activeTab = $(this).attr("rel");
				$("#" + activeTab).fadeIn()
			}
		});
		var deliveryList_index = 0;
		var returnList_index = 0;
		var collectList_index = 0;
		
		//deliveryList
		$.ajax({
			url:"todoListAjax_deliveryList.do",
			success:function(data){
				data = eval("("+data+")");
				$(data).each(function(index, bitman) {
					if(bitman.service_state == '배송중'){
						deliveryList_index = 1;
						var li_d = $("<li></li>");
						var a_d = $("<a></a>").attr({
							'href' : 'todoDelivery_Detail.do?_id='+bitman._id,
							'data-ajax' : 'false'
						});
						var a_d_btn = $("<a></a>").text("oo");

						var img_d = $("<img></img>").attr('src', 'resources/img/product/'+bitman.productInfo.main_img);
						var p_d_title = $("<p></p>").attr('style', 'font-size: 15px; color: #880000; margin-bottom: 15px').text("[배송] [ 담당자 : "+bitman.bitman+"]");
						var p_d_addr = $("<p></p>").attr('style', 'font-size: 18px; font: bold;').text(bitman.memberInfo.address +" / "+bitman.memberInfo.address_detail);
						var p_d_content = $("<p></p>").text("카테고리 : "+bitman.productInfo.category+", 고객명 : "+bitman.memberInfo.name);

						$(a_d).append(img_d, p_d_title, p_d_addr, p_d_content);
						$(li_d).append(a_d, a_d_btn);

						$("#deliveryList_ul").append(li_d);
					}
					
					
				});
				$("#deliveryList_ul").listview("refresh");
				if(deliveryList_index == 0){
					$("#deliveryList_ul").append("<h3>요청 목록이 없습니다.</h3>");
				}
			}
		}); //end ajax

		//returnList
		$.ajax({
			url : "todoListAjax_returnList.do",
			success : function(data) {
				data = eval("(" + data + ")");
				$(data).each(function(index, bitman) {
					if(bitman.service_state == '수거중'){
						returnList_index = 1;
						var li_d = $("<li></li>");
						var a_d = $("<a></a>").attr({
							'href' : 'todoReturn_Detail.do?_id=' + bitman._id,
							'data-ajax' : 'false'
						});

						var img_d = $("<img></img>").attr('src', 'resources/img/product/' + bitman.productInfo.main_img);
						var p_d_title = $("<p></p>").attr('style', 'font-size: 15px; color: #880000; margin-bottom: 15px').text("[반납]");
						var p_d_addr = $("<p></p>").attr('style', 'font-size: 18px; font: bold;').text(bitman.memberInfo.address + " / " + bitman.memberInfo.address_detail);
						var p_d_content = $("<p></p>").text("카테고리 : " + bitman.productInfo.category + ", 고객명 : " + bitman.memberInfo.name);

						$(a_d).append(img_d, p_d_title, p_d_addr, p_d_content);
						$(li_d).append(a_d);

						$("#returnList_ul").append(li_d);
					}

				});
				$("#returnList_ul").listview("refresh");
				if(returnList_index == 0){
					$("#returnList_ul").append("<h3>요청 목록이 없습니다.</h3>");
				}
			}
		}); //end ajax

		//collectList
		$.ajax({
			url : "todoListAjax_collectList.do",
			success : function(data) {
				data = eval("(" + data + ")");
				$(data).each(function(index, bitman) {
					if(bitman.service_state == '수거중'){
						collectList_index = 1;
						var li_d = $("<li></li>");
						var a_d = $("<a></a>").attr({
							'href' : 'todoCollect_Detail.do?_id='+bitman._id,
							'data-ajax' : 'false'
						});

						var img_d = $("<img></img>").attr('src', 'resources/img/product/' + bitman.productInfo.main_img);
						var p_d_title = $("<p></p>").attr('style', 'font-size: 15px; color: #880000; margin-bottom: 15px').text("[수거]");
						var p_d_addr = $("<p></p>").attr('style', 'font-size: 18px; font: bold;').text(bitman.memberInfo.address + " / " + bitman.memberInfo.address_detail);
						var p_d_content = $("<p></p>").text("카테고리 : " + bitman.productInfo.category + ", 고객명 : " + bitman.memberInfo.name);

						$(a_d).append(img_d, p_d_title, p_d_addr, p_d_content);
						$(li_d).append(a_d);

						$("#collectList_ul").append(li_d);
					}
					
				});
				$("#collectList_ul").listview("refresh");
				if(collectList_index == 0){
					$("#collectList_ul").append("<h3>요청 목록이 없습니다.</h3>");
				}

			}
		}); //end ajax

	})
</script>

<style type="text/css">
	.todo-category {width:calc(100% + 30px); margin:-15px;}
	.todo-category .tab_rent {width:50%; float:left; text-align: center; background: #ddd}
	.todo-category .tab_pickup {width:50%; float:right; text-align: center; background: #ddd}
	.todo-category .active {background: #aaa; color: #fff}</style>
</head>
<body>
	<div data-role="content">
      <div class="todo-category" style="display: inline-block;">
         <div rel="tab_rent" class="tab_rent active" >
            <P>배송LIST</p>
         </div>
         <div rel="tab_pickup" class="tab_pickup">
            <p>수거LIST</p>
         </div>
      </div>
      <div id="tab_rent" class="todo-list" >
         <ul id="deliveryList_ul" data-role="listview" data-icon="false" data-split-icon="delete" style="margin: 15px;">
         	<li data-role="list-divider">배송요청</li>
          	<!-- 배송LIST -->  
         </ul>
      </div>
      <div id="tab_pickup" class="todo-list">
         <ul id="returnList_ul" data-role="listview" data-icon="false" style="margin: 15px;">
         	<li data-role="list-divider">반납요청</li>
            <!-- 반납LIST -->
         </ul>
         <ul id="collectList_ul" data-role="listview" data-icon="false" style="margin: 15px;">
         	<li data-role="list-divider">수거요청</li>
            <!-- 수거LIST -->
         </ul>
      </div>
   </div>
   
</body>
</html>
