<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
</head>
<body>
 	<div class="qna-list" id="changeQnaList" style="width:100%;">
			<div>
		 	<div style="padding:5px;"> 
		 			<h2>Q&A</h2>
					<div class="qna-wrapper">
						<c:if test="${sessionScope.MEMBER_ID eq null}">
                                       <div class="review-write-btn" style="float:right; border: 1px solid black;">
                                 <a href="#"  data-size="md" data-label="상품 문의 작성" onClick="alert('로그인 후 작성 가능합니다.'); return false;">QNA 작성하기</a></div>
                              </c:if> 
                               <c:if test="${sessionScope.MEMBER_ID ne null }">
                                 <div class="review-write-btn" style="float:right; border: 1px solid black;">
                                <a href="/ModuHome/qna/modal_qnaForm?GOODS_NUMBER=${goodsBasic.GOODS_NUMBER}" data-toggle="modal" data-target="#myModal">QNA 작성하기</a>
                                  </div>
                              </c:if> 
					</div>
				</div>
		 			<hr style="color:#99999; width:100%;">
			</div>
               <div class="section-body">
                  	<c:if test="${qnaSize == 0}">
                  	<div style="text-align:center; padding:20px;color: #8b8e94; line-height: 28px;font-size: 15px;">
                  	작성된 qna가 없습니다.
                  	</div>
                  	</c:if>
                  <ul class="list-dropdown">
                     <c:forEach var="goodsQna" items="${qnaList}" varStatus="stat">
                     <c:if test="${qnaEndPagingNum >= stat.count}">
                     <li>
                         <ul style="float:right; display:inline-block; list-style:none;">
                         <li class="author">${goodsQna.MEMBER_NAME}</li>
                         <li class="date">
                         <fmt:formatDate value="${goodsQna.QNA_REPDATE}" pattern="yyyy-MM-dd"/></li>
                         <li>
                         		<c:if test="${goodsQna.MEMBER_NUMBER eq sessionScope.MEMBER_NUMBER }">
									<c:url var="viewURL" value="/qnaDelete">
										<c:param name="QNA_NUMBER" value="${goodsQna.QNA_NUMBER}" />
										<c:param name="DETAIL" value="1" />
										<c:param name="GOODS_NUMBER" value="${goodsBasic.GOODS_NUMBER}" />
									</c:url>
								    <p style="float:right;"><a href="${viewURL}" style="float:right;" class="delete" onclick="delchk();">[삭제]</a></p>
					  			</c:if> 
                         </li>
                         </ul>
                        <!-- 질문자 제목 -->
                        	<div>
                           <strong class="title">${goodsQna.QNA_TITLE}</strong>
                        	</div>
                        <!-- 질문자내용 -->
                        <div>
                                 <p style="width:60%;">${goodsQna.QNA_CONTENT}</p>
                        </div>
                        <!-- 답변내용 -->
                        <c:if test="${goodsQna.QNA_REPCONTENT ne null}">
                           <div class="answer" style="margin-left: 30px;">
                              <p> <strong>
                              ┗관리자:
                              </strong>${goodsQna.QNA_REPCONTENT}</p>
                           </div> 
                           <hr>
                        </c:if>
                  
                     </li>
                     </c:if>
                     </c:forEach> 
                  </ul>
                        </div>
                       <div id="pagination" style="text-align:center; padding-bottom:60px;">
                           <c:if test="${qnaSize gt 5 }">
                           <br>
	                           <c:if test="${qnaNowPage ne 1 }">
	                           <a onclick="javascript:ajaxQnaPaging(1,${qnaEndPagingNum},${qnaStartPagingNum},${qnaNowPage});">&laquo;</a>
	                           </c:if>
	                      <%--      <c:forEach var="pgNum" begin="1" end="${reviewTotalPage}" step="1">
	                           <a>${pgNum}</a>
	                           </c:forEach> --%>
                              <a class="pg_current" >${qnaNowPage}</a>
	                           <c:if test="${qnaNowPage ne qnaTotalPage }">
	                           <a onclick="javascript:ajaxQnaPaging(2,${qnaEndPagingNum},${qnaStartPagingNum},${qnaNowPage});">&raquo;</a>
	                           </c:if>
                             <br>
                           </c:if>
                       </div>
            </div>
</body>
</html>