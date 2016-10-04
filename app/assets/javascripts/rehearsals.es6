ZiggeoApi.Events.on("system_ready", function() {
  // we search for our embedding using the getElementById to find the element first and then to find the video object within the same
  var recorder = ZiggeoApi.V2.Recorder.findByElement( document.getElementById('recorderElement') );

  function postVideoToken(videoToken, streamToken){
    $form = $('#rehearsalsForm');
    $ziggeotoken = $('#rehearsal_video_token');
    $webtoken = $('#rehearsal_token');
    $ziggeotoken.val(videoToken);
    $webtoken.val(streamToken)
    $form.submit();
  };

  $('.submit_rehearsal').hide();
  recorder.on('verified', function() {
      $('.submit_rehearsal').show();
    // console.log(streamToken);
    // getting the streamtoken and storing it in streamToken var to ship it to the outside world
    var streamToken = recorder.get('stream'); //to get the stream token
    var videoToken = recorder.get('video'); //to get the video token
    // console.log(videoToken);
    // console.log(streamToken);

    $('.submit_rehearsal').click(function(){
      var nextRehearsal= $(".list_of_lesson_rehearsals > div").length + 1;
      var newrehearsal = `<div class="rehearsal_thumbnail">`+
                  `Rehearsal `+nextRehearsal+`<br>`+
                  `<img src="`+videoImage(videoToken)+`" width="100%" class="rehearsal_img rehearsal_`+nextRehearsal+`">`+
                  `</div>`;

      $.ajax({
        type:'GET',
        url:'/rehearsals/api',
        success: function(data){

          var sorted = data.sort(SortObjectsById);
          var thisRehearsalId = sorted[sorted.length - 1].id + 1;
          var newrehearsal = `<div class="rehearsal_thumbnail">`+
                                `<button class="shadebox_btn rehearsal_btn" data-rehearsal="`+thisRehearsalId+`" data-rehearsalnumber="`+nextRehearsal+`">`+
                                    `Rehearsal `+nextRehearsal+
                                    `<div id="rehearsal_`+thisRehearsalId+`_status" class="blankdot"></div><br>`+
                                    `<img src="`+videoImage(videoToken)+`" width="100%" class="rehearsal_img"><br>`+
                                    `ref#: r`+((thisRehearsalId*30)+5)*7+`id`+thisRehearsalId+
                                `</button>`+
                              `</div>`;
          $('.list_of_lesson_rehearsals').append(newrehearsal);
          // pageReady();
        }
      });

      // here is where we call the postVideoToken function and pass it both token vars
      if(videoToken != ''){postVideoToken(videoToken, streamToken);}else{}
      $('.submit_rehearsal').hide()
      $('.record_another_rehearsal').show()
    });

  });
});


var pageReady = function(){

  $('.record_another_rehearsal').click(function(){
    location.reload();
  });




  // REHEARSAL SUBMISSION
  var changeSubmitButton = function(submission, id){
    if(submission === false || !submission){
      $('button.submission').text('Submit for Feedback');
      $('button.submission').removeClass('red');
      $('button.submission').addClass('blue');
      $('#rehearsal_'+id+'_status').prop('class', 'blankdot');
    }else{
      $('button.submission').text('Make Rehearsal Private');
      $('button.submission').removeClass('blue');
      $('button.submission').addClass('red');
      $('#rehearsal_'+id+'_status').prop('class', 'orangedot');
    }
  }
  
  $('.rehearsal_btn').click(function(){
    var rehearsalid = $(this).data('rehearsal');
    var rehearsalNumber = $(this).data('rehearsalnumber');
    console.log(rehearsalNumber);
    console.log(rehearsalid);

    $.ajax({
      type:'GET',
      url:'/rehearsals/'+rehearsalid+'/api',
      success: function(data){
        // console.log(data);
        $('.put_title_here').html('Rehearsal #'+rehearsalNumber);
        $('.put_video_here').html('<ziggeoplayer ziggeo-theme="modern" class="ziggeo_play_elem rehearsal_video" ziggeo-video="'+data.video_token+'" ziggeo-stretch> </ziggeoplayer>');

        $('button.submission').data('rehearsalid', rehearsalid);
        $('button.submission').data('rehearsalsubmission', data.submission);
        changeSubmitButton(data.submission, data.id);
      }
    });
  });

  $(".submission").click(function(){
    var submissionId = $(this).data('rehearsalid');
    var submissionBool = $(this).data('rehearsalsubmission');

    $.ajax({
      type:'PUT',
      url:'/rehearsals/'+submissionId+'/api',
      success: function(data){
        // console.log(data);
        // console.log(data.submission);
        changeSubmitButton(data.submission, data.id);
      }
    });
  });



  // FEEDBACK SUBMISSION
  $('.user_bubble').click(function(event) {
    event.preventDefault();
    var rehearsalid = $(this).data('rehearsalid');
    var lessonTitle = $(this).data('lessontitle');

    $.ajax({
      type:'GET',
      url:'/rehearsals/'+rehearsalid+'/api',
      success: function(data){
        // console.log(data);
        $('.put_title_here').html('Rehearsal for: <a href="/courses/'+data.course_id+'/topics/'+data.topic_id+'/lessons/'+data.lesson_id+'/"><b>'+lessonTitle+'</b></a>');
        $('.put_video_here').html('<ziggeoplayer ziggeo-theme="modern" class="ziggeo_play_elem rehearsal_video" ziggeo-video="'+data.video_token+'" ziggeo-stretch> </ziggeoplayer>');
        $('a.leave_feedback').prop('href','/rehearsals/'+data.id);

        $('.mark_as_completed').data('rehearsalid', data.id);
        $('.leave_feedback').data('rehearsalid', data.id);
      }
    });
  });

  $('.mark_as_completed').click(function(event) {
    event.preventDefault();
    var thisid = $(this).data('rehearsalid');

    $.ajax({
      type:'PUT',
      url:'/rehearsal/'+thisid+'/rehearsal_approved',
      success: function(data){
        console.log(data);
        $('.mark_as_completed').text('Lesson approved');
      }
    });
  });
};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);