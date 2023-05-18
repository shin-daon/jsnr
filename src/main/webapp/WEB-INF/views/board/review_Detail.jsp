<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;700&display=swap"  rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<title>집사 상세후기</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
	* {font-family: 'Noto Sans KR', sans-serif;}
	
	.container:nth-of-type(3) {
	  display: flex;
	 
	}
	
	
	.col:nth-child(2) { 
 	 width: 70%;
	}
	
	.review {
	  display: flex;
	  align-items: flex-start;
	  justify-content: space-between;
	}
	
	.review .profile {
	  margin-right: -30px;
	}
	
	.review img {
	  width: 100px;
	  height: 100px;
	  object-fit: cover;
	  margin-right:1px;
	  border-radius: 50%;
	}
	
	.review h2 {
	  font-size: 1.5rem;
	  font-weight: bold;
	  margin-left:20px;
	}
		.review h4 {
	  font-size: 20px;
	  margin-left:20px;
	}
	
	.review p {
	  font-size: 1rem;
	  margin-bottom: 10px;
	  margin-top: 20px;
	  margin-left:20px;
	}
	
	.review .info {
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	  text-align: center;
	  width: 100%;
	}
	
	.row {
		border: 0.5px solid rgb(26, 188, 156);
		padding: 18px;
		margin: 10px;
		border-radius: 30px;
	}
	
	p {
	   display: -webkit-box;
	   -webkit-line-clamp: 4;
	   -webkit-box-orient: vertical;
	   overflow: hidden;
	   text-overflow: ellipsis;
	   max-height: 120px; /* line-height와 font-size를 곱한 값을 입력합니다. */
 	}
 	
 	.username {
	  background-color: rgb(26, 188, 156);
	  color: white;
	  font-size: 20px;
	  padding: 5px;
	  border-radius: 5px;
	  margin-top: 10px;
	  text-align: center;
	}
	

	button.search-button {
        padding: 0.3rem 0.5rem; /* 패딩값 조정 */
        font-size: 1rem; /* 폰트 크기 조정 */
        border-radius: 10px; /* 둥근 모서리 크기 */
    }
    
     .col:nth-child(3) .images { 
 	  padding-left: 60px; 
 	} 
	
	.col:first-child .images {
	  padding-right: 1px;
	}
	
	#comment {
	  text-align: center;
	}
	
	.material-symbols-outlined {
	  font-variation-settings:
	  'FILL' 0,
	  'wght' 100,
	  'GRAD' 200,
	  'opsz' 48;
	  color: rgb(26, 188, 156);
	   
	  
	}
	
	.material-symbols-outlined {
	  font-variation-settings:
	  'FILL' 0,
	  'wght' 100,
	  'GRAD' 200,
	  'opsz' 48;
	   color: rgb(26, 188, 156);
	}
		
	#reviewDetailSetting{align-items: center; margin-Left: 220px;}
	
	#allReviewBtn{
		background-color: rgb(26, 188, 156);
		color: white;
		font-size: 24px;
		padding: 0.7rem 1.5rem;
		border-radius: 5px; 
		border: none; 
		margin-right: 170px;}
		
	#replyBtn{border: none;
	background-color: rgb(239, 245, 245);
	color: rgb(67, 154, 151);
	border-radius: 5px;}
	
	#replyContent{
	border: 1px solid #7F8487;
	background-color: white;
	color: rgb(67, 154, 151);
	border-radius: 5px;}
	
	#contentBox{border: 1px solid #7F8487; border-radius: 5px;}
</style>


</head>
<body>
<%@ include file="../common/top.jsp" %>

