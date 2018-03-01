<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 포털</title>
</head>
<body>
	<table>
		<tr>
			<td>
				<img src="resources/portal/naver.png">
				<div style="background-color: #6eb877;">
					<form action="linkPage.jsp" method="post">
						<input type="text" size="20" name="keyword">
						<input type="hidden" value="naver" name="portal">
						<input type="submit" value="검색">
					</form>
				</div>
				<br>
				<br>
			</td>
		</tr>
		<tr>
			<td>
				<img src="resources/portal/daum.png">
				<div style="background-color: #71a9d9;">
					<form action="linkPage.jsp" method="post">
						<input type="text" size="20" name="keyword">
						<input type="hidden" value="daum" name="portal">
						<input type="submit" value="검색">
					</form>
				</div>
				<br>
				<br>
			</td>
		</tr>
		<tr>
			<td>
				<img src="resources/portal/nate.png">
				<div style="background-color: #e34949;">
					<form action="linkPage.jsp" method="post">
						<input type="text" size="20" name="keyword">
						<input type="hidden" value="nate" name="portal">
						<input type="submit" value="검색">
					</form>
				</div>
				<br>
				<br>
			</td>
		</tr>
		<tr>
			<td>
				<img src="resources/portal/google.png">
				<div style="background-color: #d4c9c9;">
					<form action="linkPage.jsp" method="post">
						<input type="text" size="20" name="keyword">
						<input type="hidden" value="google" name="portal">
						<input type="submit" value="검색">
					</form>
				</div>
				<br>
				<br>
			</td>
		</tr>
	</table>
</body>
</html>