<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="ko">
<head>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>
<style type="text/css">
#order-paging {
  padding-left: 10px;
  padding-right: 10px;
}
</style>
</head>
<body>

    <section class="flexslider">
      <ul class="slides">
        <li style="background-image: url(/ModuHome/style/img/notice.jpg)" class="overlay">
          <div class="container">
            <div class="row">
              <div class="col-md-8 col-md-offset-2">
                <div class="probootstrap-slider-text text-center">
                  <h1 class="probootstrap-heading" style="font-size: 60px;"><span><strong>공지사항</strong></span></h1>
                </div>
              </div>
            </div>
          </div>
        </li>
      </ul>
    </section>	
	
	

    <section class="probootstrap-section probootstrap-bg-white">
      <div class="container">
        <div class="row" align="center">
          <br><span style="font-size: 45px;">고객센터</span><p>
          <br><span style="font-size: 15px;">기분 좋은 쇼핑, 모두의집이 도와드릴게요</span><p>
        </div>
        <div class="row">
          <div class="col-md-5 probootstrap-animate" style="border: 1px solid #999999; margin-left: 72px; margin-right: 25px; height: 170px;">
            <ul style="list-style: none; padding: 15px 0px 0px 0px; margin:0px;">
				<span>인테리어 소품 구매 처음이신가요?<br></span>
				<span>주문, 배송, 상품, 교환, 환불 관련한 질문들이 궁금하다면<br></span>
				<p>&nbsp;
            </ul>
            <div align="right" ><a href="/ModuHome/faqList">자주묻는질문 보러가기</a></div>
          </div>

          <div class="col-md-5 probootstrap-animate" style="border: 1px solid #999999; margin-left: 25px; margin-right: 73px; height: 170px; padding-top: 13px; ">
            <div class="col-md-5 probootstrap-animate">
              <img src="/ModuHome/style/img/scenter_q.png" style="width: 100px; margin-top: 19px; ">
            </div>
            <div class="col-md-7 probootstrap-animate">
              <span style="font-size: 15px; font-weight: 600;">CUSTOMER CENTER</span>
              <br><span style="font-size: 26px; font-weight: 600;">1224-1224</span>
              <br><span style="color: #131313;">평일</span><span>&nbsp;&nbsp;AM 10:00~ PM 17:00</span>
              <br><span style="color: #131313;">점심</span><span>&nbsp;&nbsp;AM 12:00~ PM 13:00</span>
              <br><span style="color: #131313;">휴무</span><span>&nbsp;&nbsp;주말 및 공휴일 휴무</span>
            </div>
       	  </div>
	    </div>
      </div> 
    </section>

    <section class="probootstrap-section probootstrap-bg-white" style="margin-top: 0px; padding: 0px;">
      <div class="container">
        <div class="row">
          <div class="col-md-2 probootstrap-animate"></div>

          <div class="col-md-8 probootstrap-animate">
            <form action="#" method="post" class="probootstrap-form">

              <table width="100%" style="margin-bottom: 30px;">
                <thead style="background-color: #85c8dd; color:#fff;">
                  <tr style="height: 40px" align="center">
                    <td width="10%" style="font-weight: bold">글번호</td>
                    <td width="58%" style="font-weight: bold">제목</td>
                    <td width="7%" style="font-weight: bold">조회수</td>
                    <td width="15%" style="font-weight: bold">작성일</td>                                                            
                  </tr>
                </thead>
                <tbody>
				<c:choose>
					<c:when test="${fn:length(noticeList) > 0 }">
						<c:forEach items="${noticeList }" var="noticeList">   
							<tr style="height: 40px" align="center">
			                    <td width="10%">${noticeList.NOTICE_NUMBER}</td>
			                    <td width="58%">
			                    	<a href="#this" name="NOTICE_TITLE">${noticeList.NOTICE_TITLE }</a>
									<input type="hidden" id="NOTICE_NUMBER" value="${noticeList.NOTICE_NUMBER }">
								</td>
			                    <td width="7%">${noticeList.NOTICE_HITCOUNT}</td> 	
			                    <td width="15%"><fmt:formatDate value="${noticeList.NOTICE_REGDATE}" pattern="yyyy.MM.dd" /></td>
	                  		</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4" align="center">조회된 결과가 없습니다</td>
						</tr>
					</c:otherwise>			
				</c:choose>		
                </tbody>     
              </table>

              <table align="center">
                <tr>
                <c:if test="${sessionScope.MEMBER_ADMIN eq 1}">
                  <td><input type="button" class="btn btn-primary btn-lg" id="write" name="#this" value="글쓰기"></td>
                </c:if> 
                </tr>
              </table>
            </form>
            
            <!-- 페이징 모양만 -->
              <div align="center" style="margin-top: 50px; margin-bottom: 50px;">
                <table align="center">
                  <a href="#" id="order-paging"><img src="/ModuHome/style/img/arrll.png"></a>
                  <a href="#" id="order-paging"><img src="/ModuHome/style/img/arrl.png"></a>
                  <a href="#" id="order-paging">1</a>
                  <a href="#" id="order-paging">2</a>
                  <a href="#" id="order-paging">3</a>
                  <a href="#" id="order-paging">4</a>
                  <a href="#" id="order-paging">5</a>
                  <a href="#" id="order-paging"><img src="/ModuHome/style/img/arrr.png"></a>
                  <a href="#" id="order-paging"><img src="/ModuHome/style/img/arrrr.png"></a>
                </table>
              </div>            
            
          </div>

          <div class="col-md-2 probootstrap-animate"></div>

        </div>
      </div>
    </section>  	
	
	
<form id="commonForm" name="commonForm"></form>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#write").on("click", function(e){
				e.preventDefault();
				fn_openBoardWrite();
			});
			
			$("a[name='NOTICE_TITLE']").on("click", function(e){
				e.preventDefault();
				fn_openBoardDetail($(this));
			});
		});
		
		function fn_openBoardWrite() {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/noticeWriteForm'/>");
			comSubmit.submit();
		}
		
		function fn_openBoardDetail(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/noticeDetail'/>");
			comSubmit.addParam("NOTICE_NUMBER", obj.parent().find("#NOTICE_NUMBER").val());
			comSubmit.submit();
		}
	
	</script>
	
</body>
</html>