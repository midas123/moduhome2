var account;

$(function(){
   $(".btn-close").live("click",function(){
      modal.close();
   });
   $(".page-heading strong").html($("#navigator option:selected").text())
   $('.catalog .addon .preview.button').on("click", function () {
      $('.action-preview').ajaxComplete(function(){
         selectboxChange();
      });
   });

   // modal 내의 select 값 변경시 적용
    $(document).on("change", ".selectbox select", function(){
        selectboxChange();
    });
   // modal 내의 select ajax 완료 후 호출
    $("#modal").ajaxComplete(function(){
      selectboxChange();
      input_auto_selected();
   });
});

function modal_label(label){
   $("#modal .modal-head h4").html(label);
}

$("#navigator").change(function(){
   location.href = $(this).val();
});

/*** 상단 검색창 포커스 ***/
$('.searchStore .nav-head').click(function () {
   ajax_search_keyword();
   $('.gnb-overlay, .globalNavigation .searchStore .nav-wrap').addClass('active');
   $('#input-searchKeyword').focus();
});
$('.globalHeader-search-mobile .icon').click(function () {
   ajax_search_keyword();
   $('#input-modal-searchKeyword').focus();
});
$('#input-searchKeyword').keyup(function () {
   var stxt = $("#input-searchKeyword").val();   
   ajax_search_keyword(stxt);
});
$('#input-modal-searchKeyword').keyup(function () {
   var stxt = $("#input-modal-searchKeyword").val();   
   ajax_search_keyword(stxt);
});
function ajax_search_keyword(stxt){
   var str="";
   $.getJSON("../main/ajax", {mode:"search", stxt:stxt}, function(data){

      $(".ajax-search-words").empty();
      $(data.words).each(function(idx, v){
         str = encodeURI("../store/search?stxt="+ v.word);
         $(".ajax-search-words").append("<a href='"+str+"' class='word'>" + v.word + "</a>");
      });

      $(".ajax-search-brand").html(data.brand);

      $(".ajax-search-contents").empty();
      $(data.contents).each(function(idx, v){
         $(".ajax-search-contents").append("<a href='../store/"+v.vid+"?no=" + v.contentsno + "'>" + v.contentstitle + "</a>");
      });

      $(".ajax-search-goods").html(data.goods);
      $(".ajax-search-editor").html(data.editor);   

   });
}

$(".btn-more-recently").click(function(){
   $(".product-recently-list li.hide").toggleClass("hide");
   $(this).remove();
});

$("form").submit(function(){
   $(this).find("input").removeAttr("disabled");
});

/*** input tag CSS 자동 처리 ***/
input_auto_selected();
function input_auto_selected(){
   $(".modal-content input[type=radio]").each(function(){
      if ($(this).is(":checked")) $(this).parents('.radio').addClass("selected");
      else $(this).parents('.radio').removeClass("selected");
   });
}

$(".modal-content input[type=radio]").live("click", function(){
   $(".modal-content input[name=" + $(this).attr("name") + "]").parents('.radio').removeClass("selected");
   $(this).parents('.radio').addClass("selected");
});
$(".modal-content input[type=checkbox]").live("click", function(){
   if ($(this).is(":checked")) $(this).parents('.checkbox').addClass("selected");
   else $(this).parents('.checkbox').removeClass("selected");
});

$('.list-short-cut .short-cut a[href*=#]:not([href=#]), .featured-view-sort-by .sort-by-category a[href*=#]:not([href=#])').live("click", function() {
   if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
         $('html,body').animate({
            scrollTop: target.offset().top
         }, 500);
         return false;
      }
   }
});

$(".auto_mail").change(function(){
   $(this).prev().val($(this).val());
});

$.fn.rowspan = function(colIdx, isStats) {       
    return this.each(function(){      
        var that;     
        $('tr', this).each(function(row) {      
            $('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
                 
                if ($(this).html() == $(that).html()
                    && (!isStats 
                            || isStats && $(this).prev().html() == $(that).prev().html()
                            )
                    ) {            
                    rowspan = $(that).attr("rowspan") || 1;
                    rowspan = Number(rowspan)+1;
 
                    $(that).attr("rowspan",rowspan);
                     
                    // do your action for the colspan cell here            
                    $(this).hide();
                     
                    //$(this).remove(); 
                    // do your action for the old cell here
                     
                } else {            
                    that = this;         
                }          
                 
                // set the that if not already set
                that = (that == null) ? this : that;      
            });     
        });    
    });  
}; 

$.fn.colspan = function(rowIdx) {
    return this.each(function(){
         
        var that;
        $('tr', this).filter(":eq("+rowIdx+")").each(function(row) {
            $(this).find('th').filter(':visible').each(function(col) {
                if ($(this).html() == $(that).html()) {
                    colspan = $(that).attr("colSpan") || 1;
                    colspan = Number(colspan)+1;
                     
                    $(that).attr("colSpan",colspan);
                    $(this).hide(); // .remove();
                } else {
                    that = this;
                }
                 
                // set the that if not already set
                that = (that == null) ? this : that;
                 
            });
        });
    });
}