<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> <head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
<meta charset="UTF-8"/> 
<!-- IE Condition Where Breaking CSS --> 
<meta name="viewport" content="width=1000"/> 
<title>모두의 집</title> 
<script type="text/javascript" src="//cdn.ggumim.co.kr/resource/house_interior_web/ggumim.stack-1.1.84.min.js"></script> 
<link type="text/css" rel="stylesheet" href="/ModuHome/css/store/ggumim-1.1.86.min.css"/>
<style type="text/css">
#searchimage {
	position:relative;
	top: 17px;
	height:21px; 
	width:23px; 
}
#searchframe {
	position:relative;
	height:30px; 
	width:100px;
	right: 10px;
 	border-bottom: 2px solid lightgrey;
     border-top-style: none;
    border-right-style: none;
    border-left-style: none; 
    background-color:transparent;
}
#cartimage {
	position:relative;
	top: 17px;
	height:21px; 
	width:23px; 
}
</style>
</head> 
<body class="body-gray"> 
<div class="head head-fixed"> 
<div class="head-bar head-bar-white"> 
<div class="navigation">
 
<div style="position:absolute;left:200px;"> <a href="/">
<div class="logo"> 
<img src="//cdn.ggumim.co.kr/resource/icons/svg_pc_main_logo.svg" alt="집꾸미기"> 
</div></a></div>


<div style="position: absolute;right:30px;"> 
<ul> 
<li> 

<!-- 검색창 -->
<form action="/ModuHome/goods/search" method="post">
<input type="search" name="isSearch" id="searchframe" size="10">
<input type="image" class="search_btn" id="searchimage" src="/ModuHome/theme/i_pc_search.png" alt="검색">
</form>   
<!-- 검색창 end-->	            		
		            		
</li>
<li>
<a href="/commerce/cart"> 
<img src="/ModuHome/theme/i_pc_cart.png" id="cartimage"/></a>
</li>
 
<li> <a href="/member/order_nonmember/"> 주문조회 </a> </li> 
<li> <a href="#" onclick="location.href='/login/';" style="padding-top: 2px;"> 
<div class="login-btn" style="background-color: #999999;"> 로그인/회원가입 </div> </a> 
</li></ul> </div></div></div></div>

</body>



</html>
