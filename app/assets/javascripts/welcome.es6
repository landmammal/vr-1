var pageReady = function(){





	var homeTitleChange = ['Interview Skills', 'Languages', 'Pronunciation', 'Customer Service', 'Anything'];
	$('.js-learn_home').text(homeTitleChange[0]);
	
	console.log(homeTitleChange.length);

	var i = 1;
	
	function homeChange(){
		if(i < homeTitleChange.length){
			setTimeout(function(){
				$('.js-learn_home').text(homeTitleChange[i]);
				// console.log(i);
				i+=1;
				runChange();
			}, 1500);
		}else{
			setTimeout(function(){
				$('.js-learn_home').fadeOut(1000);
				$('.js-start').fadeOut(1000);
			}, 1100);
			setTimeout(function(){
				$('.js-title').fadeIn(1000);
			}, 2100);

			setTimeout(function(){
				i = 0;
				$('.js-title').fadeOut(500);
				$('.js-learn_home').text(homeTitleChange[i]);
				setTimeout(function(){
					$('.js-learn_home').fadeIn(1500);
					$('.js-start').fadeIn(1500);
				}, 2100);
				runChange();
			}, 5000);
		}
	}

	function runChange(){
		homeChange();
	}


	homeChange();
	

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