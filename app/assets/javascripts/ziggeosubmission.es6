// console.log('Ziggeo es6 here');
var pageReady = function(checkrecorder){
	if(checkrecorder === true){
		ZiggeoApi.Events.on("system_ready", function() {

			var recorders = document.getElementsByClassName('ziggeo_recorder');
			// console.log(recorders);

			$.each(recorders, function( index, value ) {
				var recorderClass = value.className.split(' ')[0];
				// console.log(recorderClass);

        // save explanation,prompt,model if there is an image in the form
        $('#img_prev').hide();
        $(document).on('change', '.uploaded', function() {
          $('.ziggeo').remove();
          $('#img_prev').show();
        
          var input = this;
          if (input.files && input.files[0]) {
          var reader = new FileReader();

          reader.onload = function (e) {
            $('#img_prev')
              .attr('src', e.target.result)
              .width(150)
              .height(200);
          };

          reader.readAsDataURL(input.files[0]);
          }
          var streamToken = 'no video';
          var videoToken = 'no video';
          var thisForm = recorderClass;
           $('.save_'+recorderClass).show();
           // console.log('component');
           $('.save_'+recorderClass).click(function() {
             postTokenInForm(thisForm, videoToken, streamToken);
             if($(this).hasClass('shade_close')){
               $('.shadebox_bg').removeClass('open');
               recorder.reset();
             }
           });
         })

			    var recorder = ZiggeoApi.V2.Recorder.findByElement($('ziggeorecorder.'+recorderClass));
			    // console.log(recorder);
			    // recorder.record();

			  $(document).on('click', '.shade_close', function() {
					recorder.reset();
					$(this).closest('.shadebox').find('.save_'+recorderClass).show();
					$(this).closest('.shadebox_bg').find('form')[0].reset();
					// console.log('clicked')
				});

			    function postTokenInForm(thisForm, videoToken, streamToken){
			    	var $form = $('.'+thisForm+'Form');
			    	$('#'+thisForm+'_video_token').val(videoToken);
			    	$('#'+thisForm+'_token').val(streamToken);
			    	$form.submit();

			    	// console.log(thisForm+" in submission");

			    	if(thisForm === 'rehearsal'){
			    		var nextRehearsal= $(".list_of_lesson_rehearsals > div").length + 1;
			    		$('.ba-videoplayer-theme-modern-rerecord-button-container').append("<span class='choose_rehearsal'>Choose submission from thumbnails below</span>");

				        var newRehearseNum = parseInt($('.js-num_rehearsals').text()) + 1;
				        $('.js-num_rehearsals').text(newRehearseNum);
					}
		    		if(thisForm === 'feedback'){
			    		$('.ba-videoplayer-theme-modern-rerecord-button-container').append("<span class='choose_rehearsal'>Your Feedback has been submitted. Reloading in 3 secs.</span>");
			    		setTimeout(function(){ location.reload(); }, 3500);
			    		// setTimeout(function(){ recorder.reset(); }, 3500);
		    		}
			    };


			    $('.submit_ziggeo').hide();
			    // $('.save_'+recorderClass).hide();
			    $('.ba-videorecorder-theme-modern-button-primary').click(function() {
				    $('.save_ziggeo').hide();
				    $(this).closest($('.component_wrapper')).find($('.save_'+recorderClass)).hide();
				    // console.log('clicked');
				});

				$(document).on("click", ".ba-videorecorder-button-primary[data-selector=stop-primary-button]", function(){
					$('.recorder_please_wait').fadeIn(1000);
				});


				recorder.on('recording', function() {
				});

			    recorder.on('verified', function() {
			    	// console.log('Ziggeo');

			    	var streamToken = recorder.get('stream');
			    	var videoToken = recorder.get('video');
			    	var thisForm = recorderClass;
					// console.log(thisForm+" 01 ");
					$('.recorder_please_wait').hide();


			    	setTimeout(function(){
				    	if(thisForm == 'rehearsal'){
				    		// console.log(" PUT BUTTON");
					    	$('.ba-videoplayer-theme-modern-rerecord-button-container').prepend("<button class='submit_rehearsal submit_ziggeo green_sft' style='float:right;' data-formname='rehearsal'><span>Save Rehearsal</span></button>");
				    	}
				    	if(thisForm == 'feedback'){
					    	$('.ba-videoplayer-theme-modern-rerecord-button-container').prepend("<button class='submit_feedback submit_ziggeo blue' style='float:right;' data-formname='feedback'><span>Send Feedback</span></button>");
				    	}
			    	}, 600);

			    	if($('.submit_'+recorderClass).length > 0){
			    		$('.submit_'+recorderClass).show();
				    	// $('.submit_2').hide();

				    	$(document).on('click', '.submit_'+recorderClass, function() {
				    		// console.log('clicked');

					    	thisForm = $(this).data('formname');
					    	// console.log(thisForm+" 02 ");


					    	if(videoToken != ''){
					    		postTokenInForm(thisForm, videoToken, streamToken);

					    		// $('.submit_'+recorderClass).addClass('submitted_ziggeo');
						    	$('.submit_'+recorderClass+' span').fadeOut(100);
						    	$('.submit_'+recorderClass+' span').empty();
						    	$('.submit_'+recorderClass+' span').addClass('ion-checkmark-circled');

							    $('.submit_'+recorderClass+' span').delay(700).fadeIn(500);

						    	$('.ba-videoplayer-theme-modern-rerecord-button').fadeOut(500);

					    		$('.submit_'+recorderClass).delay(1500).fadeOut(500);

					    		$('.ba-videoplayer-theme-modern-rerecord-button-container').delay(2000).append("<button class='record_another_rehearsal blue' style='float:right; display:none;'>Record Another</button>")
						        $('.record_another_'+recorderClass).delay(2000).hide(100);
						        $('.record_another_'+recorderClass).delay(2000).fadeIn(100);

					    	}
				    	});
				    }else if($('.save_ziggeo').length > 0){
				    	// console.log(thisForm+" form sent");
				    	$('.save_ziggeo').show();
			    		postTokenInForm(thisForm, videoToken, streamToken);
				    }else{
				    	$('.save_'+recorderClass).show();
				    	console.log('component');
				    	$('.save_'+recorderClass).click(function() {
					    	postTokenInForm(thisForm, videoToken, streamToken);
					    	if($(this).hasClass('shade_close')){
					    		$('.shadebox_bg').removeClass('open');
					    		recorder.reset();
					    	}
				    		// $('form.'+recorderClass+'Form')[0].reset();
				    	});
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

				$(document).on('click', '.record_another_'+recorderClass, function() {
					location.reload();
					// recorder.reset();
					// $('.rehearsal_script').text('');
					// $(this).hide();
					// $('.submit_'+recorderClass).removeClass('submitted_ziggeo');
					// $('.submit_'+recorderClass).empty();
					// $('.submit_'+recorderClass).text('Save Rehearsal');
					// $('.record_another_'+recorderClass).hide();
					// streamToken = '';
			  //   	videoToken = '';
				});
			});
		});
	};

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);
