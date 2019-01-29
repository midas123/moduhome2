<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<link type="text/css" rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link type="text/css" rel="stylesheet"
	href="https://fonts.googleapis.com/earlyaccess/nanumgothic.css" />

<link type="text/css" rel="stylesheet" href="/ModuHome/css/store/ggumim-1.2.04.min.css"/>

<link rel="stylesheet" type="text/css" href="/ModuHome/theme/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="/ModuHome/theme/slick/slick-theme.css"/>	

<style>

body {
   font-family: 'Nanum Gothic';
}

.btn-just-buy, .review-write-btn {
	border: 1px solid #85C8DD;
    background: #85C8DD;
    color: #fff;
    text-align:center;
}
.btn-cart {
	border: 1px solid #b2b2b2;
    background: #b2b2b2;
    color: #fff;
}
.container {
	width: 1000px;
}
.furniture-view{
	margin-top: 100px;
	width: 1000px;
}

.furniture-view .row .furniture-view-infomation {
	float:right;
	margin-right: 80px;
	padding-top: 50px;
	padding-bottom: 50px;
}
.furniture-view-infomation div {
	margin-left: 50px;
}
.furniture-delivery div {
	margin-left: 1px;
}
.furniture-view-option div {
	margin-left: 1px;
}
.furniture-view-option .option-set select {
	margin-top: -30px;
}

.furniture-view .furniture-view-image .furniture-view-image-wrapper {
	width: 400px;
	margin-left: 50px;
	padding-top: 50px;
}


.slick-prev:before {
  color: #999;
}
.slick-next:before {
  color: #999;
}



i {
  border: 2px;
  border-style: solid;
  border-color: #bfbfbf;
  border-width: 0 3px 3px 0;
  display: inline-block;
  padding: 3px;
}
.arrowdown {
    transform: rotate(45deg);
    -webkit-transform: rotate(45deg);
}
.arrowup {
    transform: rotate(-135deg);
    -webkit-transform: rotate(-135deg);
}

#pagination {
  margin: 0 auto;
  display:table;
}

#pagination a {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
  transition: background-color .3s;
  border: 1px solid #ddd;
  font-size: 15px;
}

#pagination a.active {
  background-color: #4CAF50;
  color: white;
  border: 1px solid #4CAF50;
}


#pagination a:hover:not(.active) {background-color: #ddd;}


</style>

