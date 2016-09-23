function thisLessonsList(name, json_object){
	var newjson = railsToJson(json_object);
	// console.log(newjson);

	for(var i in newjson){
		var item = newjson[i];
		// console.log(item);
		var itemorder = parseInt(i)+1;
		if(item.position_prior == 1){ var ispriority = `<div class="greendot"></div>`; }else{
			var ispriority = ``;
		}

		var listOfItems = `<a href="/`+name+`/`+item.id+`/edit">`+
							itemorder+' - '+item.title+` `+ispriority+`</a><br>`;

		$('.js_listOf'+name).append(listOfItems);
	};
}

function allLessons( current_lesson, arr){
	var lessonsArray = railsToJson(arr);
	// console.log(current_lesson);
	// console.log(lessonsArray);
	// console.log(lessonsArray.length-1);
	var ind = lessonsArray.indexOf(current_lesson);
	var index = ind+1;
	// console.log(index);

	if(index===lessonsArray.length-1){
		$('.lesson_next').hide();
	}
	if(index===0){
		$('.lesson_previous').hide();
	}

}


function lessonProgress(les_type, expl_arr, prompt_arr, model_arr){
	// console.log(expl, prompt, model)

	var explanation_progress = progressStatus('explanation', expl_arr);
	var prompt_progress = progressStatus('prompt', prompt_arr);
	var model_progress = progressStatus('model', model_arr);

	var isReady = false;

	function progressStatus(name, stat){
		var statjson = railsToJson(stat);
		// console.log(statjson);

		var count_item = 0;
		var count_prior = 0;
		var token_check = '';
		
		for( var i in statjson){
			var item = statjson[i];
			// console.log(item);
			count_item += 1;
			var vid_token = typeof(item.video_token) == 'string';
			if(item.position_prior == '1'){ 
				count_prior += 1 

				if(vid_token){
					token_check = item.video_token;
				}else{ 
					token_check = '';
				}
			}
		}
		// console.log(token_check);
		// console.log(count_prior);

		function progressErr(errclass, err){
			$('.js-'+name+'_prog').addClass(errclass);
			$('.'+name+'_prog_err').text(err);
		}

		if(count_item > 0){
			if( count_prior > 1 ){ 
				isReady = false;
				progressErr('caution2 ion-alert', 'More than one has been set as Primary, please only choose one.');
				
			}else if( count_prior < 1 ){
				isReady = false;
				progressErr('caution2 ion-alert', 'At least one needs to be set as Primary');
			}else{
				if(token_check == ''){
					isReady = false;
					progressErr('caution1 ion-alert', 'Primary selection is missing video');
				}else{
					isReady = true;
					// console.log('READY');
					progressErr('ready ion-checkmark', name+' is ready');
					$('.js-'+name).addClass('ready');
				}
			}
		}else{
			isReady = false;
			progressErr('notready ion-close', 'You havent created one yet');
		}

		$('.js-'+name+'_prog').hover(function(){
			$('.'+name+'_prog_err').toggle();
		});
		return isReady;
	}

	var lesson_type = parseInt(les_type);
	var lessonReady = false;

	
	if( lesson_type == 0 || !lesson_type ){
		if(explanation_progress && prompt_progress && model_progress){ lessonReady = true; }
	}else if( lesson_type == 1 ){
		if(explanation_progress && model_progress){ lessonReady = true; }
	}else if( lesson_type == 2 ){
		if(explanation_progress && prompt_progress){ lessonReady = true; }
	}else if( lesson_type == 3 ){
		if(prompt_progress && model_progress){ lessonReady = true; }
	}


	if(lessonReady){
		$('.lesson_ready').show();
		
		$('.js-trainee_view').click(function(){
			$('.show_trainee_view').fadeToggle(500);
		});
		
		$('.showIfLessonComplete').show();
	}
}




function scriptOpacityToggle(video_type){
	// console.log(video_type);

	var opacity_slider = $('.'+video_type+'_script_opacity');
	var opacity_knob = $('.'+video_type+'_knob');
	var opacity_switch = $('.'+video_type+'_switch');

	opacity_slider.change(function(){
		// console.log($(this).val());
		$('.'+video_type+'_script').css('opacity', $(this).val());
	});

	opacity_switch.click(function(){
		$(opacity_knob).toggleClass('active');
		opacity_switch.toggleClass('active');

		if($(opacity_knob).hasClass('active')){
			opacity_slider.hide();
			$('.'+video_type+'_script').fadeOut(400);
		}else{
			opacity_slider.show();
			$('.'+video_type+'_script').fadeIn(parseInt(opacity_slider.val()));
		}
	});

}


