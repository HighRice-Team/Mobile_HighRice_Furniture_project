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
		
		//bitmanList
		$.ajax({
			url:"todoListAjax_bitmanList.do",
			success:function(data){
				data = eval("("+data+")");
				$(data).each(function(index , bitman){
					alert(bitman.productInfo.quality)
				});
				
			}
		});
		
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
		<div class="todo-category">
			<div rel="tab_rent" class="tab_rent active" >
				<P>배송LIST</p>
			</div>
			<div rel="tab_pickup" class="tab_pickup">
				<p>수거LIST</p>
			</div>
		</div>
		<div id="tab_rent" class="todo-list" >
			<ul data-role="listview" data-icon="false">
				<li style="width: calc(100% - 45px); height: 81px; float: left; border: none; background: #eee; border-bottom : 1px solid #aaa;">
					<a href="todoRent.do" data-ajax="false">
						<img src="resources/img/product/b1.jpg" />
						<p style=" font-size: 15px; color: #880000; margin-bottom: 15px">[배송]</p>
						<p style=" font-size: 18px; font: bold; ">주소 어쩌고 저쩌고 저쩌고</p>
						<p>카테고리 : sofa, 고객명 : 홍길동</p>
					</a> 
				</li>
				<li style="width: 45px; height: 51px; float: right; border: none; background: #eee; margin : 0; padding : 30px 0 0 0; border-bottom : 1px solid #aaa;">
					<input type="checkbox" id="checkbox" style="width:30px; height:30px;  margin: -15px; ">
					<p style="margin: 20px 0 0 5px">김지안</p>
				</li>
			</ul>
		</div>
		<div id="tab_pickup" class="todo-list">
			<ul data-role="listview" data-icon="false">
				<li style="float: left; width: 100%; height: 81px; float: left; border: none; background: #eee; border-bottom : 1px solid #aaa;">
					<a href="todoPickup.do" data-ajax="false">
						<img src="resources/img/product/b1.jpg" />
						<p style="font-size: 15px; color: #880000; margin-bottom: 15px">[검수 수거]</p>
						<p style="font-size: 18px; font: bold;">주소 어쩌고 저쩌고 저쩌고</p>
						<p>카테고리 : sofa, 고객명 : 홍길동</p>
					</a>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>
<!-- 
	<ul data-role="listview" data-icon="false">
		<li style="width: calc(100% - 45px); height: 81px; float: left; border: none; background: #fff; border-bottom : 10px solid #ddd;">
			<a href="todoDetail.do" data-icon="info">이러한 저러한 이런저런 가구
				<img src="resources/img/product/b1.jpg" />
			</a> 
		</li>
		<li style="width: 45px; height: 51px; float: right; border: none; background: #fff; margin : 0; padding : 30px 0 0 0; border-bottom : 10px solid #ddd;">
			<input type="checkbox" id="checkbox" style="width:30px; height:30px;  margin: -15px; ">
			<p style="margin: 20px 0 0 5px">김지안</p>
		</li>
	</ul>
 -->