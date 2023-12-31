<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;700&display=swap" rel="stylesheet">
<title>login</title>
<style>
.menu1:hover:not(.active){color: rgb(51, 51, 51);}
.menu2:hover:not(.active){color: rgb(51, 51, 51);}
.myMenu:hover:not(.active){color: rgb(51, 51, 51);}
.btjipsa{width: 138px; height: 58px; background: rgb(26, 188, 156); border-style: none; border-radius: 4px;}
.topLoginCont{width: 1200px; max-width: none !important; margin: 0 auto;}
.logo{width: 160px;}
.menu1{font-size: 23px; font-family: 'Noto Sans KR', sans-serif; font-weight: 700; margin: 10px; color: rgb(51, 51, 51); text-decoration: none;}
.menu2{font-size: 23px; font-family: 'Noto Sans KR', sans-serif; font-weight: 700; color: rgb(51, 51, 51); text-decoration: none; justify-content: unset;}
.left{margin-left: 5%; display: inline;}
#right{margin-left: 18%; display: inline;}

#top_hr{border: 20px solid rgb(26, 188, 156); opacity: 1; margin: 0;}
#top_hr2{border: 1px solid gray;}
#profile{width: 53px; height: 53px; border-radius: 100%; margin: 5px;}
.animal:hover:not(.active){color: rgb(51, 51, 51);}
.name:hover:not(.active){color: rgb(51, 51, 51);}
.name{font-size: 23px; font-weight: 700; font-family: 'Noto Sans KR', sans-serif; margin: 0px; color: rgb(51, 51, 51); text-decoration: none; display: inline-block;}
.animal{font-style: inherit; font-size: 18px; font-family: 'Noto Sans KR', sans-serif; margin: 0; color: rgb(51, 51, 51); text-decoration: none;}
.dropd{position: relative; margin-right: 13%; margin-top: 3%;}
.butn{padding: 10px 20px; background-color: transparent; border: none;}
#drop-c{position: absolute; z-index: 1; border-radius: 15px; background-color: rgb(255, 255, 255); border-style: none; box-shadow: rgb(224, 224, 224) 0px 0px 20px 0px;}
#drop-c a{display: block; padding: 5px 20px; margin: 2px 0px 0px 0px; text-decoration: none;}
.myMenu{font-weight: 700; font-size: 18px; font-family: 'Noto Sans KR', sans-serif; margin: 10px; color: rgb(51, 51, 51); text-decoration: none;}
#logOut{border: solid 1px; border-radius: 4px; width:100px; height:37px; margin-left: 45px; border-color: rgb(151, 222, 206); background-color: white;
 font-family: 'Noto Sans KR', sans-serif; color: rgb(26, 188, 156);}
#droul{margin: 0px 0px 0px; padding: 1px 1px 1px 1px; list-style: none;}
</style>
</head>
<body>
<header> 
	<hr id="top_hr">
	<br>
	<div class="topLoginCont" style="width: 1200px;"> 
		<div class="left" style="color: inherit;">
	    	<a class="menu1"><img src="resources/image/logo.png" alt="logo" class="logo"></a>
		    <a class="menu1">집사매칭</a>
		    <a class="menu1">이용후기</a>
		    <a class="menu1">고객센터</a>
		</div>
		<div id="right">
			    <a class="menu1"><img src="resources/image/profile.png" alt="profile" id="profile"></a>
			    <a class="menu2">name</a>
		    <div class="dropd" style="float:right; " aria-expanded="false">
		        <button onclick="dp_menu()" class="butn"><img src="resources/image/down.png"></button>
		        <div style="width: 230px; height: 305px;" id="drop-c">
		        	<ul id="droul">
			            <li><a class="name">NAME님</a></li>
			            <li><a class="animal" style="display: block; float:left;">고양이</a><a class="animal">시암</a></li>
			            <li><a class="animal">미돌이</a></li>
			            <li><a><hr></a></li>
			            <li><a class="myMenu">마이페이지</a></li>
			            <li><a class="myMenu">프로필 설정</a></li>
			            <li><a><button onclick="" id="logOut">로그아웃</button></a></li>
		            </ul>
		        </div>
	  	 	</div>
  	 	</div>
	</div>
	<hr id="top_hr2">
</header>
<script>
    let click = document.getElementById("drop-c");
	click.style.display = "none"

	const dp_menu=()=>{
	    if(click.style.display === "none"){
	        click.style.display = "block";
	    }else{
	        click.style.display = "none";
	    }
	}
	
</script>
</body>
</html>