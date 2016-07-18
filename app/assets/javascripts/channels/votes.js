$(document).ready(function() {
  $('.vote-form').on('submit', function(event) {
    event.preventDefault();

    var $route = $('this').attr('href');
    var $data = $('this').serialize();
    console.log($route);
    console.log($data);
    var $request = $.ajax({
      method: 'POST',
      url: $route
    })

    $request.done(function(response) {
      $('#' + $route).text('Thank you for voting!')
    });
  });

});