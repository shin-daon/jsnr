<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap" rel="stylesheet">
<style>
	* {font-family: 'Noto Sans KR', sans-serif;}

	body {text-align: center; margin-left: auto; margin-right: auto;}
	
	.title {margin-left: 450px; font-weight: 700;}
	.subtitle {margin-left: 450px;}
	
	.area {border: 1px solid lightgray; padding: 20px; 
			border-radius: 20px; box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);  text-align: center;
			margin-left: auto; margin-right: auto; width: 600px; height: 100px; display: flex; align-items: center; justify-content: center;}
	
	.area3 {border: none; padding: 20px; 
			border-radius: 20px;  text-align: center;
			margin-left: auto; margin-right: auto; width: 600px; height: 100px; display: flex; align-items: center; justify-content: center;}
	
	.area2 {border: none; padding: 20px; 
			text-align: center;
			margin-left: auto; margin-right: auto; width: 700px; height: 100px; display: flex; align-items: center; justify-content: center;}
			
	.purchase {background-color: #1abc9c; color:white; border: none; width:110px; height: 40px;
			border-radius: 50px; box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);}
			
	.purchase:active {background-color: white; color:#1abc9c; border: 1px solid #1abc9c; width:110px; height: 40px;
			border-radius: 50px;}
			
	.purchase2 {margin-left: 350px;}
	
	
	#btn { border-radius: 20px; box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
		border: none; background-color:#1abc9c; color:white; width: 300px; height: 70px;}
	
	#btn:active {background-color: white; color:#1abc9c; border: 1px solid #1abc9c; width:300px; height: 70px;
			border-radius: 50px;}
	h4 {display: inline-block; display: flex; align-items: center; width: 100px; }
	.table thead tr th{background: rgba(224, 224, 224, 0.51);}
	.tableDiv{
		width: 800px;
		text-align: center;
		display: block;
		margin: 0 auto;
	}
</style>
<body>
	<jsp:include page="../common/top.jsp"/>
	
	<br>
	<h2 class="title">마이페이지</h2><br>
	<h4 class="title" style="width: 200px;">프리미엄 결제</h4><br><br>
	<h5 class="subtitle">검색 상단에 올라가는 혜택이!</h5><br><br>
	<c:if test="${ jibsaInfo.isPrimium eq 'Y' }">
		<div class="tableDiv">
			<p style="margin-right: 520px;">${ loginUser.memberName }님은 이미 혜택을 받고 계십니다!</p>
			<table class="table">
				<thead>
					<tr>
						<th>이름</th>
						<th>구독 기간</th>
						<th>시작 날짜</th>
						<th>종료 날짜</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${ loginUser.memberName }</td>
						<td id="date"></td>
						<td>${ jibsaInfo.primiumPaymentDate }</td>
						<td>${ jibsaInfo.primiumEndDate }</td>
					</tr>
				</tbody>
			</table>
		</div>
	</c:if>
	<c:if test="${ jibsaInfo.isPrimium eq 'N' }">
	<span class="subtitle">원하는 프리미엄 결제 개월 수를 선택해주세요</span><br><br><br>
	
	<div class="area">
		<h4>1개월 12000원</h4>
		<button value="12000" class="cards purchase purchase2">선택하기</button>
	</div><br>
	
	<div class="area">
		<h4>3개월 35000원</h4>
		<button value="35000" class="cards purchase purchase2">선택하기</button>
	</div><br>
	
	<div class="area">
		<h4>6개월 68000원</h4>
		<button value="68000" class="cards purchase purchase2">선택하기</button><br>
	</div><br><br>
	
	<div class="area3">
		<h3 id="noticePay">원하시는 구독을 골라주세요.</h3>
	</div>
	
	<h4 class="subtitle"></h4>
	</c:if>
	<br><br><br><br>
	<c:if test="${ jibsaInfo.isPrimium eq 'N' }">
	<div class="area2" >
  		<button id="btn" onclick="requestPay()">결제하기</button><br>
	</div><br>
	</c:if>
	
	<c:if test="${ jibsaInfo.isPrimium eq 'Y' }">
	<div class="area2" >
  		<button id="btn" onclick="location.href='javascript:history.back()'">뒤로가기</button><br>
	</div><br>
	</c:if>
	
	
	<br><br><br>
	<br><br><br>
	<br><br><br>
	
	<jsp:include page="../common/bottom.jsp"/>
	<script>
		const phone = '${loginUser.memberPhone}';
		const email = '${loginUser.memberEmail}';
		const name = '${loginUser.memberName}';
		let pay = 0;
		const cardss = document.querySelectorAll('.cards');
		let noticePays = document.querySelector('#noticePay');
		for(const i of cardss){
			i.addEventListener('click', () => {
				const userCode = "imp14397622";
				IMP.init(userCode);
				pay = parseInt(i.value);
				noticePays.innerText = ''; 
				noticePays.innerText = pay + '원 구독을 선택하셨습니다.';
			})	
		}
	
		function requestPay() {
			if(pay === 0){
				notivePays.innerText = '';
			}
			 IMP.request_pay({
			    pg: "kakaopay",
			    pay_method: "card",
			    merchant_uid: "merchant_" + new Date().getTime(),
			    name: '집사나라 ' + pay.toString().charAt(0) + '개월 구독',
			    amount: pay,
			    buyer_tel: phone,
			    buyer_email : email,
			    buyer_name : name
			}, function(rsp){
				if(rsp.success){
					$.ajax({
						type : 'POST',
						url : '${contextPath}/insertPremium.js',
						data : {date : pay.toString().charAt(0), memberNo : ${loginUser.memberNo}},
						success : data => {
							if(data == 'yes'){
								location.href = '${contextPath}/premium_success.js?date='+pay.toString().charAt(0);
							} else {
								console.log('업데이트 실패');
							}
						},
						error: data => {
					          console.log('업데이트 실패');
					        }
					});
				} else {
					alert(rsp.error_msg);
				}
			})
		}
		
		const startDate = '${jibsaInfo.primiumPaymentDate}';
		const endDate = '${jibsaInfo.primiumEndDate}';
		const period = endDate.substring(5,7) - startDate.substring(5,7);
		const date = document.getElementById('date');
		date.innerText = period + '개월';
	</script>
</body>
</html>