var pageReady = function(){

	var lesson_videos = ['explanation','prompt','model','rehearsal'];

	var explanation =  '<button class="big_btn lesson_btn show_explanation">Explanation</button>';
	var demonstration =  '<button class="green_sft big_btn lesson_btn show_demonstrastion">Demonstration</button>';
	var practice =  '<button class="green_sft big_btn lesson_btn show_practice">Practice</button>';

	var lesson_type = parseInt($('.lesson_type').text());
	// console.log(lesson_type);

	var lesson_desc = '';

	if(lesson_type == 1 || lesson_type == 2 || lesson_type == 3 ){
		$('.thrd').width('48%');
		$('.progress_unit').width('50%');
	}

	if( lesson_type == 0  || !lesson_type ){
		$('.js-lesson_buttons').html(explanation+demonstration+practice);

	}else if(lesson_type == 1 || lesson_type == 2){
		$('.js-lesson_buttons').html(explanation+practice);
		$('.lesson_btn').width('19%');
		if( lesson_type == 1){ $('.prompt_check').hide(); $('.js-prompt').hide(); lesson_desc = 'This is a Demonstration lesson, you only need the Explanation and the Role Model.';}
		if( lesson_type == 2){ $('.model_check').hide(); $('.js-model').hide(); lesson_desc = 'This is a Question/Answer lesson, you only need the Explanation and the Prompt.';}

	}else if(lesson_type == 3){
		$('.js-lesson_buttons').html(demonstration+practice);
		$('.lesson_btn').width('19%');
		$('.explanation_check').hide(); $('.js-explanation').hide();

		lesson_desc = 'This is a direct lesson, you only need the Prompt and the Role Model.';

	}

	$('.lesson_desc').text(lesson_desc);

	$('.lesson_video_center').show();
	$('.explanation_video').show();

	function checkBtn(){
		if($('.lesson_btn').hasClass('green_sft')){
			$('.lesson_btn').addClass('green_sft');
		}
	}

	if($('.model_video').text() || $('.prompt_video').text() || $('.rehearsal_video').text()){
		var model_video = document.getElementsByClassName('model_video')[0].innerHTML;
		var prompt_video = document.getElementsByClassName('prompt_video')[0].innerHTML;
		var rehearsal_video = document.getElementsByClassName('rehearsal_video')[0].innerHTML;
	}

	function scrollToBody(){
		// console.log('BTN Pressed');
		$('html, body').animate({
	        scrollTop: $(".body").offset().top
	    }, 1000);
	};

	$('.show_explanation').click(function(){
		$('.lesson_vid').hide();
		checkBtn();
			$(this).toggleClass('green_sft');
			$('.lesson_video_center').show();
			$('.explanation_video').show();
			scrollToBody();
	});
	$('.show_demonstrastion').click(function(){
		$('.lesson_vid').hide();
		checkBtn();
			$(this).toggleClass('green_sft');
			$('.lesson_video_left').show();
			$('.lesson_video_left').html(prompt_video);
			$('.lesson_video_right').show();
			$('.lesson_video_right').html(model_video);
			scrollToBody();
	});
	$('.show_practice').click(function(){
		$('.lesson_vid').hide();
		checkBtn();
			$(this).toggleClass('green_sft');
			$('.lesson_video_left').show();
			$('.lesson_video_rehearsal').show();
			$('.rehearsal_video').show();
			if( lesson_type == 2){
				$('.lesson_video_left').html(prompt_video);
			}else{
				$('.lesson_video_left').html(model_video);
			}
			scrollToBody();
	});



	// var lessonShowWindows = ['explanation', 'prompt', 'model'];
	// var toRemove = lessonShowWindows.map((item) => item);
	
	// function showLessonItem(name){
	// 	$('.js-show_'+name).click(function(){
	// 		var index = toRemove.indexOf(name);
	// 		toRemove.splice(index, 1);

	// 		var i = 0;
	// 		do{	
	// 			$('.'+toRemove[i]+'_video').hide();
	// 			$('.js-show_'+toRemove[i]).addClass('green_sft'); 
	// 			i+=1; 
	// 		}while(i < toRemove.length);
	// 		$('.'+name+'_video').show();
	// 		$('.js-show_'+name).removeClass('green_sft'); 
			
	// 		toRemove = lessonShowWindows.map((item) => item);

	// 	});
	// }

	// var a = 0;
	// do{	showLessonItem(lessonShowWindows[a]); a+=1; }while(a < lessonShowWindows.length);




	$('.js-re_record').click(function(){
		$('.js-recorded_player').toggle();
		$('.js-re_record_ziggeo').toggle();

		if($('.js-re_record').text()==='Re-Record?'){
			$('.js-re_record').text('Cancel Re-Record');
		}else{
			$('.js-re_record').text('Re-Record?');
		}
	});


};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);