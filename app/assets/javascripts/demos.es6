var pageReady = function(){

	$('.demo').click(function(event) {
		event.preventDefault();
		$('.demo').fadeToggle(500);
		$('#home_top_text').addClass('demo_open');
		$('.demo_form').delay(600).fadeToggle(500);
	});

	$('.js-cancel_sched').click(function(event){
		event.preventDefault();
		$('.demo_form').fadeToggle(500);
		$('.demo').delay(600).fadeToggle(500);
		$('.home_top_text').delay(600).removeClass('demo_open');
	});

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);