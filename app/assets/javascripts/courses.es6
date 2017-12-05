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

	$('form.edit_course').on("change", function(){
		if($('#course_privacy').val() === "2" ){
			$('.course_price').show();
		}else{
			$('.course_price').hide();
		}
	});
	$('form.new_course').on("change", function(){
		if($('#course_privacy').val() === "2" ){
			$('.course_price').show();
		}else{
			$('.course_price').hide();
		}
	});


	$('#btn-buy').click(function(){
		console.log("HEY");
		setTimeout(function(){
			$('.Modal-form input[type="email"]').hide();
		}, 1000)
	});

	$('#emails').on("input", function(){
		let text = $(this).val();
		let newF = new Object();
		newF.emails = text;
		
		setTimeout(function(){

			$.ajax({
				url: "/email_exits",
				type:"post",
				data:newF,
				success: function(data){

					setTimeout(function(){
						if(data.multipl){						
							$('.multiple_emails').show();
							$('.does_not_exist').hide();
							$('.auto_add').fadeOut();					
						}else if(data.found){
							$('.does_not_exist').hide();
							$('.auto_add').fadeIn();
							$('.multiple_emails').hide();
						}else{
							if(newF.emails===""){ 
								$('.does_not_exist').hide(); 
							}else{
								$('.does_not_exist').show();
							}
							$('.auto_add').fadeOut();
							$('.multiple_emails').hide();
						}
					}, 500);

				},error: function(e){

					console.log("ERROR");

				}
			});

		}, 500);
	});

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

	
	$("#generate_new_access_code").click(function(e){
		e.preventDefault();

		$.ajax({
			type:"GET",
			url:'/generate_course_code/',
			success: function(data){
			  $('.access_code').val(data["new code"]); 
			},
			error: function(e){
				console.log("ERROR: "+e);
			}
		});
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