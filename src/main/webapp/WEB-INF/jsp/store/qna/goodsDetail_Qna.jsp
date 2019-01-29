<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


 	<div class="qna-list" id="changeQnaList" style="width:100%;">
	<div class="qna-top">
		 	<div style="padding:5px;"> 
		 			<h2>Q&A</h2>
					<div class="qna-wrapper">
						<c:if test="${sessionScope.MEMBER_ID eq null}">
                                       <div class="review-write-btn" style="float:right; border: 1px solid black;">
                                 <a href="#"  data-size="md" data-label="상품 문의 작성"
                                    onClick="alert('로그인 후 작성 가능합니다.'); return false;">QNA 작성하기
                                 </a></div>
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
                     <c:if test="${qnaStartPagingNum < stat.count}">
                     <li style="margin-bottom:30px; list-style-type: none;">
                         <ul style="float:right; display:inline-block; list-style:none;">
                         <li class="author">${goodsQna.MEMBER_NAME}</li>
                         <li class="date">
                         <fmt:formatDate value="${goodsQna.QNA_REGDATE}" pattern="yyyy-MM-dd"/></li>
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
                           <div style="float:left; margin-right:20px;">
                           <strong class="title">${goodsQna.QNA_TITLE}</strong>
                           </div>
                           <c:choose>
                           <c:when test="${goodsQna.QNA_REPCONTENT == null}">
                           <div style="float:left; text-align:center; width:70px; height:30px; background-color:lightgray; font-size:14px;">${goodsQna.QNA_REPSTATE}</div>
                           </c:when>
                           <c:when test="${goodsQna.QNA_REPCONTENT != null}">
                           <div style="float:left; text-align:center; width:70px; height:30px; background-color:black; font-size:14px; color:white;">${goodsQna.QNA_REPSTATE}</div>
                           </c:when>
                           </c:choose>
                        	</div>
                        <!-- 질문자내용 -->
                   		<div style="clear:left; width:60%; height:50px;">
                                 <div class="qna-content-class"  style="width:90%; float:left; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${goodsQna.QNA_CONTENT}</div>
                                 <div class="qna-content-button"  style="width:10%; font-size:12px; color:#a6a6a6; font-weight: bold;"></div>
                        </div>
                        <!-- 답변내용 -->
                        <c:if test="${goodsQna.QNA_REPCONTENT ne null}">
                           <div class="answer" style="margin-left: 30px;">
                              <p> <strong>
                              ┗관리자:
                              </strong>${goodsQna.QNA_REPCONTENT}</p>
                           </div> 
                        </c:if>
                           <hr style="padding:5px;">
                     </li>
                     </c:if>
                     </c:if>
                     </c:forEach> 
                  </ul>
             </div>
             <!-- QnA 페이징 -->
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
       </div>  <!-- qna-list END -->