<div id="reviewDetailSetting">
	<div class="container">
		<br>
		<h1 class="text-left">집사 후기</h1>
		<div class="container" style="display: flex; align-items: center;">
		<div class="col">
			<div class="reviewLeftBtn">
           		<span class="material-symbols-outlined" style="font-size: 70px;">arrow_circle_left</span>
        	</div>
        </div>			
		<input type="hidden" value="${ b.memberNo }" name="memberNo">
		<input type="hidden" value="${ page }" name="page">
		<div class="col">
			<div class="row" style="width: 600px; margin-right: 170px;">
			  	<div class="col">
				    <div class="review">
						  <div class="profile">
							  <img src="resources/image/user.png">
							  <div class="username"></div>
						  </div>
						  <div class="info">
						  <table style="text-align: left;"> 
						  	  <tr>
						  		  <td colspan="3"><h2>${b.jibsaName} 집사</h2><h4>${b.matchingPlace}</h4></td>
						  	 	  <td>평균평점 ${b.reviewRating }점</td>
						  	  </tr>
						  	  <tr><td colspan="3"><br></td><tr>
						  		  <td></td>
						 	  <tr>
								  <td><h4>${b.animalName}</h4></td>
								  <td><h4>${b.animalKind}</h4></td>
								  <td></td>
								  <td></td>
						  	  </tr>
						  </table>
						  </div>
					</div>
					<br>
				</div>
				<hr><br><br>
				<textarea readonly cols="50" rows="10" style="resize: none; padding: 20px;" name="content" id="contentBox">  ${b.reviewContent }</textarea>
				
				<hr><br><hr><br>
				<h3 style="text-align: center;">집사의 댓글</h3>
				<br>
				<table>
					<thead style="text-align: center;">
						<tr>
							<th width="130px">댓글 내용</th>
							<th width="130px">매칭 종료일</th>
						</tr>
					</thead>
					<tbody class="tbody1" style="text-align: center;">	
						<c:forEach items="${ list }" var="r">
						<tr class="tr1">
							<td class="td1">${ r.jibsaComment }</td>
							<td class="td1">${ r.endDate  }</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<br><hr><br>
				  <div id="comment">
				    <label>댓글입력 : </label>
					<input id="replyContent"type="text" placeholder=" 댓글을 달거나 수정해주세요">
					<input id="replyBtn" type="button" value ="댓글 수정">
				  </div>
			</div>
			<br><br>
			<div class="col" style="text-align: center;">
				<button id="allReviewBtn"onclick="location.href='${contextPath}/review_Main.bo'">모든 후기 보기</button>
			</div>
			<div class="col">
				<div class="reviewRightBtn">
           			<span class="material-symbols-outlined" style="font-size: 70px;">arrow_circle_right</span>
        		</div></div>
			</div></div>
		</div>
	</div>
<br><br><br><br>	
<%@ include file="../common/bottom.jsp" %>

<script>
	window.onload=()=>{
		let usernames = document.querySelector('.username');
		const URLSearch = new URLSearchParams(location.search);
		const usernameChange = URLSearch.getAll('userName');
			
		usernames.innerText += usernameChange;
		
		
		document.getElementById('replyBtn').addEventListener('click', ()=>{
			$.ajax({
				url: '${contextPath}/updateReply.bo',
				data: {
						jibsaComment:document.getElementById('replyContent').value,
						memberNo:${loginUser.memberNo},
						matchingNo:${b.matchingNo},
						jibsaNo:${b.jibsaNo}
				},
				success: data =>{
					console.log(data);
					const tbody = document.querySelector('.tbody1');
					tbody.innerHTML = '';
					
					for(const r of data){
						const tr = document.createElement('.tr1');
						
						const contentTd = document.createElement('.td1');
						contentTd.innerText = r.jibsaComment;
						
						const dateTd = document.createElement('.td1');
						dateTd.innerText = r.endDate;
						
						tr.append(contentTd);
						tr.append(dateTd);
						tbody.append(tr);
						
					}
					document.getElementById('replyContent').value = '';
				},
				error: data =>{
					console.log(data);
				}
			});
		})		
	} 
</script>
		
		
		
		
		
		
		
		
</body>
</html>