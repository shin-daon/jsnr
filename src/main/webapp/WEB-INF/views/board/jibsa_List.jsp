<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>집사와 훈련사 조회 페이지</title>
	<style>
		.card:hover{
			cursor: pointer;
			background: rgba(26, 188, 156, 0.7);
		}
	</style>
</head>
<body>
	<jsp:include page="../common/top.jsp"/>
	<div class="container text-center border rounded mb-5">
		<br>
		<h1>훈련사 / 집사 lIST</h1>
		<br>
		<h5>집사나라의 파트너를 소개합니다!</h5>
		<br>
	</div>
	
	<div class="container text-center mb-5">
		<div class="filter d-flex justify-content-end mb-5">
			<div class="filter-group d-flex">
				<button class="shadow m-bg-color rounded-2 border-0 fs-6 fw-bold text-white me-2" style="width: 100px; height: 40px;">훈련사</button>
				<button class="shadow m-bg-color rounded-2 border-0 fs-6 fw-bold text-white me-2" style="width: 100px; height: 40px;">집사</button>
			</div>
			<div class="filter-group d-flex">
				<select id="sort-select">
			   		<option value="price-low">금액 낮은 순</option>
			   		<option value="reviews-high">후기 많은 순</option>
			 	</select>
			</div>
		</div>
		
		
		<div class="row d-flex justify-content-center">
			<c:forEach items="${ pList }" var="l">
				<div class="card col-3 mx-3 mb-4" style="width: 350px;">
					<input type="hidden" value="${ l.memberNo }">
			  		<div class="card-body row d-flex justify-content-center">
			  			<div class="col-12">
			    			<img src="${ contextPath }/resources/image/logo.png" class="w-75">
			    		</div>
			    		<p class="name mb-2">${ l.jibsaName } 집사님</p>
			    		<div class="text-black me-2 mx-0 px-0">
				    		<div class="row px-0 text-start" style="height: 50px;">
				    			<span class="col-4 ps-3">활동지역</span>
				    			<span class="col-8 px-0">${ l.availableArea }</span>
			    			</div>
			    			<div class="row px-0 text-start">
				    			<span class="col-4 ps-3">시급</span>
				    			<span class="col-8 px-0">${ l.exptectedSalary }</span>
			    			</div>
			    			<div class="row px-0 text-start">
				    			<span class="col-4 ps-3">매칭횟수</span>
				    			<span class="col-8 px-0">${ l.workCount }번 </span>
			    			</div>
			    			<div class="text-end">
				    			<span class="px-0">평점 ${ l.jibsaAvgRating }점</span>
			    			</div>
				    	</div>
					</div>
				</div>
				
			</c:forEach>
			
			
			<nav aria-label="Standard pagination example" style="float: right;">
				<ul class="pagination">
          			<li class="page-item">
          				<c:url var="goBack" value="${ loc }">
          					<c:param name="page" value="${ pi.currentPage-1 }"></c:param>
          				</c:url>
          				<a class="page-link" href="${ goBack }" aria-label="Previous">
          					<span aria-hidden="true">&laquo;</span>
           			</a>
          			</li>
          			<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
         				<c:url var="goNum" value="${ loc }">
         					<c:param name="page" value="${ p }"></c:param>
         				</c:url>
          				<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
          			</c:forEach>
          			<li class="page-item">
          				<c:url var="goNext" value="${ loc }">
          					<c:param name="page" value="${ pi.currentPage+1 }"></c:param>
          				</c:url>
          				<a class="page-link" href="${ goNext }" aria-label="Next">
          					<span aria-hidden="true">&raquo;</span>
          				</a>
          			</li>
   				</ul>
     		</nav>
			
		</div>
	</div>
	
	<%@ include file="../common/bottom.jsp"%>
	
	<script>
		window.onload = () =>{
			const cards = document.querySelectorAll('.card');
			for(card of cards){
				const mId = card.children[0].value;
				console.log(mId);
				card.addEventListener('click', function(){
					location.href="${contextPath}/jibsa_Detail.bo?mId="+mId+"&page="+${pi.currentPage};
				})
			}
		}
	</script>









	
</body>
</html>