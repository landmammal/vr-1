var pageReady = function(){

	$('.js-show_form').click(function(event){
		event.preventDefault();

		$('.js-open_form').fadeIn(500);
		$('.js-show_form').hide();
		$('.js-cancel_form').show();
	});

	$('.js-cancel_form').click(function(event){
		event.preventDefault();

		$('.js-open_form').fadeOut(500);
		
		setTimeout(function(){
			$('.js-show_form').show();
		},600);
	});



};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);