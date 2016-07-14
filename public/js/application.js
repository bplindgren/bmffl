$(document).ready(function({

  $('#standings-type').on('submit', function(event) {
    event.preventDefault();

    var $route = $this.attr('action')
    var $data = $this.serialize()
    var $request = $.ajax({
      method: 'GET',
      url: $route,
      data: $data,
    });

    $request.done(function(partial) {
      $('#full-league-standings-table').append(partial);
      console.log(partial)
    });
  });

})

