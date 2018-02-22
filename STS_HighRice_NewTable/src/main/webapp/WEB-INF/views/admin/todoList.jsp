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
		
	})
</script>
<style type="text/css">
	.todo-category {width:calc(100% + 30px); margin:-15px;}
	.todo-category .tab_rent {width:50%; float:left; text-align: center; background: #ddd}
	.todo-category .tab_pickup {width:50%; float:right; text-align: center; background: #ddd}
	.todo-category .active {background: #aaa; color: #fff}</style>
</head>
<body>
	<div id="tab_rent" class="todo-list" >
		<ul data-role="listview" data-icon="false" id="asasas">
		</ul>
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