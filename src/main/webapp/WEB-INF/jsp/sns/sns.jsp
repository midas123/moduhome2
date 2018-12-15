<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>스토리</title>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<!-- jQuery -->
<!-- <script src="/style/resources/common/jquery-1.9.1.min.js"></script> -->
<!-- Bootstrap Core JavaScript -->
<script src="/style/resources/bootstrap/js/bootstrap.min.js"></script>
<!-- Bootstrap Core CSS -->
<link href="/style/resources/bootstrap/css/bootstrap.css" rel="stylesheet">
<!-- BootsWatch Lumen CSS -->


</head>
<body>

<div style="display:none;" class="url" id="${url}">
</div>    
 
<div style="display:none;" class="mem_id" id="${MEMBER_NUMBER}">
</div> 

<form name="snsBoard" action="/ModuHome/snsinsert" method="post" enctype="multipart/form-data">
		<!-- <input type="hidden" name="mode" value="login"> 
		<input type="hidden" name="viewName" value="${viewName}"> -->

		<div class="input">
			
			<div class="sns_content">
				<input type="text" id="sns_content" name="SNS_CONTENT" required="" class="xx-control" placeholder="내용">내용
			</div>
				<input type="hidden" id="member_number" name="MEMBER_NUMBER" required="" class="xx-control" value="${MEMBER_NUMBER }">
			<div class="sns_image">
				<input type="file" id="sns_image" name="SNS_IMAGE">메인사진
			</div>
			
		</div>

		<button type="submit" class="button">
			<span class="button-label">글쓰기</span>
		</button>
	</form>
		
		<table>
		<tbody>
				
                   <c:forEach items="${snsList2}" var="snsList" >
                   
                   
                   
                   <table>
                   <form>
                     <tr>
                        <td>${snsList.SNS_NUMBER }</td>
                        <td>${snsList.MEMBER_NUMBER }</td>
                        <td>${snsList.SNS_TITLE }</td>
                       	<td>
                           <fmt:formatDate value="${snsList.SNS_REGDATE}" pattern="yyyy.MM.dd" />
                        </td>
                   		<td>
                   		<div>
                   		<c:if test="${snsList.SNS_IMAGE eq null}">
                   		<td>${snsList.SNS_NUMBER}</td>
                   		</c:if>
                   		<c:if test="${snsList.SNS_IMAGE ne null}">
                   		   <img src="/ModuHome/images/snsMain/${snsList.SNS_IMAGE}" width="60" height="60" >${snsList.SNS_NUMBER}</td>
                   		</c:if>
                   		</td>
                   		</div>
                        <td>${snsList.SNS_CONTENT}</td>                     
                        
                        <!-- 좋아요하트 -->
                        <td>                                                                        
                        <c:if test="${snsList.LIKER eq null }">
                           <a class="likebtn" onclick="likeReg(${snsList.SNS_NUMBER},${snsList.SNS_LIKE});" id='like_link${snsList.SNS_NUMBER}'>
                              <img src="/ModuHome/style/img/heart_off.png" alt="heart_img" width="20px" id='like_img${snsList.SNS_NUMBER}'>
                           </a>
                        </c:if>
                        
                        <c:if test="${snsList.LIKER != null}">
                           <a class="likebtn" onclick='likeDel(${snsList.SNS_NUMBER},${snsList.SNS_LIKE});' id="like_link${snsList.SNS_NUMBER}">
                              <img src='/ModuHome/style/img/heart_on.png' alt='heart_img' width='20px' id="like_img${snsList.SNS_NUMBER}">
                           </a>
                        </c:if>                       
                        </td>
                       
                       <!--  좋아요수 출력 -->
                        <c:if test="${snsList.SNS_LIKE eq 0}">
                        <td id="likeCount${snsList.SNS_NUMBER}">제일 먼저 좋아요를 눌러주세요!</td>
                        </c:if>
                         <c:if test="${snsList.SNS_LIKE != 0}">
                        <td id="likeCount${snsList.SNS_NUMBER}">${snsList.SNS_LIKE}명이 좋아합니다.</td>
                         
                        </c:if>
                        
                        <!-- 신고하기 -->
                        <td>  		
						   	<a href="#" class="btn btn-link" data-toggle="modal" data-target="#police" style="align:left; text-align:left; color:#5a5a5a;" onclick="modal_view('${snsList.SNS_NUMBER}');">
						   		<img src="/ModuHome/style/img/police.png" alt="article_police" style="width:30px;height:30px;" class="img-circle" />
				    		</a>						  	
                        </td>
                     </tr>
                     </form>
                     </div>
                    </table>
		
					<table>
					<td colspan="3">
   					 <form name="cm" action="snsCommentInsert" method="post">
        				<input type="hidden" id="sns_number" name="SNS_NUMBER" value="${snsList.SNS_NUMBER}">
        				<!-- 세션 아이디 --> 
       					<input type="hidden" id="member_number" name="MEMBER_NUMBER" value="${MEMBER_NUMBER}"> 
        			<input type="text" id="sns_cm_content" name="SNS_CM_CONTENT" >
        			<button type="submit">댓글등록</button>
        			
        				<c:forEach items="${snsCommentList}" var="snsCommentList" >
        					<c:if test="${snsList.SNS_NUMBER eq snsCommentList.SNS_NUMBER}">
                   				<table>
                   					<td>${snsCommentList.MEMBER_NUMBER}</td>
                   					<td>${snsCommentList.SNS_CM_CONTENT}</td>
                   					<td>${snsCommentList.SNS_CM_REGDATE}</td>
                   				</table>
                   			</c:if>
                   		</c:forEach>
   					</form>
   					</td>
					</table>
                  </c:forEach>
                  
               </tbody> 
               </table>
