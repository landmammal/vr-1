var pageReady = function(){


	$('.demo').click(function(event){
		event.preventDefault();
		$('.demo').fadeToggle(500);
		$('.home_top_text').addClass('demo_open');
		setTimeout(function(){
			$('.demo_form').fadeToggle(500);
		}, 600);
	});

	$('.js-cancel_sched').click(function(event){
		event.preventDefault();
		$('.demo_form').fadeToggle(500);
		setTimeout(function(){
			$('.demo').fadeToggle(500);
			$('.home_top_text').removeClass('demo_open');
		}, 600);
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
					console.log(data);
					console.log('Demo Posted');

					$('.demo_form').toggle();
					$('.check_mark').show();
					$('.check_mark').html('<img src="/assets/checkmark_white.gif" width="50px">');
					$('#notice').toggle();

					$('.js-form').val('');

					setTimeout(function(){
						$('.check_mark').fadeOut(500);
						$('#notice').fadeOut(500);					
						setTimeout(function(){
							$('.demo').fadeIn(500);
							$('.home_top_text').removeClass('demo_open');
						}, 600);
					}, 2000);

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