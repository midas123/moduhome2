<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <script src="/ModuHome/dist/jquery/jquery-1.11.0.min.js"></script>
<script src="/ModuHome/dist/jquery/jquery-ui.js"></script>
<script src="/ModuHome/dist/jquery/jquery-migrate-1.2.1.min.js"></script> -->

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
var IMP = window.IMP;
IMP.init('imp08080720'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

</script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode; 
            document.getElementById('sample6_address').value = fullAddr;

            //커서를 상세주소 필드로 이동한다.
            document.getElementById('sample6_address2').focus();
        }
    }).open();
}
</script>



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

</script>

<script type="text/javascript">
var submitAction = function(e) {
	e.preventDefault();
    e.stopPropagation();
};

function buyGoods() {
	 if ($('#order-name').val().length == 0) {
	        alert("주문자의 성함을 입력하세요.");	       
	        $('#order-name').focus();
	        return false;
	    }  
	 
	 if ($('#emergency12').val().length == 0 || $('#emergency13').val().length == 0) {
	        alert("주문자의 연락처을 입력하세요.");	       
	        $('#emergency12').focus();
	        return false;
	    }
	 if ($('#input-mail').val().length == 0) {
	        alert("주문자의 이메일을 입력하세요.");	       
	        $('#input-mail').focus();
	        return false;
	    } 
	 
	 if ($('#receiver').val().length == 0) {
	        alert("수령인의 이름을 입력하세요.");	       
	        $('#receiver').focus();
	        return false;
	    }
	 
	 if ($('#emergency32').val().length == 0 || $('#emergency33').val().length == 0) {
	        alert("수령인의 연락처을 입력하세요.");	       
	        $('#emergency32').focus();
	        return false;
	    }
	 
	 if ($('#sample6_postcode').val().length == 0 || $('#sample6_address').val().length == 0 || $('#sample6_address').val().length == 0) {
	        alert("수령인의  주소를 입력하세요.");	       
	        $('#sample6_postcode').focus();
	        return false;
	    }
	 if(document.getElementById("agree").checked != true){
		 alert("정보수집에 동의하셔야합니다.");
		 document.getElementById("agree").focus();
		 return false;
	 }
	 
	 if ($('input[name=payType]:checked').length == 0) {
		 alert("결제방법을 선택해주세요.")
		 return false;
	 }
	 if ($('input[name=payType]:checked').val() == "inicisPay") {
		 IMP.request_pay({
    pg : 'html5_inicis', // version 1.1.0부터 지원.
    pay_method : 'card',
    merchant_uid : '${ORDER_CODE}' + new Date().getTime(),
    name : '[ModuHome]'+'${GOODS_NAME}',
    amount : $.trim(rm_comma($("#totalPrice").html())),
    buyer_email : '${orderMember.MEMBER_EMAIL}',
    buyer_name : '${orderMember.MEMBER_NAME}',
    buyer_tel : '${orderMember.MEMBER_PHONE}',
    buyer_addr : '${orderMember.MEMBER_ADDRESS1}'+'${orderMember.MEMBER_ADDRESS2}',
    buyer_postcode : $("#sample6_postcode").val(),
    m_redirect_url : '/ModuHome/orderEnd'
}, function(rsp) {
    if ( rsp.success ) {
        var msg = '결제가 완료되었습니다.';
        msg += '고유ID : ' + rsp.imp_uid;
        msg += '상점 거래ID : ' + rsp.merchant_uid;
        msg += '결제 금액 : ' + rsp.paid_amount;
        msg += '카드 승인번호 : ' + rsp.apply_num;
    } else {
        var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
    }
    alert(msg);
});
		 return false;
	 }
	 
	$('#frmOrder').submit();
}
</script>
<script>

window.onload = function (){
    var phone = '${orderMember.MEMBER_PHONE}';
    if(phone != "" && phone != null){
    var firstNumber = phone.substring(0,3);
    var secondNumber = phone.substring(3,7);
    var finalNumber = phone.substring(7,11);
    $("#emergency11").val(firstNumber);
    $("#emergency12").attr('value',secondNumber);
    $("#emergency13").attr('value',finalNumber);
   }
 }
