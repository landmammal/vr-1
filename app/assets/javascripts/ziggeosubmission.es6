// console.log('Ziggeo es6 here');
var pageReady = function(){

	ZiggeoApi.Events.on("system_ready", function() {

	    var recorder = ZiggeoApi.V2.Recorder.findByElement($('ziggeorecorder#ziggeoRecorder'));
	    var ziggeoClass = recorder._parentElement.className;
	    // console.log(recorder);
	    // console.log(ziggeoClass);


	    function postTokenInForm(thisForm, videoToken, streamToken){
	    	var $form = $('.'+thisForm+'Form');
	    	$('#'+thisForm+'_video_token').val(videoToken);
	    	$('#'+thisForm+'_token').val(streamToken);
	    	$form.submit();

	    	// console.log(thisForm+" in submission");

	    	if(thisForm === 'rehearsal'){
	    		var nextRehearsal= $(".list_of_lesson_rehearsals > div").length + 1;
	    		$('.ba-videoplayer-theme-modern-rerecord-button-container').append("<span class='choose_rehearsal'>Scroll down to send to instructor</span>");

		        var newRehearseNum = parseInt($('.js-num_rehearsals').text()) + 1;
		        $('.js-num_rehearsals').text(newRehearseNum);
			}
    		if(thisForm === 'feedback'){
	    		$('.ba-videoplayer-theme-modern-rerecord-button-container').append("<span class='choose_rehearsal'>Your Feedback has been submitted. Reloading in 3 secs.</span>");
	    		setTimeout(function(){ location.reload(); }, 3500);
    		}
	    };

	    $('.submit_ziggeo').hide();
	    $('.ba-videorecorder-theme-modern-chooser-primary-button').click(function(){
		    $('.save_ziggeo').hide();
	    });

	    recorder.on('verified', function() {
	    	$('.save_ziggeo').show();
	    	$('.submit_'+ziggeoClass).show();
	    	// $('.submit_2').hide();
	    	// console.log('Ziggeo');

	    	var streamToken = recorder.get('stream');
	    	var videoToken = recorder.get('video');
	    	var thisForm = ziggeoClass.replace('Form','');
	    	
	    	if(thisForm === 'rehearsal'){
		    	$('.ba-videoplayer-theme-modern-rerecord-button-container').prepend("<button class='submit_rehearsal submit_ziggeo green_sft' style='float:right;' data-formname='rehearsal'><span>Save Rehearsal</span></button>");
	    	}
	    	if(thisForm === 'feedback'){
		    	$('.ba-videoplayer-theme-modern-rerecord-button-container').prepend("<button class='submit_feedback submit_ziggeo blue' style='float:right;' data-formname='feedback'><span>Send Feedback</span></button>");
	    	}

	    	if($('.submit_'+ziggeoClass).length > 0){
		    	$(document).on('click', '.submit_'+ziggeoClass, function() {
		    		// console.log('clicked');

			    	thisForm = $(this).data('formname');
			    	// console.log(thisForm);


			    	if(videoToken != ''){
			    		postTokenInForm(thisForm, videoToken, streamToken);

			    		$('.submit_'+ziggeoClass).addClass('submitted_ziggeo');
				    	$('.submit_'+ziggeoClass+' span').fadeOut(100);
				    	$('.submit_'+ziggeoClass+' span').empty();
				    	$('.submit_'+ziggeoClass+' span').addClass('ion-checkmark-circled');
				    	
					    $('.submit_'+ziggeoClass+' span').delay(700).fadeIn(500);
				    	
				    	$('.ba-videoplayer-theme-modern-rerecord-button').fadeOut(500);
				    	
			    		$('.submit_'+ziggeoClass).delay(1500).fadeOut(500);
				    	
			    		$('.ba-videoplayer-theme-modern-rerecord-button-container').delay(2000).append("<button class='record_another_rehearsal blue' style='float:right; display:none;'>Record Another Rehearsal</button>")
				        $('.record_another_'+ziggeoClass).delay(2000).hide(500);
				        $('.record_another_'+ziggeoClass).delay(2000).fadeIn(500);
				    	
			    	}
		    	});
		    }else{
		    	// console.log(thisForm+" form sent");
	    		postTokenInForm(thisForm, videoToken, streamToken);
		    }

		    function resetZiggeo(){
		    	// break;
		    	streamToken = "";
	    		videoToken = "";
		    }

		    $('.ba-videoplayer-theme-modern-rerecord-button').click(function(){
		    	resetZiggeo();
		    });
		    $('div[title=Re-Record]').click(function(){
		    	resetZiggeo();
		    });
		    $('.ba-videoplayer-theme-modern-playbutton-container').click(function(){
		    	$('.submit_2').fadeIn(500);
		    });

	    });
		
		$(document).on('click', '.record_another_'+ziggeoClass.replace('Form',''), function() {
			location.reload();
		});
	});

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);