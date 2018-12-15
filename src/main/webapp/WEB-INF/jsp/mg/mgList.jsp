<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>매거진</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>

   <!--  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400" rel="stylesheet"> -->
    <link rel="stylesheet" href="/ModuHome/search/css/styles-merged.css">
    <link rel="stylesheet" href="/ModuHome/search/css/style.min.css">
    <link rel="stylesheet" href="/ModuHome/search/css/custom.css">
  
</head>
<body>



<section class="flexslider">
      <ul class="slides">
        <li style="background-image: url(/ModuHome/style/img/mg3.jpg)" class="overlay">
          <div class="container">
            <div class="row">
              <div class="col-md-8 col-md-offset-2">
              
                <div class="probootstrap-slider-text text-center" style=" margin-top:300px;">
                     <h1 class="probootstrap-heading" style="font-size: 60px;"><span><strong><font face='Serif'>매거진</font></strong></span></h1>
                </div>
         
              </div>
            </div>
          </div>
        </li>
      </ul>
</section> 
    


	  <section class="probootstrap-section probootstrap-section-lighter">
    <div class="container">
      <div class="row">
         <!--   	<form name="magazine" action="mgInsertForm" method="post">
        		<button type="submit" class="button">
					<span>매거진등록</span>
				</button>
        	</form> -->
       
       <c:forEach items="${mgList}" var="mgList" varStatus="status">
       
           <c:url var="viewURL" value="mgDetail">
               <c:param name="MG_NUMBER" value="${mgList.MG_NUMBER}" />
               <c:param name="MEMBER_NUMBER" value="${sessionScope.MEMBER_NUMBER}" />
           </c:url>
          <%--  <a href="${viewURL}"> --%> <a href="#this" name="MG_TITLE">
       	 <div class="col-md-6  col-sm-6">
        	  <div class="probootstrap-card probootstrap-listing" style="height:550px">
            	<div class="probootstrap-card-media">
            	  <img src="/ModuHome/images/mgMain/${mgList.MG_TITLE_IMAGE}" class="img-responsive" style="width:600px; height:400px; margin-bottom:1px;">
            	      <div class="text" >
                <a href="#this" name="MG_TITLE"></a>
                <input type="hidden" id="MG_NUMBER" value="${mgList.MG_NUMBER }">
                <input type="hidden" id="MEMBER_NUMBER" value="${sessionScope.MEMBER_NUMBER }">
               
              </div>
            	
            	<!--   <a href="#" class="probootstrap-love"><i class="icon-heart"></i></a> -->
            	</div>
           		 <div class="probootstrap-card-text" > 
           		 
           		 <%-- <div>
           		 	<span class="btn btn-primary">Title</span>
           		 	<span style="font-size:30px; color:#85C8DD; margin-left:20px; text-align:center;">${mgList.MG_TITLE }</span>
           		 </div> --%>
           		
           		<%-- <div class="btn btn-primary">Title</div>
           		 <!--  <div class="probootstrap-listing-category for-sale" ><span style="background-color: #85C8DD;">Title</span></div> -->
            	  <div class="probootstrap-listing-price"><strong>${mgList.MG_TITLE }</strong> </div>
            	   --%>
            	 <%--  <div class="probootstrap-listing-location">
            		 ${mgList.MG_HASHTAG} 
            	   </div> --%>
            	   
            	   <div class="probootstrap-card-heading">${mgList.MG_CONTENT}</div>  
            	   <div class="probootstrap-listing-location" style="color:#85c8dd">    	   
            		  ${mgList.MG_TYPE}&nbsp; ${mgList.MG_STYLE}&nbsp; ${mgList.MG_SPACE}&nbsp; ${mgList.MG_AVERAGE}
            	   </div>
            	   <%-- <div class="probootstrap-card-heading">${mgList.MG_CONTENT}</div> --%>
            	</div>
            	<div class="probootstrap-card-extra">

            	</div>
		 		<c:if test="${status.last eq true }">
					<input type="hidden" class="last" id="${mgList.MG_NUMBER }">
		   		</c:if>
          	</div>
        	</div>
        	</a> 
        </c:forEach>
        
          			<table id="table" class="table">
                    
                    </table>
                    
                     <table id="table2" class="table2">
                    
                    </table>
                  



	<div class="addbtn"> <tr><td colspan="5">
	<a href="javascript:moreList();" class="btn btn-primary">더보기</a>
	</td></tr></div>

        
      </div>
    </div>

   
  </section>
    <form id="commonForm" name="commonForm"></form>

 

 
 <script type="text/javascript">
    $(document).ready(function() {
       $("a[name='MG_TITLE']").on("click", function(e){
          e.preventDefault();
          fn_openBoardDetail($(this));
       });
    });

    function fn_openBoardDetail(obj) {
       var comSubmit = new ComSubmit();
       comSubmit.setUrl("<c:url value='/mgDetail'/>");
       comSubmit.addParam("MG_NUMBER", obj.parent().find("#MG_NUMBER").val());
       if((obj.parent().find("#MEMBER_NUMBER").val()) != "") {
          comSubmit.addParam("MEMBER_NUMBER", obj.parent().find("#MEMBER_NUMBER").val());
       }
       else {
          comSubmit.addParam("MEMBER_NUMBER", 0);
       }
       comSubmit.submit();
    }    

  function moreList() {
	var MG_NUMBER = $(".last").attr("id"); 
	/* alert(MG_NUMBER+"1"); */
	$.ajax({
			async : true,
			type : 'post', 
			url : 'mgmorelist.ajax',
			dataType : 'json',
			data : {MG_NUMBER : MG_NUMBER}, 
	 	    success : function (mgMoreList) {
				if(mgMoreList != null) {
					/* alert("data ok"); */
					console.log(mgMoreList);
					var content = "";
					for(var i=0; i<mgMoreList.mgMoreList.length; i++){
						content +=
																				
							"<c:url var='viewURL' value='mgDetail'>"+
							"<c:param name='MG_NUMBER' value="+mgMoreList.mgMoreList[i].MG_NUMBER+"/>"+
							"<c:param name='MEMBER_NUMBER' value='${sessionScope.MEMBER_NUMBER}' />"+
							"</c:url>" +
							"<a href='${viewURL}'>"+
							
					       	 "<div class='col-md-6  col-sm-6'>"+
				        	  "<div class='probootstrap-card probootstrap-listing'>"+
				            	"<div class='probootstrap-card-media'>"+
				            	  "<img src='/ModuHome/images/mgMain/"+mgMoreList.mgMoreList[i].MG_TITLE_IMAGE+"' class='img-responsive' style='width:600px; height:400px;'>"+
				            	"</div>"+
				           		 "<div class='probootstrap-card-text'>"+
				           	/* 	  "<div>"+
				           		  "<span class='btn btn-primary'>Title</span>"+
				           		  "<span style='font-size:30px; color:#85C8DD; margin-left:20px; text-align:center;'>"+mgMoreList.mgMoreList[i].MG_TITLE+"</span>"+
				           		  "</div>"+ */
			                        
				           		  "<div class='probootstrap-card-heading'>"+mgMoreList.mgMoreList[i].MG_CONTENT+"</div>"+
				           		  
				            	   "<div class='probootstrap-listing-location'>"+           	   
				            		  mgMoreList.mgMoreList[i].MG_TYPE+"&nbsp;"+mgMoreList.mgMoreList[i].MG_STYLE+"&nbsp;"+mgMoreList.mgMoreList[i].MG_SPACE+"&nbsp;"+mgMoreList.mgMoreList[i].MG_AVERAGE+
				            	   "</div>"+
				            	   
				            	"</div>"+
				            	"<div class='probootstrap-card-extra'>"+

				            	"</div>"+
						 		"<c:if test='${status.last eq true }'>"+
									"<input type='hidden' class='last' id='"+mgMoreList.mgMoreList[i].MG_NUMBER+"'>"+
						   		"</c:if>"+
				          	"</div>"+
				        	"</div>"+
				        	"</a>";
											
							
							
                      
					
					}
					$('.addbtn').remove();//remove btn
					content+="<div class='addbtn'><tr><td colspan='4'><a href='javascript:moreList();' class='btn btn-primary'>더보기</a></td></tr></div>";
		            $(content).appendTo("#table"); 
				}
				else {
					alert("data no");
					
				}
			},  
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			} 
	});

};  

 
	
</script>

</body>
</html>