</head>
<body class="goods-detail-page" style="background: #fff">
	<form name="fmOrder">
			<input type="hidden" name="mode"> 
			<input type="hidden" name="goodsno" value="${goodsBasic.GOODS_NUMBER }"> 
				<input type="hidden" name="GOODS_NAME" value="${goodsBasic.GOODS_NAME}">
	<div class="container" style="margin: auto; width: 1000px;">
		<div class="furniture-view">
			<div class="row" style="display: block; margin: auto;">
				<div class="product-slider" style="width: 400px; height:400px; float:left; margin-top: 60px;">
					<c:forEach var="goodsImage" items="${goodsImage}" varStatus="stat" begin="0" end="1">
					<div >
					<img src="/ModuHome/images/goods/${goodsImage.IMAGE}" onerror="this.src='/ModuHome/images/noimg_130.gif'" 
					style="width: 400px; height:400px;"/>
					</div>
					</c:forEach>
				</div>
								
				<!--/.left menu end-->
				<div class="col-xs-6 furniture-view-infomation"  style="float:right;">
							<div class="furniture-view-brand">${goodsBasic.GOODS_BRNAME}</div>
							<div class="furniture-view-name">${goodsBasic.GOODS_NAME}</div>
							<div class="furniture-view-cost">
								<c:if test="${goodsBasic.GOODS_PRICE eq goodsBasic.GOODS_DISPRICE}">
								<span>
									<fmt:formatNumber value="${goodsBasic.GOODS_PRICE}" type="number" />원
								</span><br/> 
						        </c:if>
								<c:if test="${goodsBasic.GOODS_PRICE ne goodsBasic.GOODS_DISPRICE}">
										<span class="original slashit"><fmt:formatNumber
												value="${goodsBasic.GOODS_PRICE}" type="number" />원</span><br/> 
										<span class="discount"><fmt:formatNumber
										value="${goodsBasic.GOODS_DISPRICE}" type="number" /></span>원 
										<span class="discount_rate">(<fmt:formatNumber
											value="${(goodsBasic.GOODS_PRICE - goodsBasic.GOODS_DISPRICE)*100 / goodsBasic.GOODS_PRICE}"
											type="number" />%할인)</span>
								</c:if>
							</div>
						<div class="furniture-delivery">
							<div class="row">
								<div>배송비</div>
								<div>
									<div style="float: left; font-size: 12px;">2,500 원 (
										30,000원 이상 무료 )</div>
									<div style="float: left; font-size: 12px;">(선결제)</div>
									<input type="hidden" name="delivery-payment" value="0">
								</div>
							</div>
						</div>
					<!--/.right top menu end-->
					<div class="furniture-view-option ">
						<div>상품옵션</div>
						<div class="option-set">
						<select id="option" onchange="setOption(this)"
							style="width: 225px">
							<option selected value="opt-default">-옵션 선택-</option>
							<c:forEach var="goodsDetail" items="${goodsDetail}"
								varStatus="stat">
							<c:choose>
							<c:when test="${goodsDetail.GOODS_AMOUNT eq 0}">
							품절
							</c:when>
							<c:when test="${goodsDetail.GOODS_AMOUNT > 0}">
								<c:if test="${goodsDetail.GOODS_AMOUNT > 0}">
									<c:if
										test="${goodsBasic.GOODS_DISPRICE ne goodsBasic.GOODS_PRICE }">
										<option
											value="${goodsDetail.GOODS_OPTION1} ${goodsDetail.GOODS_OPTION2 }"
											data-optnm1="${goodsDetail.GOODS_OPTION1 }"
											data-optnm2="${goodsDetail.GOODS_OPTION2 }"
											stock="${goodsDetail.GOODS_AMOUNT }"
											price="${goodsBasic.GOODS_DISPRICE }"
											kinds="${goodsDetail.GOODS_KIND_NUMBER }">${goodsDetail.GOODS_OPTION1}-${goodsDetail.GOODS_OPTION2 }
										</option>
										<c:if test="${goodsBasic.GOODS_DISPRICE eq goodsBasic.GOODS_PRICE }">
										</c:if>
									</c:if>
								</c:if>
								</c:when>
								</c:choose>
								</c:forEach>
						</select>
						</div>	
						<br><br>
						<div>
							<ul class="MK_inner-opt-cm" id="MK_innerOpt_01"></ul>
						</div>
						<div id="MK_innerOptTotal" class="">
							<p class="totalRight">
								<span class="MK_txt-total">합계</span> <span id="MK_txt-won"
									data-price="">0원</span>
							</p>
						</div>	
					</div>
					<div class="row" style="margin-right: -100px; margin-left: -1px;">
							<div class="col-xs-5 btn-cart" id="cartBtn"
								onclick="javascript:_exec('cart');" style="width:230px; height:40px; text-align: center;">장바구니 담기</div>
							<div class="col-xs-5 btn-just-buy"
								onclick="javascript:_exec('buy');" style="margin-left:0px; width:230px; height:40px; ">바로구매</div>
					</div>
				</div>
				<!--/.right bottom menu-->
			</div>
			<!--/right menu-->
		</div>
		</div>
		<div class="product" style="margin: auto; width: 1000px;">
			<div class="commerce-title">
				<h2>상품 정보</h2>
			</div>
		<div class="product_detail_image" style="width: 1000px; max-height: 3000px; overflow:hidden;" >
			<c:forEach var="goodsImage" items="${goodsImage}" varStatus="stat" begin="2">
			<img src="/ModuHome/images/goods/${goodsImage.IMAGE}" style="display: block; margin-left: auto; margin-right: auto; width:80%;">
			<br>
			</c:forEach>
		</div> 
		
		<div style="text-align:center; padding: 30px;">
			<div class="showbutton">
			<button id="show" value="1" style="background-color: white; color: black; border: 1px solid black; width: 130px; height: 30px;">상품정보 더보기</button>
			</div>
			<div style="padding: 10px;">
			<i class="arrowdown"></i>
			</div>		
			<div style="padding: 10px;">
			<i class="arrowup"></i>
			</div>	
		</div>
		<div id="changeReviewList" style="color:#262626;"> 
              <div id="review">
                   <div class="review-top">
                        <div style="float:left;"><h2 style="font-family: 'Nanum Gothic';">구매 후기</h2><sub style="color:gray;">총 ${reviewSize }개의 구매 후기</sub></div>
                   <c:if test="${sessionScope.MEMBER_ID ne null and reviewCheck > 0}">
                       <div class="review-write-btn" style="float:right; margin-top:30px; border: 1px solid black; background: #fff; color: black;">
                          <a href="/ModuHome/review/reviewForm?GOODS_NUMBER=${goodsBasic.GOODS_NUMBER}" 
                          data-toggle="modal" data-target="#myModal">후기 작성하기</a>
                       </div>
                   </c:if> 
                   </div>     
                  	<div style="clear:both; padding: 10px;">
                  	<hr> 
                  	</div>
              		<c:if test="${reviewSize == 0}">
                  	<div style="clear:left; text-align:center; padding:20px;color: #8b8e94; line-height: 28px; font-size: 15px;">
                  	작성된 상품 후기가 없습니다.
                  	</div>
                  	</c:if>
	                     <c:forEach var="goodsReview" items="${reviewList}" varStatus="stat">
	                     <c:if test="${reviewEndPagingNum >= stat.count}">
	                     <c:if test="${reviewStartPagingNum < stat.count}">
                      <div style="width:auto;" class="comment-title"><strong>${goodsReview.REVIEW_TITLE }</strong></div>	
                      <div style="width:auto; height:100px;">
                   		    <div style="float:left; width:22%; height:100%;">
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
                        <div id="pagination" style="text-align:center; padding-bottom:60px;">
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
				</div> <!-- changeReviewList END -->
		<!-- qna 상품문의 -->
		<div class="qna-list" id="changeQnaList" style="width:100%; color:#262626;">
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
                                <a href="/ModuHome/qna/modal_qnaForm?GOODS_NUMBER=${goodsBasic.GOODS_NUMBER}" data-toggle="modal" data-target="#myModal2">QNA 작성하기</a>
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
                           <div><hr style="padding:5px;"></div>
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
			<c:if test="${not empty relatedGoods}">
			<div class="bottom-product-list" style="width: 100%;">
				<div class="commerce-title">
					<h2>추천 상품</h2>
				</div>
				<div class="product-recommend-slider" style="width: 100%; display: block;">
					<c:forEach items="${relatedGoods}" var="relatedGoods">
					<div style="width: 400px; height:auto;">
						<a href="/ModuHome/goods/detail?GOODS_NUMBER=${relatedGoods.GOODS_NUMBER }"> <img
							src="/ModuHome/images/goods/${relatedGoods.GOODS_THUMBNAIL}" style="width: 350px; height:auto;"/>
						</a>
						<div class="description">
							<div class="name"><a href="/ModuHome/goods/detail?GOODS_NUMBER=${relatedGoods.GOODS_NUMBER }">${relatedGoods.GOODS_NAME }</a></div>
							<div class="price_original">
								<s><fmt:formatNumber value="${relatedGoods.GOODS_PRICE }" type="number"/>원</s>
							</div>
							<div class="price_discount">
								<span><fmt:formatNumber value="${relatedGoods.GOODS_DISPRICE }" type="number"/></span>원 
								(<fmt:formatNumber value="${(relatedGoods.GOODS_PRICE - relatedGoods.GOODS_DISPRICE)*100 / relatedGoods.GOODS_PRICE}" type="number"/>%)
							</div>
						</div>
					</div>
					</c:forEach>
					</div> 
					
				</div>
				</c:if>
