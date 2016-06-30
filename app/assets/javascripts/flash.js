
// Make the flash message disappear after 7 seconds
$(window).load(function(){
  $(".notice, .error").delay(7000).hide("slow")
});