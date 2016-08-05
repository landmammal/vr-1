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

	if(expl==='3' && prompt==='3' && model==='3'){
		var lessonReady = ``;
		$('.lesson_ready').toggle();
		
		$('.js-trainee_view').click(function(){
			$('.show_trainee_view').fadeToggle(500);
		});
		
		$('.showIfLessonComplete').toggle();
	}
}

var pageReady = function(){

	var zig_rec_w = $('.lesson_half').width() - 10;
	var zig_play_w = $('.lesson_half').width() - 10;
	var zig_rec_h = zig_rec_w  / 1.77;
	var zig_play_h = zig_play_w  / 1.77;

	function recSize(item){ $(item).width(zig_rec_w).height(zig_rec_h); }
	function playSize(item){ $(item).width(zig_play_w).height(zig_play_h); }
	function changePropSize(element){ $(element).prop('width', zig_play_w); $(element).prop('height', zig_play_h); }
	function runChangeSize(){

		changePropSize('embed'); changePropSize('object'); changePropSize('ba-ziggeoplayer');

		playSize('.ziggeo_play_elem'); playSize('.video-player-inner'); playSize('.video-player-outer');
		playSize('.ba-videoplayer-theme-modern-overlay');
		playSize('.ba-videoplayer-theme-modern-stretch-height');

		recSize('.ziggeo_rec_elem'); recSize('div[data-view-id=cid_3]'); recSize('.video-recorder-flash');
		recSize('.ba-videorecorder-theme-modern-chooser-container');
		recSize('.ba-videorecorder-theme-modern-size-normal');
		recSize('.ba-videorecorder-theme-modern-size-medium');
		recSize('.ba-videorecorder-theme-modern-blue');
		recSize('.ba-videorecorder-noie8s');
		recSize('.ba-videorecorder-theme-modern-container');
		recSize('.ba-videorecorder-theme-modern-norecorder');
		recSize('.ba-videorecorder-theme-modern-video');
		recSize('.ba-videorecorder-theme-modern-overlay');
	}
	
	setInterval(function(){ runChangeSize(); }, 1000);

	$(window).resize(function(){
		zig_rec_w = $('.lesson_half').width() - 10;
		zig_play_w = $('.lesson_half').width() - 10;
		zig_rec_h = zig_rec_w  / 1.77;
		zig_play_h = zig_play_w  / 1.77;

		setInterval(function(){ runChangeSize(); }, 1000);
	});







	var lessonShowWindows = ['explanation', 'prompt', 'model'];
	var toRemove = lessonShowWindows.map((item) => item);
	
	function showLessonItem(name){
		$('.js-show_'+name).click(function(){
			var index = toRemove.indexOf(name);
			toRemove.splice(index, 1);

			var i = 0;
			do{	
				$('.'+toRemove[i]+'_video').hide();
				$('.js-show_'+toRemove[i]).addClass('green_sft'); 
				i+=1; 
			}while(i < toRemove.length);
			$('.'+name+'_video').show();
			$('.js-show_'+name).removeClass('green_sft'); 
			
			toRemove = lessonShowWindows.map((item) => item);

		});
	}

	var a = 0;
	do{	showLessonItem(lessonShowWindows[a]); a+=1; }while(a < lessonShowWindows.length);


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