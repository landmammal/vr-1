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
			$('.js-courses_box_title').text('My courses');
		},600);
	});





	function course_box_change(title){
		$('.js-courses_box_title').text(title);
	}

	$('.js-course_form').click(function(){
		course_box_change('Creating new course');
	})

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);