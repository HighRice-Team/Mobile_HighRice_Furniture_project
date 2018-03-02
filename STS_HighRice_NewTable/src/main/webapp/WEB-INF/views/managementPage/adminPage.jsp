<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table{
	width: 100%;
}
.chkCondition{
	visibility: hidden;
}

</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>
<style type="text/css">
	.button { width: 100px; height: 30px; margin: 15px 0 10px 0; font-size: 15px; border: 1px solid #ddd; border-radius: 7px;}
	.contentForm { margin: 0 15% 0 15%; padding: 40px 0 40px 0;}
	#table { width="100%"; float: left;}
	#main_footer{
		font-size: 1.2vw;
	}
</style>
<script type="text/javascript">
$(function(){
		
	
		$("#tabs").tabs();
		
		
		//제품 검수완료 및 변경을 위한 dialog
		$("#productDialog").dialog({
			width:400,
			maxWidth:400,
			minWidth:400,
			autoOpen:false,
			modal:true,
			buttons:{
				"수정":function(){
					$("#productDialog").submit()
				},
				"취소":function(){
					$("#productDialog").dialog("close")
				}
			}
		})
		
		//프로덕트 그리드
		$("#product_grid").jsGrid({
	        width: "95%",
	        height: "auto",
	        editing:true,
	        filtering: true,
	        sorting: true,
	        paging: true,
	        autoload: true,
	        autosearch:true,
	        searchModeButtonTooltip :"Switch to searching",
	        pageSize : 10,
	        pageButtonCount:5,
	        
	        rowClick: function(args) {
	        	
	        },
	        
	        // 더블클릭 시 다이얼로그를 열어줌
	        rowDoubleClick:function(args){
	        	var data = args.item
	        
	        	$("#productDialog").dialog("open")
	        	$("#product_name").val(data.product_name)
	        	$("#product_id").val(data.product_id)
	        	$("#category").val(data.category)
	        	$("#main_img").val(data.main_img)
	        	$("#sub_img").val(data.sub_img)
	        	$("#price").val(data.price)
	        	$("#condition").val("물품게시")
	        },
	        
	        controller : {
	        	
	        	loadData:function(filter){
	        		return $.ajax({
	        			type:"POST",
	        			url:"admin_product.do",
	        			data:filter,
	        			dataType:"JSON"
	        		})
	        	},
	        	updateItem : function(item){
	            	$.ajax({
	            		url:"adminUpdate_product.do",
	            		data:item,
	            		success:function(data){
	            			alert("업데이트 완료");
	            		}
	            	})
	            }
	        },
	        
	        fields: [
	            { name: "product_id", title:"제품번호", type: "number", width: 50},
	            { name: "category", title:"종류",type: "select", 
	            	items:[{id:"", Name:""},{id:"DESK", Name:"DESK"}, {id:"CLOSET", Name:"CLOSET"}, {id:"SOFA", Name:"SOFA"}, {id:"BED", Name:"BED"}],
	            	valueField: "id", textField: "Name", valueType:"String", width: 50 },
	            { name: "product_name",title:"품명", type: "text", width: 150 },
	            { name: "main_img",title:"사진", width: 50, itemTemplate:function(_,item){
	            	if(item.main_img != null){
	            		return $("<img/>").attr("src", "resources/img/product/"+item.main_img).css("width","70px")
	            	}
	            } },
	            { name: "member_id", title:"판매자", type: "text",width:50},
	            { name: "quality", title:"품질", type: "select",
	            	items:[{id:"", Name:""},{id:"A", Name:"A"}, {id:"B", Name:"B"}, {id:"C", Name:"C"}],
	            	valueField: "id", textField: "Name", valueType:"String", width: 50 },
	            { name: "price", title:"가격", type: "number", width:100},
	            { name: "condition", title:"물품상태", type: "select",
	            	items:[{id:"", Name:""},{id:"물품게시", Name:"물품게시"}, {id:"배송중", Name:"배송중"}, 
	            		{id:"대여중", Name:"대여중"},{id:"반납", Name:"반납"},{id:"수취확인", Name:"수취확인"},
	            		{id:"등록", Name:"등록"},{id:"입금완료", Name:"입금완료"},{id:"환불요청", Name:"환불요청"},
	            		{id:"반납요청", Name:"반납요청"},{id:"반납대기",Name:"반납대기"},{id:"1차검수",Name:"1차검수"},{id:"2차검수",Name:"2차검수"}],
	            	valueField: "id", textField: "Name", valueType:"String", width: 100 },
	           { type: "control", deleteButton:false },
	           {name:"deleteCondtion",title:"삭제", width:100, itemTemplate:function(_,item){
	        	   
	        	   if(item.condition=="등록"){
	        		   var str = $("<div></div>")
	        		   		str.append($("<div style='float:left; padding-left:50px;'></div>").html("<input type='button' class='delCondition' value='삭제'>").on("click",function(){
	        					   data = {"product_id":item.product_id}
	        					   var con = confirm("정말로 삭제하시겠습니까?")
	        						if(con == true){
	        							$.ajax({
	        		            			url:"delete_product.do",
	        		            			data:data,
	        		            			success:function(data){
	        		            				alert("삭제 완료")
	        		            				location.href=""
	        		            			}
	        		            		})
	        		            		// 이 값에 해당되는 상품을 삭제
	        						}
	        		        		
	        		        	}))
	            			str.append($("<div style='float:left; margin-left:10px;'></div>").html("<input type='button' value='수거' product_id='"+item.product_id+"' id='collectBtn_admin'>"))
	        		  return str
	        	   }else if(item.condition=="2차검수"){
	        		   var str = $("<div></div>")
	        		   str.append($("<div style='float:left; padding-left:35px;'></div>").html("<input type='button' class='delCondition' value='2차검수 완료'>").on("click",function(){
	        					   data = {"product_id":item.product_id,"condition":"물품게시"}
	        							$.ajax({
	        		            			url:"UpdateCondition_product",
	        		            			data:data,
	        		            			success:function(data){
	        		            				alert("변경 완료")
	        		            				location.href=""
	        		            			}
	        		            		})
	        		        		
	        		        	}))
	        		   return str;
	        	   }
	           }}
	        ]
		});
		
		//오더 그리드
		$("#order_grid").jsGrid({
	        width: "95%",
	        height: "400px",
	        filtering: true,
	        sorting: true,
	        paging: true,
	        autoload: true,
	        
	        pageSize : 10,
	        pageButtonCount:5,
	        
	        controller : {
	        	loadData: function(filter) {
	        		return $.ajax({
	        			type:"POST",
	        			url:'admin_orderlist.do',
	        			data:filter,
	        	        dataType : "JSON"
	        		 })
	            },
	            
	            updateItem : function(item){
	            	$.ajax({
	            		url:"adminUpdate_orderlist.do",
	            		data:item,
	            		success:function(data){
	            			alert("오더리스트 업데이트 완료");
	            		}
	            	})
	            }
	        },
	        
	        fields: [
	            { name: "order_id", title:"주문번호",type: "number", width: 30},
	            { name: "member_id", title:"구매자",type: "text", width: 80},
	            { name: "product_id",title:"제품번호", type: "number", width: 30},
	            { name: "pay_date",title:"구매일", type: "text",width:60},
	            { name: "rent_start",title:"대여시작", type: "text", width:60 },
	            { name: "rent_end", title:"대여마강", type: "text", width:60 },
	            { name: "rent_month",title:"대여기한(개월)", type: "number", width:60},
	            { name: "orderlist_condition", title:"상태", type: "select",
	            	items:[{id:"", Name:""},{id:"입금완료", Name:"입금완료"}, {id:"배송중", Name:"배송중"}, 
	            		{id:"대여중", Name:"대여중"},{id:"반납", Name:"반납"},{id:"배송완료", Name:"배송완료"},{id:"취소", Name:"취소"},
	            		{id:"검수완료", Name:"검수완료"},{id:"수취확인", Name:"수취확인"},	{id:"반납요청", Name:"반납요청"},{id:"반납대기", Name:"반납대기"},{id:"환불요청", Name:"환불요청"}],
	            	valueField: "id", textField: "Name", valueType:"String", width: 60 },
	            { name:"비고", width:100, itemTemplate:function(_,item){
	            	var str = $("<div></div>")
	            	if(item.orderlist_condition=="입금완료"){
	            		str.append($("<div style='float:left; padding-left:70px;'></div>").html("<input type='button' value='배송' order_id='"+item.order_id+"' id='deliveryBtn_admin'>"))
	            		str.append($("<div style='float:left; margin-left:10px;'></div>").html("<input type='button' value='취소' order_id='"+item.order_id+"' id='resetBtn_admin'>"))
	            	}else if(item.orderlist_condition=="반납요청"){
	            		str.append($("<div style='float:left; padding-left:70px;'></div>").html("<input type='button' value='반납' order_id='"+item.order_id+"' id='returnBtn_admin'>"))
	            	}else if(item.orderlist_condition=="환불요청"){
	            		str.append($("<div style='float:left; padding-left:70px;'></div>").html("<input type='button' value='환불' order_id='"+item.order_id+"' product_id='"+item.product_id+"' id='refundBtn_admin'>"))
	            	}
	            	return str;
	              }
	            }

	        ]
		})
		
		$("#member_grid").jsGrid({
			width: "95%",
	        height: "400px",
	        filtering: true,
	        editing:true,
	        sorting: true,
	        paging: true,
	        autoload: true,
	        
	        rowClick:function(){
	        },
	        rowDoubleClick: function(args) {
	        	
	        },
	        pageSize : 10,
	        pageButtonCount:5,
	        
	        controller : {
	        	loadData: function(filter) {
	        		return  $.ajax({
	        			url:'admin_member.do',
	        	        dataType : "json",
	        	        type:"POST",
	        	        data:filter
	        		 })
	        		
	            },
	            
	            updateItem : function(data){
	            	$.ajax({
	            		url:'adminUpdate_member.do',
	            		data:data,
	            		success:function(data){
	            			elart("회원정보 변경 완료")
	            		}
	            	})
	            }
	        },
	        
	        fields: [
	            { name: "member_id", title:"아이디",type: "text", width: 150},
	            { name: "name",title:"이름", type: "text", width: 50 },
// 	            { name: "pwd", title:"비밀번호", type: "text", width: 70 },
	            { name: "tel", title:"전화번호",type: "text", width: 100 },
	            { name: "pwd_q",title:"비밀번호 질문", type: "select", 
	            	items:[{id:"", Name:""},{id:"자신의 보물 제1호는?", Name:"자신의 보물 제1호는?"}, {id:"자신의 출신 초등학교는?", Name:"자신의 출신 초등학교는?"}, {id:"인상 깊게 읽은 책 이름은?", Name:"인상 깊게 읽은 책 이름은?"}, {id:"가장 기억에 남는 선물은?", Name:"가장 기억에 남는 선물은?"}],
	            	valueField: "id", textField: "Name", valueType:"String",
	            	width: 170 },
	            { name: "pwd_a", title:"답변",type: "text", width: 70 },
	            { name: "address", title:"시/군/구",type: "text",width:100 },
	            { name: "address_detail",title:"주소", type: "text", width:100 },
	            { name: "payback", title:"payback", type: "number", width:50, readOnly:true},
	            { name: "bank", title:"은행명",type: "select", 
	            	items:[{id:"",Name:""}, {id:"농협",Name:"농협"},{id:"국민",Name:"국민"},{id:"기업",Name:"기업"},{id:"신한",Name:"신한"},{id:"우리",Name:"우리"}],
	            	valueField: "id", textField: "Name", valueType:"String", width:50},
	            { name: "account_no", title:"계좌번호",type: "text", width:100},
	            { name: "grade", title:"등급",type: "number", width:40},
	            { type: "control", deleteButton:false },
	            { name:"비밀번호 초기화", width:100, itemTemplate:function(_,item){
	            	var str = $("<button></button>").addClass("reset").text("초기화").on("click",function(){
	            		var reset =  confirm("비밀번호를 초기화 하시겠습니까?")
	    	        	var data = {"member_id":item.member_id}
	    	        	
	    	        	if(reset == true){
	    	        		$.ajax({
	    	        			url:"updateResetPwd_member.do",
	    	        			dataType:"json",
	    	        			data:data,
	    	        			success:function(data){
	    	        				alert("비밀번호를 초기화 하였습니다.")
	    	        			}
	    	        			
	    	        		})
	    	        		
	    	        	}
	            	})
	            	return str;
	            	
	            }}
	            
	        ]
		})
		
		$(document).on("click","#resetBtn_admin",function(){
			alert("취소")
			order_id = $(this).attr("order_id")
		})
		$(document).on("click","#deliveryBtn_admin",function(){
			var a = window.open("admin/deliveryInfo.do?order_id="+$(this).attr("order_id"),"배송처리","width=400,height=200")
		})
		$(document).on("click","#returnBtn_admin",function(){
			var a = window.open("admin/returnInfo.do?order_id="+$(this).attr("order_id"),"반납처리","width=400,height=200")
		})
		$(document).on("click","#refundBtn_admin",function(){
			if(confirm("환불 처리하시겠습니까?")){
				var order_id = $(this).attr("order_id")
				var product_id = $(this).attr("product_id")
				$.ajax({
					url:"updateOrderlistCondition.do",
					data:{"order_id":order_id,"condition":"취소"},
					success:function(){
						$.ajax({
							url:"UpdateCondition_product",
							data:{"product_id":product_id,"condition":"물품게시"},
							success:function(){
								$.ajax({
									url:"refund.do",
									data:{"order_id":order_id},
									success:function(){
										alert("환불 완료")
									}
								})
							}
						})
					}
				})
				
			}
			
		})
		$(document).on("click","#collectBtn_admin",function(){
			var a = window.open("admin/collectInfo.do?product_id="+$(this).attr("product_id"),"수거처리","width=400,height=200")
		})
})