</script>

<script>
function copydata2() {
    if ($('input[name="same2"]').prop('checked') === true) {
       $('input[name="RECEIVER_NAME"]').val($('input[name="MEMBER_NAME"]').val());
         if ('select' == 'select') {
            if ($('select[name="emergency21"]').length > 0 && document.frmOrder.tempemergency21) $('select[name="emergency21"] option[value='+document.frmOrder.tempemergency21.value+']').attr("selected",true);
        } else {
            if ($('select[name="emergency21"]').length > 0 && document.frmOrder.tempemergency21) $('select[name="emergency21"]').val(document.frmOrder.tempemergency21.value);
        }
        if ($('input[name="emergency22"]').length > 0 && document.frmOrder.tempemergency22) $('input[name="emergency22"]').val(document.frmOrder.tempemergency22.value);
        if ($('input[name="emergency23"]').length > 0 && document.frmOrder.tempemergency23) $('input[name="emergency23"]').val(document.frmOrder.tempemergency23.value);
        if ('select' == 'select') {
            if ($('select[name="emergency31"]').length > 0 && $('select[name="guestPhone1"]').length > 0) $('select[name="emergency31"] option[value='+$('select[name="guestPhone1"]').val()+']').attr("selected",true); 
        } else {
            if ($('select[name="emergency31"]').length > 0 && $('select[name="guestPhone1"]').length > 0) $('select[name="emergency31"]').val($('select[name="guestPhone1"]').val()); 
        }
        if ($('input[name="emergency32"]').length > 0 && $('input[name="guestPhone2"]').length > 0) $('input[name="emergency32"]').val($('input[name="guestPhone2"]').val()); 
        if ($('input[name="emergency33"]').length > 0 && $('input[name="guestPhone3"]').length > 0) $('input[name="emergency33"]').val($('input[name="guestPhone3"]').val()); 
        if ($('input[name="guestPhone2"]').length > 0 && document.frmOrder.tempemergency2) $('input[name="emergency2"]').val(document.frmOrder.tempemergency2.value);
        if ($('input[name="guestPhone3"]').length > 0 && $('input[name="emergency"]').length > 0) $('input[name="emergency3"]').val($('input[name="emergency"]').val());
        
    } else {
       $('input[name="RECEIVER_NAME"]').val('');
        if ('select' == 'select') {
            if ($('select[name="emergency21"]')) $('select[name="emergency21"] option[value=""]').attr("selected",true);
        } else {
            if ($('select[name="emergency21"]')) $('select[name="emergency21"]').val('');
        }
        if ($('input[name="emergency22"]')) $('input[name="emergency22"]').val('');
        if ($('input[name="emergency23"]')) $('input[name="emergency23"]').val('');
        if ('select' == 'select') {
            if ($('select[name="emergency31"]')) $('select[name="emergency31"] option[value=""]').attr("selected",true);
        } else {
            if ($('select[name="emergency31"]')) $('select[name="emergency31"]').val('');
        }
        if ($('input[name="emergency32"]')) $('input[name="emergency32"]').val('');
        if ($('input[name="emergency33"]')) $('input[name="emergency33"]').val('');
        if ($('input[name="emergency2"]')) $('input[name="emergency2"]').val('');
        if ($('input[name="emergency3"]')) $('input[name="emergency3"]').val('');
        
    }
}
</script>

<link rel="stylesheet" href="/ModuHome/css/store/common.css">
<link rel="stylesheet" href="/ModuHome/css/store/footer.1.css">
<link rel="stylesheet" href="/ModuHome/css/store/header.1.css">
<link rel="stylesheet" href="/ModuHome/css/store/nanumgothic.css">
<link rel="stylesheet" href="/ModuHome/css/store/okdgg_layer.css">
<link rel="stylesheet" href="/ModuHome/css/store/scroll.css">
<link rel="stylesheet" href="/ModuHome/css/store/menu.1.css">
<link rel="stylesheet" href="/ModuHome/css/store/order.css">


