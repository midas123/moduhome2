<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
</head>
<body>
	<div class="cboth p_review" id="changeReviewList"> 
            <div id="review">
                   <div class="review-top">
                        <h2 style="font-family: 'Nanum Gothic';">구매 후기</h2><sub style="color:gray;">총 ${reviewSize }개의 구매 후기</sub>
                        <hr>
                        <c:if test="${sessionScope.MEMBER_ID ne null and checkBuy eq goodsBasic.GOODS_NUMBER and reviewCheck > 0}">
                        <div class="review-write-btn" style="border: 1px solid black; background: #fff; color: black; text-align: center;">
                           <a href="/ModuHome/review/reviewForm?GOODS_NUMBER=${goodsBasic.GOODS_NUMBER}" 
                           data-toggle="modal" data-target="#myModal">후기 작성하기</a>
                        </div>
                        </c:if> 
                    </div>     
	                     <c:forEach var="goodsReview" items="${reviewList}" varStatus="stat">
	                     <c:if test="${reviewEndPagingNum >= stat.count}">
	                     <c:if test="${reviewStartPagingNum < stat.count}">
                      <div style="width:auto; height:100px;">
                   		    <div style="float:left; width:22%; height:100%;">
                    		  <div class="comment-title"><strong>${goodsReview.REVIEW_TITLE }</strong></div>	
                    		  <div class="star-icon">
                    		    <span class="star">
	                            <c:if test="${goodsReview.REVIEW_SCORE == 20 }"><font color="#FFBF00" size="5">★</font>
								</c:if>
								<c:if test="${goodsReview.REVIEW_SCORE == 40 }"><font color="#FFBF00" size="5">★★</font>
								</c:if>
								<c:if test="${goodsReview.REVIEW_SCORE == 60 }"><font color="#FFBF00" size="5">★★★</font>
								</c:if>
								<c:if test="${goodsReview.REVIEW_SCORE == 80 }"><font color="#FFBF00" size="5">★★★★</font>
								</c:if>
								<c:if test="${goodsReview.REVIEW_SCORE == 100 }"><font color="#FFBF00" size="5">★★★★★</font>
								</c:if>
	                            </span>
	                     		</div> 
                    		</div>
                      		<div style="float:left; width:47%; height:100%;">
                      			   <div class="comment">
	                              ${goodsReview.REVIEW_CONTENT }
	                           		</div>
                      		</div>
							<div style="float:left; width:21%; height:100%;">
								<c:if test="${goodsReview.REVIEW_IMAGE ne null }"> 
								<img class="imgScale" src="/ModuHome/images/review/${goodsReview.REVIEW_IMAGE}" style="width:auto%; height:100%; cursor: pointer;" onclick="detailView(this)">
                                </c:if>
								
							</div> 
							<div style="float:left; width:10%; height:100%;">
								<div style="display:inline-block;">${goodsReview.MEMBER_NAME}<br><br></div>
								<div style="display:inline-block;">
								<fmt:formatDate value="${goodsReview.REVIEW_REGDATE}" pattern="YYYY-MM-dd" />
						        <c:if test="${goodsReview.MEMBER_NUMBER eq sessionScope.MEMBER_NUMBER }">
													<c:url var="viewURL" value="/reviewDelete">
														<c:param name="REVIEW_NUMBER" value="${goodsReview.REVIEW_NUMBER}" />
														<c:param name="DETAIL" value="1" />
														<c:param name="GOODS_NUMBER" value="${goodsBasic.GOODS_NUMBER}" />
								  					</c:url>
								 <a href="${viewURL}" class="delete" onclick="delchk();" >[삭제]</a>
						  		</c:if> 
								</div>
							</div>
                      </div>
					<hr>
						 </c:if>
	                     </c:if>
	                     </c:forEach>		
             </div>
                          <!--  상품 후기 페이징 -->
                        <div id="pagination" style="text-align:center;">
                           <c:if test="${reviewSize gt 5 }">
                           <br>
	                           <c:if test="${reviewNowPage ne 1 }">
	                           <a onclick="javascript:ajaxReviewPaging(1,${reviewEndPagingNum},${reviewStartPagingNum},${reviewNowPage});">&laquo;</a>
	                           </c:if>
	                      <%--      <c:forEach var="pgNum" begin="1" end="${reviewTotalPage}" step="1">
	                           <a>${pgNum}</a>
	                           </c:forEach> --%>
                              <a class="pg_current" >${reviewNowPage}</a>
	                           <c:if test="${reviewNowPage ne reviewTotalPage }">
	                           <a onclick="javascript:ajaxReviewPaging(2,${reviewEndPagingNum},${reviewStartPagingNum},${reviewNowPage});">&raquo;</a>
	                           </c:if>
                             <br>
                           </c:if>
                        </div>
                        </div>
</body>
</html>