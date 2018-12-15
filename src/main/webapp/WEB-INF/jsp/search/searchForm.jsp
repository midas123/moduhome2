<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>통합검색</title>

   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Free Bootstrap Theme by uicookies.com">
<meta name="keywords"
	content="free website templates, free bootstrap themes, free template, free bootstrap, free website template">
<link href="https://fonts.googleapis.com/css?family=Bellefair|Open+Sans"
	rel="stylesheet">
<link rel="stylesheet" href="/ModuHome/style/css/styles-merged.css">
<link rel="stylesheet" href="/ModuHome/style/css/style.min.css">

 <!--  <script src="/ModuHome/search/js/scripts.min.js"></script>
  <script src="/ModuHome/search/js/main.min.js"></script>
  <script src="/ModuHome/search/js/custom.js"></script> -->

</head>
<body>

<section class="flexslider">
      <ul class="slides">
        <li style="background-image: url(/ModuHome/style/img/search.jpg)" class="overlay">
          <div class="container">
            <div class="row">
              <div class="col-md-8 col-md-offset-2">
              
                <div class="probootstrap-slider-text text-center" style=" margin-top:300px;">
                  <h1 class="probootstrap-heading" style="font-size: 60px;"><span><strong>검색</strong></span></h1>
                </div>
         
              </div>
            </div>
          </div>
        </li>
      </ul>
</section>

	  <section class="probootstrap-section probootstrap-bg-white">
      <div class="container" >
        <div class="row">
        		<div
				class="col-md-12 text-center section-heading probootstrap-animate"
				data-animate-effect="fadeIn">
          <div class="col-md-3 probootstrap-animate"></div>

          <div class="col-md-6 probootstrap-animate" style="margin:200px 0px 200px 0px;">
            <form name="search" action="totalSearch" method="post">
				<div class="col-md-12 text-left" style="font-size:40px; color:#212121; margin-bottom:10px;" >
					<font face='돋움'>통합검색</font>
				</div>
               
               <div class="col-md-10">
                    <c:if test="${MEMBER_NUMBER ne null }">		
						<input type="hidden" id="member_number" name="MEMBER_NUMBER" value="${MEMBER_NUMBER}">
					</c:if>
                  <input type="text" style=" width:420px; height:60px;" id="issearch" name="ISSEARCH" class="form-control" placeholder="아이디, 매거진, 상품, 게시판">
               </div>
                
                <div class="col-md-2" style="margin-top:10px;">
                	<input type="submit" class="btn btn-primary btn-lg"  style="margin-bottom:30px;" id="write"  value="찾기">
                </div>
              
              
          
            </form>
                       
           	
            <div class="col-md-12 text-center" style="padding:20px;">
            
            <c:if test="${MEMBER_ID ne null}">	
            	<strong>${MEMBER_ID}의 최근 검색어</strong>
            </c:if>
            </div>
            
            <c:if test="${MEMBER_NUMBER ne null}">
          		<c:forEach items="${recentSearch}" var="recentSearch" >
            <div class="col-md-4 text-center">
            		<c:if test="${recentSearch.MEMBER_NUMBER eq MEMBER_NUMBER }">
						${recentSearch.SEARCH_RECENT}
        			</c:if>
            </div>
            	</c:forEach>
            </c:if>
          
          </div>

          <div class="col-md-3 probootstrap-animate"></div>
			</div>
        </div>
      </div>
    </section>   

</body>
</html>