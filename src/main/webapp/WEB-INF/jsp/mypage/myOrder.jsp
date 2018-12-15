<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>first</title>

</head>
<body>

<div style="display:none;" class="Session_mem_id" id="${mem_id}">
</div>

<div class="container">
<section class="probootstrap-section probootstrap-bg-white">
      <div class="container">
        <div class="row">
         
          <div class="col-md-12 probootstrap-animate" style="padding-top:0px;">
            <form action="#" method="post" class="probootstrap-form">


              <style type="text/css">
                .orderForm tr td{
                  border-style: 1px solid ;
                }
                #order-th {
                  height: 50px;
                  border-top : 2px solid #85c8dd;
                }

                #order-td {
                  height: 70px;
                  border-top : 1px solid #b4b4b4;
                  border-bottom : 1px solid #b4b4b4;
                }
                #order-table {
                  border-bottom : 2px solid;
                }

                #order-paging {
                  padding-left: 10px;
                  padding-right: 10px;
                }

                #order-btn{
                  background-color: #85c8dd;
                  border: none;
                  color: #fff;
                  border-radius: 10px;
                }
              </style>


              <div align="center"  style="padding-bottom: 50px;">
                <span style="font-size: 25px;">주문내역</span>

              </div>

              <div>
                <table width="100%" id="order-table">
                  <tr id="order-tr">
                    <th width="10%" id="order-th" style="text-align: center">주문일자</th>
                    <th width="30%" id="order-th" style="text-align: center">상품명</th>
                    <th width="15%" id="order-th" style="text-align: center">결제금액</th>
                    <th width="15%" id="order-th" style="text-align: center">배송상태</th>
                    <th width="15%" id="order-th" style="text-align: center">주문상태</th>
                    <th width="15%" id="order-th" style="text-align: center">주문조회</th>
                  </tr>
                  <c:choose>
                    <c:when test="${fn:length(myOrderList) > 0}">
                    <c:forEach items="${myOrderList}" var="myOrderList"> 
                 <tr>
                    <td width="10%" align="center" id="order-td">${myOrderList.ORDER_DATE}</td>
                    <td width="30%" id="order-td">&nbsp;&nbsp;${myOrderList.GOODS_NAME}</td>
                    <td width="15%" align="center" id="order-td">${myOrderList.ORDER_TOTAL_PRICE}</td>
                    <c:choose>
                    <c:when test="${myOrderList.ORDER_STATE eq '주문취소'}">
                    <td width="15%" align="center" id="order-td">주문취소준비중<br/></td>
                    </c:when>
                    <c:when test="${myOrderList.ORDER_STATE eq '구매확정'}">
                    <td width="15%" align="center" id="order-td">구매확정<br/></td>
                    </c:when>
                    <c:when test="${myOrderList.ORDER_DELIVERY_STATE eq '배송완료'}">
                    <td width="15%" align="center" id="order-td">${myOrderList.ORDER_DELIVERY_STATE}<br/><button id="order-btn" onclick='pay_update2(${myOrderList.ORDER_NUMBER});'>구매확정</button></td>
                    </c:when>
                    <c:when test="${myOrderList.ORDER_DELIVERY_STATE eq '배송중'}">
                    <td width="15%" align="center" id="order-td">${myOrderList.ORDER_DELIVERY_STATE}<br/></td>
                    </c:when>
                    <c:when test="${myOrderList.ORDER_DELIVERY_STATE eq '배송준비중'}">
                    <td width="15%" align="center" id="order-td">${myOrderList.ORDER_DELIVERY_STATE}<br/></td>
                    </c:when>
                    <c:otherwise><td width="15%" align="center" id="order-td">${myOrderList.ORDER_DELIVERY_STATE}<br/><button id="order-btn" onclick='pay_update(${myOrderList.ORDER_NUMBER});'>주문취소</button></td></c:otherwise>
                    </c:choose>
                    <td width="15%" id="order-td" style="text-align: center">${myOrderList.ORDER_STATE}</td>
                    <td width="15%" align="center" id="order-td" onclick="openWin('${myOrderList.ORDER_CODE}');">조회</td>
                  </tr> 
               </c:forEach>
              </c:when>
              <c:otherwise>
                <tr>
                    <th colspan="4">조회된 결과가 없습니다.</th>
                </tr>
             </c:otherwise>
             </c:choose>
                 
                </table>
              </div>

 <!--              <div align="center" style="margin-top: 50px;">
                <table align="center" width="70%">
                  <a href="#" id="order-paging"><img src="img/arrll.png"></a>
                  <a href="#" id="order-paging"><img src="img/arrl.png"></a>
                  <a href="#" id="order-paging">1</a>
                  <a href="#" id="order-paging">2</a>
                  <a href="#" id="order-paging">3</a>
                  <a href="#" id="order-paging">4</a>
                  <a href="#" id="order-paging">5</a>
                  <a href="#" id="order-paging"><img src="img/arrr.png"></a>
                  <a href="#" id="order-paging"><img src="img/arrrr.png"></a>
                </table>
              </div> -->


            </form>
          </div>
        </div>
      </div>
    </section>  
    </div>
    </body>
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
  <script>
    function openWin(ordercode){  
    	window.open("http://localhost:8080/ModuHome/myOrderDetail", "조회하기", "width=750, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
	          $.ajax({
		          type : 'post', 
		          url : 'myOrderDetail',
			  	  headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
				  },
				  dataType : 'json',
		          data : JSON.stringify({
		        	  ORDER_CODE : ordercode
		          }),
		          success : function (data) {  
		        	  
		             }
		         });
	         
    };
	
function pay_update(order_number){
		 var ordernum = order_number;
		 var state ="주문취소";
		 if(confirm("정말 주문취소 하시겠습니까?") == true){
		      $.ajax({
		          type : 'post', 
		          url : 'payUpdate',
		          data: ({ORDER_NUMBER:ordernum,ORDER_STATE:state}),
		          success : function (data) {  
		        	  alert("구매취소가 완료되었습니다.");
		             }
		         });
		      
		   }else {
		       return;
		    }
		 };
		 
function pay_update2(order_number){
	 var ordernum = order_number;
	 var state ="구매확정";	
	if(confirm("구매확정 하시겠습니까?") == true){
	      $.ajax({
	          type : 'post', 
	          url : 'payUpdate',
	          data: ({ORDER_NUMBER:ordernum,ORDER_STATE:state}),
	          success : function (data) {  
	               alert("구매확정이 완료되었습니다.");
	             }
	         });
	      
		}else{
		   return;
		}
	};
  </script>
</html>