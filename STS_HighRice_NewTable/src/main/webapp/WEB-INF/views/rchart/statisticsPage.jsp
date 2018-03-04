<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">

	$(function() {
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
	.stat_list {width:calc(100% + 30px); margin:-15px;}	
	.stat-category .tab_statMember {width:50%; float:left; text-align: center; background: #ddd}
	.stat-category .tab_statSearch {width:50%; float:right; text-align: center; background: #ddd}
	.stat-category .tab_statKeyword {width:50%; float:left; text-align: center; background: #ddd}
	.stat-category .active {background: #aaa; color: #fff}
</style>
</head>
<body>
	<div data-role="content">
      <div class="stat-category" style="display: inline-block;  padding-bottom: 5%;">
         <div rel="tab_statMember" class="tab_statMember active" >
            <P>회원통계</p>
         </div>
         <div rel="tab_statSearch" class="tab_statSearch">
            <p>유입통계</p>
         </div>
         <div rel="tab_statKeyword" class="tab_statKeyword">
            <p>검색어통계</p>
         </div>
      </div>
      <div id="tab_statMember" class="stat_list">
         <ul id="gender_ul" data-role="listview" data-icon="false" data-divider-theme="d" style="margin: 15px 0">
         	<li data-role="list-divider">bit 가구대여점 회원 성비</li>
         	<img src="resources/chart_img/${genderRate}" width="100%">
         </ul>
         <ul id="age_ul" data-role="listview" data-icon="false" data-divider-theme="d" style="margin: 15px 0;">
         	<li data-role="list-divider">bit 가구대여점 회원 연령대</li>
         	<img src="resources/chart_img/${generationRate}" width="100%">
         </ul>
      </div>
      <div id="tab_statSearch" class="stat_list">
         <ul id="route_ul" data-role="listview" data-icon="false" data-divider-theme="d" style="margin: 15px 0;">
         	<li data-role="list-divider">bit 가구대여점 검색포탈 유입통계</li>
         	<img src="resources/chart_img/${inflowPortalRoute}" width="100%">
         </ul>
         <ul id="route_ul" data-role="listview" data-icon="false" data-divider-theme="d" style="margin: 15px 0;">
         	<li data-role="list-divider">bit 가구대여점 디바이스별 유입통계</li>
         	<img src="resources/chart_img/${inflowDeviceRoute}" width="100%">
         </ul>
      </div>
      <div id="tab_statKeyword" class="stat_list">
         <ul id="keyword_ul" data-role="listview" data-icon="false" data-divider-theme="d" style="margin: 15px 0;">
         	<li data-role="list-divider">bit 가구대여점 유입 인기검색어 통계</li>
         	<img src="resources/chart_img/${searchKeyword}" width="100%">
         </ul>
      </div>
   </div>
   
</body>
</html>
