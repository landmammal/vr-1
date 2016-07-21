var pageReady = function(){
	var user_role = $('.js-user_role').text();
	var user_id = $('.js-user_id').text();

	if(['Trainee', 'Admin', 'Instructor'].includes(user_role)){
		$('.js-display_my_courses').show();
	}

	$('.js-back_to_courses').click(function(event){
		event.preventDefault();

		$('.js-my_courses_list').show();
		$('.js-my_topics_list').hide();
		$('.js-my_lessons_list').hide();

		$('.js-course_name').empty();
		$('.js-cn').hide();
		$('.js-topic_name').empty();
		$('.js-tn').hide();

		$('.js-course_form_hide').show();

	})
	$('.js-back_to_topics').click(function(event){
		event.preventDefault();

		$('.js-my_courses_list').hide();
		$('.js-my_topics_list').show();
		$('.js-my_lessons_list').hide();

		$('.js-topic_name').empty();
		$('.js-tn').hide();
	})

	// $.ajax({
	// 	url:'/courses/api',
	// 	success:function(data){
			
	// 		for(var courses in data){
	// 			var course = data[courses];
	// 			// console.log(course);

	// 			if(user_role === 'Trainee'){
	// 				var dispCrs= course.id+` - <a href="/courses/${course.id}">`+course.title+`</a><br>`+
	// 							 ``;
	// 				$('.js-my_courses').append(dispCrs);
	// 			}
	// 		}

	// 	}
	// });
};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);