var pageReady = function(){

	$('.js-create_newCourse').click(function(event){
		event.preventDefault();

		$('.js-new_course').fadeIn(500);
		$('.js-create_newCourse').hide();
		$('.js-cancel_newCourse').show();
	});

	$('.js-cancel_newCourse').click(function(event){
		event.preventDefault();

		$('.js-new_course').fadeOut(500);
		
		setTimeout(function(){
			$('.js-create_newCourse').show();
		},600);
	});


};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);