</body>

 <div class="modal fade bs-example-modal-sm police" id="police" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm" style="width:500px;">
    <div class="modal-content">
     <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> 
        <div class="modal-title" style="height:20px;">
        	<div class="container-fluid">
        		<div class="col-xs-6" style="align:left; text-align:left;"><h5 style="font:맑은고딕;"><strong>게시글 신고</strong></h5></div>
	        	<div class="col-xs-6" style="align:right; text-align:right;">
	        		<!-- <a href="#" data-dismiss="modal">
	        			<img src="/style/resources/images/main/del_img.png" alt="del_img" style="height:60%;" />
					</a>	 -->										        	
	        	</div>
        	</div>
        </div>
     </div>
	  <form action="<c:url value="/policeReg"/>" method="post" class="form-horizontal" enctype="multipart/form-data">
      <div class="modal-body">
      <div class="container-fluid">
      
      	
		    <div class="row">
			    
		        <div class="col-xs-12" style="text-align:left;align:left;" > 
			        
           			<div style="min-height:200px;">
			        	
                        <div class="col-xs-12">
		        			<Strong>신고 내용</Strong>		        		   				
		        				<input type="hidden" name="MEMBER_NUMBER" value="${MEMBER_NUMBER}" id="MEMBER_NUMBER" />
     							<input type="hidden" name="SNS_NUMBER" value="${SNS_NUMBER}" id="SNS_NUMBER" />
     							<input type="hidden" name="url" value="${url}" id="url"/>
					   	    	<textarea class="form-control" rows="14" id="POLICE_CONTENT" name="POLICE_CONTENT" ></textarea>					        
				   		</div>
                 
		        	</div>
				       
		        </div>
		        
		    </div>
	    
	  </div>
	  </div>
      <div class="modal-footer">
      	<div class="form-group">
	      <div class="col-xs-12" style="text-align:right;">
	        <button type="submit" class="btn btn btn-warning" ><Strong>등록</Strong></button>
	        <a href="#" class="btn btn-default" data-dismiss="modal" ><Strong>&nbsp;&nbsp;취소&nbsp;&nbsp;</Strong></a>
	      </div>
	    </div>   
      </div>
      
	  </form>
    </div>
  </div>
</div>


<script type="text/javascript">

$(document).ready(function() {   
	var mem_id = $(".mem_id").attr("id");
	var url = window.location.href;  /* 현재 url */
	
	
	$('#police').on('hide.bs.modal', function (e) {  /* 취소나 x눌렀을 경우 돌아가는 페이지  */
		location.href = url;  
		    
	});
	
	 $('#url').value = url;
	
	
	
});
  /* 모달에 각 sns_number를 전달해주는 매소드 */
function modal_view(sns_number) {
    $('#police').on('show.bs.modal', function (event) {

        $(".col-xs-12 #SNS_NUMBER").val(sns_number);
        

    });
  };
  
    var article_seqJS = 0;
    function likeReg(article_seq,like_count){
      var mem_id = $(".mem_id").attr("id");
      var likeCount = like_count+1;
      article_seqJS = article_seq;
      $.ajax({
         type : 'post', 
         url : 'likeSNSReg',
         data: ({MEMBER_NUMBER:mem_id,SNS_NUMBER:article_seq}),
         success : function (data) {  
      	      /* 좋아요 클릭시 좋아요수 증가 */ 
      	      
      	    	 var html = likeCount+"명이 좋아합니다."  /* 증가된 좋아요 수를 출력 */
                 $('#likeCount'+article_seqJS).html(html);
      	      
      	   $('#like_img'+article_seqJS).attr({ /*빨간하트로 바꿔줌  */
      		   'src' : '/ModuHome/style/img/heart_on.png'
      	   });  
      	   
      	   $('#like_link'+article_seqJS).attr({ /* 링크를 좋아요취소기능으로 바꿈 */
      		   'onclick' : 'likeDel('+article_seqJS+','+likeCount+');'
      	   });
         }
      });
    };
          

    function likeDel(article_seq,like_count){
      var mem_id = $(".mem_id").attr("id");
      var likeCount = like_count-1;
      article_seqJS = article_seq;
      $.ajax({
          type : 'post', 
          url : 'likeSNSDel',
          data : ({MEMBER_NUMBER:mem_id, SNS_NUMBER:article_seq}),
          success: function (data){
        	  if(likeCount == 0){
        		  var html = "제일 먼저 좋아요를 눌러주세요!"  
                  $('#likeCount'+article_seqJS).html(html);
        	  }else{
        		  var html = likeCount+"명이 좋아합니다."  /* 감소된 좋아요 수를 출력 */
                  $('#likeCount'+article_seqJS).html(html);
        	  }
          	
          	$('#like_img'+article_seqJS).attr({
          		'src' : '/ModuHome/style/img/heart_off.png'
          	});
          	$('#like_link'+article_seqJS).attr({
          		'onclick' : 'likeReg('+article_seqJS+','+likeCount+');'
          	});
          }
      });
    };


</script>

</html>