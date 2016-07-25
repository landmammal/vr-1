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

			$('.'+name+'_prog_err').text('Missing the video');
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
		var lessonReady = `<div class="lesson_ready">Lesson is ready to go</div>`;
		$('.lesson_progress_bar').prepend(lessonReady);

		$('.showIfLessonComplete').toggle();
	}
}

var pageReady = function(){


	var zig_rec_w = window_width / 2.5;
	var zig_rec_h = zig_rec_w  / 1.77;
	// $('.ziggeo_rec_elem').width(zig_rec_w).height(zig_rec_h);
	
	var zig_play_w = window_width / 2.4;
	var zig_play_h = zig_play_w  / 1.77;
	// $('.ziggeo_play_elem').width(zig_play_w).height(zig_play_h);
	// $('.video-player-outer').width(zig_play_w).height(zig_play_h);
	// $('.video-player-content').width(zig_play_w).height(zig_play_h);

	$(window).resize(function(){
		zig_rec_w = $(window).width() / 2.5;
		zig_rec_h = zig_rec_w  / 1.77;
		// $('.ziggeo_rec_elem').width(zig_rec_w).height(zig_rec_h);

		var zig_play_w = $(window).width() / 2.2;
		var zig_play_h = zig_play_w  / 1.77;
		// $('.ziggeo_play_elem').width(zig_play_w).height(zig_play_h);
		// $('.video-player-outer').width(zig_play_w).height(zig_play_h);
		// $('.video-player-content').width(zig_play_w).height(zig_play_h);
	});

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);