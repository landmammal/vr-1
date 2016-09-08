var pageReady = function(){

	$('.js-course_register_btn').click(function(){
		$('.js-register_course').fadeOut(500);

		$('.js-register_confirm').html('<img src="/assets/checkmark.png" width="40px"><br> Thank you for registering for the course.<br> Please refresh the page to view the full course content.');
		setTimeout(function(){
			$('.js-register_confirm').fadeIn(500);
			setTimeout(function(){
				location.reload();
			}, 2500);
		}, 500);
	});

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);