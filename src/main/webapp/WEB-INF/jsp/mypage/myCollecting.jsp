<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>first</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>

</head>
<body>

    <section class="probootstrap-section probootstrap-bg-white" style="padding-top:0px;">
      <div class="container">
        <div class="row">
          <div class="col-md-6 col-md-offset-3 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
            <span style="font-size: 36px;">내가 보관한 매거진</span>
          </div>
        </div>

        <!-- END row -->

        <div class="row">

		 	<c:forEach items="${mgMycollectList}" var="mgMycollectList">         
				<form>
				<c:url var="viewURL" value="mgDetail">
					<c:param name="MG_NUMBER" value="${mgMycollectList.MG_NUMBER}" />           
				</c:url>
		
		          <div class="col-md-4">
		            <div class="probootstrap-service-2 probootstrap-animate">
		              <div class="image" style="width: 100%">
		                  <img src="/ModuHome/images/mgMain/${mgMycollectList.MG_TITLE_IMAGE}" style="width: 100%;" height="350px">
		              </div>
		              <div class="text" style="width: 100%">
				        <a href="#this" name="MG_TITLE">${mgMycollectList.MG_TITLE }</a>       
		                <input type="hidden" id="MG_NUMBER" value="${mgMycollectList.MG_NUMBER }">
		                <input type="hidden" id="MEMBER_NUMBER" value="${sessionScope.MEMBER_NUMBER }">
		              </div>
		            </div> 		          
		          </div>
				</form>
		 	</c:forEach>        
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

</script>

</body>
</html>