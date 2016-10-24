var pageReady = function(){


	$('.demo').click(function(event) {
		event.preventDefault();
		$('.demo').fadeToggle(500);
		$('#home_top_text').addClass('demo_open');
		$('.demo_form').delay(600).fadeToggle(500);
	});

	$('.js-cancel_sched').click(function(event){
		event.preventDefault();
		$('.demo_form').fadeToggle(500);
		$('.demo').delay(600).fadeToggle(500);
		$('.home_top_text').delay(600).removeClass('demo_open');
	});

	$('.js-schedule_demo').click(function(event){
		event.preventDefault();
		
		var new_demo = new Object();
		new_demo.first_name = $('.js-first_name').val();
		new_demo.last_name = $('.js-last_name').val();
		new_demo.email = $('.js-email').val();
		new_demo.phone_number = $('.js-phone_number').val();
		new_demo.date = $('.js-date').val();

		var formFilled = true;
		if($('.js-first_name').val().length === 0){ 
			var err_name = 'first name'; formFilled = false; 
		}else if($('.js-last_name').val().length === 0){ 
			var err_name = 'last name'; formFilled = false; 
		}else if($('.js-email').val().length === 0){ 
			var err_name = 'email'; formFilled = false; 
		}

		if(formFilled){
			$.ajax({
				type:'POST',
				url:'/demos',
				data:new_demo,
				success:function(data){
					// console.log(data);
					// console.log('Demo Posted');

					$('.demo_form').toggle();
					$('.check_mark').show();
					$('.check_mark').html('<img src="/assets/checkmark_white.gif" width="50px">');
					$('#notice').toggle();

					$('.js-form').val('');
					
					$('.check_mark').delay(2000).fadeOut(500);
					$('#notice').delay(2000).fadeOut(500);
					$('.demo').delay(2600).fadeIn(500);
					$('.home_top_text').delay(2600).removeClass('demo_open');

				}
			});
		}else{
			var err = 'The '+err_name+' field has not been filled in.';
			formERR(err);
		}
	});



};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);