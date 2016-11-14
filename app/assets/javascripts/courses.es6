function edit_or_start_course(course){
	var course = course;

	$('.js-edit_'+course).click(function(event){
		event.preventDefault();

        // console.log('clicked to edit')
        $('.edit_'+course).toggle();
        $('.more_'+course).toggle();
        $('.edit_sec_'+course).toggle();
        $('.card_desc_'+course).toggle();
    });

    
};




// function click_on_course(course_id, course_title){
// 	$('.js-c_'+course_id).click(function(event){
// 		event.preventDefault();													
// 		var node = document.getElementById('topics_for_'+course_id);
// 		var topics_list = node.innerHTML;

// 		$('.js-my_courses_list').hide();
// 		$('.js-my_topics_list').show();
// 		$('.js-topics_list').html(topics_list);
// 		$('.js-course_name').text(course_title);
// 		$('.js-cn').show();
// 		$('.js-course_form_hide').hide();

// 	});
// };

// function click_on_topic(topic_id, topic_title){
// 	$('.js-t_'+topic_id).click(function(action){
// 		action.preventDefault();							
// 		var node_2 = document.getElementById('lessons_for_'+topic_id)
// 		var lessons_list = node_2.innerHTML;

// 		$('.js-my_topics_list').hide();
// 		$('.js-my_lessons_list').show();
// 		$('.js-lessons_list').html(lessons_list);
// 		$('.js-topic_name').text(topic_title+' :: Lessons');
// 		$('.js-tn').show();
// 	});
// };

// function click_on_lesson(lesson_id){

// };









var pageReady = function(){

	$('.js-add_form_btn').click(function(event){
		event.preventDefault();
		var thisForm = $(this).data('form');
		$('.js-'+thisForm+'_form').fadeIn(500);

		$('html, body').animate({
	        scrollTop: $(".body").offset().top
	    }, 1000);
	});

	// $('.js-add_topic').click(function(){

	// });


	$('.js-cancel_form').click(function(event){
		event.preventDefault();
		var thisForm = $(this).data('form');
		$('.js-'+thisForm+'_form').fadeOut(500);
	});


	// $('#new_course').submit(function(event){
	// 	event.preventDefault();
	// 	$.ajax({
	// 		success:function(new_course_data){
	// 			console.log(new_course_data)

	// 			$('.js-open_form').fadeOut(500);

	// 			setTimeout(function(){
	// 		        $('.js-all_courses').fadeIn(200);
	// 		        $('.js-all_courses').append(new_course_data);
	// 			},500);
	// 		}
	// 	});
	// });

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);