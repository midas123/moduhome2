<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>first</title>
</head>
<body>

<style type="text/css">
	.mypage-box {
		height: 300px;
		background: url(/ModuHome/style/img/mypage_1.PNG) no-repeat;
		background-size: cover;
		color : #3c3c3c;
	}
	.mypage-smallbox {
		height: 140px;
		border: 1px solid #8b8e94;
	}

</style>


<div style="display:none;" class="load_mem_id" id="${memberModel.MEMBER_NUMBER }">
</div>
<div style="display:none;" class="mem_id" id="${sessionScope.MEMBER_NUMBER}">
</div>


<div class="modal fade follow" id="follow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <div class="modal-title" style="height:20px;">
        	<div class="container-fluid">
        		<div class="col-xs-9" style="align:left; text-align:left;"><h5 style="font:맑은고딕;"><strong id="follow_sub"></strong></h5></div>
        	</div>
        </div>
     </div>
      <div class="modal-body">
     	<div class="container-fluid">
			<div class="row" id="follow_cont">
	         <table style="width:100%" id="follow_table">

	         </table>
			</div>
	  	</div>
	  </div>
    </div>
  </div>
</div>

    <!-- Fixed navbar -->
    
<%--     <section class="probootstrap-section probootstrap-bg-white" >
      <div class="container">

        <div class="row">

          <div class="col-md-10">
              <div class="mypage-box"  align="center">
                  <li style="list-style: none;">
                    <div style="width: 100%; height: 100px;">
                      <img src="/ModuHome/style/img/img_sm_3.jpg" style="border-radius: 50%; width: 70px; height: 70px; margin-top: 20px; ">

                    <div style="font-size: 22px; margin-top: 20px;">${memberModel.MEMBER_NICKNAME }님</div>
                    </div>
					<div class="col-md-3"  style=" margin-top: 50px;"></div>
                    <div class="col-md-3"  style=" margin-top: 50px;">
                      <div style="font-size: 20px">팔로우</div>
                      <div><a onclick="followModal('followingList');" id="follow_quantity" style='font-family:나눔고딕,san-serif;font-size:12px;color:#555555;text-decoration:none;' >${follow_quantity }</a></div>
                    </div>  
                    <div class="col-md-3" style=" margin-top: 50px;">
                      <div style="font-size: 20px">팔로잉</div>
                      <div><a onclick="followModal('followerList');" id="following_quantity" style='font-family:나눔고딕,san-serif;font-size:12px;color:#555555;text-decoration:none;' >${following_quantity }</a></div>
                    </div>
                    <div class="col-md-12" style=" margin-top: 20px;">
						<c:if test="${memberModel.MEMBER_NUMBER != sessionScope.MEMBER_NUMBER}">
							<a onclick='follow("${memberModel.MEMBER_NUMBER }");' id="follow_btn" >
							
								<c:if test="${follow_exist == 0 }">
									<img src="/ModuHome/style/img/follow_btn.png" alt="follow_btn" style="width:100px;" />
								</c:if>
						        					
								<c:if test="${follow_exist == 1 }">
									<img src="/ModuHome/style/img/following_btn.png" alt="following_btn" style="width:100px;" />
								</c:if>
							</a>
						</c:if>                   
                    </div>
                  </li>
              </div>
          </div>
        </div>

        <div class="row">
        </div>
        
      </div>
    </section> --%>
  
