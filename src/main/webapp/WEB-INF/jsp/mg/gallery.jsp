<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>갤러리</title>

  
  </head>
  <body>

<section class="flexslider">
      <ul class="slides"> 
        <li style="background-image: url(/ModuHome/style/img/gallery2.jpg)" class="overlay">
          <div class="container">
            <div class="row">
              <div class="col-md-8 col-md-offset-2">
              
                <div class="probootstrap-slider-text text-center" style=" margin-top:300px;">
                  <h1 class="probootstrap-heading" style="font-size: 60px;"><span><strong>갤러리</strong></span></h1>
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
          <div class="col-md-12">
            <div class="portfolio-feed three-cols">
              <div class="grid-sizer"></div>
              <div class="gutter-sizer"></div>
              <div class="probootstrap-gallery">
              
              <c:forEach items="${glList}" var="glList" varStatus="status">
              
              <figure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject" class="grid-item probootstrap-animate">
                <a href="/ModuHome/images/mgMain/${glList.MG_TITLE_IMAGE}" itemprop="contentUrl" data-size="6000x4000">
                  <img src="/ModuHome/images/mgMain/${glList.MG_TITLE_IMAGE}" itemprop="thumbnail" alt="Free Bootstrap Template by uicookies.com" />
                </a>
                <figcaption itemprop="caption description">Image caption here</figcaption>
              </figure>
             
                </c:forEach>

              </div>

            </div>
          </div>
        </div>
      </div>
    </section>

    

   <!--  <section class="probootstrap-section">
      <div class="container">
        <div class="row">
          <div class="col-md-6 col-md-offset-3 text-center section-heading probootstrap-animate">
            <h2>Why Choose Us</h2>
            <p class="lead">Lorem ipsum dolor sit amet consectetur adipisicing elit. Iusto provident qui tempore natus quos quibusdam soluta at.</p>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="service left-icon probootstrap-animate">
              <div class="icon"><i class="icon-mobile3"></i></div>
              <div class="text">
                <h3>Consectetur Adipisicing</h3>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iusto provident qui tempore natus quos quibusdam soluta at.</p>
              </div>  
            </div>
            <div class="service left-icon probootstrap-animate">
              <div class="icon"><i class="icon-presentation"></i></div>
              <div class="text">
                <h3>Aliquid Dolorum Saepe</h3>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iusto provident qui tempore natus quos quibusdam soluta at.</p>
              </div>
            </div>
            <div class="service left-icon probootstrap-animate">
              <div class="icon"><i class="icon-circle-compass"></i></div>
              <div class="text">
                <h3>Eveniet Tempora Anisi</h3>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iusto provident qui tempore natus quos quibusdam soluta at.</p>
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="service left-icon probootstrap-animate">
              <div class="icon"><i class="icon-lightbulb"></i></div>
              <div class="text">
                <h3>Laboriosam Quod Dignissimos</h3>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iusto provident qui tempore natus quos quibusdam soluta at.</p>
              </div>  
            </div>
            
            <div class="service left-icon probootstrap-animate">
              <div class="icon"><i class="icon-magnifying-glass2"></i></div>
              <div class="text">
                <h3>Asperiores Maxime Modi</h3>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iusto provident qui tempore natus quos quibusdam soluta at.</p>
              </div>
            </div>
            
            <div class="service left-icon probootstrap-animate">
              <div class="icon"><i class="icon-browser2"></i></div>
              <div class="text">
                <h3>Libero Maxime Molestiae</h3>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iusto provident qui tempore natus quos quibusdam soluta at.</p>
              </div>
            </div>

          </div>
        </div>
        END row
      </div>
    </section> -->
 
    <!-- <footer class="probootstrap-footer">
      <div class="container">
        <div class="row">
          <div class="col-md-12 text-center">
              <ul class="probootstrap-footer-social">
                <li><a href="#"><i class="icon-twitter"></i></a></li>
                <li><a href="#"><i class="icon-facebook"></i></a></li>
                <li><a href="#"><i class="icon-github"></i></a></li>
                <li><a href="#"><i class="icon-dribbble"></i></a></li>
                <li><a href="#"><i class="icon-linkedin"></i></a></li>
                <li><a href="#"><i class="icon-youtube"></i></a></li>
              </ul>
          </div>
        </div>
        END row
        <div class="row">
          <div class="col-md-12 copyright text-center">
            <p>&copy; 2017 <a href="https://uicookies.com/">uiCookies:FineOak</a>. All Rights Reserved. <br> Designed &amp; Developed with <i class="icon icon-heart"></i> by <a href="https://uicookies.com/">uicookies.com</a></p>
          </div>
        </div>
      </div>
    </footer> -->
    



    
 
    <div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="pswp__bg"></div>
      <div class="pswp__scroll-wrap">

          <div class="pswp__container">
              <div class="pswp__item"></div>
              <div class="pswp__item"></div>
              <div class="pswp__item"></div>
          </div>

          <div class="pswp__ui pswp__ui--hidden">
              <div class="pswp__top-bar">
                  <div class="pswp__counter"></div>
                  <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>
                  <button class="pswp__button pswp__button--share" title="Share"></button>
                  <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>
                  <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>
                  <div class="pswp__preloader">
                      <div class="pswp__preloader__icn">
                        <div class="pswp__preloader__cut">
                          <div class="pswp__preloader__donut"></div>
                        </div>
                      </div>
                  </div>
              </div>
              <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                  <div class="pswp__share-tooltip"></div> 
              </div>
              <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
              </button>
              <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
              </button>
              <div class="pswp__caption">
                  <div class="pswp__caption__center"></div>
              </div>
          </div>
      </div>
    </div>

  </body>
</html>