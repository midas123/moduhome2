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
    <section class="probootstrap-section probootstrap-bg-white">
      <div class="container">
        <div class="row">
          <div class="col-md-2 probootstrap-animate"></div>

          <div class="col-md-10 probootstrap-animate">
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
                    <th width="15%" id="order-th" style="text-align: center">주문일자</th>
                    <th width="40%" id="order-th" style="text-align: center">상품명</th>
                    <th width="15%" id="order-th" style="text-align: center">결제금액</th>
                    <th width="15%" id="order-th" style="text-align: center">주문상태</th>
                    <th width="15%" id="order-th" style="text-align: center">주문조회</th>
                  </tr>
                  <tr>
                    <td width="15%" align="center" id="order-td">2012.22.33</td>
                    <td width="40%" id="order-td">&nbsp;&nbsp;예영이가 자주 입는 회색 거미줄티/td>
                    <td width="15%" align="center" id="order-td">90,000원</td>
                    <td width="15%" align="center" id="order-td">배송중<br/><button id="order-btn">구매취소</button></td>
                    <td width="15%" align="center" id="order-td">조회</td>
                  </tr>
                  <tr>
                    <td width="15%" align="center" id="order-td">2012.22.33</td>
                    <td width="40%" id="order-td">&nbsp;&nbsp;예영이가 자주 입는 회색 거미줄티/td>
                    <td width="15%" align="center" id="order-td">90,000원</td>
                    <td width="15%" align="center" id="order-td">배송중<br/><button>구매취소</button></td>
                    <td width="15%" align="center" id="order-td">조회</td>
                  </tr>                  
                  <tr>
                    <td width="15%" align="center" id="order-td">2012.22.33</td>
                    <td width="40%" id="order-td">&nbsp;&nbsp;예영이가 자주 입는 회색 거미줄티/td>
                    <td width="15%" align="center" id="order-td">90,000원</td>
                    <td width="15%" align="center" id="order-td">배송중<br/><button>구매취소</button></td>
                    <td width="15%" align="center" id="order-td">조회</td>
                  </tr>
                  <tr>
                    <td width="15%" align="center" id="order-td">2012.22.33</td>
                    <td width="40%" id="order-td">&nbsp;&nbsp;예영이가 자주 입는 회색 거미줄티/td>
                    <td width="15%" align="center" id="order-td">90,000원</td>
                    <td width="15%" align="center" id="order-td">배송중<br/><button>구매취소</button></td>
                    <td width="15%" align="center" id="order-td">조회</td>
                  </tr>         
                </table>
              </div>

              <div align="center" style="margin-top: 50px;">
                <table align="center">
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
              </div>


            </form>
          </div>
        </div>
      </div>
    </section>  