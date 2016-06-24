var pageReady = function(){


	$('.demo').click(function(event){
		event.preventDefault();
		$('.demo_form').fadeIn(400);
		$('.demo').toggle();
	});

	$('.js-cancel_sched').click(function(event){
		event.preventDefault();
		$('.demo_form').toggle();
		$('.demo').fadeIn(400);
	});


};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);