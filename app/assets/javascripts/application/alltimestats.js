$(document).ready(function() {
  $('.alltime-sort').on('click', function(event) {
    event.preventDefault();

    var $route = $(this).attr('href');
    var $stat = $(this).attr('id');

    var $request = $.ajax({
      url: $route,
      data: { stat: $stat },
      success: function(data) {
        console.log('success');
      },
      complete: function (xhr, status) {
        console.log(xhr.status); // 200
      }
    });
  });
});