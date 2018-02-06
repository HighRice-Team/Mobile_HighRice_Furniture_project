<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
div a{ font-size: xx-small;}
p{
	font-family: monospace;
}
html,body{
	height: 100%;
	overflow:hidden;
}


</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, 
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
<meta name="apple-mobile-web-app-capable" content="yes"/>
<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
<title>Insert title herasdsade</title>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
	<div data-role="page">
		<div data-role="header"><a href="#aa">메뉴</a><h1>메인</h1></div>
		
		<div data-role="content">
			
			<jsp:include page="${viewPage }"/>
			
			<div data-role="panel" data-position="left" data-display="overlay" id="aa">
				야호야호야호야호
			</div>
		</div>
		
		<div data-role="footer" data-position="fixed"><h2>푸터</h2></div>
	</div>
	
	
</body>
</html>