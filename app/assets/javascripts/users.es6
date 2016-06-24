var pageReady = function(){

	$('.js-new_c').click(function(event){
		event.preventDefault();
		$('.js-new_courses').show();
		$('.js-ongoing_courses').hide();		
		$('.js-completed_courses').hide();		
	});

	$('.js-ongoing_c').click(function(event){
		event.preventDefault();
		$('.js-new_courses').hide();
		$('.js-ongoing_courses').show();		
		$('.js-completed_courses').hide();		
	});

	$('.js-completed_c').click(function(event){
		event.preventDefault();
		$('.js-new_courses').hide();
		$('.js-ongoing_courses').hide();		
		$('.js-completed_courses').show();		
	});

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);