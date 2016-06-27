var pageReady = function(){

	$('.js-my_f').click(function(event){
		event.preventDefault();
		$('.js-my_feedback').show();
		$('.js-my_courses').hide();		
		$('.js-completed_courses').hide();		
	});

	$('.js-my_c').click(function(event){
		event.preventDefault();
		$('.js-my_feedback').hide();
		$('.js-my_courses').show();		
		$('.js-completed_courses').hide();		
	});

	$('.js-completed_c').click(function(event){
		event.preventDefault();
		$('.js-my_feedback').hide();
		$('.js-my_courses').hide();		
		$('.js-completed_courses').show();		
	});

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);