</div>
	<br />
	<br />
<!-- modal trigger 삭제금지 -->
<div class="modal fade bs-example-modal-sm mymodal" id="myModal" tabindex="-1" role="dialog" 
aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm" style="width:500px;">
		<div class="modal-content">
		</div>
	</div>
</div>

<div class="modal fade bs-example-modal-sm mymodal" id="myModal2" tabindex="-1" role="dialog" 
aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm" style="width:500px;">
		<div class="modal-content">
		</div>
	</div>
</div>
<!-- modal trigger 삭제금지 -->

<!-- The Modal image-->
<div id="myModal2" class="modal"  onclick="this.style.display='none'" style="margin: auto; width:400px; height:400px;">
  <span class="close">&times;</span>
  <div>
  <img class="modal-content" id="img01" style="width:100%; display: block; margin: auto;">
  </div>
  <div id="caption"></div>
</div>


<script>
	//콤마 추가
	function comma(num) {
		var len, point, str;
		num = num + "";
		point = num.length % 3;
		len = num.length;
		str = num.substring(0, point);
		while (point < len) {
			if (str != "")
				str += ",";
			str += num.substring(point, point + 3);
			point += 3;
		}
		return str;
	}
	//콤마 삭제
	function rm_comma(num) {
		var number = num + "";
		return number.replace(",", "");
	}
	//수량 변경 함수
	function change_ea(obj, idx) {
		var ea = parseInt($("input.input_ea", $(obj).parent().parent()).val(),
				10)
				+ idx;
		if (ea < 1) {
			alert("1개 이상을 주문하셔야 합니다");
			return;
		}
		$("input.input_ea", $(obj).parent().parent()).val(ea);
	}
	function chkSoldout(obj) {
		if (obj.options[obj.selectedIndex].stock == "0") {
			alert("선택한 항목은 품절된 옵션입니다");
			obj.selectedIndex = 0;
			return false;
		}
		return true;
	}
	function setOption(obj) {
		$(document).ready(
			function() {
				var totprice = 0;
				if ($("#option option:selected").attr("disabled") == "disabled") {
					alert("선택한 옵션은 품절된 상태입니다");
					$("#option").get(0).selectedIndex = 0;
					return;
				}
				var optno = $("#option option:selected").val();
				if (!optno)
					return;
				//상품 옵션 추가 html
				var li = "<li class='MK_li_1_1'><span class='MK_p-name'>" 
						+ $("#option option:selected").attr("value")
						+ "</span><input type='hidden' name='optno[]' value='" + optno + 
								"'><input type='hidden' name='kinds[]' value='"
						+ $("option:selected", $(obj)).attr("kinds")
						+ "'><input type='hidden' class='mstock' value='"
						+ $("option:selected", $(obj)).attr("stock")
						+ "'><div class='MK_qty-ctrl' style='height:50px'>"
						+ "<input type='text' name='ea[]' value='1' class='input_ea' size='2' maxlength='3' readonly>"
						+ "<span class='ea'><a class='MK_btn-up'><img src='/ModuHome/images/storeMain/btn_num_up.gif' alt='' />"
						+ "</a><a class='MK_btn-dw'><img src='/ModuHome/images/storeMain/btn_num_down.gif' alt='' />"
						+ "</a></span></div><span class='MK_price' data-price='"
						+ $("option:selected", $(obj)).attr("price") + "'>"
						+ comma($("option:selected", $(obj)).attr("price"))
						+ "원</span><a href='#' optno='" + optno +"'class='MK_btn-del'><img src='/ModuHome/images/storeMain/btn_close.gif' alt='' /></a></li>";
				//페이지에 html 코드 삽입
				$("#MK_innerOpt_01").append(li);
				//상품 추가할때 합계가격 갱신
		 		var thisIdx = $(".input_ea").attr("value");
				var inputEa = parseInt(thisIdx, 10);
				var price = parseInt(rm_comma($("option:selected",
						$('#option')).attr("price")), 10);
				price = price * inputEa;
				price = parseInt(price, 10);
				totprice = parseInt(rm_comma($("#MK_txt-won")
						.html()), 10);
			
				totprice = totprice + price;
				$("#MK_txt-won").data("price", totprice);
				$("#MK_txt-won").html(comma(totprice) + "원"); 
			});
	}
	//상품옵션 삭제
	$(document).ready(function() {
		$("#MK_innerOpt_01").on("click", ".MK_btn-del", function() {
			var ritem = $(this).attr("optno");
			console.log("ritem:"+ritem);
			var thisIdx = $(".MK_btn-del").index(this);
			var price = parseInt($(".MK_price").eq(thisIdx).data("price"), 10);
			var totprice = parseInt($("#MK_txt-won").data("price"), 10);
			totprice = parseInt(totprice - price);
			$("#MK_txt-won").data("price", totprice);
			$("#MK_txt-won").html(comma(totprice) + "원");
			//삭제
			$(".MK_li_1_1").eq(thisIdx).remove();
			//기본 선택 위치로
			$("option:eq(0)").prop("selected", true);
		});

	//수량증가
				$("#MK_innerOpt_01").on("click","li a.MK_btn-up",
						function(e) {
							//현재 옵션의 리스트 인덱스							
							var thisIdx = parseInt($(".MK_btn-up").index(this),10);
							//수량 변경 함수
							change_ea(this, 1);
							//입력 수량
							var inputEa = parseInt($(".input_ea").eq(thisIdx).val(), 10);
							//상품 재고 수량
							var mStock = parseInt($(".mstock").eq(thisIdx).val(), 10);
							//단품 가격
							var price = parseInt($('.MK_price').eq(thisIdx).attr("data-price"), 10);
							//합계 가격
							var totprice = parseInt($("#MK_txt-won").data("price"), 10);
							//재고 수량  체크
							if (inputEa > mStock) {
								alert(mStock + "개 이상 주문하실 수 없습니다.");
								$(".input_ea").eq(thisIdx).val(mStock);
								return false;
							}
							//합계 금액 계산							
							totprice = totprice + price;
							//계산 결과 삽입
							$(".MK_price").eq(thisIdx).data("price",
									(price * inputEa));
							$(".MK_price").eq(thisIdx).html(
									comma(price * inputEa) + "원");
							$("#MK_txt-won").data("price", totprice);
							$("#MK_txt-won").html(comma(totprice) + "원");
						}
				);
				//수량 감소
				$("#MK_innerOpt_01").on(
						"click",
						"li a.MK_btn-dw",
						function(e) {
							var thisIdx = $(".MK_btn-dw").index(this);
							var inputEa = parseInt($(".input_ea").eq(thisIdx)
									.val(), 10);
							if (inputEa == 1) {
								alert("1개 이상 주문하셔야 합니다.");
								$(".input_ea").eq(thisIdx).val() == 1;
								return false;
							}
							change_ea(this, -1);
							inputEa = parseInt(
									$(".input_ea").eq(thisIdx).val(), 10);
							var price = parseInt(
									$('.MK_price').eq(thisIdx).attr("data-price"), 10);
							
							$(".MK_price").eq(thisIdx).data("price",
									(price * inputEa));
							var total = $(".MK_price").eq(thisIdx).html(
									comma(price * inputEa) + "원");
							var totprice = parseInt($("#MK_txt-won").data(
									"price"), 10);
							totprice = totprice - price;
							$("#MK_txt-won").data("price", totprice);
							$("#MK_txt-won").html(comma(totprice) + "원");
							return false;
						});
			});
			//엔터키 submit방지	
			$(document).on("keypress", ":input:not(textarea)", function(event) {
			    return event.keyCode != 13;
			});		
				
