<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,
			maximum-scale=1.0, minimum-scale=1.0,
			user-scalable=no"/>
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$("li").click(function(){
		location.href="detailQna.do?board_id="+$(this).find(".board_id").html()
	})
})
</script>
</head>
<body>
	<div data-role="content">
		<h3 style="text-align: center">QNA</h3>
		<a href="insertQna.do" data-role="button" data-icon="forward" data-iconpos="right" data-ajax="false" data-corners="false" style="text-align: center;">글쓰기</a>
		<br>
		<ul data-role="listview" style="width: ">
			<li>
				<span class="board_id">1120</span><span style="margin-left: 10% ">배송문의</span>
					<div style="float: right; margin-top: -3%;">
						<div class="ui-grid-a">
							aaa1
						</div>
						<div class="ui-grid-a">2018-01-26</div>
					</div>
			</li>
			<li>
				<span class="board_id">1120</span><span style="margin-left: 10% ">배송문의</span>
					<div style="float: right; margin-top: -3%;">
						<div class="ui-grid-a">
							aaa1
						</div>
						<div class="ui-grid-a">2018-01-26</div>
					</div>
			</li>
			<li>
				<span class="board_id">1120</span><span style="margin-left: 10% ">배송문의</span>
					<div style="float: right; margin-top: -3%;">
						<div class="ui-grid-a">
							aaa1
						</div>
						<div class="ui-grid-a">2018-01-26</div>
					</div>
			</li>
			
		</ul>
	</div>
</body>
</html>