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
	.a   {
		background-color: #85c8dd; color:#fff;
		text-align: center;
	}
	.b{
		background-color: #ebebeb; 
		text-align: center;
	}
</style>

</head>
<body>



    <section class="probootstrap-section probootstrap-bg-white">
      <div class="container">
        <div class="row">
          <div class="col-md-2 probootstrap-animate"></div>

          <div class="col-md-8 probootstrap-animate">
            <form action="#" method="post" class="probootstrap-form">
            <Br>



              <table width="100%">
                  <tr style="height: 40px">
                    <td width="15%" class="a">글번호</td>
                    <td width="35%" class="b">${map.NOTICE_NUMBER }</td>
                    <td width="15%" class="a">조회수</td>
                    <td width="35%" class="b">${map.NOTICE_HITCOUNT }</td>                                                            
                  </tr>
                  <tr style="height: 40px">
                    <td width="15%" class="a">작성자</td>
                    <td width="35%" class="b">관리자</td>
                    <td width="15%" class="a">작성일</td>
                    <td width="35%" class="b">${map.NOTICE_REGDATE }</td>                                                            
                  </tr>
              </table>
              <table width="100%">
                <tr style="height: 40px">
                  <td width="15%" class="a">제목</td>
                  <td width="85%" class="b">${map.NOTICE_TITLE }</td>
                </tr>

                <tr>
                  <td colspan="2">
                    <div style="margin: 30px 0px 30px 0px;" >
                      <p>${map.NOTICE_CONTENT }</p>
                    </div>
                  </td>
                </tr>
              </table>
              <table align="center">
                <tr>
                  <td><input type="button" class="btn btn-primary btn-lg" id="list" name="#this" value="목록으로"></td>
                <c:if test="${sessionScope.MEMBER_ADMIN eq 1}">
                  <td>&nbsp;&nbsp;</td>
                  <td><input type="button" class="btn btn-primary btn-lg" id="update" name="#this" value="수정하기"></td>
                </c:if>
                </tr>
              </table>
            </form>
          </div>

          <div class="col-md-2 probootstrap-animate"></div>

        </div>
      </div>
    </section>  


<form id="commonForm" name="commonForm"></form>
	
	<script type="text/javascript">	
		$(document).ready(function() {
			$("#list").on("click", function(e) {
				e.preventDefault();
				fn_openBoardList();
			});
			
			$("#update").on("click", function(e) {
				e.preventDefault();
				fn_openBoardUpdate();
			});
		});
		
		function fn_openBoardList() {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/admin/noticeList'/>");
			comSubmit.submit();
		}
		
		function fn_openBoardUpdate() {
			var NOTICE_NUMBER= "${map.NOTICE_NUMBER}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/admin/noticeModifyForm'/>");
			comSubmit.addParam("NOTICE_NUMBER", NOTICE_NUMBER);
			comSubmit.submit();
		}
	
	</script>
	
	
	

</body>
</html>