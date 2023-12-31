<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<title>내 정보 수정</title>
<style>
	#ebtn{
	  background: rgb(26, 188, 156);
	  color: white;
	  padding: 10px;
	  border: none;
	  border-radius: 10px;
	  margin-left: 160px;
  }
  .sel{
  	font-size: 20px;
  	font-weight: bold;
  }
  .edit{
  	width: 650px;
  	height: 800px;
  	border-radius: 10px;
  	box-shadow: 0px 0px 14px gray;
  	margin-left: 200px;
  	display: flex;
    justify-content: center;
    align-items: center;
  }
  #editForm{margin-right: 30px; text-align: left;}
  input{width: 400px; height: 35px;}
  #wbtn{
  	font-size: 10px;
  	background: rgb(26, 188, 156);
	color: white;
	padding: 5px;
	border: none;
	border-radius: 10px;
	margin-left: 450px;
  }
  #btn {display: inline-block; background-color: #1abc9c; color:white; border: none; width:120px; height: 40px;
			border-radius: 50px; box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1); margin-left: 880px;}
			
	#modal { width: 320px; height: 180px; border: 1px solid #eee; padding: 50px; margin: auto; display: none;
			border-radius: 20px; box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);  text-align: center; background-color: white;
			 position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999;}
	
	#btn3 { background-color: #1abc9c; color:white; border: none; width: 100px; height: 35px;
			border-radius: 20px; box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2); }
			
	#btn4 { background-color: lightgray; color:white; border: none; width: 100px; height: 35px;
			border-radius: 20px; box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);}
	#changeModal{width: 600px; height: 450px; border: 1px solid #eee; padding: 50px; margin: auto; display: none;
			border-radius: 20px; box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);  text-align: center; background-color: white;
			 position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999;}
	#change{
	  background: rgb(26, 188, 156);
	  color: white;
	  padding: 10px;
	  border: none;
	  border-radius: 10px;
	  width: 55px; height: 40px;
	}
	.pwd{border: 1px solid black;}
	#btn5{
	  background-color: #1abc9c; color:white; border: none; width: 100px; height: 35px;
	  border-radius: 20px; box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
	}
	#btn6{
	  background-color: lightgray; color:white; border: none; width: 100px; height: 35px;
	  border-radius: 20px; box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
	}
