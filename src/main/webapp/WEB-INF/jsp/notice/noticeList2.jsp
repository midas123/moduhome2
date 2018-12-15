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

    <section class="probootstrap-section probootstrap-bg-white" style="margin-top: 0px; padding: 0px;">
      <div class="container">
        <div class="row">
          <div class="col-md-2 probootstrap-animate"></div>

          <div class="col-md-8 probootstrap-animate">
            <form action="#" method="post" class="probootstrap-form">
<br>
              <table width="100%" style="margin-bottom: 30px;">
                <thead style="background-color: #85c8dd; color:#fff;">
                  <tr style="height: 40px" align="center">
                    <td width="10%" style="font-weight: bold">글번호</td>
                    <td width="45%" style="font-weight: bold">제목</td>
                    <td width="10%" style="font-weight: bold">조회수</td>
                    <td width="25%" style="font-weight: bold">작성일</td>                                                            
                  </tr>
                </thead>
                <tbody>
				<c:choose>
					<c:when test="${fn:length(noticeList) > 0 }">
						<c:forEach items="${noticeList }" var="noticeList">   
							<tr style="height: 40px" align="center">
			                    <td width="10%">${noticeList.NOTICE_NUMBER}</td>
			                    <td width="45%">
			                    	<a href="#this" name="NOTICE_TITLE">${noticeList.NOTICE_TITLE }</a>
									<input type="hidden" id="NOTICE_NUMBER" value="${noticeList.NOTICE_NUMBER }">
								</td>
			                    <td width="10%">${noticeList.NOTICE_HITCOUNT}</td> 	
			                    <td width="25%"><fmt:formatDate value="${noticeList.NOTICE_REGDATE}" pattern="yyyy.MM.dd" /></td>
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
			comSubmit.setUrl("<c:url value='/admin/noticeWriteForm'/>");
			comSubmit.submit();
		}
		
		function fn_openBoardDetail(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/admin/noticeDetail'/>");
			comSubmit.addParam("NOTICE_NUMBER", obj.parent().find("#NOTICE_NUMBER").val());
			comSubmit.submit();
		}
	
	</script>
	
</body>
</html>