</script>
<script>
//상품 설명 더보기, 접기 버튼
$(document).ready(function(){
	$('.arrowup').hide();
  	$("#show").click(function(e){
  		var check = $(this).attr("value");
  		if(check == 1){  			
        var position = $("#show").offset().top;
        $('.product_detail_image').css("max-height", '');
        $(this).attr("value",2);
        $(this).html("상품정보 접기")
        $('html').animate({ scrollTop: position });
        $('.arrowdown').hide();
        $('.arrowup').show();
        e.preventDefault();
  		}
  		if(check ==2){
  		  $('.product_detail_image').css("max-height", '3000px');
          $(this).attr("value",1);
          $(this).html("상품정보 더보기");
          $('.arrowup').hide();
          $('.arrowdown').show();
  		  var position = $("#show").offset().top;
          $('html').animate({ scrollTop: position-200 });
          e.preventDefault();
  		}
    });
});
</script>
<script>
//최초 페이지 요청시
$(document).ready(function(){
	makeQnaButton();
	DoQnaButton();
});
//ajax 완료 후
$(document).ajaxComplete(function () {
	makeQnaButton();
	DoQnaButton();
});

//QnA 글자수 47자 초과시 '더보기'생성
function makeQnaButton(){
	$('.qna-content-class').each(function() {
		var qnaContent = $(this).html();
		var qnaLength = qnaContent.length;
		if(qnaLength > 47){
			$(this).next().html('더보기');
		}
		})
}

