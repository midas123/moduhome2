<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>first</title>
</head>
<body>

    <section class="flexslider">
      <ul class="slides">
        <li style="background-image: url(/ModuHome/style/img/slider_1.jpg)" class="overlay">
          <div class="container">
            <div class="row">
              <div class="col-md-8 col-md-offset-2">
                <div class="probootstrap-slider-text text-center">
                  <h1 class="probootstrap-heading">보관하기 테스트</h1>
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
          <div class="col-md-6 col-md-offset-3 text-center section-heading probootstrap-animate">
          
			<a href='#' onclick='collecting_reg(${MG_NUMBER}, ${sessionScope.MEMBER_NUMBER });'><img src='/ModuHome/style/img/inbox.png' alt='heart_img' width='20px'></a>
			<h6 id='collecting_quan'>${collecting_quan }</h6>
			
            <h3>게시글번호는 ${MG_NUMBER}</h3>

            <h3>매거진 글제목</h3>

            <h3>세션 사용자  ${sessionScope.MEMBER_NICKNAME} </h3>
  

          </div>
        </div>
        <!-- END row -->
        <div class="row mb40">
          <div class="col-md-6 probootstrap-animate">
            <p></p>
          </div>
          <div class="col-md-6 probootstrap-animate">
            <p></p>
          </div>
        </div>
        <!-- END row -->

      </div>
    </section>

</body>

<script>

	function collecting(mg_number){
		document.getElementById("mg_number").value = mg_number;
		loadCollectingData();
		collec_submit()
		$('#collecting').modal('show');
	}
	
	function collec_submit(){
		var mg_number = document.getElementById("mg_number").value;
		var member_number = 61;
		collecting_reg(mg_number, member_number);
	}

	function collecting_reg(mg_number, member_number){
	  $.ajax({
			type : 'post', 
			url : 'collectingReg',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'json',
			data : JSON.stringify({
				mg_number : mg_number,
				member_number : member_number
			}),
			success: collecting_reg_ok
	  });
	};

	function collecting_reg_ok(data){
		if(data == 1){

			alert("매거진 담기가 완료되었습니다. 마이페이지에서 확인하세요!");
			var dual = parseInt($('#collecting_quan').text())+1;
			$('#collecting_quan').text(dual);
			
		}else{
			alert("이미 담기가 완료된 매거진입니다.");
		} 
	}

	function loadCollectingData() {
	  var mem_id = $(".Session_mem_id").attr("id");
	  $.ajax({
			type : 'post', 
			url : 'collectingViewData.do',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'json',
			data : JSON.stringify({
				id : mem_id
			}),
			success: setCollectingData
	  });
	};

	function setCollectingData(data) {

	  var html = '';
	  if(data != null){
			$(data).each(
				function(){
					console.log(this);
						
					html+=	"<tr>"
					    +     	"<td style='height:40px;width:30%;vertical-align:middle;align:middle;text-align:middle;'>"
					    + 			"<img src='/style/resources/images/collection_img/"+this.imgname+"' alt='"+this.imgname+"' class='img-rounded' style='width:90%;height:90%;'/>"
					    + 		"</td>"
					    + 		"<td style='height:40px;width:60%;vertical-align:top;align:left;text-align:left;'>"
					    + 			"<strong style='font-size:12px;font-family:나눔고딕;'>"+this.subject+"</strong><br>"
					    + 			"<font style='font-size:11px;color:#555555;'>"+this.nickname+"</font>"
					    + 		"</td>"
					    + 		"<td style='height:40px;width:10%;vertical-align:middle;align:center;text-align:center;'>"
					    + 			"<input type='radio' name='collection_seq' id='collection_seq' value='"+this.collection_seq+"'>"
					    + 		"</td>"
					    + 	"</tr>";
				}	
			);

			  $('#collecting_table').html(html);
			  
		}else{
			alert("등록된 컬렉션 목록이 없습니다. 먼저 컬렉션을 등록해주세요.");
		}
	};

</script>

</html>