<section class="flexslider">
      <ul class="slides">
        <li style="background-image: url(/ModuHome/style/img/myHome.jpg)" class="overlay">
          <div class="container">
            <div class="row">
              <div class="col-md-8 col-md-offset-2">
                <div class="probootstrap-slider-text text-center" style=" margin-top:300px;">
                  <h1 class="probootstrap-heading" style="font-size: 60px;"><span><strong>마이홈</strong></span></h1>
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
          <div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">
            <div class="col-md-12 probootstrap-animate" style="background: url(/ModuHome/style/img/mymain.png) no-repeat left 100%; background-size: cover; width: 100%; height: 300px;">

                <div class="col-md-4"></div>
                <div class="col-md-4">
                  <img src="/ModuHome/images/member/${memberModel.STORED_FILE_NAME }" style="border-radius: 50%; width: 150px; height: 150px; margin-top: 20px; margin-bottom: 5px;">
                  <span style="color: #212121;"><br>${memberModel.MEMBER_NICKNAME }님</span>
                </div>
                <div class="col-md-4" align="right" style=" margin: 30px 0px 0px 0px;">
                	<c:if test="${memberModel.MEMBER_NUMBER != sessionScope.MEMBER_NUMBER}">
						<a onclick='follow("${memberModel.MEMBER_NUMBER }");' id="follow_btn" >
			                <c:if test="${follow_exist == 0 }">
			                  	<img src="/ModuHome/style/img/follow_btn.png" style="width: 100px;">
			                </c:if>
			                <c:if test="${follow_exist == 1 }">
			                  	<img src="/ModuHome/style/img/following_btn.png" style="width: 100px;">
			                </c:if>
			            </a>
					</c:if>    
                </div>
    
              <div class="col-md-12">
                <!-- <div class="mypage-box" align="center"> -->
                  <li style="list-style: none;">
                    <div class="col-md-3"></div>
                    <div class="col-md-3">
                      <div style="font-size: 20px; color: #212121;">팔로우</div>
                      <div>
                        <a onclick="followModal('followingList');" id="follow_quantity" style='font-family:나눔고딕,san-serif;font-size:12px;color:#212121;text-decoration:none;' >${follow_quantity }</a>
                      </div>
                    </div>  
                    <div class="col-md-3">
                      <div style="font-size: 20px; color: #212121;">팔로잉</div>
                      <div>
                        <a onclick="followModal('followerList');" id="following_quantity" style='font-family:나눔고딕,san-serif;font-size:12px;color:#212121;text-decoration:none;' >${following_quantity }</a>
                      </div>
                    </div>
                  </li>
                <!-- </div> -->
              </div>
            </div>
          </div>
      </div>
    </div>
</section>    
    
    
<section class="probootstrap-section probootstrap-bg-white" style="padding:0px 0px 0px 0px;">
  <div class="container">
      <div class="row">
          <div class="col-md-12 text-center section-heading probootstrap-animate" data-animate-effect="fadeIn">

            <div class="col-md-12" style="margin:20px 0px 80px 0px;">
              <div class="col-md-3 text-center ">
                <div style="font-size:20px;"><strong>마이페이지<br/></strong></div>
              </div>
              <div class="col-md-3 text-center ">
                <div style="font-size:20px;"><strong>주문내역<br/></strong></div>
              </div>
              <div class="col-md-3 text-center ">
                <div style="font-size:20px;"><strong>활동내역<br/></strong></div>
              </div>
              <div class="col-md-3 text-center ">
                <div style="font-size:20px;"><strong>회원정보<br/></strong></div>
              </div>

              
              <div style="border-bottom: 1px solid #bcbcbc; margin-bottom: 10px;"><hr></div>
              <div class="col-md-3 text-center">
                <a href="/ModuHome/myHome">마이홈<br/></a>
                <a href="/ModuHome/noticeList">고객센터<br/></a>
              </div>            
              <div class="col-md-3 text-center ">
                <a href="/ModuHome/MyOrderList">내 주문내역<br/></a>
                <a href="/ModuHome/cart/cartList">장바구니<br/></a>
              </div>
              <div class="col-md-3 text-center" >
                <a href="/ModuHome/myStory">내 스토리<br/></a>
                <a href="/ModuHome/myCollecting">보관함<br/></a>
              </div>
              <div class="col-md-3 text-center">
                <a href="/ModuHome/MemberAuthForm">회원정보수정<br/></a>
                <a href="/ModuHome/MemberdeleteForm">탈퇴<br/></a>
              </div>    
            </div>  
          </div>
      </div>
    </div>
</section>  


    
    
</body>

<script type="text/javascript">
var state = "style";
var handler = null;
var isLoading = false;
var contNum = 1;
var follow_target ="";
var load_mem_id = parseInt($(".load_mem_id").attr("id"));

function followModal(state){
	if(state == 'followerList'){
		loadfollowerData();
		$("#follow_sub").text("팔로워");
		$('#follow').modal('show');
	}
	if(state == 'followingList'){
		loadfollowingData();
		$("#follow_sub").text("팔로잉");
		$('#follow').modal('show');
	}
}

function loadfollowerData() {
  var load_mem_id = parseInt($(".load_mem_id").attr("id"));
  $.ajax({
		type : 'post', 
		url : 'followerViewData',
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		dataType : 'json',
		data : JSON.stringify({
			follow : load_mem_id
		}),
		success: setfollowerData
  });
};

function loadfollowingData() {
  var load_mem_id = parseInt($(".load_mem_id").attr("id"));
  $.ajax({
		type : 'post', 
		url : 'followingViewData',
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		dataType : 'json',
		data : JSON.stringify({
			following : load_mem_id
		}),
		success: setfollowingData
  });
};

