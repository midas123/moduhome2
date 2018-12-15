<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>ModuHome 관리자페이지</title>
<!-- Bootstrap Core CSS -->
<link href="http://localhost:8080/ModuHome/resources/admincss/bootstrapadmin.min.css" rel="stylesheet" type="text/css">
<style type="text/css">
@media ( min-width :768px) {
	#page-wrapper {
		margin: 0 0 0 250px !important;
	}
}
</style>

<!-- Custom CSS -->
<link href="http://localhost:8080/ModuHome/resources/admincss/sb-admin-2.css" rel="stylesheet">
<!-- jQuery -->

<script src="http://localhost:8080/ModuHome/resources/admincss/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="http://localhost:8080/ModuHome/resources/admincss/bootstrap.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="http://localhost:8080/ModuHome/resources/admincss/sb-admin-2.js"></script>
</head>
<body>
	<div id="wrapper">
		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0; background-color: #85C8DD">
			<div class="navbar-header" style="background-color: #85C8DD">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> 
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" style="color: #fff;" href="/ModuHome/admin/adminPage"><strong>ModuHome 관리자페이지</strong></a>
			</div>
			<!-- /.navbar-header -->
			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						<li>
							<a href="/ModuHome/admin/adminPage" style="background: #85C8DD; border-bottom: 1px solid #F8F8F8;">
								<b class="fa fa-dashboard fa-fw">관리자홈</b>
							</a>
						</li>
						<li>
							<a href="/ModuHome/goods" style="background: #85C8DD; border-bottom: 1px solid #F8F8F8;">
								<b class="fa fa-dashboard fa-fw">쇼핑몰로 이동</b>
							</a>
						</li>
						<li class="active">
							<a href="#" style="background: #85C8DD;">
								<b class="fa fa-bar-chart-o fa-fw">상품관리</b>
								<span class="fa arrow">▼</span>
							</a>
							<ul class="nav nav-second-level">
								<li><a href="/ModuHome/admin/goodsList">- 상품목록</a></li>
								<li><a href="/ModuHome/admin/goodsInsertForm">- 상품등록</a></li>
							</ul>
						</li>
						<li class="active">
							<a href="#" style="background: #85C8DD;">
								<b class="fa fa-dashboard fa-fw">회원관리</b>
								<span class="fa arrow">▼</span>
							</a>
							<ul class="nav nav-second-level">
								<li><a href="/ModuHome/admin/memberList">- 회원목록</a></li>
							</ul> <!-- /.nav-second-level -->
						</li>

						<li class="active">
							<a href="#" style="background: #85C8DD;">
								<b class="fa fa-bar-chart-o fa-fw">주문관리</b>
								<span class="fa arrow">▼</span>
							</a>
							<ul class="nav nav-second-level">
								<li><a href="/ModuHome/admin/orderList">- 주문목록</a></li>
								<li><a href="/ModuHome/admin/cancelList">- 주문취소목록</a></li>
								<li><a href="/ModuHome/admin/exchangeList">- 교환/반품목록</a></li>
							</ul>
						</li>
						<li class="active">
							<a href="#" style="background: #85C8DD;">
								<b class="fa fa-bar-chart-o fa-fw">게시판관리</b>
								<span class="fa arrow">▼</span>
							</a>
							<ul class="nav nav-second-level">
								<li><a href="/ModuHome/admin/noticeList">- 공지사항</a></li>
								<li><a href="/ModuHome/admin/mglist">- 매거진</a></li>
								<li><a href="/ModuHome/admin/reviewAdmin">- 구매후기</a></li>
								<li><a href="/ModuHome/admin/faqList">- FAQ</a></li>
								<li><a href="/ModuHome/qna/adminQnaList">- Q&A</a></li>
								<li><a href="/ModuHome/policeList">- 신고</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
			<!-- /.navbar-static-side -->
		</nav>
		<div id="page-wrapper">
			<!-- 메인container-->
			<tiles:insertAttribute name="body" />
			<!-- // container -->
		</div>
		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->
</body>
</html>