<title>주문페이지</title>
<style>
.endorder-footer button{
	text-align: center;
	font-size: 16px;
	border: none;
	color: white;
	width:230px; 
	height:40px;
	 background: #85C8DD;
	 margin-top: 90px;
	 margin-bottom: 20px;
}

.endorder-footer .button2{
	background: #b2b2b2;
}

.pointbutton-mid button{
	float:left;
	text-align: center;
	font-size: 13px;
	border: none;
	color: white;
	width:100px; 
	height:25px;
	background: #85C8DD;
	margin-top: 12px;
	margin-bottom: 20px;
	border-radius: 12px;
}

.lastprice-footer {
	margin-top: 20px;
	margin-bottom: 40px;
	color: #1a1a1a;
}
.lastprice-footer div{
	padding: 1px;
}

.order_title {
	font-family: 'Nanum Gothic';
}


</style>

</head>
<div class="col-md-12" style="background-color:#85C8DD; height: 80px; width: 100%; margin-top: 0px;">
</div>
<body style="background-color:white;">
<br>
<br>
<br>
<br>
<div id="wrap" style="margin-top: 20px;">
   <div id="contentWrapper" style="background-color:white;">
        <div id="contentWrap">
           <div id="content">
                <div id="order">
                <div style="text-align:center;"><h3 class="order_title">주문/결제</h3></div>
               		<dl class="loc-navi">
                        <dt class="blind">현재 위치</dt>
                        <dd>
                            <a href="/ModuHome/">home</a> &gt; 주문서 작성
                        </dd>
                    </dl>
                    <div class="page-body">
            		<form method="post" id="frmOrder" name="frmOrder" action="/ModuHome/orderEnd">
					    <c:forEach var="orderForm"  items="${goods}" varStatus="stat">
					    <input type="hidden" id="ea[]" name="ea[]" value="${orderForm.EA }">
					    <input type="hidden" id="kinds[]" name="kinds[]" value= "${orderForm.GOODS_KIND_NUMBER }">
					    <input type="hidden" name="GOODS_NUMBER[]" value="${orderForm.GOODS_NUMBER }">
					    </c:forEach>
					    <input type="hidden" name="MEMBER_ID" value="${orderMember.MEMBER_ID }">
					    <input type="hidden" name="ORDER_CODE" value="${ORDER_CODE}">
                    <div class="table-cart table-order-prd">
                    <h3 class="order_title" style="margin-top:30px;"><small>상품 정보</small></h3>
                    <table class="order-table">
                    <caption>주문할 상품</caption>
                    <colgroup>
                                    <col width="70">
                                    <col width="*">
                                    <col width="70">
                                    <col width="90">
                                    <col width="90">
                                    <col width="90">
                    </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col"><div class="tb-center"></div></th>
                                        <th scope="col"><div class="tb-center" style="text-align:left;">구입 상품명</div></th>
                                        <th scope="col"><div class="tb-right">수량</div></th>
                                        <th scope="col"><div class="tb-right">가격</div></th>
                                        <th scope="col"><div class="tb-right">할인가격</div></th>
                                        <th scope="col"><div class="tb-right">적립</div></th>
                                    </tr>
                             	</thead>
                        <tbody>
                         <c:forEach var="orderForm"  items="${goods}" varStatus="stat">
      <c:url var="viewURL" value="/goods/detail">
      <c:param name="GOODS_NUMBER" value="${orderForm.GOODS_NUMBER }" />
      </c:url>
              <tr class="nbg">
           <td>
              <div class="tb-center">
              <a href="${viewURL}"><img src="/ModuHome/images/goods/${orderForm.GOODS_THUMBNAIL}" width="40" /></a>                             
              </div>
           </td>
           <td>
              <div class="tb-left tb-bold">
              <a href="${viewURL}" style="font-weight: bold;">${orderForm.GOODS_NAME} ${orderForm.GOODS_COLOR} ${orderForm.GOODS_SIZE}</a>
              </div>
           </td>
           <td>
              <div class="tb-right">${orderForm.EA } 개</div>
           </td>
           <td>
         <div class="tb-right tb-bold"> 
         <c:choose>
         <c:when test="${orderForm.GOODS_DISPRICE ne orderForm.GOODS_PRICE}">
         <del>${orderForm.GOODS_PRICE * orderForm.EA}원</del><br/>
         <span style="font-weight: bold;"><fmt:formatNumber value="${orderForm.GOODS_DISPRICE * orderForm.EA}" type="number" />원</span>
         </c:when>
         <c:otherwise>
         <span style="font-weight: bold;"><fmt:formatNumber value="${orderForm.TOTALPRICE }" type="number" />원</span>
         </c:otherwise>
         </c:choose>
         </div>
      </td>
      <td>
         <div class="tb-right tb-bold" >
         <c:choose>
         <c:when test="${orderForm.GOODS_DISPRICE ne null}">
         <span ><fmt:formatNumber value="-${orderForm.TOTALPRICE - (orderForm.GOODS_DISPRICE * orderForm.EA)}" type="number" />원</span>
         </c:when>
         </c:choose>
         </div>
      <td>
       <c:if test="${not empty sessionScope.MEMBER_ID}">
         <div class="tb-right">
         <c:choose>
         <c:when test="${orderForm.GOODS_DISPRICE ne orderForm.GOODS_PRICE}">
         <span><fmt:formatNumber value="${orderForm.GOODS_DISPRICE * orderForm.EA / 100}" type="number" />원</span>
         </c:when>
         <c:otherwise>
         <span><fmt:formatNumber value="${orderForm.TOTALPRICE / 100}" type="number" />원</span>
         </c:otherwise>
         </c:choose>
         </div>
      </c:if>
      <c:if test="${empty sessionScope.MEMBER_ID}">
         <div class="tb-right">
         <c:choose>
         <c:when test="${orderForm.GOODS_DISPRICE ne orderForm.GOODS_PRICE}">
         <span>0원</span>
         </c:when>
         <c:otherwise>
         <span>0원</span>
         </c:otherwise>
         </c:choose>
         </div>
      </c:if>
      </td>
      <tr class="nbg">
         <td colspan="6">
         <div class="tb-left">옵션1 : ${orderForm.GOODS_OPTION1} / 옵션2 : ${orderForm.GOODS_OPTION2}</div> 
         </td>
      </tr>
      <td colspan="6" >
           </c:forEach>
       </tbody>
       <tfoot>
      <c:forEach var="orderForm"  items="${goods}" varStatus="stat">
      <c:choose>
      <c:when test="${orderForm.GOODS_DISPRICE ne orderForm.GOODS_PRICE}">
      <c:set var= "sum" value="${sum + (orderForm.GOODS_DISPRICE * orderForm.EA)}"/>
      </c:when>
      <c:otherwise>
      <c:set var= "sum" value="${sum + orderForm.TOTALPRICE}"/>
      </c:otherwise>
      </c:choose>
      </c:forEach>
	</tfoot>
   
   	</table>
    </div><!-- table-cart table-order-prd -->
                           <h3 class="order_title" style="margin-top:50px;"><small>주문자 정보</small></h3>
                           <div class="table-order-info table-user">
                              <table class="order-table">
                                 <caption>주문자 정보</caption>
                                    <colgroup>
                                       <col width="90">
                                       <col width="*">
                                       <col width="70">
                                       <col width="*">
                                    </colgroup>
                                    <tbody>
                                       <tr class="nbg">
                                          <th scope="row"><div class="tb-right">이 름</div></th>
                        				 <td>
											                    <div class="tb-left">
											                    ${orderMember.MEMBER_NAME }                                    
											<input type="hidden" name="MEMBER_NUMBER" value="${orderMember.MEMBER_NUMBER }">
											                    <input type="hidden" name="MEMBER_NAME"
											                          id="order-name" class="MS_input_txt txt-input2 width100"
											                          value="${orderMember.MEMBER_NAME }">
											                    </div>
											                 </td>
                                       <th scope="row"><div class="tb-right">연락처</div></th>   
                                       <td>
                                          <div class="tb-left">
                                        <select 
                          id="emergency11" name="guestPhone1" class="MS_select MS_tel">
                          <option value="">선택</option>
                          <option value="010" selected>010</option>
                          <option value="011">011</option>
                          <option value="016">016</option>
                          <option value="017">017</option>
                          <option value="018">018</option>
                          <option value="019">019</option>
                          <option value="02">02</option>
                          <option value="031">031</option>
                          <option value="032">032</option>
                          <option value="033">033</option>
                          <option value="041">041</option>
                          <option value="042">042</option>
                          <option value="043">043</option>
                          <option value="044">044</option>
                          <option value="051">051</option>
                          <option value="052">052</option>
                          <option value="053">053</option>
                          <option value="054">054</option>
                          <option value="055">055</option>
                          <option value="061">061</option>
                          <option value="062">062</option>
                          <option value="063">063</option>
                          <option value="064">064</option>
                          <option value="0502">0502</option>
                          <option value="0503">0503</option>
                          <option value="0504">0504</option>
                          <option value="0505">0505</option>
                          <option value="0507">0507</option>
                          <option value="070">070</option>
                          <option value="080">080</option>
                          </select>
                          - <input type="text" 
                           id="emergency12" size="4" name="guestPhone2"
                          maxlength="4" class="MS_input_txt" value=""> 
                          - <input
                          type="text" name="guestPhone3"
                          id="emergency13" size="4" maxlength="4"
                          class="MS_input_txt" value="">
                                          </div>
                                          </td>
                                       </tr>
                                       <tr>
                                    <th scope="row"><div class="tb-right">E-mail</div></th>
                 <td colspan="3">
                    <div class="tb-left">
                    <input type="email" id="input-mail" name="MEMBER_EMAIL" value="${orderMember.MEMBER_EMAIL }" class="xx-control" required="" alt="이메일을 입력하세요." style="width:200px">
                    
                    
                    </div><!-- tb-left -->
                    </td>
                                          </tr>
                                    </tbody>
                              </table><!-- order-table -->
                           </div><!-- table-order-info table-user -->
                           <div style="margin-top:50px;">
                           <h3 class="order_title"><small>배송 정보</small></h3>
                               <label> <input
                                 type="checkbox" name="same2" id="same2"
                                 onclick="javascript:copydata2();"> 배송지 주문자 정보 입력
                              </label>
                           </div>
                           <div class="table-order-info">
                              <table class="order-table">
                                 <caption>배송지 정보</caption>
                                 <colgroup>
                                    <col width="85">
                                    <col width="135">
                                    <col width="70">
                                    <col width="*">
                                    <col width="70">
                                    <col width="*">
                                 </colgroup>
                                 <tbody>
                                 	    <tr class="nbg">
                                       <th scope="row"><div class="tb-right">이 름</div></th>
                                       <td>
                                          <div class="tb-left">
                                             <input type="text" name="RECEIVER_NAME"
                                                id="receiver" class="MS_input_txt txt-input2 width100"
                                                value="">
                                          </div>
                                       
                                       </td>
                                       
                                       <th scope="row"><div class="tb-right">연락처</div></th>
                                       <td>
                                          <div class="tb-left2">
                                             <select name="emergency31"
                                                id="emergency31" class="MS_select MS_tel">
                                                <option value="" selected="selected">선택</option>
                                                <option value="010" selected="selected">010</option>
                                                <option value="011">011</option>
                                                <option value="016">016</option>
                                                <option value="017">017</option>
                                                <option value="018">018</option>
                                                <option value="019">019</option>
                                                <option value="02">02</option>
                                                <option value="031">031</option>
                                                <option value="032">032</option>
                                                <option value="033">033</option>
                                                <option value="041">041</option>
                                                <option value="042">042</option>
                                                <option value="043">043</option>
                                                <option value="044">044</option>
                                                <option value="051">051</option>
                                                <option value="052">052</option>
                                                <option value="053">053</option>
                                                <option value="054">054</option>
                                                <option value="055">055</option>
                                                <option value="061">061</option>
                                                <option value="062">062</option>
                                                <option value="063">063</option>
                                                <option value="064">064</option>
                                                <option value="0502">0502</option>
                                                <option value="0503">0503</option>
                                                <option value="0504">0504</option>
                                                <option value="0505">0505</option>
                                                <option value="0507">0507</option>
                                                <option value="070">070</option>
                                                <option value="080">080</option>
                                             </select> - <input type="text" name="emergency32"
                                                id="emergency32" size="4"
                                                maxlength="4" class="MS_input_txt" value=""> - <input
                                                type="text" name="emergency33"
                                                id="emergency33" size="4" maxlength="4"
                                                class="MS_input_txt" value="">
                                          </div><!-- tb-left2 -->
                                       </td>
                                    </tr>
                                    <!-- 주소 시작 -->
                                    <tr>
                                       <th scope="row"><div class="tb-right">주소</div></th>
                                       <td colspan="5">
                                          <div class="tb-left tb-label-r10">
                                          <ul>
                                          <li>
                                          <input style="width:100px;" type="text" id="sample6_postcode" name="RECEIVER_ZIPCODE" value="${orderMember.MEMBER_ZIPCODE }" class="MS_input_txt" placeholder="우편번호" maxlength="3" readonly>
                                          <a class="button button-dimmed" onclick="sample6_execDaumPostcode()" style="background:white; border-style: hidden;">
                                          <img src="/ModuHome/images/storeMain/btn_h20_zipcode_sch.gif"
                                                      alt="우편번호 검색" title="우편번호 검색"></a>
                                          
                                          </li>
                                          <li>
                                          <input type="text" id="sample6_address" name="RECEIVER_ADDRESS1" value="${orderMember.MEMBER_ADDRESS1 }" class="MS_input_txt txt-input2 width350" placeholder="주소" readonly> [기본주소]
                                          </li>
                                          <li>
                                          <input type="text" id="sample6_address2" name="RECEIVER_ADDRESS2" value="${orderMember.MEMBER_ADDRESS2 }" class="MS_input_txt txt-input2 width350" placeholder="상세주소"> [나머지주소]
                                          </li>
                                          </ul>
                                          
                                          </div><!-- tb-left tb-label-r10 -->
                                          </td>
                                          </tr>
                                          <tr>
                                             <th scope="row">
                                             <div class="tb-right">
                                             주문메시지 <em class="d-block">(100자내외)</em>
                                             </div>
                                          </th>
                                          <td colspan="5">
                                             <div class="tb-left">
                                             <textarea name="DELIVERY_MESSAGE" id="message"
                                             cols="50" rows="5" class="MS_textarea"></textarea>
                                             </div>
                                          </td>
                                          </tr>
                                          
                                          <tr>
                                       <th scope="row"><div class="tb-right">안내메세지</div></th>
                                       <td colspan="5">
                                          <div class="new-privercy-contract">
                                             <p>개인정보 수집·이용</p>
                                             <div class="privercy-contract">
                                                <table class="tbl" summary="목적, 항목, 보유기간">
                                                   <caption>개인정보 수집/이용</caption>
                                                   <colgroup>
                                                      <col width="*">
                                                      <col width="30%">
                                                      <col width="20%">
                                                   </colgroup>
                                                   <thead>
                                                      <tr>
                                                         <th scope="col">목적</th>
                                                         <th scope="col">항목</th>
                                                         <th scope="col">보유기간</th>
                                                      </tr>
                                                   </thead>
                                                   <tbody>
                                                      <tr>
                                                         <td class="purpose"><div class="txt-l">서비스
                                                               제공에 따른 요금정산, 콘텐츠 제공, 구매 및 요금결제, 물품배송, 금융거래 본인 인증 및
                                                               금융서비스</div></td>
                                                         <td class="items"><div class="txt-l">주문자
                                                               정보(이름, 연락처), 받는분 정보(이름, 연락처, 주소)</div></td>
                                                         <td class="holding"><div class="txt-l">목적
                                                               달성 후 5일까지(관계법률로 인해 필요 시, 일정기간 보존)</div></td>
                                                      </tr>
                                                   </tbody>
                                                </table>
                                                <div style="margin-top: 5px;">* 동의하셔야 서비스를 이용하실 수
                                                   있습니다.</div>
                                                <div class="privercy-agree">
                                                   <label><input type="radio" id="agree"
                                                      name="new_privacy_agree" value="Y"> 정보수집에
                                                      동의합니다.</label> <label><input type="radio"
                                                      name="new_privacy_agree" value="N" checked="">
                                                      동의하지 않습니다.</label>
                                                </div>
                                             </div>
                                          </div>
                                       </td>
                                    </tr>
                                </tbody>
                                    </table>
                                    </div><!-- table-order-info -->
                        
                        <!-- 포인트 -->
     
                      		  	<h3 class="order_title" style="margin-top:50px;"><small>포인트</small></h3>
                   <div class="table-order-info">
                           <table>
                           <colgroup>
                                    <col width="90">
                                    <col width="90">
                                    <col width="90">
                                    <col width="*">
                                    <col width="70">
                                    <col width="*">
                           </colgroup>
                           <tbody>
                      		  	<tr class="nbg">
                              <th scope="row"><div class="tb-right">적립 포인트</div></th>
                              <td>
                                 <div class="tb-left">
                                 
                                 <input type="text" id="order-name" name="nameOrder" disabled="disabled"  
                                 value="<fmt:formatNumber value="${sum / 100 }" type="number" />" 
                                 class="MS_input_txt txt-input2 width100">
                                 </div>
                              </td>
                              </tr>
                              <tr class="nbg">
                              <th scope="row"><div class="tb-right">누적 포인트</div></th>
                              <td colspan="6">
                                 <div class="tb-left">
                                 <input type="text" id="myPoint" name="myPoint" disabled="disabled" 
                                 value="${orderMember.MEMBER_POINT }">
                                 <input type="hidden" id="backupPoint" disabled="disabled" value="${orderMember.MEMBER_POINT}">
                                 </div>
                              </td >
                              </tr>
                              <tr class="nbg">
                              <th scope="row"><div class="tb-right">사용 포인트</div></th>
                              <td colspan="6">
                                 <div class="tb-left">
                                 <input type="text" id="POINT_POINT" name="POINT_POINT"  value="">
                                 ※ 고객님은 <fmt:formatNumber value="${sum*0.05}" type="number" />점까지 사용 가능합니다.&nbsp;&nbsp; (포인트는 결제금액의 최대 5%까지 사용 가능)
                                 </div>
                                 </td>
                                <td>
                              </td>
                              </tr>
                           </tbody>
                           </table>
                                 <div class="pointbutton-mid" style="float:left; border: none;">
                                 <button type="button" onclick="javascript:changePoint();" >포인트 적용</button>
                                 <button type="button" onclick="javascript:rollbackPoint();" style="background: #b2b2b2; margin-left:2px;">적용 취소</button>
                                 </div>
                </div><!-- table-order-info -->
             		
                <div style="margin-top:80px;"><h3 class="order_title"><small>결제 방법</small></h3></div>
                <div class="cnt-box" style="float:left; width:100%;">
                       <div><input type="radio" name="payType" value="cash"><span class="custom-radio"></span>&nbsp;&nbsp;무통장 입금 :<span style="color: #0054A6;">농협중앙회 301-0548-7870-42 (예금주:(주)모두의집 ))</span></div>
                       <div><input type="radio" name="payType" value="inicisPay"><span class="custom-radio"></span>&nbsp;&nbsp;이니시스 페이</div>
                </div>
                 <div style="float:left; margin-top:30px; width:100%;"><h3 class="order_title"><small>최종 결제 금액</small></h3></div>
                 <div><hr style="clear:both; display:block; width: 100%; background-color:#b7b7b7; height: 1px;"></div>
                 <div class="lastprice-footer" style="float:left; margin-top:10px; width:60%; font-color:#1a1a1a;">
                                         <div style="float:left; width:50%;">상품금액</div><div style="float:right; width:50%;"><fmt:formatNumber value="${sum}" type="number" />원</div> 
                                                <div style="float:left; width:50%;"><strong style="color:#ff6666;">포인트 차감</strong></div> <div style="float:right; width:50%;"><strong style="color:#ff6666;"><span id="pointDis">0</span>점</strong></div>
                                         		 <div style="float:left; width:50%;">배송료</div>
                                         		 <div style="float:right; width:50%;">
                                         		 <c:choose>
                                                <c:when test="${sum >= 30000}">
                                                0원
                                                </c:when>
                                                <c:otherwise>      
                                                2,500원
                                                </c:otherwise>
                                                </c:choose>       
                                         		 </div>
                                          <br>
                                          <div style="float:left; width:50%;"><strong>총 결제금액</strong></div><div style="float:right; width:50%;">
                                          <strong id="totalPrice"><c:choose>
                                          <c:when test="${sum >= 30000}">
                                          <fmt:formatNumber value="${sum }" type="number" />
                                          </c:when>
                                          <c:otherwise>
                                          <fmt:formatNumber value="${sum + 2500}" type="number" />
                                          </c:otherwise>
                                          </c:choose></strong><strong>원</strong>
                                          </div>
                          </div>
                 <div><hr style="clear:both; display:block; width: 100%; background-color:#b7b7b7; height: 1px;"></div>
                    					<input type="hidden" name="TOTALPRICE" value="${sum}">
                    					<span id="oritotalprice" value=""></span>
                    					<input type="hidden" name="usePoint" value="0">  
                        <div class="endorder-footer" style="margin:auto; width:45%;">
                               <button type="button" onclick="javaScript:buyGoods();">주문하기</button> 
                               <button type="button" class="button2" onclick="location.href='/ModuHome/goods/detail?GOODS_NUMBER=${GOODS_NUMBER}';">주문취소</button> 
                        </div>
                    </form>
                    </div><!-- page-body -->
            </div><!-- order -->
         </div><!-- content -->
      </div><!-- contentWrap -->
   </div><!-- contentWrapper -->
