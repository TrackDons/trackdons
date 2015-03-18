/*

slide-1
slide-1-no
slide-2
slide-2-no
slide-3
slide-3-no
slide-4
slide-4-no

*/

jQuery(document).ready(function($){
  
  // to lazy to DRYize this, whoever is pissed of at this code is welcome to do it! ;) -- alvaro
  $('#slide-1 .btn-yes').on('click', function(event){
    event.preventDefault();
    slide(1, 2);
  });
  $('#slide-1 .btn-no').on('click', function(event){
    event.preventDefault();
    slide(1, '1-no');
  });
  $('#slide-2 .btn-yes').on('click', function(event){
    event.preventDefault();
    slide(2, 3);
  });
  $('#slide-2 .btn-no').on('click', function(event){
    event.preventDefault();
    slide(2, '3-no');
  });
  $('#slide-3 .btn-yes').on('click', function(event){
    event.preventDefault();
    slide(3, 4);
  });
  $('#slide-3 .btn-no').on('click', function(event){
    event.preventDefault();
    slide(3, '4-no');
  });

  function slide(from, to){
    // console.log("#slide-" + from + ' hide');
    // console.log("#slide-" + to + ' show');
    $("#slide-" + from).fadeOut(function() {
      $("#slide-" + to).fadeIn();
    });
    
  }

});