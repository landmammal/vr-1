function edit_or_start_course(course){
	var course = course;

	$('.js-edit_'+course).click(function(event){
		event.preventDefault();

        console.log('clicked to edit')
        $('.edit_'+course).toggle();
        $('.more_'+course).toggle();
        $('.edit_sec_'+course).toggle();
        $('.card_desc_'+course).toggle();
    });

		
	var user_registered = $('.js-user_registered_'+course).text();
	if( user_registered === 'registered'){
        
        $('.js-start_'+course).click(function(event){
			event.preventDefault();
            console.log('clicked to start');

        });

	}else{
           
        $('.js-start_'+course).click(function(event){
			event.preventDefault();
	        console.log('clicked to register');

	        console.log($('.js-course_id_'+course).text());
			console.log($('.js-user_id_'+course).text());
			console.log($('.js-user_role_'+course).text());

			var coursereg = new Object();
				coursereg.course_id = $('.js-course_id_'+course).text();
				coursereg.user_id = $('.js-user_id_'+course).text();
				coursereg.user_role = $('.js-user_role_'+course).text();

			$.ajax({
				type:'POST',
				url:'/course_registrations/api',
				data:coursereg,
				success:function(data){

			        console.log('registered')
			        $('.check_'+course).toggle();
			        $('.checked_'+course).toggle();

				}
			});
		});

	}
};


// function show_courses(){
// 	$.ajax({
// 		url:'/courses/api',
// 		success:function(data){

// 	        console.log('course created')
// 	        $('.js-all_courses').empty();

// 	        var new_courses = $('<%= escape_javascript(render "./courses/courses") %>');
// 	        $('.js-all_courses').html(new_courses);

// 			$('.js-open_form').fadeOut(500);

// 			setTimeout(function(){
// 		        $('.js-all_courses').fadeIn(200);
// 			},500);

// 		}
// 	});
// }


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
			$('.js-all_courses').show();
		},600);
	});

	$('.js-create_course').click(function(event){
		event.preventDefault();

		var newcourse = new Object();
			newcourse.title = $('.js-course_title').val();
			newcourse.description = $('.js-course_desccription').val();
			newcourse.tags = $('.js-course_tags').val();
			newcourse.status = $('.js-course_status').val();
			newcourse.instructor_id = $('.js-course_instructor').val();

		$.ajax({
			type:'POST',
			url:'/courses/api',
			data:newcourse,
			success:function(data){

		        console.log('course created')
		        $('.js-all_courses').empty();

		        var new_courses = $('<%= escape_javascript(render "./courses/courses") %>');
		        $('.js-all_courses').html(new_courses);

				$('.js-open_form').fadeOut(500);

				setTimeout(function(){
			        $('.js-all_courses').fadeIn(200);
				},500);

			}
		});
	});



	function course_box_change(title){
		$('.js-courses_box_title').text(title);
	};

	$('.js-course_form').click(function(){
		course_box_change('Creating new course');
		$('.js-all_courses').hide();
	});


};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);