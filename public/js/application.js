$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
//   Datatype needed?

  $('.button-click').on('click', function(e) {
    e.preventDefault();
    $.ajax({
          url:"/goals",
          type:'put',
          data: {id: $(this).attr("data-id")},
          dataType: 'JSON'
        }).done(function(serverData) {
          console.log(serverData)
          // Do action here
          // console.log(serverData);
        }).
          fail(function(serverData) {
            console.log("That... Did not work at all");
                      console.log(serverData);

    });
  });
});










