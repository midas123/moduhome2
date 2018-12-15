<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>	
 	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>first</title>

</head>
<body>

<div style="display:none;" class="url" id="${url}">
</div>    
 
<div style="display:none;" class="mem_id" id="${MEMBER_NUMBER}">
</div> 
    
    <section class="probootstrap-section probootstrap-bg-white" style="padding-top:0px;">
      <div class="container">
		
		
        <!-- END row -->
        <div class="row">
        
          <div class="col-md-2"></div>
        
          <div class="col-md-8">			
          
          
            <c:forEach items="${snsList}" var="snsList">

            <div class="probootstrap-service-2 probootstrap-animate">
              <div class="text" style="width:100%;">
                <img src="/ModuHome/style/img/img_sm_1.jpg" width="50px" style="border-radius: 50%; float: left; margin-right: 30px">
                <h6>${snsList.MEMBER_ID }</h6>
                <h6><fmt:formatDate value="${snsList.SNS_REGDATE}" pattern="yyyy.MM.dd" /></h6>
              </div>
              
	         <c:if test="${snsList.SNS_HIDE eq 0 }">
	              <div class="text" style="width:100%;">  
	                <p>${snsList.SNS_CONTENT}</p>
	              </div>
	         
	         </c:if>
	         <c:if test="${snsList.SNS_HIDE eq 1 }">
	              <div class="text" style="width:100%;">  
	                <span style="text-decoration: line-through;">${snsList.SNS_CONTENT}</span><span style="color:#ff0000;">&nbsp;&nbsp;신고처리된 글 입니다.</span>
	              </div>
	         </c:if>             

              <div class="text" style="width:100%;"> 
				<c:if test="${snsList.SNS_IMAGE ne null}">
					<img src="/ModuHome/images/snsMain/${snsList.SNS_IMAGE}" width="60" height="60" >
				</c:if>
              </div>
              
              <div class="text" style="width:100%; margin:0em 0;  margin-bottom: 0px;">
           
				<c:if test="${snsList.SNS_LIKE eq 0}">
					<a class="likebtn" id='like_link${snsList.SNS_NUMBER}'>
						<img src="/ModuHome/style/img/heart_off.png" alt="heart_img" width="20px" id='like_img${snsList.SNS_NUMBER}'>
					</a>
					<span id="likeCount${snsList.SNS_NUMBER}">아직 인기가 없습니다</span> 
				</c:if>
                        
				<c:if test="${snsList.SNS_LIKE ne 0}">
					<a class="likebtn" id="like_link${snsList.SNS_NUMBER}">
						<img src='/ModuHome/style/img/heart_on.png' alt='heart_img' width='20px' id="like_img${snsList.SNS_NUMBER}">
					</a>
					<span id="likeCount${snsList.SNS_NUMBER}">${snsList.SNS_LIKE}명이 좋아합니다</span> 
				</c:if>	
              </div>
              
              <!-- 댓글 -->
           	<div class="text" style="width: 100%; background-color: #dedede;">
	            <form name="cm" action="snsCommentInsert" method="post">
	        	<input type="hidden" id="sns_number" name="SNS_NUMBER" value="${snsList.SNS_NUMBER}">
	       		<input type="hidden" id="MEMBER_NUMBER" name="MEMBER_NUMBER" value="${sessionScope.MEMBER_NUMBER }">             
	       		<input type="hidden" id="CM_INDEX" name="CM_INDEX" value="mypage">             
	      	            
               <!--  <input type="text" id="sns_cm_content" name="SNS_CM_CONTENT" style="width:80%;" placeholder="댓글을 입력하세요!">
                <input type="submit" value="댓글등록" class="btn btn-primary btn-lg"> -->
			
        			<c:forEach items="${snsCommentList}" var="snsCommentList">
        				<c:if test="${snsList.SNS_NUMBER eq snsCommentList.SNS_NUMBER}">
                   			<table>
                   				<tr>
                   					<td width="50">${snsCommentList.MEMBER_ID}</td>
	                   				<td width="250">${snsCommentList.SNS_CM_CONTENT}</td>
	                   				<td>${snsCommentList.SNS_CM_REGDATE}</td>
                   				</tr>
                   			</table>                  			
                   		</c:if>
                   	</c:forEach>   
                </form>    	             
            </div>      
           </div> 
            </c:forEach>
          </div>
          <div class="col-md-2"></div>
        </div>
      </div>
    </section>

</body>
</html>