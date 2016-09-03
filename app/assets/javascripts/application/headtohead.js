$(document).ready(function() {
  $('#h2h-form').on('submit', function(event) {
    event.preventDefault();

    var $route = $(this).attr('url');
    var $data = $(this).serializeArray();
    console.log($route);
    console.log($data);

    var $request = $.ajax({
      url: $route,
      data: $data
    });
  });


});