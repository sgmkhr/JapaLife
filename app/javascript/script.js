$(function() {
  $('#to_pagetop a').on('click', function(event) {
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});