function setfollowerData(data) {

  var html = '';
  if(data != null){
		$(data).each(
			function(){
				console.log(this);
					
				html+=	"<tr>"
				    +     	"<td style='height:40px;width:20%;vertical-align:middle;align:middle;text-align:middle;'>"
				    + 			"<img src='/ModuHome/images/member/"+this.prof_img+"' alt='prof_img' style='width:33px;height:31px;' class='img-circle' />"
				    + 		"</td>"
				    + 		"<td style='height:40px;width:60%;vertical-align:top;align:left;text-align:left;'>"
				    + 			"<a  href='/ModuHome/myHome?MEMBER_NUMBER="+this.following+"' style='font-size:12px;font-weight:bold;color:#555555;font-family:나눔고딕;'>"+this.nickname+"</a><br>"
				    + 		"</td>"
				    + 		"<td style='height:40px;width:20%;vertical-align:middle;align:center;text-align:center;'>"
				    +			"<a href='#' onclick='followM(\""+this.follow_id+"\");' id='list_follow_btn"+this.follow_id+"' >"
					if(this.follow_to != 0){
					html+=			"<img src='/ModuHome/style/img/followList_del.png' alt='followList_Del' width='40px'>"
					}
					if(this.follow_to == 0){
					html+=			"<img src='/ModuHome/style/img/followList_reg.png' alt='followList_Reg' width='40px'>"
					}
				    html+=		"</a>"	
		   		 	+		"</td>"
				    + 	"</tr>";
			}	
		);
		  $('#follow_table').html(html);
	}
};

function setfollowingData(data) {
  var html = '';
  if(data != null){
		$(data).each(
			function(){
				console.log(this);
					
				html+=	"<tr>"
				    +     	"<td style='height:40px;width:20%;vertical-align:middle;align:middle;text-align:middle;'>"
				    + 			"<img src='/ModuHome/images/member/"+this.prof_img+"' alt='prof_img' style='width:33px;height:31px;' class='img-circle' />"
				    + 		"</td>"
				    + 		"<td style='height:40px;width:60%;vertical-align:top;align:left;text-align:left;'>"
				    + 			"<a  href='/ModuHome/myHome?MEMBER_NUMBER="+this.follow+"' style='font-size:12px;font-weight:bold;color:#555555;font-family:나눔고딕;'>"+this.nickname+"</a><br>"
				    + 		"</td>"
				    + 		"<td style='height:40px;width:20%;vertical-align:middle;align:center;text-align:center;'>"
				    +			"<a href='#' onclick='followM(\""+this.following_id+"\");' id='list_follow_btn"+this.following_id+"' >"
					if(this.follow_to != 0){
					html+=			"<img src='/ModuHome/style/img/followList_del.png' alt='followList_Del' width='40px'>"
					}
					if(this.follow_to == 0){
					html+=			"<img src='/ModuHome/style/img/followList_reg.png' alt='followList_Reg' width='40px'>"
					}
				    html+=		"</a>"	
		   		 	+		"</td>"
				    + 	"</tr>";
			}	
		);
		  $('#follow_table').html(html);
	}
};


function followM(follow_id){
  var mem_id = $(".mem_id").attr("id");
  follow_target = follow;
  $.ajax({
	  	type : 'post', 
		url : 'followDo.do',
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		dataType : 'json',
		data : JSON.stringify({
			follow : mem_id,
			following : follow
		}),
		success: followM_ok
  });
};

function followM_ok(data){
	var html = "";
	if(data == 1){
		html=	"<img src='/ModuHome/style/img/followList_del.png' alt='followList_Del' width='40px'>"
	}
	if(data == 0){
		html=	"<img src='/ModuHome/style/img/followList_reg.png' alt='followList_Reg' width='40px'>"
	}
	$('#list_follow_btn'+follow_target).html(html);
}

 function follow(load_mem_id){
	var mem_id = parseInt($(".mem_id").attr("id"))
	$.ajax({
		type : 'post', 
		url : 'followDo',
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		dataType : 'json',
		data : JSON.stringify({
			follow : load_mem_id,
			following : mem_id
		}),
		success: follow_ok
	});
};


function follow_ok(data){
	var html = "";
	var dual = "";
	if(data == 1){
		dual = parseInt($('#following_quantity').text())+1;
		html=	"<img src='/ModuHome/style/img/following_btn.png' alt='following_btn' style='width:100px;' />"
	}
	if(data == 0){
		dual = parseInt($('#following_quantity').text())-1;
		html=	"<img src='/ModuHome/style/img/follow_btn.png' alt='follow_btn' style='width:100px;' />"
	}

	$('#following_quantity').text(dual);
	$('#mini_follow_quantity').text(dual);
	$('#follow_btn').html(html);
}
	

</script>

</html>