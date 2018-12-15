<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                  <h1 class="probootstrap-heading">보관한거 지우기 테스트</h1>
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
          
			<a href='#' onclick='collecting(${MG_NUMBER}, ${sessionScope.MEMBER_NUMBER });'><img src='/ModuHome/style/img/inbox.png' id="collect_img" alt='collect_img' width='20px'></a>
			<a id='collecting_quan'>${collecting_quan }</a>
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
		var collection_seq = 0;
		var cnt = 0;
		collecting_reg(mg_number, member_number);
	}
	
	function collecting(mg_number, member_number){
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
				success: collecting_ok
		  });
		};

		function collecting_ok(data){
			var html = "";
			var dual = "";
			if(data == 1){
				alert("매거진 담기가 완료되었습니다. 마이페이지에서 확인하세요!");
				dual = parseInt($('#collecting_quan').text())+1;

				$('#collect_img').attr({ /*빨간박스 바꿔줌  */
					'src' : '/ModuHome/style/img/oubox.png'
				}); 
			
			}
			if(data == 0){
				alert("매거진 담기를 취소하였습니다.");
				dual = parseInt($('#collecting_quan').text())-1;
				
				$('#collect_img').attr({ /*빈박스로 바꿔줌 */
					'src' : '/ModuHome/style/img/inbox.png'
				}); 
			}
			
			$('#collecting_quan').text(dual);
			$('#collect_img').html(html);

		}


</script>

</html>