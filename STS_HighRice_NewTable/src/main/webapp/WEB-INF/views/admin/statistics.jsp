<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">

	
$(function(){
	$(".stat_list").hide()
	$(".stat_list:first").show()
	$(".stat-category div").click(function() {
		if ($(".stat-category div").hasClass("active")) {
			$(".stat-category div").removeClass("active")
			$(this).addClass("active")
 			$(".stat_list").hide()
 			var activeTab = $(this).attr("rel")
			$("#" + activeTab).fadeIn()
		}
	})
})

</script>

<style type="text/css">
	.stat-category {width:calc(100% + 30px); margin:-15px;}
	.stat-category .tab_statMember {width:50%; float:left; text-align: center; background: #ddd}
	.stat-category .tab_statSearch {width:50%; float:right; text-align: center; background: #ddd}
	.stat-category .active {background: #aaa; color: #fff}</style>
</head>
<body>
	<div data-role="content">
      <div class="stat-category" style="display: inline-block;  padding-bottom: 3%;">
         <div rel="tab_statMember" class="tab_statMember active" >
            <P>회원</p>
         </div>
         <div rel="tab_statSearch" class="tab_statSearch">
            <p>유입</p>
         </div>
      </div>
      <div id="tab_statMember" class="stat_list">
         <ul id="gender_ul" data-role="listview" data-icon="false" data-divider-theme="d" style="margin: 15px -5%;">
         	<li data-role="list-divider">회원 성비</li>
         	<div id="graph_gender">회원 성비 그래프</div>
         </ul>
         <ul id="age_ul" data-role="listview" data-icon="false" data-divider-theme="d" style="margin: 15px -5%;">
         	<li data-role="list-divider">회원 연령대</li>
         	<div id="graph_age">회원 연령대 그래프</div>
         </ul>
         <ul id="order_ul" data-role="listview" data-icon="false" data-divider-theme="d" style="margin: 15px -5%;">
         	<li data-role="list-divider">시간대별 주문 건수</li>
         	<div id="graph_order">시간대별 주문 건수 그래프</div>
         </ul>
      </div>
      <div id="tab_statSearch" class="stat_list">
         <ul id="route_ul" data-role="listview" data-icon="false" data-divider-theme="d" style="margin: 15px -5%;">
         	<li data-role="list-divider">유입 경로</li>
         	<div id="graph_route">유입 경로 그래프</div>
         </ul>
         <ul id="keyword_ul" data-role="listview" data-icon="false" data-divider-theme="d" style="margin: 15px -5%;">
         	<li data-role="list-divider">유입 검색어</li>
         	<div id="text-keyword">유입 검색어 텍스트</div>
         </ul>
         <ul id="dayVisit_ul" data-role="listview" data-icon="false" data-divider-theme="d" style="margin: 15px -5%;">
         	<li data-role="list-divider">요일별 방문자수</li>
         	<div id="graph_dayVisit">요일별 방문자수 그래프</div>
         </ul>
         <ul id="timemVisit_ul" data-role="listview" data-icon="false" data-divider-theme="d" style="margin: 15px -5%;">
         	<li data-role="list-divider">시간대별 방문자수</li>
         	<div id="graph_timemVisit">시간대별 방문자수 그래프</div>
         </ul>
      </div>
   </div>
   
</body>
</html>
