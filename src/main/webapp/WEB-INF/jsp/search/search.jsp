<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>검색</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Free Bootstrap Theme by uicookies.com">
<meta name="keywords"
	content="free website templates, free bootstrap themes, free template, free bootstrap, free website template">
<link href="https://fonts.googleapis.com/css?family=Bellefair|Open+Sans"
	rel="stylesheet">
<link rel="stylesheet" href="/ModuHome/style/css/styles-merged.css">
<link rel="stylesheet" href="/ModuHome/style/css/style.min.css">
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
        	<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          		<div class="col-md-2 probootstrap-animate"></div>

          		<div class="col-md-8 probootstrap-animate" style="margin:200px 0px 0px 0px;">
            		<div class="col-md-12" >
						<div class="col-md-6 text-center"><h1>검색결과</h1></div>
						<div class="col-md-6 text-right" style="margin:30px 0px 0px 0px;"><input type="button"  onclick="location.href='searchForm'" class="btn btn-primary btn-lg" id="write"  value="재검색"></div>
					</div>
				</div>
				
				<div class="col-md-2 probootstrap-animate"></div>
			</div>
		</div>
	</div>
</section>



	<section class="probootstrap-section probootstrap-bg-white" >
		<div class="container" >
    		<div class="row">
    		
				<c:forEach items="${memberSearch}" var="memberSearch" >
					<c:url var="memberURL" value="myHome">
						<c:param name="MEMBER_NUMBER" value="${memberSearch.MEMBER_NUMBER}" />          
					</c:url>
					
					<c:if test="${fn:contains(memberSearch.MEMBER_ID, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
							<h2>[회원] 검색결과 &nbsp;&nbsp;<a href="${memberURL}"><strong>${memberSearch.MEMBER_ID}</strong></a></h2>
          			</div>
				</div>
					</c:if>
				</c:forEach>
				
				
				<c:forEach items="${mgSearch}" var="mgSearch" >
					<c:url var="mgURL" value="mgDetail">
						<c:param name="MG_NUMBER" value="${mgSearch.MG_NUMBER}" />  
						<c:param name="MEMBER_NUMBER" value="${sessionScope.MEMBER_NUMBER}" />          
					</c:url>
					
					<c:if test="${fn:contains(mgSearch.MG_TITLE, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
	    					<h2>[매거진] 검색결과 &nbsp;&nbsp;<a href="${mgURL}"><strong>${mgSearch.MG_TITLE}</strong></a></h2>
          			</div>
          			
				</div>
					</c:if>
					
					<c:if test="${fn:contains(mgSearch.MG_CONTENT, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
	    					<h2>[매거진] 검색결과 &nbsp;&nbsp;<a href="${mgURL}"><strong>${mgSearch.MG_TITLE}</strong></a></h2>
          			</div>
          			
				</div>
					</c:if>
										
					<c:if test="${fn:contains(mgSearch.MG_TYPE, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
	    					<h2>[매거진] 검색결과 &nbsp;&nbsp;<a href="${mgURL}"><strong>${mgSearch.MG_TITLE}</strong></a></h2>
          			</div>
          			
				</div>
					</c:if>
					
					<c:if test="${fn:contains(mgSearch.MG_STYLE, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
	    					<h2>[매거진] 검색결과 &nbsp;&nbsp;<a href="${mgURL}"><strong>${mgSearch.MG_TITLE}</strong></a></h2>
          			</div>
          			
				</div>
					</c:if>
					
					<c:if test="${fn:contains(mgSearch.MG_SPACE, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
	    					<h2>[매거진] 검색결과 &nbsp;&nbsp;<a href="${mgURL}"><strong>${mgSearch.MG_TITLE}</strong></a></h2>
          			</div>
          			
				</div>
					</c:if>

					<c:if test="${fn:contains(mgSearch.MG_AVERAGE, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
	    					<h2>[매거진] 검색결과 &nbsp;&nbsp;<a href="${mgURL}"><strong>${mgSearch.MG_TITLE}</strong></a></h2>
          			</div>
          			
				</div>
					</c:if>					
				</c:forEach>


				<c:forEach items="${goodsSearch}" var="goodsSearch" >

					<c:url var="goodsURL" value="/goods/detail?GOODS_NUMBER=${goodsSearch.GOODS_NUMBER}" />
					
					<c:if test="${fn:contains(goodsSearch.GOODS_NAME, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
							<h2>[상품] 검색결과&nbsp;&nbsp;<a href="${goodsURL}"><strong>${goodsSearch.GOODS_NAME}</strong></a></h2>
          			</div>
				</div>
					</c:if>
					
					<c:if test="${fn:contains(goodsSearch.GOODS_CATEGORY1, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
							<h2>[상품] 검색결과 &nbsp;&nbsp;<a href="${goodsURL}"><strong>${goodsSearch.GOODS_NAME}</strong></a></h2>
          			</div>
				</div>
					</c:if>

					<c:if test="${fn:contains(goodsSearch.GOODS_CATEGORY2, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
							<h2>[상품] 검색결과 &nbsp;&nbsp;<a href="${goodsURL}"><strong>${goodsSearch.GOODS_NAME}</strong></a></h2>
          			</div>
				</div>
					</c:if>						

					<c:if test="${fn:contains(goodsSearch.GOODS_BRNAME, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
							<h2>[상품] 검색결과 &nbsp;&nbsp;<a href="${goodsURL}"><strong>${goodsSearch.GOODS_NAME}</strong></a></h2>
          			</div>
				</div>
					</c:if>	
					
				</c:forEach>
				
				<c:forEach items="${noticeSearch}" var="noticeSearch" >
					<c:url var="noticeURL" value="noticeDetail">
						<c:param name="NOTICE_NUMBER" value="${noticeSearch.NOTICE_NUMBER}" />          
					</c:url>
					
					<c:if test="${fn:contains(noticeSearch.NOTICE_TITLE, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
							<h2>[공지사항] 검색결과&nbsp;&nbsp;<a href="${noticeURL}"><strong>${noticeSearch.NOTICE_TITLE}</strong></a></h2>
          			</div>
				</div>
					</c:if>
					
					<c:if test="${fn:contains(noticeSearch.NOTICE_CONTENT, isSearch)}">
        		<div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
          			<div class="col-md-2 probootstrap-animate"></div>
          			<div class="col-md-10 probootstrap-animate text-left">
							<h2>[공지사항] 검색결과 &nbsp;&nbsp;<a href="${noticeURL}"><strong>${noticeSearch.NOTICE_TITLE}</strong></a></h2>
          			</div>
				</div>
					</c:if>					
					
				</c:forEach>				
				
			</div>
		</div>
	</section>
	
	<section class="probootstrap-section probootstrap-bg-white" style="margin:100px 0px 00px 0px;">
	</section>
	







<%-- 
회원 검색결과:<br/>
<c:forEach items="${memberSearch}" var="memberSearch" >

		<c:url var="memberURL" value="myHome">
			<c:param name="MEMBER_NUMBER" value="${memberSearch.MEMBER_NUMBER}" />          
		</c:url>

		<c:if test="${fn:contains(memberSearch.MEMBER_ID, isSearch)}">
			결과: <td><a href="${memberURL}">${memberSearch.MEMBER_ID}</a></td>
	     	넘버: <td>${memberSearch.MEMBER_NUMBER}</td> <br/>
        </c:if>
		

</c:forEach> --%>

       
</body>
</html>