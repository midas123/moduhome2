<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/ModuHome/style/js/scripts.min.js"></script>
 <script src="/ModuHome/style/js/custom.min.js"></script>
<style>
.img-responsive {
	display: block;
	/* max-width: 100%; */
	height: 300px;
	width: 300px;
}

.storemain-top {
	margin-top: 60px;
}

.commerce-menu {
	width: 100%;
	text-align: center;
	background-color: #f9f9f9;
	margin-right: 0 !important;
}

.commerce-menu ul li a {
	padding: 0 35px !important;
	font-weight: 500;
	color: black;
}

.commerce-menu ul li {
	display: inline;
	float: left;
}

.commerce-menu {
	min-width: 1150px;
}

.commerce-menu ul li a:hover{
	color: #85C8DD;
	font-weight: bold;
	border-bottom: 1px solid #85C8DD;
	border-bottom-width: 2px;
}

body #main-slider-bg{
background: white; !important;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<div class="storemain-top" style="margin-top: 0px;">
		<section class="flexslider" id="main-slider-bg">
			<ul class="slides">
				<li
					style="background-image: url(/ModuHome/images/storeMain/20180827storemain2.jpeg); width: auto; height: 600px;">
				</li>
				<li
					style="background-image: url(/ModuHome/images/storeMain/20180827storemain3.jpeg); width: auto; height: 600px;">
				</li>
				<li
					style="background-image: url(/ModuHome/images/storeMain/20180827storemain4.jpeg); width: auto; height: 600px;">
				</li>
			</ul>
		</section>
	</div>
	<section class="probootstrap-section probootstrap-bg-white">
		<div class="container">
				<div class="commerce-menu" style="display:inline-block; background: white; margin-bottom:30px;" >
					<div class="col-md-8 col-md-offset-2">
					<div class="col-md-2" ><a href="/ModuHome/goods/category?CATEGORY=전체" style="color: black;">전체상품</a></div>
					<c:forEach items="${mainCategory}" var="mainCategory" varStatus="status">
					<div class="col-md-2" ><a href="/ModuHome/goods/category?CATEGORY=${mainCategory}" style="color: black;">${mainCategory}</a></div>
					</c:forEach>
					</div> 
	
				</div>
			<div class="row">
				<div class="commerce-title">
				<font size="3" style="font-family: Open Sans, Arial, sans-serif; color:black; margin-left: 140px;">신상품<!--  <a href="/ModuHome/goods/category?CATEGORY=전체&fromMain=1" style="color: black; float: right; font-weight: 500; font-size: 16px; margin-top: 25px; margin-right: 80px; cursor: pointer;">전체보기></a> -->
					</font>
					<hr align="center" style="width:75%;">
				</div>
			</div>
			<div class="row" style="width:80%; margin:0 auto;">
				<c:forEach items="${newItem}" var="newItem" begin="0"
					varStatus="status" end="5">
					<c:url var="goodsUrl"
						value="/goods/detail?GOODS_NUMBER=${newItem.GOODS_NUMBER}" />
					<div class="col-md-4 probootstrap-animate">
						<a href="${goodsUrl}"><img
							src="/ModuHome/images/goods/${newItem.GOODS_THUMBNAIL}"
							alt="Free Bootstrap Template by uicookies.com"
							class="img-responsive"></a>
						<div class="name" style="width:275px; display: inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color:#85C8DD;">
							<a href="${goodsUrl}">${newItem.GOODS_NAME}</a>
						</div>
						<div>
							<del>
								<span class="price_original"><fmt:formatNumber
										value="${newItem.GOODS_PRICE}" /></span>
							</del>
							원
						</div>
						<span class="price_discount"><fmt:formatNumber
								value="${newItem.GOODS_DISPRICE}" /></span> <span class="unit">원</span><span>(<fmt:formatNumber
								value="${(newItem.GOODS_PRICE - newItem.GOODS_DISPRICE)*100 / newItem.GOODS_PRICE}"
								type="number" />%)
						</span>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<section class="probootstrap-section probootstrap-bg-white">
		<div class="container">
			<div class="row">
				<div class="commerce-title">
				<font size="3" style="font-family: Open Sans, Arial, sans-serif; color:black; margin-left: 140px;">인기 상품<!--  <a href="/ModuHome/goods/category?CATEGORY=전체&fromMain=2" style="color: black; float: right; font-weight: 500; font-size: 16px; margin-top: 25px; margin-right: 80px; cursor: pointer;">전체보기></a> -->
					</font>
					<hr align="center" style="width:75%;">
				</div>
				
			</div>
			<!-- END row -->
			<%-- <c:forEach items="${sellBestItem}" var="sellBest" begin="0" varStatus="status" end="${fn:length(sellBestItem)}"> --%>
			<div class="row" style="width:80%;margin:0 auto;">
				<c:forEach items="${sellBestItem}" var="sellBest" begin="0"
					varStatus="status" end="5">
					<c:url var="goodsUrl"
						value="/goods/detail?GOODS_NUMBER=${sellBest.GOODS_NUMBER}" />
					<div class="col-md-4 probootstrap-animate">
						<a href="${goodsUrl}"><img
							src="/ModuHome/images/goods/${sellBest.GOODS_THUMBNAIL}"
							alt="Free Bootstrap Template by uicookies.com"
							class="img-responsive"></a>
						<div class="name" style="width:300px; display: inline-block; white-space: nowrap; overflow: hidden; color:#85C8DD;">
							<a href="${goodsUrl}">${sellBest.GOODS_NAME}</a>
						</div>
						<div>
							<del>
								<span class="price_original"><fmt:formatNumber
										value="${sellBest.GOODS_PRICE}" /></span>
							</del>
							원
						</div>
						<span class="price_discount"><fmt:formatNumber
								value="${sellBest.GOODS_DISPRICE}" /></span> <span class="unit">원</span><span>(<fmt:formatNumber
								value="${(sellBest.GOODS_PRICE - sellBest.GOODS_DISPRICE)*100 / sellBest.GOODS_PRICE}"
								type="number" />%)
						</span>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>
	
</html>