<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="Change_pwd" data-role="page" data-close-btn="none" data-overlay-theme="b">
<script type="text/javascript">
	$(function(){
		
		//비밀번호 수정 ajax
		$("#Change_pwd_btn").click(function(){
			var oldPwd = $("#oldPwd").val();
			var pwd = $("#newPwd").val();
			var pwd2 = $("#chk_newPwd").val();
			
			
			var data ={"input_pwd":pwd,"input_pwd2":pwd2,"old_pwd":oldPwd};
				
			$.ajax({
				url:"../../changePwdChk.do",
				data:data,
				success:function(data){
						
					data = eval('('+data+')')
						
					if(data=="일치"){
							
						var member_id = '<%=session.getAttribute("id")%>'
							
						data = {"member_id":member_id ,"pwd":pwd}
							
						$.ajax({
							url:"../../updatePwd_member.do",
							data:data,
							success:function(data){
								alert("비밀번호 변경 완료");
								location.href="../../myPage.do?selectedMyPage=mP";
							}
						});
						
					}else{
						alert(data)
					}
				}
			});
			
		});
	});
</script>
	<div data-role="header">
		<h2>비밀번호 수정</h2>
	</div>
	<div data-role="content">
		<table>
			<tr>
				<td>현재 비밀번호</td>
				<td><input type="password" id="oldPwd"></td>
			</tr>
			<tr>
				<td>변경할 비밀번호</td>
				<td><input type="password" id="newPwd"></td>
			</tr>
			<tr>
				<td>변경할 비밀번호 확인</td>
				<td><input type="password" id="chk_newPwd"></td>
			</tr>
		</table>
		<div class="ui-grid-a">
			<div class="ui-block-a">
				<input id="Change_pwd_btn" type="button" value="변경" data-theme="b">
			</div>
			<div class="ui-block-b">
				<a href="#" data-rel="back" data-role="button" data-theme="b">취소</a>
			</div>
		</div>
	</div>
</div>
