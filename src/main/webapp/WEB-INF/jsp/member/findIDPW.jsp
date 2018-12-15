<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>first</title>


</head>
<body>

<style>
#tabmenu{ position:relative; height:29px; background:url(images/tab_menu.gif) repeat-x 0 100%; font-family:'돋움',dotum; font-size:12px }
#tabmenu ul,#tabmenu ul li{margin:0;padding:0}
#tabmenu ul li{list-style:none; font-size: 16px;}
#tabmenu ul li,#tabmenu ul li a{background:url(images/bg_tab2_off.gif) no-repeat}
#tabmenu ul li{float:left;margin-right:-1px;line-height:26px}
#tabmenu ul li a{display:inline-block;padding:2px 16px 1px;_padding:3px 16px 0;background-position: 100% 0;font-weight:bold;color:#666;cursor:pointer;text-decoration:none !important}
#tabmenu ul li a:hover{color:#000}
#tabmenu ul li.on,#tabmenu ul li.on a{background-image:url(images/bg_tab2_on.gif)}
#tabmenu ul li.on a{color:#3376b8}

#tabcontent1{}
#tabcontent2{}
</style>


    <section class="flexslider"> 
      <ul class="slides"> 
        <li style="background-image: url(/ModuHome/style/img/findIDPW.jpg)" class="overlay">
          <div class="container">
            <div class="row">
              <div class="col-md-8 col-md-offset-2">
                <div class="probootstrap-slider-text text-center">
                  <h1 class="probootstrap-heading"><span><strong>아이디/비밀번호 찾기</strong></span></h1>
                </div>
              </div>
            </div>
          </div>
        </li>
      </ul>
    </section>

    
    <section class="probootstrap-section probootstrap-bg-white">
      <div class="container">
        <div class="row">

          <div class="col-md-3 probootstrap-animate"></div>

          <div class="col-md-6 probootstrap-animate">

			<div id="tabmenu">
			<ul>
			
			<c:if test="${state == 'id' || state==''||state==null}">
				<li class="on"> <a onClick="show_leemocon(0);">ID찾기</a> </li>
				<li class=""> <a onClick="show_leemocon(1);">PW찾기</a> </li>
			</c:if>
			<c:if test="${state == 'pw'}">
				<li class=""> <a onClick="show_leemocon(0);">ID찾기</a> </li>
				<li class="on"> <a onClick="show_leemocon(1);">PW찾기</a> </li>
			</c:if>		
					
			</ul>
			</div>

			<c:if test="${state == 'id' || state==''||state==null}">
			<div id="tabcontent0" style="display:;">
			</c:if>
			<c:if test="${state == 'pw'}">
			<div id="tabcontent0" style="display:none;">
			</c:if>
			<!-- <div id="tabcontent0" style="display:;"> -->
			<form action="/ModuHome/login/findID" method="post" class="probootstrap-form">
              <div class="form-group">
                <input type="text" class="form-control" id="MEMBER_NAME" name="MEMBER_NAME" placeholder="이름">
              </div>
              <div class="form-group">
                <input type="email" class="form-control" id="MEMBER_EMAIL" name="MEMBER_EMAIL" placeholder="이메일주소">
              </div>
              
              <div class="form-group" align="center">
                <input type="submit" class="btn btn-primary btn-lg" id="submit" name="submit" value="아이디는?">
              </div>
            </form>
            
			</div>
			
			<c:if test="${state == 'id' || state==''||state==null}">
			<div id="tabcontent1" style="display:none;">
			</c:if>
			<c:if test="${state == 'pw'}">
			<div id="tabcontent1" style="display:;">
			</c:if>
			<!-- <div id="tabcontent1" style="display:none;"> -->
			
				<form action="/ModuHome/login/findPW" method="post" class="probootstrap-form">
	
	              <div class="form-group">
	                <input type="text" class="form-control" id="MEMBER_ID" name="MEMBER_ID" placeholder="아이디" >
	              </div>
	              <div class="form-group">
	                <input type="text" class="form-control" id="MEMBER_NAME" name="MEMBER_NAME" placeholder="이름">
	              </div>
	              <div class="form-group">
	                <input type="email" class="form-control" id="MEMBER_EMAIL" name="MEMBER_EMAIL" placeholder="이메일주소">
	              </div>
	
	              <div class="form-group" align="center">
	                <input type="submit" class="btn btn-primary btn-lg" id="submit" name="submit" value="비밀번호는?">
	              </div>
	            </form>
	            
			</div>
			
			
        	<c:if test="${fn:length(message) > 0}">
       			<center>
       				<br><hr>
	       			<div style="width:80%; background-color: #b6eeff;">
					  <button type="button" class="close" data-dismiss="alert">&times;</button>
					  ${message }
					</div>
       			</center>
      		</c:if>			
			
            
           </div> 
          <div class="col-md-3 probootstrap-animate"></div>
          
        </div>
      </div>
    </section>   


</body>

<script language="javascript">
function show_leemocon(tabnum){
 var i;
 var d = new Array(4);
 var tm = document.getElementById("tabmenu").getElementsByTagName("li");
 for(i=0; i<=1; i++){
  
  d[i] = document.getElementById("tabcontent"+i);
  d[i].style.display = "none";
  tm[i].className = "";
 };

 
  switch(tabnum){
   case 0:
	    d[0].style.display = "";
	 	tm[0].className = "on";
    break;
   case 1:
	    d[1].style.display = "";
	 	tm[1].className = "on";
    break;
  };
};
</script>


</html>