</div><!-- wrap -->
<br>
<br>
<br>
<br>
<br>
<br>
<script>

function changePoint() {
	$(document).ready(function(){
	var mypoint = parseInt($("#myPoint").val(), 10);//보유 포인트
	var usepoint = parseInt($("#POINT_POINT").val(), 10);//사용할 포인트
	var deliveryfee = 0;//배송비
	var afterpoint = 0;//차감 후 포인트 
	var aftersumprice =0;//포인트 차감 후 결제금액
	var sumprice = ${sum};//포인트 적용 전 결제금액
	var pointmax = sumprice * 0.05;//포인트 사용한도
	
	//사용할 포인트 유효성 검사
	if(isNaN(usepoint) || usepoint <= 0){
		alert("포인트는 숫자로 입력해주세요.");
		return false;
	}
	
 	if(usepoint > pointmax){
		alert("포인트 사용 범위 초과");
		return false;
	}
	 
	//포인트 차감
	if(mypoint >= usepoint){
		 afterpoint = mypoint - usepoint;
	} else {
		alert("포인트를 다시 입력해주세요.");
		return false;
	}
	
	//배송비 설정
	if(sumprice < 30000){
		deliveryfee = 2500; 
	}
	//결제금액에서 포인트, 배송비 계산
	aftersumprice = sumprice + deliveryfee - usepoint;
	
	//계산 결과 삽입
	$("#pointDis").html(usepoint);
	$("#myPoint").val(afterpoint);
	$("#totalPrice").html(comma(aftersumprice));
	$(":input[name=TOTALPRICE]").val(aftersumprice);
	$(":input[name=usePoint]").val(usepoint);
	});
}

function rollbackPoint() {
	var sumprice = ${sum}; //주문 총액
	var bkpoint = parseInt($("#backupPoint").val(), 10);//원래 포인트
	var zrpoint = "";//사용 포인트 빈칸
	//페이지 삽입
	$("#totalPrice").html(comma(sumprice));
	$("#myPoint").val(bkpoint);
	$("#POINT_POINT").val(zrpoint);
	$("#pointDis").html(0);
	return false;	
} 

</script>
</body>
</html>