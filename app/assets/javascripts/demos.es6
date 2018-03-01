var pageReady = function(){

	$('.demo').click(function(event) {
		event.preventDefault();
		$('.demo').fadeToggle(500);
		$('.demo_form').delay(600).fadeToggle(500);
	});

	$('.js-cancel_sched').click(function(event){
		event.preventDefault();
		$('.demo_form').fadeToggle(500);
		$('.demo').delay(600).fadeToggle(500);
	});

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);