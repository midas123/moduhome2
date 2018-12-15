<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <li style="background-image: url(img/slider_1.jpg)" class="overlay">
          <div class="container">
            <div class="row">
              <div class="col-md-8 col-md-offset-2">
                <div class="probootstrap-slider-text text-center">
                  <h1 class="probootstrap-heading">환영합니다</h1>
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

          <div class="col-md-4 probootstrap-animate"></div>
           
          <div class="col-md-4 probootstrap-animate">
            <form action="/ModuHome/login" method="post" class="probootstrap-form">

              <div class="form-group">
                <label for="id">회원가입 성공</label>
              </div>


              <a href="/ModuHome/loginForm" style="margin-left: 100px">로그인 화면으로</a>
            </form>
          </div>

          <div class="col-md-4 probootstrap-animate"></div>
          
        </div>
      </div>
    </section>   
   

</body>
</html>