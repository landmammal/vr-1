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
		            location.reload();
		            // window.location.href = "#send_to_instructor";
		            // window.location.replace("#send_to_instructor");
		          }
		        });
			}
	    };

	    // ba-videoplayer-theme-modern-rerecord-frontbar
	    // ^^^^ Use this div to add button to submit rehearsal

	    $('.submit_ziggeo').hide();

	    recorder.on('verified', function() {
	    	$('.submit_'+ziggeoClass).show();
	    	// console.log('Ziggeo');

	    	var streamToken = recorder.get('stream');
	    	var videoToken = recorder.get('video');
	    	var thisForm = ziggeoClass.replace('Form','');

	    	if($('.submit_'+ziggeoClass).length > 0){
		    	$('.submit_'+ziggeoClass).click(function(){
		    		// console.log('clicked');

			    	thisForm = $(this).data('formname');
			    	// console.log(thisForm);

			    	if(videoToken != ''){
			    		postTokenInForm(thisForm, videoToken, streamToken);
			    		$('.submit_'+ziggeoClass).hide();
				        $('.record_another_'+ziggeoClass).show();
			    	}
		    	});
		    }else{
		    	// console.log(thisForm+" form sent");
	    		postTokenInForm(thisForm, videoToken, streamToken);
		    }

	    });
		
		$('.record_another_'+ziggeoClass.replace('Form','')).click(function(){
			location.reload();
		});
	});


};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);