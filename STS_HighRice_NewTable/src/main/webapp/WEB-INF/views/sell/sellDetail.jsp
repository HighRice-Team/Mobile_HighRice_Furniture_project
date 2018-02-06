<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, 
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
<link rel="stylesheet" href="resources/css/jquery.mobile-1.3.2.css" />
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
		background-image: url("resources/img/cross.png");
	}
	
	img{
		width:50px;
		
	}
	
</style>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
$(document).bind("mobileinit", function(){
	 $("select[name=category]").find("option[value='"+$("#pp").val()+"']").attr("selected", "selected");	  
	   $("input[value="+$("#qq").val()+"]").attr("checked","checked")
})
</script>
<script src="resources/js/jquery.mobile-1.3.2.js"></script>
<script type="text/javascript">
$(function(){
	   $("#update").click(function(){
		   if($("#condition").val() == '등록'){
			   $("#sellUpdateForm").submit()
		   }else{
			   alert("등록 상태의 물품만 변경할 수 있습니다.")
		   }
		   
	   })
	
	   $("#mainIMG").change(function(){
		   var mainIMG = $("#mainIMG").val();
		   if(mainIMG.length >= 10){
			   mainIMG = mainIMG.substring(0, 10)+"..."
		   }
		   
		   $("#main").html("파일명 :"+ mainIMG)
	   })
	   $("#subIMG").change(function(){
		   var subIMG = $("#subIMG").val();
		   var main = $("#main").text()
		   main = main.trim()
		   if(main.length == 0){
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

	   
	   $("select[name=category]").find("option[value='"+$("#pp").val()+"']").attr("selected", "selected");	  
	   $("input[value="+$("#qq").val()+"]").attr("checked","checked")
	  
	  
	})
	
</script>
</head>
<body>

	<div data-role="page">
		<div data-role="header">
			<h2>SELL Update</h2>
		</div>
		<div data-role="content">
			<h2 style="text-align: center;">상품 변경 페이지</h2>
			<form id="sellUpdateForm" method="post" enctype="multipart/form-data" action="sellUpdate.do" data-ajax="false">
			<input type="hidden" name="product_id" value=${p.product_id }>
			<input type="hidden" id="condition" value="${p.condition }">
			<input type="hidden" id="qq" value="${p.quality }">
		
			<div>
				<div data-role="fieldcontain">
					<label for="product_name">가구이름</label>
					<div class="center">
						<input type="text" name="product_name" id="product_name" style="width:90%" value="${p.product_name }">
					</div>
				</div>
				<input type="hidden" name="member_id" value="${member_id}" id="member_id">
				<input type="hidden" id="pp" value="${p.category }">
			</div>
			
			
			
			<div data-role="fieldcontain">
				<label for="category">분류</label>
					<span class="center">
					  <select id="category" name="category" >
						<option value="BED">BED</option>
						<option value="SOFA">SOFA</option>
						<option value="DESK">DESK</option>
						<option value="CLOSET">CLOSET</option>	
					  </select>
					</span>
			</div>
			
			품질 :
			<div class="center">
			<div class="ui-grid-b">
				<div class="ui-block-a">
					<input type="radio" id="q1" name="quality" value="A" >
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
					 <label data-role="button" data-iconpos="notext" data-icon="plus" style="width:90%; height:100px;" >
						<input type="file" name="mainIMG"  style="display:none;" id="mainIMG">
					</label>
					<div id="main">
						<c:if test="${not empty p.main_img}">
							<img src="resources/img/product/${p.main_img }">
						</c:if>
					</div>
				</div>
				<div class="ui-block-b">
					서브이미지 
					 <br>
					 <label data-role="button" data-iconpos="notext" data-icon="plus" style="width:90%; height:100px;">
					 	<input type="file" name="subIMG" id="subIMG" data-role="button" style="display:none;">
					 </label>
					 <div id="sub">
					 	<c:if test="${not empty p.sub_img}">
							<img src="resources/img/product/${p.sub_img }">
						</c:if>
					 </div>
				</div>
			</div>
			<div class="ui-grid-a" style="padding: 10px" align="center">
				<div class="ui-block-a"><input id="update" type="button" value="수정"></div>
				<div class="ui-block-b"><input id="cancel" type="button" value="취소"></div>
			</div>
		</form>
		</div>
		<div data-role="footer" data-position="fixed">
			<h2>Team HighRice</h2>
		</div>
	</div>

</body>
</html>