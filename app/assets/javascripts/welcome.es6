var pageReady = function(){


	$('.demo').click(function(event){
		event.preventDefault();
		$('.demo_form').fadeIn(400);
		$('.demo').toggle();
	});

	$('.js-cancel_sched').click(function(event){
		event.preventDefault();
		$('.demo_form').toggle();
		$('.demo').fadeIn(400);
	});

	$('.js-schedule_demo').click(function(event){
		event.preventDefault();
		
		var new_demo = new Object();
		new_demo.first_name = $('.js-first_name').val();
		new_demo.last_name = $('.js-last_name').val();
		new_demo.email = $('.js-email').val();
		new_demo.phone_number = $('.js-phone_number').val();
		new_demo.date = $('.js-date').val();

		$.ajax({
			type:'POST',
			url:'/demos',
			data:new_demo,
			success:function(data){
				console.log(data);
				console.log('Demo Posted');

				$('.demo_form').toggle();
				$('.demo').fadeIn(400);
				$('#notice').toggle();

				setTimeout(function(){
					$('#notice').fadeOut(400);					
				}, 5000);
			}
		});
	});

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);