//var qnaHeight = $('#qna-content-text2').css('height');//QnA 내용의 높이 css값
//'더보기' 클릭시 QnA 내용 전체 표시 '접기' 클릭시 내용 감추기
function DoQnaButton(){
	$('.qna-content-button').each(function(){
		$(this).click(function(){
			if($(this).html() == '더보기'){
				$(this).parent().css('height',120);
				$(this).parent().css('word-break','normal');
				$(this).prev().removeAttr("style")
				$(this).html('접기');
			} else { //'접기'
				$(this).prev().css({'width':'90%', 'float':'left', 'text-overflow':'ellipsis', 'overflow':'hidden', 'white-space':'nowrap'});
				$(this).html('더보기');
				$(this).parent().css('height',50);
			}
		});
	})
}
</script>

<script>
//상품 후기, QnA - aJax
function ajaxReviewPaging(pagingCheck,reviewEndPagingNum,reviewStartPagingNum,reviewNowPage) {
 var tempScrollTop = $("#changeReviewList").offset().top-100;
 var pagingReviewOnOff="ON";
 var GOODS_NUMBER='${GOODS_NUMBER}';
  $.ajax({
     url: "/ModuHome/goods/detail",
       type : "post",
       data: {"reviewNowPage":reviewNowPage,"reviewStartPagingNum":reviewStartPagingNum,
    	   "reviewEndPagingNum":reviewEndPagingNum,"pagingReviewOnOff":pagingReviewOnOff,
    	   "pagingCheck":pagingCheck,"GOODS_NUMBER":GOODS_NUMBER},
       success:function(data){
          $("#changeReviewList").html(data);
          $(window).scrollTop(tempScrollTop);
       }
    });     
}

