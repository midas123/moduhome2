<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="TOTALPRICE" value="0" />

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>first</title>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  

<link rel="stylesheet" type="text/css" href="<c:url value='/css/ui.css'/>" />

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>

<scRIPT language="Javascript">

</scRIPT>

</head>
<body>

<div class="row" style="padding-left:15px;width:900px;">    
	<h1 class="page-header">주문내역</h1>
</div>
	<form id="frm" name="frm" enctype="multipart/form-data">
		<table class="board_view">
			<colgroup>
				<col width="13%">
				<col width="*"/>
			</colgroup>
			<caption>주문 내역</caption>
			<tbody>
				<tr>
					<th scope="row">주문코드</th>
					<td colspan="3">${orderBasic.ORDER_CODE}<input type="hidden" id="GOODS_NUMBER" name="GOODS_NUMBER" class="wdp_90" value="${goodBasic.GOODS_NUMBER}"></input></td>
				</tr>
				<tr>
					<th scope="row">주문상태</th>
					<td colspan="1">
					<c:if test="${orderBasic.ORDER_STATE eq '주문진행중' }"><b>${orderBasic.ORDER_PAY_STATE }</b></c:if>
					<c:if test="${orderBasic.ORDER_STATE ne '주문진행중' }"><b>${orderBasic.ORDER_STATE }(${orderBasic.ORDER_PAY_STATE })</b></c:if>
					</td>
					<th scope="row">배송상태</th>
					<td colspan="1"><b>${orderBasic.ORDER_DELIVERY_STATE}</b></td>
				</tr>
				<tr>
					<th scope="row">주문자</th>
					<td colspan="1">${orderBasic.BUYER_NAME} <c:if test="${orderBasic.MEMBER_NUMBER ne null}">(${orderBasic.MEMBER_ID})</c:if></td>
					<th scope="row">연락처</th>
					<td colspan="1">${orderBasic.BUYER_NUMBER}</td>
				</tr>
				<tr>
					<th scope="row">이메일</th>
					<td colspan="3">${orderBasic.BUYER_EMAIL}</td>
				</tr>
				<tr>
					<th scope="row">수령자</th>
					<td colspan="1"><b>${orderBasic.RECEIVER_NAME}</b></td>
					<th scope="row">연락처</th>
					<td colspan="1"><b>${orderBasic.RECEIVER_NUMBER}</b></td>
				</tr>
				<tr>
					<th scope="row">주소</th>
					<td colspan="3"><b>[${orderBasic.RECEIVER_ZIPCODE}]<br/>${orderBasic.RECEIVER_ADDRESS1} ${orderBasic.RECEIVER_ADDRESS2}</b></td>
				</tr>
				<tr>
					<th scope="row" rowspan=${size}>구매목록</th>
					<c:forEach var="orderDetail" items="${orderDetail}">
					<td colspan="1">${orderDetail.GOODS_NAME}  ${orderDetail.GOODS_COLOR}/${orderDetail.GOODS_SIZE}</td>
					<td colspan="1">${orderDetail.ORDER_AMOUNT}개</td>
					<td colspan="1"><fmt:formatNumber value="${orderDetail.ORDER_TOTAL_PRICE}" type="number" />원
					<c:set var="TOTALPRICE" value="${TOTALPRICE+orderDetail.ORDER_TOTAL_PRICE}" /></td>
				</tr>
				<tr>
				</c:forEach>
				</tr>
				<tr>
					<th scope="row" width="17%">총 주문금액</th>
					<td colspan="1"><fmt:formatNumber value="${TOTALPRICE}" type="number"/>원</td>
				
					<th scope="row">적립금사용</th>
					<td colspan="1"><fmt:formatNumber value="${-orderBasic.POINT_POINT}" type="number"/>원</td>
				</tr>
				<tr>
					<th scope="row">총 결제금액</th>
					<td colspan="3"><b><fmt:formatNumber value="${TOTALPRICE+orderBasic.POINT_POINT}" type="number"/>원</b></td>
				</tr>
				
				<c:if test="${orderCancel ne null }">
					<th scope="row">
					<c:if test="${ orderBasic.ORDER_STATE eq '주문취소' || orderBasic.ORDER_STATE eq '취소완료'}">취소사유</c:if>
					<c:if test="${ orderBasic.ORDER_STATE eq '교환신청' || orderBasic.ORDER_STATE eq '교환완료'}">교환사유</c:if>
					<c:if test="${ orderBasic.ORDER_STATE eq '반품신청' || orderBasic.ORDER_STATE eq '반품완료'}">반품사유</c:if>
					</th>
					<td colspan="1">${orderCancel.CANCEL_CONTENT}</td>
				
					<th scope="row">신청날짜</th>
					<td colspan="1"><fmt:formatDate	value="${orderCancel.CANCEL_REGDATE}" pattern="YY.MM.dd" /></td>
				</c:if>
				
			</tbody>
		</table>
		
		<br/><br/>
		<c:choose>
		<c:when test="${param.CANCEL ne null}">
		<a href="#this" class="btn" id="cancel">목록으로</a>
		</c:when>
		<c:when test="${param.EXCHANGE ne null}">
		<a href="#this" class="btn" id="exchange">목록으로</a>
		</c:when>
		<c:otherwise>
		<a href="#this" class="btn" id="list">목록으로</a>
		</c:otherwise>
		</c:choose>
	</form>
	<br/>
	<br/>
	
	<form id="commonForm" name="commonForm"></form>
	<script type="text/javascript">
		var gfv_count = 1;
		var gfc_count = 1;
	
		$(document).ready(function(){
			$("#list").on("click", function(e){ //목록으로 버튼
				e.preventDefault();
				fn_openOrderList();
			});
			$("#cancel").on("click", function(e){ //목록으로 버튼
				e.preventDefault();
				fn_openCancelList();
			});
			$("#exchange").on("click", function(e){ //목록으로 버튼
				e.preventDefault();
				fn_openExchangeList();
			});
			
			$("#write").on("click", function(e){ //작성하기 버튼
				e.preventDefault();
				fn_insertGood();
			});
			
			$("#addFile").on("click", function(e){ //파일 추가 버튼
				e.preventDefault();
				fn_addFile();
			});
			
			$("#addKind").on("click", function(e){ //파일 추가 버튼
				e.preventDefault();
				fn_addKind();
			});
			
			$("a[name='delete']").on("click", function(e){ //삭제 버튼
				e.preventDefault();
				fn_deleteKind($(this));
			});
		});
		
		function fn_openOrderList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/admin/orderList' />");
			comSubmit.submit();
		}
		function fn_openCancelList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/admin/cancelList' />");
			comSubmit.submit();
		}
		function fn_openExchangeList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/admin/exchangeList' />");
			comSubmit.submit();
		}
		
		function fn_insertGood(){
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/admin/goodsModify' />");
			comSubmit.submit();
		}
		
		function fn_addKind(){
			var str = "<p><select name='GOODS_COLOR' size=1><OPTION value=''>색상</OPTION><OPTION value='BLACK'>BLACK</OPTION><OPTION value='GRAY'>GRAY</OPTION><OPTION value='BROWN'>BROWN</OPTION><OPTION value='BURGUNDY'>BURGUNDY</OPTION><OPTION value='PINK'>PINK</OPTION><OPTION value='PURPLE'>PURPLE</OPTION><OPTION value='WHITE'>WHITE</OPTION><OPTION value='NAVY'>NAVY</OPTION><OPTION value='BLUE'>BLUE</OPTION><OPTION value='GREEN'>GREEN</OPTION><OPTION value='YELLOW'>YELLOW</OPTION><OPTION value='RED'>RED</OPTION><OPTION value='SKYBLUE'>SKYBLUE</OPTION><OPTION value='BEIGE'>BEIGE</OPTION> </select> <input type='text' placeholder='사이즈' name='GOODS_SIZE'> <input type='text' placeholder='수량' name='GOODS_AMOUNT'> <a href='#this' class='btn' name='delete'>삭제</a></p>";
			$("#kindDiv").append(str);
			$("a[name='delete']").on("click", function(e){ //삭제 버튼
				e.preventDefault();
				fn_deleteKind($(this));
			});
		}
		
		function fn_deleteKind(obj){
			obj.parent().remove();
		}
		
		function fn_addFile(){
			var str = "<p><input type='file' name='IMAGE'> <a href='#this' class='btn' name='delete'>삭제</a></p>";
			$("#fileDiv").append(str);
			$("a[name='delete']").on("click", function(e){ //삭제 버튼
				e.preventDefault();
				fn_deleteFile($(this));
			});
		}
		
		function fn_deleteFile(obj){
			obj.parent().remove();
		}
		
	</script>
</body>
</html>