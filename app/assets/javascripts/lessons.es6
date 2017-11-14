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


function checkComponent(){
	var elements = document.getElementsByClassName('progress_btn');

	console.log(elements);
	var i = 0;
	var checkClass = [];
	do{
		var classes = elements[i].className.split(' ');
		console.log(classes);

		if(classes.includes('ready')){ checkClass.push(true); }else{ checkClass.push(false);}
		console.log(checkClass);

		i++
	}while(i<elements.length);


	if(checkClass.includes(false)){
		return false;
	}else{
		return true;	
	}
}


function reloadIfTrue(){
	var reload = true;
	if($('.js-trainee_view').is(':visible')) {
		reload = false;
	}

	if(reload){ 
		if(checkComponent()){ location.reload(); }
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

			$('.js-'+name+'_prog').removeClass('caution2');
			$('.js-'+name+'_prog').removeClass('caution1');
			$('.js-'+name+'_prog').removeClass('ion-close');
			$('.js-'+name+'_prog').removeClass('ion-alert');
			$('.js-'+name+'_prog').removeClass('ion-checkmark');
			$('.js-'+name+'_prog').removeClass('notready');
			$('.js-'+name+'_prog').removeClass('ready');

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
					progressErr('ready ion-checkmark', '');
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
	
	$('.js-trainee_view').click(function(){
		$('.show_trainee_view').fadeToggle(500);
	});

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



function chooseRehearsal(rehearsal_id){
	
}


var pageReady = function(){

	var lesson_videos = ['explanation','prompt','model','rehearsal'];

	var explanation =  '<button class="selected lesson_btn show_explanation" data-group="lesson" data-frame="explanation">Step 1: Explanation</button>';
	var demonstration =  '<button class="lesson_btn show_demonstrastion" data-group="lesson" data-frame="demonstration">Step 2: Demonstration</button>';
	var practice =  '<button class="lesson_btn show_practice" data-group="lesson" data-frame="practice">Step 3: Rehearse</button>';

	var lesson_type = parseInt($('.lesson_type').text());
	// console.log(lesson_type);

	var lesson_desc = '';

	if(lesson_type == 1 || lesson_type == 2 || lesson_type == 3 ){
		$('.lesson_progress').width('49.5%');
		$('.progress_unit').width('50%');
	}

	if( lesson_type == 0  || !lesson_type ){
		$('.js-lesson_buttons').html(explanation+demonstration+practice);
		$('.model_video').addClass('practice');

	}else if(lesson_type == 1 || lesson_type == 2){
		$('.js-lesson_buttons').html(explanation+practice);
		$('.lesson_btn').width('19%');
		if( lesson_type == 1){ $('.prompt_check').hide(); $('.model_video').addClass('practice'); $('.js-prompt').hide(); lesson_desc = 'This is a Demonstration lesson, you only need the Explanation and the Role Model.';}
		if( lesson_type == 2){ $('.model_check').hide(); $('.prompt_video').addClass('practice'); $('.js-model').hide(); lesson_desc = 'This is a Question/Answer lesson, you only need the Explanation and the Prompt.';}

	}else if(lesson_type == 3){
		$('.js-lesson_buttons').html(demonstration+practice);
		$('.lesson_btn').width('19%');
		$('.explanation_check').hide(); $('.js-explanation').hide();

		lesson_desc = 'This is a direct lesson, you only need the Prompt and the Role Model.';

	}

	$('.lesson_desc').text(lesson_desc);

	$('.lesson_btn').click(function(){
		$('.lesson_btn').removeClass('selected');
		$(this).addClass('selected');

	    var embedding = ZiggeoApi.V2.Player.findByElement('ziggeoplayer');
	    embedding.stop();
	});

	// if($('.model_video').text() || $('.prompt_video').text()){
	// 	var explanation_video = document.document.getElementsByClassName('explanation_video')[0].innerHTML;
	// 	var model_video = document.getElementsByClassName('model_video')[0].innerHTML;
	// 	var prompt_video = document.getElementsByClassName('prompt_video')[0].innerHTML;
	// 	var rehearsal_video = document.getElementsByClassName('rehearsal_video')[0].innerHTML;
	// }


	function scrollToBody(){
		var bodyHTML = $('html, body');
		if(bodyHTML[1].scrollTop < 238){
			bodyHTML.animate({
		        scrollTop: $(".body").offset().top
		    }, 1000);
		}
	};


	// $('.explanation_video').removeClass('hide');
	// $('.explanation_video').addClass('full');

	$(document).on('click','.show_explanation' , function(){

		$('.explanation_video').removeClass('hide');
		$('.prompt_video').addClass('hide');
		$('.model_video').addClass('hide');
		$('.rehearsal_video').addClass('hide');
		scrollToBody();
	});

	$(document).on('click','.show_demonstrastion' , function(){

		$('.explanation_video').addClass('hide');
		$('.prompt_video').removeClass('hide');
		$('.model_video').removeClass('hide');
		$('.rehearsal_video').addClass('hide');
		scrollToBody();
	});

	$(document).on('click','.show_practice' , function(){

		$('.explanation_video').addClass('hide');
		$('.rehearsal_video').removeClass('hide');

		if( lesson_type == 2){
			$('.prompt_video').removeClass('hide');
			$('.model_video').addClass('hide');
		}else{
			$('.prompt_video').addClass('hide');
			$('.model_video').removeClass('hide');
		}
		scrollToBody();
	});

	// console.log($('.media_wrapper'));
	
	// if($('.media_wrapper').data('videotype') === "ziggeo" || !$('.media_wrapper').data('videotype')){
		if($('.media_wrapper').data('token') !== ''){
			$('.js-play_ziggeo').removeClass('hide');
			$('.js-re_create').text('Re Record');
			$('.js-re_create').removeClass('hide');
		}else{
			$('.js-record_ziggeo').removeClass('hide');
		}

		$('.js-re_create').click(function() {
			if($(".js-re_create").text() === 'Re Record'){
			  	$('.js-record_ziggeo').removeClass('hide');
			  	$('.js-play_ziggeo').addClass('hide');
			  	$(".js-re_create").text('Cancel');
			  }else{
			  	$(".js-re_create").text('Re Record');
			  	$('.js-record_ziggeo').addClass('hide');
			  	$('.js-play_ziggeo').removeClass('hide');
			  }
		});


		$(".training-path-1").click(function(){
			 var tmp_shift =$(".js-Video-container");
			 tmp_shift.clone().insertAfter(".rehearsal_Container");
			 tmp_shift.remove();
		});
		$(".training-path-2").click(function(){
		  
			var tmp_shift =$(".js-Video-container");
			tmp_shift.clone().insertBefore(".rehearsal_Container");
			tmp_shift.remove();
		});

	// }else if($('.media_wrapper').data('videotype') === "image"){

	// }else if($('.media_wrapper').data('videotype') === "youtube"){

	// }	

	// function changeuploadWindow(vidType){
		
	// 	function recreatebuttontext(text1, text2, window1, window2){
	// 		$('.js-re_create').removeClass('hide');
	// 		$('.js-re_create').text(text1);

	// 		$('.js-re_create').click(function() {
	// 		  if($(".js-re_create").text() === text1){
	// 		  	$(window1).removeClass('hide');
	// 		  	$(window2).addClass('hide');
	// 		  	$(".js-re_create").text(text2);
	// 		  }else{
	// 		  	$(".js-re_create").text(text1);
	// 		  	$(window1).addClass('hide');
	// 		  	$(window2).removeClass('hide');
	// 		  }
	// 		});
	// 	}

	// 	switch(vidType){
	// 	    case 'local':
	// 	    	console.log('local');
	// 	    	$('.image_holder').addClass('hide');
	// 	    	if($('.media_wrapper').data('token').length < 1){
	// 				$('.js-record_ziggeo').removeClass('hide');
	// 			}else{
	// 				recreatebuttontext('Re-Record?', 'Cancel Record', '.js-record_ziggeo', '.js-play_ziggeo');
	// 				$('.js-play_ziggeo').removeClass('hide');
	// 			}
	// 	        break;

	// 	    case 'youtube':
	// 	    	console.log('youtube');
	// 	    	if($('.media_wrapper').data('token').length < 1){
					
	// 			}else{

	// 			}
	// 	        break;

	// 	    case 'image':
	// 	    	console.log('image');
	// 	    	$('.ziggeo').addClass('hide');
	// 	    	$('.image_holder').removeClass('hide');
	// 	    	if($('.media_wrapper').data('token').length < 1){
	// 		    	$('.js-image_ready').hide();				
	// 		    	$('.js-image_upload').show();
	// 			}else{
	// 		    	$('.js-image_ready').show();				
	// 		    	$('.js-image_upload').hide();
	// 		    	recreatebuttontext('Re-upload?', 'Cancel upload', '.js-image_upload', '.js-image_ready');
	// 			}
	// 	        break;

	// 	    default:
	// 	    	console.log('default');
	// 	    	$('.js-record_ziggeo').toggleClass('hide');        
	// 	}
	// }

	// var startVideoType = $('.media_wrapper').data('videotype');
	// changeuploadWindow(startVideoType);

	// $('.edit_component').on('input', function(){
	// 	var videoType = $('.edit_component select option:selected').val();
	// 	changeuploadWindow(videoType);
	// });







	//PLAYHEAD and POSITION EVENTS
	ZiggeoApi.Events.on("system_ready", function(){

	    var displayPosition = function(thisPlayer){
	    	var embed = ZiggeoApi.V2.Player.findByElement(thisPlayer);
	    	var controlbar = $('#'+thisPlayer.prop('id')+' div div ba-videoplayer-controlbar');
			var position = controlbar.attr('ba-position');
			var duration = controlbar.attr('ba-duration');

			var durDif = duration-position;
	    	if(durDif>0.01){ 
	    		// console.log(durDif);
			    continuePlayer(thisPlayer);
	    	}else{
			    stoppedPlayer(thisPlayer, 0);
	    	}
	    }

	    function stoppedPlayer(thisPlayer, playhead){
	    	var playerID = thisPlayer.prop('id');
	    	// console.log(playerID, playhead);
	    	
	    	if(playerID.replace('_video_player','')==='prompt' && playhead < 0.03){
	    		var embed = ZiggeoApi.V2.Player.findByElement($('#model_video_player'));
	    		// setTimeout(function(){ embed.play();}, 400);
	    	}
	    	if(playerID.replace('_video_player','')==='model'){
	    		var embed = ZiggeoApi.V2.Recorder.findByElement($('.rehearsal'));
	    		// $('ziggeorecorder').attr('ziggeo-disable_first_screen', '');
	    		// embed.activate();
	    		// embed.record();
	    		// embed.reset();
	    	}
	    	return playhead;
	    }
	    function continuePlayer(thisPlayer){
	    	setTimeout(function(){
		    	displayPosition(thisPlayer);
		    }, 100);
	    }

	    $('.ba-videoplayer-theme-modern-playbutton-container').click(function(){
	    	var thisID = $(this).closest('ziggeoplayer');
	    	setTimeout(function(){ displayPosition(thisID); }, 200);
	    });
	    // 'i.ba-videoplayer-theme-modern-icon-play'
	    // 'i.ba-videoplayer-theme-modern-icon-pause'

	    $('.js-set_cue').click(function(){
	    	var thisID = $(this).data('videotype')+'_video_player';
	    	// console.log(thisID);
	    	var currentPosition = $('ziggeoplayer#'+thisID+' div div ba-videoplayer-controlbar').attr('ba-position');
		    console.log(currentPosition);
	    });
	});

    $('.lesson_btn').click(function(){
        $('.lesson_btn').removeClass('selected');
        $(this).addClass('selected');

        var model_embedding = ZiggeoApi.V2.Player.findByElement( document.getElementById('model_video_player') );
        var explanation_embedding = ZiggeoApi.V2.Player.findByElement( document.getElementById('explanation_video_player') );
        var prompt_embedding = ZiggeoApi.V2.Player.findByElement( document.getElementById('prompt_video_player') );
        model_embedding.stop();
        explanation_embedding.stop();
        prompt_embedding.stop();
    });
};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);