</script>
<title>Insert title here</title>
</head>
<body>
	<div id="tabs">
		<ul>
			<li><a href="#a">물품관리</a></li>
			<li><a href="#b">주문관리</a></li>
			<li><a href="#c">회원관리</a></li>
			<li><a href="#d">통계</a></li>
			<li><a href="index.jsp">메인</a></li>
		</ul>
		
		<div id="a">
			<h2>물품관리</h2>
			<hr>
			<div>
				<table id="product_grid" border="1" cellpadding="10px" cellspacing="10px" class="table">

				</table>
				<div id="pager"></div>
			</div>
		</div>

		<div id="b">
			<h2>주문관리</h2>
			<hr>
			<div>
				<table id="order_grid" border="1" cellpadding="10px" cellspacing="10px" class="table">
					
				</table>
				
			</div>
		</div>

		<div id="c">
			<h2>회원관리</h2>
			<hr>
			<div>
				<table id="member_grid" border="1" cellpadding="10px" cellspacing="10px" class="table">
			
				</table>
			</div>
		</div>
		
		<div id="c">
			<h2>통계</h2>
			<hr>
			<div id="Rchart">
				
			</div>
		</div>
	</div>
	
	<form id="productDialog" method="post" enctype="multipart/form-data" action="adminSell_product.do">
		<div style="margin: 0 20% 0 20%; padding: 20px 0 20px 0; ">
			<div style="padding: 10px" align="left">
				품명 : <textarea rows="1" style="width: 90%" name="product_name" id="product_name"></textarea>
				<input type="hidden" name="product_id" id="product_id">
				<input type="hidden" name="condition" id="condition">
			</div>
			<div style="padding: 10px" align="left">
				분류 :  <select name="category" id="category">
						<option value="BED">BED</option>
						<option value="SOFA">SOFA</option>
						<option value="DESK">DESK</option>
						<option value="CLOSET">CLOSET</option>	
					</select>
			</div>
			<div style="padding: 10px" align="left">
				품질 :<input type="radio" name="quality" value="A">A
					<input type="radio" name="quality" value="B">B
					<input type="radio" name="quality" value="C" checked="checked">C
			</div>
			<div style="padding: 10px" align="left">
				대표이미지 : <input type="file" name="mainIMG"><br>
				서브이미지 : <input type="file" name="subIMG">
				<input type="hidden" name="main_img" id = "main_img">
				<input type="hidden" name="sub_img" id="sub_img">
			</div>
			<div style="padding: 10px" align="left">
				가격 : <input type="text" name="price" id="price">
			</div>
		</div>
	</form>
</body>
</html>