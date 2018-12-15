<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    
<link href="https://fonts.googleapis.com/css?family=Bellefair|Open+Sans" rel="stylesheet">
<link rel="stylesheet" href="/ModuHome/style/css/styles-merged.css">
<link rel="stylesheet" href="/ModuHome/style/css/style.min.css"> 
<script src="/ModuHome/style/js/scripts.min.js"></script>
<script src="/ModuHome/style/js/custom.min.js"></script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>first</title>
              <style type="text/css">

                #order-d-table {
                  margin-bottom: 30px;
                }
                #order-d-td-a {
                  font-size: 12px;
                  background-color: #eeeeee;
                  border: 1px solid #b4b4b4;
                  height: 35px;

                }
                #order-d-td-b {
                  font-size: 12px;
                  background-color: #fff;
                  border: 1px solid #b4b4b4;
                  height: 35px;
                }

                #order-d-th {
                  font-size: 12px;
                  background-color: #eeeeee;
                  border: 1px solid #b4b4b4;
                }
                #order-d-btn{
                  background-color: #85c8dd;
                  border: none;
                  color: #fff;
                  border-radius: 10px;

                }
              </style>
</head>
<body>

<div style="display:none;" class="Session_mem_id" id="${mem_id}">
</div>
<div class="container" style="background-color: #fff; margin: 0px 0px 0px 0px; padding: 0px;">
    <section class="probootstrap-section probootstrap-bg-white">
      <div class="container" style="padding: 0px;">
        <div class="row">
          <div class="col-md-10 probootstrap-animate">
            <form action="#" method="post" class="probootstrap-form">

              <div align="center" style="padding-bottom: 25px;">
                <span style="font-size: 25px;">주문상세내역</span>
              </div>

              <div align="center"  style="padding-bottom: 50px;">
                <table width="100%">
                  <tr>
                    <td style="background-color: #85c8dd; color: #fff;" align="center">[${myOrderDetail2.MEMBER_NAME}] 님께서 2012년 02월 02일에 주문하신 내역입니다.</td>
                  </tr>
                </table>
              </div>

            <%-- <c:forEach items="${myOrderList}" var="myOrderList" > --%>
              <div>
                <span>주문자정보</span>
                
                <table width="100%" align="center" id="order-d-table">
                  <tr>
                    <td width="10%" align="center" id="order-d-td-a">주문번호</td>
                    <td width="40%" align="center" id="order-d-td-b">${myOrderDetail2.ORDER_CODE}</td>
                    <td width="10%" align="center" id="order-d-td-a">주문일자</td>
                    <td width="40%" align="center" id="order-d-td-b">${myOrderDetail2.ORDER_DATE}</td>
                  </tr>
                  <tr>
                    <td width="10%" align="center" id="order-d-td-a">주문자</td>
                    <td width="40%" align="center" id="order-d-td-b">${myOrderDetail2.MEMBER_NAME}</td>
                    <td width="10%" align="center" id="order-d-td-a">입금현황</td>
                    <td width="40%" align="center" id="order-d-td-b">${myOrderDetail2.ORDER_PAY_STATE}</td>
                  </tr>
                  <tr>
                    <td width="10%" align="center" id="order-d-td-a">주문메모</td>
                    <td colspan="3" width="90%" id="order-d-td-b">&nbsp;&nbsp;${myOrderDetail2.DELIVERY_MESSAGE}</td>
                  </tr>    
                </table>

              </div>

              <div>
                <span>배송지정보</span>
                <table width="100%" align="center" id="order-d-table">
                  <tr>
                    <td width="10%" align="center" id="order-d-td-a">배송번호</td>
                    <td width="40%" align="center" id="order-d-td-b">${myOrderDetail2.ORDER_CODE}</td>
                    <td width="10%" align="center" id="order-d-td-a">송장번호</td>
                    <td width="40%" align="center" id="order-d-td-b">${myOrderDetail2.ORDER_CODE}<button id="order-d-btn">배송추적</button></td>
                  </tr>
                  <tr>
                    <td width="10%" align="center" id="order-d-td-a">수취인</td>
                    <td width="40%" align="center" id="order-d-td-b">${myOrderDetail2.MEMBER_NAME }</td>
                    <td width="10%" align="center" id="order-d-td-a">연락처</td>
                    <td width="40%" align="center" id="order-d-td-b">${myOrderDetail2.BUYER_NUMBER}</td>
                  </tr>
                  <tr>
                    <td width="10%" align="center" id="order-d-td-a">주소</td>
                    <td colspan="3" width="90%" id="order-d-td-b">&nbsp;&nbsp;${myOrderDetail2.BUYER_ZIPCODE}&nbsp;&nbsp;${myOrderDetail2.BUYER_ADDRESS1}&nbsp;&nbsp;${myOrderDetail2.BUYER_ADDRESS2}</td>
                  </tr>    
                  <tr>
                    <td width="10%" align="center" id="order-d-td-a">배송메세지</td>
                    <td colspan="3" width="90%" id="order-d-td-b">&nbsp;&nbsp;${myOrderDetail2.DELIVERY_MESSAGE}</td>
                  </tr>                      
                </table>
              </div>


              <div>
                <span>주문상품정보</span>
                <table width="100%" align="center" id="order-d-table">
                  <tr id="order-d-tr">
                    <th width="53%" id="order-d-th" style="text-align: center">상품정보</th>
                    <th width="7%" id="order-d-th" style="text-align: center">수량</th>
                    <th width="13%" id="order-d-th" style="text-align: center">가격</th>
                    <th width="12%" id="order-d-th" style="text-align: center">처리상태</th>
                    <th width="15%" id="order-d-th" style="text-align: center">배송번호</th>
                  </tr>
                  
		      <c:choose>
		        <c:when test="${fn:length(myOrderList) > 0}">
		          <c:forEach items="${myOrderList}" var="myOrderList">                  
                  
                  <tr>
                    <td id="order-d-td-b"><img src="/ModuHome/images/goods/${myOrderList.GOODS_THUMBNAIL }" width="60px" height="60px">&nbsp;&nbsp;${myOrderList.GOODS_NAME }</td>
                    <td id="order-d-td-b" align="center">${myOrderList.ORDER_AMOUNT }</td>
                    <td id="order-d-td-b" align="center">${myOrderList.ORDER_TOTAL_PRICE * myOrderList.ORDER_AMOUNT}원</td>
                    <td id="order-d-td-b" align="center">${myOrderList.ORDER_DELIVERY_STATE }</td>
                    <td id="order-d-td-b" align="center">${myOrderList.ORDER_CODE }</td>
                  </tr>
                  
		          </c:forEach>
		        </c:when>
		      </c:choose>   
		      
                  <tr>
                    <td id="order-d-td-a" colspan="5" align="right">총 금액 = ${total_price}원&nbsp;&nbsp;</td>
                  </tr>                                   
                </table>
              </div>

<!--               <div>
                <span>결제정보</span>
                <table width="100%" align="center" id="order-d-table">
                  <tr id="order-d-tr">
                    <th width="30%" id="order-d-th" style="text-align: center">결제방법</th>
                    <th width="30%" id="order-d-th" style="text-align: center">결제금액</th>
                    <th width="40%" id="order-d-th" style="text-align: center">세부내역</th>
                  </tr>
                  <tr>
                    <td align="center" id="order-d-td-b">카드</td>
                    <td align="center" id="order-d-td-b">90,000원&nbsp;(입금완료)</td>
                    <td align="center" id="order-d-td-b"></td>
                  </tr>                   
                </table>
              </div> -->
              <div align="center">
                <button id="order-d-btn" onclick="closeWin();">&nbsp;&nbsp;닫기&nbsp;&nbsp;</button>
              </div>

        
            </form>
          </div>
        </div>
      </div>
    </section>  
    
    </div>
    </body>

    <script>
    function openWin(){  
	    window.open("http://localhost:8080/ModuHome/myOrderDetail", "조회하기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
	}; 
    
    function closeWin(){  
	    window.close();
	}; 
	
    </script>
      </html>