<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, 
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
<title>Insert title here</title>
<style type="text/css">
	label{
		padding: 10px;
		text-align:"left";
	}
	.center{
		text-align: center;
	}
	
	.btnImg{
		background-image: url("resources/img/sell2.jpg");
	}
	
</style>
<script type="text/javascript">
$(function(){
	   $("#insert").click(function(){
	      $("#sellInsertForm").submit();
	   });
	   
	   $("#mainIMG").change(function(){
		   var mainIMG = $("#mainIMG").val();
		   if(mainIMG.length >= 10){
			   mainIMG = mainIMG.substring(0, 10)+"..."
		   }
		   
		   $("#main").html("파일명 :"+ mainIMG)
	   })
	   $("#subIMG").change(function(){
		   var subIMG = $("#subIMG").val();
		   
		   if($("#mainIMG").val() == null || $("#mainIMG").val() == ""){
			   alert("메인 이미지를 먼저 등록해주세요")
			   return
		   }
		   if(subIMG.length >= 10){
			   subIMG = subIMG.substring(0, 10)+"..."
		   }
		   
		   $("#sub").html("파일명 :"+ subIMG)
	   })
	   
	   $("#cancel").click(function(){
		   history.back();
	   })
	})
	
</script>
</head>
<body>

		<div data-role="content">
			<form id="sellInsertForm" method="post" enctype="multipart/form-data" data-ajax="false" action="sellInsert.do">
		
			<div>
				<div data-role="fieldcontain">
					<label for="product_name">가구이름</label>
					<div class="center">
						<input type="text" name="product_name" id="product_name" style="width:90%">
					</div>
				</div>
				<input type="hidden" name="member_id" value="${member_id}">
			</div>
			
			
			
			<div data-role="fieldcontain">
				<label for="category">분류</label>
					<div class="center">
					  <select id="category" name="category">
						<option value="BED">BED</option>
						<option value="SOFA">SOFA</option>
						<option value="DESK">DESK</option>
						<option value="CLOSET">CLOSET</option>	
					  </select>
					</div>
			</div>
			
			품질 :
			<div class="center">
			<div class="ui-grid-b">
				<div class="ui-block-a">
					<input type="radio" id="q1" name="quality" value="A">
					<label for="q1">A</label>
				</div>
				<div class="ui-block-b">
					<input type="radio" id="q2" name="quality" value="B">
					<label for="q2">B</label>
				</div>	
				<div class="ui-block-c">
					<input type="radio" id="q3" name="quality" value="C">
					<label for="q3">C</label>
				</div>
			</div>
			</div>
			<br>
			
			<div class="ui-grid-a center">
				<div class="ui-block-a">
					대표이미지 
					 <br>
					 <label data-role="button" data-iconpos="notext" data-icon="plus" style="width:90%; height:100px;">
						<input type="file" name="mainIMG"  style="display:none;" id="mainIMG">
					</label>
					<div id="main"></div>
				</div>
				<div class="ui-block-b">
					서브이미지 
					 <br>
					 <label data-role="button" data-iconpos="notext" data-icon="plus" style="width:90%; height:100px;">
					 	<input type="file" name="subIMG" id="subIMG" data-role="button" style="display:none;">
					 </label>
					 <div id="sub"></div>
				</div>
			</div>
			<div class="ui-grid-a" style="padding: 10px" align="center">
			
				<div class="ui-block-a"><input id="insert" type="button" data-theme="a" data-corners="false" value="등록"></div>
				<div class="ui-block-b"><input id="cancel" type="button" data-theme="c" data-corners="false" value="취소"></div>
			</div>
		</form>
		</div>


</body>
</html>