// function edit_or_start_course(course){
// 	var course = course;

// 	$('.js-edit_'+course).click(function(event){
// 		event.preventDefault();

//         // console.log('clicked to edit')
//         $('.edit_'+course).toggle();
//         $('.more_'+course).toggle();
//         $('.edit_sec_'+course).toggle();
//         $('.card_desc_'+course).toggle();
//     });

    
// };




function componentToHex(c) {
    var hex = c.toString(16);
    return hex.length == 1 ? "0" + hex : hex;
}

function rgbToHex(r, g, b) {
    return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
}




var pageReady = function(){

	$('.activate_deactivate').click(function(){
		$(this).toggleClass('default green_sft');
	});
	$('.remove_student').click(function(){
		let vr = this;
		$(vr).closest('.user_bubble').fadeOut();
		setTimeout(function(){
			$(vr).closest('.user_bubble').remove();
		}, 1000);
	});

	$(document).on("change", 'form.edit_course', function(){
		if($(this).find('#course_privacy').val() === "2" ){
			$(this).find('.course_price').show();
		}else{
			$(this).find('.course_price').hide();
		}
	});
	$(document).on("change", 'form.new_course', function(){
		if($(this).find('#course_privacy').val() === "2" ){
			$(this).find('.course_price').show();
		}else{
			$(this).find('.course_price').hide();
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

	// TODO: CHECK TO SEE IF WE"RE STILL USING THIS FUNCTION
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