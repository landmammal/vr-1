function thisLessonsList(name, json_object){
	var newjson = railsToJson(json_object);
	// console.log(newjson);

	for(var i in newjson){
		var item = newjson[i];
		// console.log(item);

		if(item.position_prior == 1){ var ispriority = `<div class="greendot"></div>`; }else{
			var ispriority = ``;
		}

		var listOfItems = `<a href="/`+name+`/`+item.id+`/edit">`+
							item.title+` `+ispriority+`</a><br>`;

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


function lessonProgress(expl, prompt, model){
	// console.log(expl, prompt, model)

	progressStatus('explanation', expl);
	progressStatus('prompt', prompt);
	progressStatus('model', model);

	function progressStatus(name, stat){
		if(stat==='3'){
			$('.js-'+name+'_prog').addClass('ready ion-checkmark');
			$('.js-'+name).addClass('ready');
		}else if(stat==='2'){
			$('.js-'+name+'_prog').addClass('caution1 ion-alert');

			$('.'+name+'_prog_err').text('Primary selection is missing video');
			$('.js-'+name+'_prog').hover(function(){
				$('.'+name+'_prog_err').toggle();
			});
		}else if(stat==='1'){
			$('.js-'+name+'_prog').addClass('caution2 ion-alert');

			$('.'+name+'_prog_err').text('At least one needs to be set as Primary');
			$('.js-'+name+'_prog').hover(function(){
				$('.'+name+'_prog_err').toggle();
			});
		}else{
			$('.js-'+name+'_prog').addClass('notready ion-close');

			$('.'+name+'_prog_err').text('You havent created one yet');
			$('.js-'+name+'_prog').hover(function(){
				$('.'+name+'_prog_err').toggle();
			});
		}
	}

	var lesson_type = $('.lesson_type').text();
	var lessonReady = null;

	if( lesson_type === 1 ){
		if(expl==='3' && model==='3'){ lessonReady = true; }
	}else if( lesson_type === 2 ){
		if(expl==='3' && prompt==='3'){ lessonReady = true; }
	}else if( lesson_type === 3 ){
		if(prompt==='3' && model==='3'){ lessonReady = true; }
	}else{
		if(expl==='3' && prompt==='3' && model==='3'){ lessonReady = true; }
	}



	if(lessonReady){
		$('.lesson_ready').show();
		
		$('.js-trainee_view').click(function(){
			$('.show_trainee_view').fadeToggle(500);
		});
		
		$('.showIfLessonComplete').show();
	}
}

var pageReady = function(){

	var explanation =  '<button class="big_btn lesson_btn show_explanation">Explanation</button>';
	var demonstration =  '<button class="green_sft big_btn lesson_btn show_demonstrastion">Demonstration</button>';
	var practice =  '<button class="green_sft big_btn lesson_btn show_practice">Practice</button>';

	var lesson_type = $('.lesson_type').text();
	console.log(lesson_type);

	var lesson_desc = '';

	if(lesson_type != 0){
		$('.thrd').width('48%');
		$('.progress_unit').width('50%');
	}

	if(lesson_type == 1 || lesson_type == 2){
		$('.js-lesson_buttons').html(explanation+practice);
		$('.lesson_btn').width('19%');
		if( lesson_type == 1){ $('.prompt_check').hide(); $('.js-prompt').hide(); lesson_desc = 'This is a Demonstration lesson, you only need the Explanation and the Role Model.';}
		if( lesson_type == 2){ $('.model_check').hide(); $('.js-model').hide(); lesson_desc = 'This is a Question/Answer lesson, you only need the Explanation and the Prompt.';}

	}else if(lesson_type == 3){
		$('.js-lesson_buttons').html(demonstration+practice);
		$('.lesson_btn').width('19%');
		$('.explanation_check').hide(); $('.js-explanation').hide();

		lesson_desc = 'This is a direct lesson, you only need the Prompt and the Role Model.';

	}else{
		$('.js-lesson_buttons').html(explanation+demonstration+practice);
	}

	$('.lesson_desc').text(lesson_desc);

	$('.lesson_video_center').show();
	$('.explanation_video').show();

	function checkBtn(){
		if($('.lesson_btn').hasClass('green_sft')){
			$('.lesson_btn').addClass('green_sft');
		}
	}

	$('.show_explanation').click(function(){
		$('.lesson_vid').hide();
		checkBtn();
			$('.show_explanation').toggleClass('green_sft');
			$('.lesson_video_center').show();
			$('.explanation_video').show();
	});
	$('.show_demonstrastion').click(function(){
		$('.lesson_vid').hide();
		checkBtn();
			$('.show_demonstrastion').toggleClass('green_sft');
			$('.lesson_video_left').show();
			$('.lesson_video_right').show();
			$('.prompt_video').show();
			$('.model_video_2').show();
	});
	$('.show_practice').click(function(){
		$('.lesson_vid').hide();
		checkBtn();
			$('.show_practice').toggleClass('green_sft');
			$('.lesson_video_left').show();
			$('.lesson_video_right').show();
			$('.model_video_1').show();
			$('.rehearsal_video').show();
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