<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width" />
<!-- facebook -->
<meta property="og:url" content="" />
<meta property="og:title" content="PANCOAT" />
<meta property="og:description" content="" />
<meta property="og:image" content="" />
<meta property="og:type" content="website" />
<meta property="og:site_name" content="PANCOAT" />
<meta property="og:locale" content="ko_KR" />
<!-- facebook -->
<title>MODA 공지사항</title>

<link rel="stylesheet" href="/MODA/theme/pshp/css/vendor/jquery-ui.css">
<link rel="stylesheet" href="/MODA/theme/pshp/css/vendor/bootstrap.css">
<link rel="stylesheet" href="/MODA/theme/pshp/css/fonts.css">
<link rel="shortcut icon" href="/favicon.ico">

<script src="/MODA/theme/pshp/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
<script src="/MODA/theme/pshp/js/vendor/selector.min.js"></script>
<script src="/MODA/theme/pshp/js/vendor/webfont.min.js"></script>
<script src="/MODA/dist/jquery/jquery-1.11.0.min.js"></script>
<script src="/MODA/dist/jquery/jquery-ui.js"></script>
<script src="/MODA/dist/jquery/jquery-migrate-1.2.1.min.js"></script>
<script src="/MODA/dist/jquery/plugin/jquery.cookie.js"></script>

<!-- font-awesome(icon) -->
<link href="/MODA/dist/font-awesome/css/font-awesome.min.css" rel="stylesheet">

<!-- owl -->
<link rel="stylesheet" href="/MODA/dist/owl/owl.carousel.css">
<link rel="stylesheet" href="/MODA/dist/owl/owl.theme.default.min.css">

<script src="/MODA/dist/owl/owl.carousel.min.js"></script>
<script src="/MODA/dist/owl/owl.js"></script>

<link rel="stylesheet" href="/MODA/theme/pshp/css/main.min.css">
<link rel="stylesheet" href="/MODA/theme/pshp/css/ui.css">

</head>
<style>
.content {
   padding: 10px 0 10px;
}

.node-info {
   list-style: none;
   margin: 0;
   padding: 0;
}

.node-info li {
   display: inline-block;
   padding-right: 15px;
}

.view2_user {
   padding-top: 6px;
}

.node_view h4 {
   font-weight: bold;
}

@media ( max-width : 450px) {
   .content img {
      width: 100%;
   }
}
</style>
<div class="viewport">
   <div class="container">
      <div id="page" class="page">
         <section class="page-category">
            <div class="selectboxWrap">
               <div class="selectbox">
                  <div class="selectbox-data">
                     <strong class="text">공지사항 </strong> 
                     <span class="icon icon-dropdown-white"></span>
                  </div>
                  <select name="category[]" id="cate02">
                     <option value="">공지사항</option>
                  </select>
               </div>
            </div>
         </section>
         <section class="page-title section">
            <h2>
               <strong>notice</strong>
            </h2>
         </section>
         <div class="my-account row">
            <section class="col-xs-24 account-navWrap">
               <nav class="account-nav">
                  <ul>
                     <li class="col-xs-8 col-sm-8 selected"><a href="/MODA/notify/notifyList">공지사항</a></li>
                     <li class="col-xs-8 col-sm-8 "><a href="/MODA//faq/faqList">FAQ</a></li>
                     <li class="col-xs-12 col-sm-8">
                        <a href="/member/findid" target="modal" data-size="md" data-label="아이디/비밀번호 찾기">아이디/비밀번호 찾기</a>
                     </li>
                  </ul>
               </nav>
            </section>
         </div>
         <div class="node_view board-notice-view section">
            <div class="wrap">
               <div class="section-head"style="width: 1138px; height: 83px;">
                  <strong class="title"><td colspan="3">${notifyDetail.NOTIFY_TITLE}</td></strong>
                  <p class="date">
                     <td>${notifyDetail.NOTIFY_REGDATE}</td>
                  </p>
               </div>
               <div class="section-body">
                  <p class="view2_user">관리자</p>
                  <ul class="list-group"></ul>
                  <div class="content">
                     <td colspan="4">${notifyDetail.NOTIFY_CONTENT}</td>
                  </div>
                  <div class="thumbnail">
                  <c:if test="${notifyDetail.NOTIFY_IMAGE ne null}">
                     <img src="/MODA/file/noticeFile/${notifyDetail.NOTIFY_IMAGE}" width="500" class="img-responsive">
                  </c:if>
                  </div>
                  <div class="pull-right"></div>
               </div>
            </div>
         </div>
         <div class="section-foot">
            <a href="/MODA/notify/notifyList" class="button"><span class="button-label">목록으로</span></a>
         </div>
      </div>
<!--       <script>
         $('.searchOption').val($('.searchOptionVal').val());
         var onWrite = function() {
            location.href = 'noticeModifyForm?NOTICE_NUMBER=${map.NOTICE_NUMBER }';
         };
      </script> -->
<script src="/MODA/dist/bootstrap/js/bootstrap.min.js"></script>
<script src="/MODA/dist/jquery/plugin/jquery.placeholder.js"></script>
<script src="/MODA/dist/js/common.js"></script>
<script src="/MODA/dist/js/event.js"></script>
<script src="/MODA/theme/pshp/js/event.js"></script>
<script src="/MODA/theme/pshp/js/plugins.min.js"></script>
<script src="/MODA/theme/pshp/js/main.min.js"></script>
<script src="/MODA/theme/pshp/js/vendor/fastclick.min.js"></script>
</div>
</div>