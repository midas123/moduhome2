<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  


<!DOCTYPE html>
<html lang="ko">
<head>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>

<style type="text/css">
  .tab-content2 > div {display:none;}
  .tab-content2 > div.active {display:block;}

  .tab ul {
    border :1px solid #ebebeb;
    padding: 0px;
  }
  .tab ul li {
    list-style: none;
    float: left;
    text-align:center;
    border-top: 1px solid #ebebeb;
    border-right: 1px solid #ebebeb; 
    background-color: #f7f7f7;
    border-bottom: 2px solid #ebebeb; 
    width: 12.5%;
  }
  
  .tab ul li:first-child {
  border-left: 1px solid #ebebeb;
  }
  
  .tab_li a {
  	color: #85c8dd;
  }
  
  .tab_li.active {
    background-color: #85c8dd;
  }  
  
  .tab_li.active a {
    color: #fff;  
  }
  
  .faq ul {
    border :1px solid #ebebeb;
    padding: 0px;
  }

  .faq ul li {
    list-style: none;
  }

  .faq ul li.list {
    border-bottom: 1px solid #f0f0f0;
  }

  .faq ul li span{
    color: #474747;
    font-weight: bold;
  }

  .db_title {
    /*border: 1px solid;*/
    padding: 6px 10px 6px 35px;
  }

  .db_detail {
    padding: 6px 10px 6px 35px; 
    border-top:1px dashed #bcbcbc;
    background-color: #f0f0f0;
  }

  .db_title:hover {
    background-color: #85c8dd;
  }
</style>

