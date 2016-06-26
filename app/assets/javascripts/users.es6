var pageReady = function(){

	$('.js-my_f').click(function(event){
		event.preventDefault();
		$('.js-my_feedback').show();
		$('.js-my_courses').hide();		
		$('.js-completed_courses').hide();		
	});

	$('.js-my_c').click(function(event){
		event.preventDefault();
		$('.js-my_feedback').hide();
		$('.js-my_courses').show();		
		$('.js-completed_courses').hide();		
	});

	$('.js-completed_c').click(function(event){
		event.preventDefault();
		$('.js-my_feedback').hide();
		$('.js-my_courses').hide();		
		$('.js-completed_courses').show();		
	});

	$.ajax({
		url:'/courses/api/user_course',
		success:function(data){
			// console.log(data);
			for(var course in data){
				var id_adj = parseInt(course)+1; 
				// console.log(id_adj);

				// $('.js-c_'+id_adj).click(function(event){
				// 	console.log(id_adj);
				// });
			}
		}
	});

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);