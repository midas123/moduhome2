<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

 <script type="text/javascript">
if('${message}' != ""){
	alert('${message}');
}


window.onload = function(){

	var str = "${viewName}";
	if (str.indexOf('mode=cart') != -1 || str.indexOf('mode=buy') != -1) {
	    ($('#lookUp').remove());
 	}else {
 		($('#orderLogin').remove());
 	}
}

function _exec(mode){
	
	if (mode=="buy"){
		if (document.getElementsByName("optno[]").length==0){ alert("옵션을 선택해주세요"); return; }
		
		var fm = document.fmOrder;
		fm.mode.value = mode;
		fm.target = "_self";
		fm.action = "/moduhome/order";
		//if (mode=="order") fm.action = "../order";
		fm.submit();
	}
}

</script>
<div class="container">

<section class="page-title section container">
	<h2>
		<strong>login</strong>
	</h2>
</section>
<div class="container">
	<div class="login-visitor">
		<div class="row">
			<section class="member col-xs-24 col-lg-12 section">
				<div class="box-shadow">
					<div class="section-head left border">
						<h3>회원 로그인</h3>
					</div>
					<div class="section-body">
						<div class="guide col-xs-24">
							<p>MODA 아이디와 비밀번호를 입력하세요</p>
						</div>
						<!-- guide//end -->
						<div class="item col-xs-24 col-sm-offset-6 col-sm-12 col-lg-offset-4 col-lg-16">
							<form name="loginForm" action="/moduhome/login" method="post">
								<input type="hidden" name="mode" value="login">
								<input type="hidden" name="viewName" value="${viewName}">

								<div class="input">
									<div class="id">
										<input type="text" id="ml-id" name="MEMBER_ID" required="" class="xx-control" placeholder="아이디">
									</div>
									<div class="password">
										<input type="password" id="ml-password" name="MEMBER_PASSWORD" required="" class="xx-control" placeholder="비밀번호">
									</div>
								</div>

								<button type="submit" class="button">
									<span class="button-label">로그인</span>
								</button>
								<!-- button//end -->
								<div class="action">
									<p>아이디/비밀번호를 잊으셨나요? <a href="/moduhome/login/findForm" target="modal" data-size="sm" data-label="아이디/비밀번호 찾기">여기를 클릭</a>하여 확인하실 수 있습니다.</p>
								</div>
							</form>
						</div>
						<!-- item//end -->
					</div>
				</div>
			</section>

		</div>
		<section class="member-signup col-xs-24 section">

			<!-- guide//end -->
			<a href="/moduhome/joinStep1" class="button large">
				<span class="button-label">회원 가입 바로가기</span>
			</a>
			<!-- button//end -->

			
		</section>
		<!--member-signup//end-->
	</div>
	<!-- member-login//end -->
</div>
</div>
