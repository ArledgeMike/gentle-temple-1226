$(document).foundation();
  $('select#cut').on("change", function(){
	  var id = $('select#cut').val();
	$.ajax({
    	url: "/cut_that/" + id,
		type: "get",
		dataType: "html",
		success:function(data){
			console.log(data);
			
			$('#results').slideUp(function(){
					$(this).html("").append('<div class="results">' + data + '</div>').slideDown();
			});
			
			
		
		}
    });
	event.preventDefault();	
  });
