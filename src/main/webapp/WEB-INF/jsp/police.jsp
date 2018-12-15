<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<title>
Styleling
</title>

<!-- jQuery -->
<script src="js/snslist/jquery-1.9.1.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="js/snslist/bootstrap.min.js"></script>
<!-- Bootstrap Core CSS -->
<link href="css/snslist/bootstrap.css" rel="stylesheet">
<!-- BootsWatch Lumen CSS -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>



  
<script type="text/javascript">

$(document).ready(function() {   
	var mem_id = $(".mem_id").attr("id");
	var url = window.location.href;  /* 현재 url */
	
	
	$('#police').on('hide.bs.modal', function (e) {  /* 취소나 x눌렀을 경우 돌아가는 페이지  */
		location.href = url;  
		    
	})
	
	 $('#url').value = url;
	
	
	
});
</script>
</head>
<body>

<div style="display:none;" class="url" id="${url}">
</div>    
 
<div style="display:none;" class="mem_id" id="${mem_id}">
</div>  

                          <div>
						  		
						    	<a href="#" class="btn btn-link" data-toggle="modal" data-target="#police" style="align:left; text-align:left; color:#5a5a5a;">
						    		<img src="/ModuHome/style/img/police.png" alt="article_police" style="width:50px;height:50px;" class="img-circle" />
						  		</a>
						  	</div>
						  
						  
 
  
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
     							<input type="hidden" name="SNS_NUMBER" value="${SNS_NUMBER}" id="MEMBER_NUMBER" />
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








</html>