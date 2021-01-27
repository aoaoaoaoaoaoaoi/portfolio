$(function () {
 var headerHight = $('.gnav').height(); //ヘッダの高さ
 $('a[href^="#"]').click(function(){
     var href= $(this).attr("href");
       var target = $(href == "#" || href == "" ? 'html' : href);
        var position = target.offset().top - headerHight; //ヘッダの高さ分位置をずらす
     $("html, body").animate({scrollTop:position}, 550, "swing");
        return false;
   });
});