</head>
<body>

    <section class="flexslider">
      <ul class="slides">
        <li style="background-image: url(/ModuHome/style/img/faq.jpg)" class="overlay">
          <div class="container">
            <div class="row">
              <div class="col-md-8 col-md-offset-2">
                <div class="probootstrap-slider-text text-center">
                 <h1 class="probootstrap-heading" style="font-size: 60px;"><span><strong>고객의소리</strong></span></h1>
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
            
            <form action="#" method="post" class="probootstrap-form">
            <ul style="list-style: none; padding: 15px 0px 0px 0px; margin:0px;">
	            <c:forEach items="${noticeList }" var="noticeList" begin="0" end="3" >
	              <li>
	              	<a href="#this" name="NOTICE_TITLE">${noticeList.NOTICE_TITLE }</a>
	             	<input type="hidden" id="NOTICE_NUMBER" value="${noticeList.NOTICE_NUMBER }">
	              </li>
	            </c:forEach>
            </ul>
            </form>
            <div align="right" ><a href="/ModuHome/noticeList">더보기</a></div>
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
          
            <div align="center" style="margin-bottom: 15px;"><span style="font-size: 20px;">자주 묻는 질문</span></div>
            <form id="frm">
            
            
              <div class="tab">
                <ul class="tab-navs">
                  <li class="tab_li active" data-cate="1"><a href="" data-toggle="tab">주문/결제</a></li>
                  <li class="tab_li" data-cate="2"><a href="#faq-tab2" data-toggle="tab">변경/취소</a></li>
                  <li class="tab_li" data-cate="3"><a href="#faq-tab3" role="tab" data-toggle="tab">상품</a></li>
                  <li class="tab_li" data-cate="4"><a href="#faq-tab4" data-toggle="tab">배송/변경</a></li>
                  <li class="tab_li" data-cate="5"><a href="#faq-tab5" data-toggle="tab">교환/반품</a></li>
                  <li class="tab_li" data-cate="6"><a href="#faq-tab6" data-toggle="tab">환불</a></li>
                  <li class="tab_li" data-cate="7"><a href="#faq-tab7" data-toggle="tab">회원관련</a></li>
                  <li class="tab_li" data-cate="8"><a href="#faq-tab8" data-toggle="tab">기타</a></li>
                </ul>
              </div>
             <!--  <div>&nbsp;</div> -->

			<div class="tab-content2">
			
			<!--1. 주문/결제 -->
              <div class="faq active" id="faq-tab1">
                <ul>
					<c:choose>
						<c:when test="${fn:length(faqList) > 0 }">
							<c:forEach items="${faqList }" var="faqList">
							<c:if test="${faqList.FAQ_CATEGORY eq 1}">
			                  <li id="faq" class="list db_select">
			                    <div class="db_title">
			                      <span>Q.&nbsp;&nbsp;</span>
			                     	${faqList.FAQ_TITLE}	
			                    </div>
			                    <div class="db_detail" style="display: none;">
			                      <p>A.&nbsp;&nbsp;${faqList.FAQ_CONTENT }</p>
			                    </div>
			                  </li>
			                </c:if>  
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><td colspan="4">조회된 결과가 없습니다</td></tr>
						</c:otherwise>			
					</c:choose>
                </ul>
              </div>
              
			<!--2. 변경/취소 -->
              <div class="faq" id="faq-tab2">
                <ul>
					<c:choose>
						<c:when test="${fn:length(faqList) > 0 }">
							<c:forEach items="${faqList }" var="faqList">
							<c:if test="${faqList.FAQ_CATEGORY eq 2}">
			                  <li id="faq" class="list db_select">
			                    <div class="db_title">
			                      <span>Q.&nbsp;&nbsp;</span>
			                     	${faqList.FAQ_TITLE}	
			                    </div>
			                    <div class="db_detail" style="display: none;">
			                      <p>A.&nbsp;&nbsp;${faqList.FAQ_CONTENT }</p>
			                    </div>
			                  </li>
			                </c:if>  
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><td colspan="4">조회된 결과가 없습니다</td></tr>
						</c:otherwise>			
					</c:choose>
                </ul>
              </div>              

			<!--3. 상품 -->
              <div class="faq" id="faq-tab3">
                <ul>
					<c:choose>
						<c:when test="${fn:length(faqList) > 0 }">
							<c:forEach items="${faqList }" var="faqList">
							<c:if test="${faqList.FAQ_CATEGORY eq 3}">
			                  <li id="faq" class="list db_select">
			                    <div class="db_title">
			                      <span>Q.&nbsp;&nbsp;</span>
			                     	${faqList.FAQ_TITLE}	
			                    </div>
			                    <div class="db_detail" style="display: none;">
			                      <p>A.&nbsp;&nbsp;${faqList.FAQ_CONTENT }</p>
			                    </div>
			                  </li>
			                </c:if>  
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><td colspan="4">조회된 결과가 없습니다</td></tr>
						</c:otherwise>			
					</c:choose>
                </ul>
              </div>
              
			<!--4. 배송 -->
              <div class="faq" id="faq-tab4">
                <ul>
					<c:choose>
						<c:when test="${fn:length(faqList) > 0 }">
							<c:forEach items="${faqList }" var="faqList">
							<c:if test="${faqList.FAQ_CATEGORY eq 4}">
			                  <li id="faq" class="list db_select">
			                    <div class="db_title">
			                      <span>Q.&nbsp;&nbsp;</span>
			                     	${faqList.FAQ_TITLE}	
			                    </div>
			                    <div class="db_detail" style="display: none;">
			                      <p>A.&nbsp;&nbsp;${faqList.FAQ_CONTENT }</p>
			                    </div>
			                  </li>
			                </c:if>  
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><td colspan="4">조회된 결과가 없습니다</td></tr>
						</c:otherwise>			
					</c:choose>
                </ul>
              </div>  
              
 			<!--5. 교환/반품 -->
              <div class="faq" id="faq-tab5">
                <ul>
					<c:choose>
						<c:when test="${fn:length(faqList) > 0 }">
							<c:forEach items="${faqList }" var="faqList">
							<c:if test="${faqList.FAQ_CATEGORY eq 5}">
			                  <li id="faq" class="list db_select">
			                    <div class="db_title">
			                      <span>Q.&nbsp;&nbsp;</span>
			                     	${faqList.FAQ_TITLE}	
			                    </div>
			                    <div class="db_detail" style="display: none;">
			                      <p>A.&nbsp;&nbsp;${faqList.FAQ_CONTENT }</p>
			                    </div>
			                  </li>
			                </c:if>  
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><td colspan="4">조회된 결과가 없습니다</td></tr>
						</c:otherwise>			
					</c:choose>
                </ul>
              </div>  
              
 			<!--6. 환불 -->
              <div class="faq" id="faq-tab6">
                <ul>
					<c:choose>
						<c:when test="${fn:length(faqList) > 0 }">
							<c:forEach items="${faqList }" var="faqList">
							<c:if test="${faqList.FAQ_CATEGORY eq 6}">
			                  <li id="faq" class="list db_select">
			                    <div class="db_title">
			                      <span>Q.&nbsp;&nbsp;</span>
			                     	${faqList.FAQ_TITLE}	
			                    </div>
			                    <div class="db_detail" style="display: none;">
			                      <p>A.&nbsp;&nbsp;${faqList.FAQ_CONTENT }</p>
			                    </div>
			                  </li>
			                </c:if>  
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><td colspan="4">조회된 결과가 없습니다</td></tr>
						</c:otherwise>			
					</c:choose>
                </ul>
              </div>    
              
			<!--7. 회원관련 -->
              <div class="faq" id="faq-tab7">
                <ul>
					<c:choose>
						<c:when test="${fn:length(faqList) > 0 }">
							<c:forEach items="${faqList }" var="faqList">
							<c:if test="${faqList.FAQ_CATEGORY eq 7}">
			                  <li id="faq" class="list db_select">
			                    <div class="db_title">
			                      <span>Q.&nbsp;&nbsp;</span>
			                     	${faqList.FAQ_TITLE}	
			                    </div>
			                    <div class="db_detail" style="display: none;">
			                      <p>A.&nbsp;&nbsp;${faqList.FAQ_CONTENT }</p>
			                    </div>
			                  </li>
			                </c:if>  
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><td colspan="4">조회된 결과가 없습니다</td></tr>
						</c:otherwise>			
					</c:choose>
                </ul>
              </div>                                                        

			<!--8. 기타 -->
              <div class="faq" id="faq-tab8">
                <ul>
					<c:choose>
						<c:when test="${fn:length(faqList) > 0 }">
							<c:forEach items="${faqList }" var="faqList">
							<c:if test="${faqList.FAQ_CATEGORY eq 8}">
			                  <li id="faq" class="list db_select">
			                    <div class="db_title">
			                      <span>Q.&nbsp;&nbsp;</span>
			                     	${faqList.FAQ_TITLE}	
			                    </div>
			                    <div class="db_detail" style="display: none;">
			                      <p>A.&nbsp;&nbsp;${faqList.FAQ_CONTENT }</p>
			                    </div>
			                  </li>
			                </c:if>  
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><td colspan="4">조회된 결과가 없습니다</td></tr>
						</c:otherwise>			
					</c:choose>
                </ul>
              </div>  
              
           </div>   
              
              

              <table align="center">
                <tr>
                <c:if test="${sessionScope.MEMBER_ADMIN eq 1}">
                  <td><input type="button" class="btn btn-primary btn-lg" id="write" name="#this" value="글쓰기"></td>
                </c:if>
                </tr>
              </table>
            </form>
          </div>

          <div class="col-md-2 probootstrap-animate"></div>

          <div class="col-md-12 probootstrap-animate" style="margin-bottom: 100px; "></div>
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
			comSubmit.setUrl("<c:url value='/faqWriteForm'/>");
			comSubmit.submit();
		}
		
		function fn_openBoardDetail(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/noticeDetail'/>");
			comSubmit.addParam("NOTICE_NUMBER", obj.parent().find("#NOTICE_NUMBER").val());
			alert( obj.parent().find("#NOTICE_NUMBER").val());
			comSubmit.submit();
		}			
		
</script>
<script>
//리스트 클릭을 하면 창이 아래로 내려오는 jquery
$(".faq .db_title").click(function(){
	$(".faq .db_detail").slideUp(200);
	if ($(this).next().css("display")=="block") return;
	$(this).next().slideDown(200);
});

//탭메뉴 전환에 쓰이는 jquery
$(".tab-navs li").click(function(){
	$(".tab-navs li").removeClass("active");
	$(this).addClass("active");	

	$(".tab-content2>div").hide();
	var cate = $(this).data("cate");
	$("#faq-tab" + cate).show();
});

</script>

</body>
</html>