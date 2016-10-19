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

	    	if(thisForm == 'rehearsal'){
	    		var nextRehearsal= $(".list_of_lesson_rehearsals > div").length + 1;
	    		$('.ba-videoplayer-theme-modern-rerecord-button-container').append("<span class='choose_rehearsal'>Scroll down to send rehearsal to your instructor</span>")
			    $.ajax({
		          type:'GET',
		          url:'/rehearsals/api',
		          success: function(data){

		            var sorted = data.sort(SortObjectsById);
		            var thisRehearsalId = sorted[sorted.length - 1].id;
		            var newrehearsal = `<div class="rehearsal_thumbnail">`+
		                                  `<button class="shadebox_btn rehearsal_btn" data-rehearsal="`+thisRehearsalId+`" data-rehearsalnumber="`+nextRehearsal+`">`+
		                                      `Rehearsal `+nextRehearsal+
		                                      `<div id="rehearsal_`+thisRehearsalId+`_status" class="blankdot"></div><br>`+
		                                      `<img src="`+videoImage(videoToken)+`" width="100%" class="rehearsal_img"><br>`+
		                                      `ref#: r`+((thisRehearsalId*30)+5)*7+`id`+thisRehearsalId+
		                                  `</button>`+
		                                `</div>`;
		            $('.list_of_lesson_rehearsals').append(newrehearsal);
		            // location.reload();
		            // window.location.href = "#send_to_instructor";
		            // window.location.replace("#send_to_instructor");
		          }
		        });
			}
    		if(thisForm == 'feedback'){
	    		$('.ba-videoplayer-theme-modern-rerecord-button-container').append("<span class='choose_rehearsal'>Your Feedback has been submitted. Reloading in 3 secs.</span>");
	    		setTimeout(function(){
	    			location.reload();
		    	}, 3500);
    		}
	    };

	    // ba-videoplayer-theme-modern-rerecord-frontbar
	    // ^^^^ Use this div to add button to submit rehearsal

	    $('.submit_ziggeo').hide();
	    $('.ba-videorecorder-theme-modern-chooser-primary-button').click(function(){
		    $('.save_ziggeo').hide();
	    });

	    recorder.on('verified', function() {
	    	$('.save_ziggeo').show();
	    	$('.submit_'+ziggeoClass).show();
	    	$('.submit_2').hide();
	    	// console.log('Ziggeo');

	    	var streamToken = recorder.get('stream');
	    	var videoToken = recorder.get('video');
	    	var thisForm = ziggeoClass.replace('Form','');
	    	
	    	if(thisForm == 'rehearsal'){
		    	$('.ba-videoplayer-theme-modern-rerecord-button').before("<button class='submit_rehearsal submit_ziggeo green_sft' style='float:right;' data-formname='rehearsal'><span>Save Rehearsal</span></button>");
	    	}
	    	if(thisForm == 'feedback'){
		    	$('.ba-videoplayer-theme-modern-rerecord-button').before("<button class='submit_feedback submit_ziggeo blue' style='float:right;' data-formname='rehearsal'><span>Send Feedback</span></button>");
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
				    	setTimeout(function(){
					    	$('.submit_'+ziggeoClass+' span').fadeIn(500);
				    	}, 700);
				    	$('.ba-videoplayer-theme-modern-rerecord-button').fadeOut(500);
				    	setTimeout(function(){
			    			$('.submit_'+ziggeoClass).fadeOut(500);
				    	}, 1500);
				    	setTimeout(function(){
				    		$('.ba-videoplayer-theme-modern-rerecord-button-container').append("<button class='record_another_rehearsal blue' style='float:right; display:none;'>Record Another Rehearsal</button>")
					        $('.record_another_'+ziggeoClass).hide(500);
					        $('.record_another_'+ziggeoClass).fadeIn(500);
				    	}, 2000);
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