function ajaxQnaPaging(pagingCheck,qnaEndPagingNum,qnaStartPagingNum,qnaNowPage) { 
 var tempScrollTop = $("#changeQnaList").offset().top-100;
 var pagingQnaOnOff="ON";
 var GOODS_NUMBER='${GOODS_NUMBER}';
  $.ajax({
       url: "/ModuHome/goods/detail",
       type : "post",
       data: {"qnaNowPage":qnaNowPage,"qnaStartPagingNum":qnaStartPagingNum,"qnaEndPagingNum":qnaEndPagingNum,"pagingQnaOnOff":pagingQnaOnOff,"pagingCheck":pagingCheck,"GOODS_NUMBER":GOODS_NUMBER},
       success:function(data){
          $("#changeQnaList").html(data);
          $(window).scrollTop(tempScrollTop);
       }
    });     
} 
</script>   

<script type="text/javascript">
//슬라이더
$(document).ready(function(){
	  $('.product-slider').slick({
		  autoplay :true
	  	});
	  
	  $('.product-recommend-slider').slick({
		  infinite: true , //'${fn:length(relatedGoods) gt 3}'
		  variableWidth: true, 
		  slidesToShow: 3,
		  arrows: true
	  	});
	  });
</script>
<script>
//상품 후기 이미지 modal
function detailView(element) {
  document.getElementById("img01").src = element.src;
  document.getElementById("myModal2").style.display = "block"; 
}
</script>
<script>
//장바구니 담기, 구매하기 유효성검사
	var loginCheck = '${sessionScope.MEMBER_ID}';
	function _exec(mode) {
		 if (mode == "buy") {
			if(loginCheck == null || loginCheck==''){			
				alert('로그인 후 이용 가능합니다.');
				
				
				return false;
				} 
			 
			if (document.getElementsByName("optno[]").length == 0) {
				alert("옵션을 선택해주세요");
				return;
			}
			
			var fm = document.fmOrder;
			fm.mode.value = mode;
			fm.target = "_self";
			fm.action = "/ModuHome/order";
			fm.submit();
		} else if (mode == "cart") {
			if (document.getElementsByName("optno[]").length == 0) {
				alert("옵션을 선택해주세요");
				return;
			}
			//var mode = 'cart';
		 	var goodsno = $("input[name='goodsno']").attr('value');
			//var ea = $("input[name='ea[]']").attr('value');
			var ea = new Array();
			$("input[name='ea[]']").each(function(i) {
				ea[i] =  $(this).val();
			    console.log("ea:"+ $(this).val());
			});
			var kinds = new Array();
			$("input[name='kinds[]']").each(function(index) {
				kinds[index] = $(this).val();
			    console.log("kinds:"+$(this).val());
			});
			var GOODS_NAME = $("input[name='GOODS_NAME']").attr('value');
			var deliverypayment = $("input[name='delivery-payment']").attr('value');
			var optno = new Array();
			$("input[name='optno[]']").each(function(index) {
				optno[index] = $(this).val();
			    console.log("optno:"+$(this).val());
			});
			console.log("1goodsno:"+goodsno);
			console.log("1GOODS_NAME:"+GOODS_NAME);
			console.log("1kinds:"+kinds);
			console.log("1ea:"+ea);
			console.log("1deliverypayment:"+deliverypayment);
			
			$.ajaxSettings.traditional = true;//배열 형태로 서버쪽 전송을 위한 설정
			
			  $.ajax({
			       url: "/ModuHome/cart/cartAdd",
			       type : "post",
			       data: {"mode":mode,"goodsno":goodsno,"ea[]":ea,"kinds[]":kinds,"GOODS_NAME":GOODS_NAME,"delivery-payment":deliverypayment, "optno[]":optno},
			       success:function(data){
			          cartPopover();
			          console.log("cartAjax Done");
			          $('.MK_li_1_1').remove();
			          $('#MK_txt-won').html("0원");
			          $('#option').val('opt-default');
			       }
			    });
		}
	}
</script>
<script>
//장바구니 상품 추가시 알림 메세지
function cartPopover() {
	$('.goods-detail-page').css("overflow", "hidden");
	console.log("팝오버");
		
	$('#cartmenu').popover({
	    container: 'body', content:"장바구니에 상품이 추가되었습니다.", trigger: 'manual'
	  });	
	$('#cartmenu').popover("show");	
		$('.goods-detail-page').css("overflow", "hidden");	
	
	setTimeout(function(){ 
		$('#cartmenu').popover("hide"); 
		$('.goods-detail-page').css("overflow", "visible");
	}
	, 2000);
}
</script>
<script>
function delchk() {
	
	return confirm('삭제하시겠습니까?');
}
</script>
</form>
</body>
</html>
