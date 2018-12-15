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
	        	<div class="col-xs-3" style="align:right; text-align:right;">
	        		<a href="#" data-dismiss="modal">
	        			<img src="/style/resources/images/main/del_img.png" alt="del_img" style="height:60%;" />
					</a>								        	
	        	</div>
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
    
    <section class="probootstrap-section probootstrap-bg-white">
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
				    + 			"<img src='/style/resources/images/mem_prof/"+this.prof_img+"' alt='prof_img' style='width:33px;height:31px;' class='img-circle' />"
				    + 		"</td>"
				    + 		"<td style='height:40px;width:60%;vertical-align:top;align:left;text-align:left;'>"
				    + 			"<a  href='/style/myPageLikeCol.do?mem_id="+this.follow_id+"' style='font-size:12px;font-weight:bold;color:#555555;font-family:나눔고딕;'>"+this.nickname+"</a><br>"
				    + 			"<font style='font-size:11px;color:#555555;'>"+this.intro+"</font>"
				    + 		"</td>"
				    + 		"<td style='height:40px;width:20%;vertical-align:middle;align:center;text-align:center;'>"
				    +			"<a href='#' onclick='followM(\""+this.follow_id+"\");' id='list_follow_btn"+this.follow_id+"' >"
					if(this.follow_to != 0){
					html+=			"<img src='/style/resources/images/main/followList_del.png' alt='followList_Del' width='40px'>"
					}
					if(this.follow_to == 0){
					html+=			"<img src='/style/resources/images/main/followList_reg.png' alt='followList_Reg' width='40px'>"
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
				    + 			"<img src='/style/resources/images/mem_prof/"+this.prof_img+"' alt='prof_img' style='width:33px;height:31px;' class='img-circle' />"
				    + 		"</td>"
				    + 		"<td style='height:40px;width:60%;vertical-align:top;align:left;text-align:left;'>"
				    + 			"<a  href='/style/myPageLikeCol.do?mem_id="+this.following_id+"' style='font-size:12px;font-weight:bold;color:#555555;font-family:나눔고딕;'>"+this.nickname+"</a><br>"
				    + 			"<font style='font-size:11px;color:#555555;'>"+this.intro+"</font>"
				    + 		"</td>"
				    + 		"<td style='height:40px;width:20%;vertical-align:middle;align:center;text-align:center;'>"
				    +			"<a href='#' onclick='followM(\""+this.following_id+"\");' id='list_follow_btn"+this.following_id+"' >"
					if(this.follow_to != 0){
					html+=			"<img src='/style/resources/images/main/followList_del.png' alt='followList_Del' width='40px'>"
					}
					if(this.follow_to == 0){
					html+=			"<img src='/style/resources/images/main/followList_reg.png' alt='followList_Reg' width='40px'>"
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
		html=	"<img src='/style/resources/images/main/followList_del.png' alt='followList_Del' width='40px'>"
	}
	if(data == 0){
		html=	"<img src='/style/resources/images/main/followList_reg.png' alt='followList_Reg' width='40px'>"
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