</style>
</head>
<body>
	<%@ include file="../common/top.jsp" %>
	<%@ include file="../common/sideBar.jsp" %>
	<div id="wrapper" class="toggled">
        <div id="page-content-wrapper">
	    	<div class="container-fluid">
	        	<div class="container text-center">
					   <h4 style="margin-right: 58%;"><b>나의 정보</b></h4>
					   		<br>
					      	<div class="edit">
					      		<form id="editForm" action="${ contextPath }/member_UpdateInfo.me" method="post">
					      			<p class="sel">1. 아이디</p>
    							  	<input type="text" name="memberId" value="${ loginUser.memberId }" readonly id="id" style="background: lightgray;"/>
    							  	<br><br>
					      			<p class="sel">2. 비밀번호</p>
    							  	<input type="password" name="memberPwd" readonly style="background: lightgray;"/>
    							  	<button type="button" id="change">변경</button>
    							  	<br><br>
					      			<p class="sel">3. 이름</p>
    							  	<input type="text" name="memberName" value="${ loginUser.memberName }" required/>
    							  	<br><br>
					      			<p class="sel">4. 이메일</p>
    							  	<input type="text" name="memberEmail" value="${ loginUser.memberEmail }" required/>
    							  	<br><br>
    							  	<p class="sel">5. 연락처</p>
    							  	<input type="text" name="memberPhone" value="${ loginUser.memberPhone }" required/>
    							  	<br><br>
    							  	<p class="sel">6. 주소</p>
    							  	<input type="text" name="memberAddress" value="${ loginUser.memberAddress }" required/>
    							  	<br><br><br><br>
    							  	<button id="ebtn">수정하기</button>
					      		</form>
					      	</div>
					      	<br>
					      	<button id="wbtn" onclick="location.href='${contextPath}/member_WithDrawal.me'">회원 탈퇴</button>
					      </div>
					    </div>
					</div>
	            </div>
				
				<div id="changeModal">
					<form action="${ contextPath }/member_UpdatePwd.me" method="post">
						<p class="sel">1. 현재 비밀번호</p>
	    				<input type="password" name="memberPwd" class="pwd" id="pwd"/>
	    				<div style="height: 30px; font-size: 12px;" id="pwdDiv1"></div>
						<p class="sel">2. 변경할 비밀번호</p>
	    				<input type="password" name="memberNewPwd" id="newPwd" class="pwd"/>
	    				<br><br>
						<p class="sel">3. 비밀번호 확인</p>
	    				<input type="password" id="pwdConfirm" class="pwd"/>
	    				<input type="hidden" value="${ loginUser.memberPwd }" id="currentPwd">
	    				<div style="height: 30px; font-size: 12px;" id="pwdDiv"></div>
						<button id="btn5">변경하기</button>&nbsp;&nbsp;&nbsp;
						<button type="button" id="btn6">취소하기</button>
					</form>
				</div>
				
				<br><br><br><br>
				
				<script>
					window.onload = () =>{
						document.getElementById('change').addEventListener('click', () => {
							document.getElementById('changeModal').style.display = 'block';
						});
						
						document.getElementById('btn6').addEventListener('click', () => {
							document.getElementById('changeModal').style.display = 'none';
						});
						
						// 아이디 중복확인, 비밀번호 일치
						const pwd = document.getElementById('newPwd');
						const pwdc = document.getElementById('pwdConfirm');
						const pwdDiv = document.getElementById('pwdDiv');
						const pwdDiv1 = document.getElementById('pwdDiv1');
						const btn5 = document.getElementById('btn5');
						const form = document.getElementById('editForm');
						const cuPwd = document.getElementById('currentPwd');
						const cPwd = document.getElementById('pwd');
						const memberId = document.getElementById('id');
						
						// 비밀번호 칸
						pwd.addEventListener('keyup', (e) => {
							if(pwd.value != '' && pwdc.value != ''){
								if(pwd.value == pwdc.value) {
									pwdDiv.innerText = '비밀번호가 일치합니다.';
									pwdDiv.style.color = 'green';
								} else {
									pwdDiv.innerText = '비밀번호가 일치하지 않습니다.';
									pwdDiv.style.color = 'red';
									e.preventDefault(); // 비밀번호가 일치하지 않으면 submit 안되게
								}
							}
						});
						
						// 비밀번호 확인 칸
						pwdc.addEventListener('keyup', (e) => {
							if(pwd.value != '' && pwdc.value != ''){
								if(pwd.value == pwdc.value) {
									pwdDiv.innerText = '비밀번호가 일치합니다.';
									pwdDiv.style.color = 'green';
								} else {
									pwdDiv.innerText = '비밀번호가 일치하지 않습니다.';
									pwdDiv.style.color = 'red';
									e.preventDefault(); // 비밀번호가 일치하지 않으면 submit 안되게
								}
							}
						});
						
						// 현재 비밀번호 체크
						cPwd.addEventListener('keyup', () => {
							if(cPwd.value == ''){
								alert('현재 비밀번호를 입력해주세요.');
							} else {
								$.ajax({
									type : 'POST',
									url : '${contextPath}/checkCurrentPwd.me',
									data : {memberId : memberId.value, memberPwd : cPwd.value},
									success : data => {
										if(data === 'yes'){
											pwdDiv1.innerText = '현재 비밀번호가 일치합니다.';
											pwdDiv1.style.color = 'green';
										} else {
											pwdDiv1.innerText = '현재 비밀번호가 일치하지 않습니다.';
											pwdDiv1.style.color = 'red';
										}
									},
									error : data => {
										console.log('비밀번호 체크 중 에러');
									}
								});
							}
						});
						
					}

					btn5.addEventListener('click', (e) => {
						if(pwdDiv1.innerText == '현재 비밀번호가 일치하지 않습니다.'){
							alert('현재 비밀번호가 일치하지 않습니다.');
							e.preventDefault();
						} else if(pwdDiv.innerText == '비밀번호가 일치하지 않습니다.'){
							alert('비밀번호가 일치하지 않습니다.');
							e.preventDefault();
						} else if(pwdDiv.innerText == '비밀번호가 일치합니다.') {
							alert('비밀번호가 변경되었습니다.');
							form.submit();
						}
					})
					
				</script>
		<br><br><br><br><br><br><br><br><br><br><br><br><br>
		<footer>
			<%@ include file="../common/bottom.jsp" %>
		</footer>
</body>
</html>