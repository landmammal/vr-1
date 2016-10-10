
var pageReady = function(){

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
  
  $(document).on('click', 'button.rehearsal_btn', function() {
    var rehearsalid = $(this).data('rehearsal');
    var rehearsalNumber = $(this).data('rehearsalnumber');
    console.log(rehearsalNumber);
    // console.log(rehearsalid);

    $.ajax({
      type:'GET',
      url:'/rehearsals/'+rehearsalid+'/api',
      success: function(data){
        // console.log(data);
        $('.put_title_here').html('Rehearsal #'+rehearsalNumber);
        $('.put_video_here').html('<div class="ziggeo_wrapper"><ziggeoplayer ziggeo-theme="modern" class="" ziggeo-video="'+data.video_token+'" ziggeo-stretch ziggeo-responsive> </ziggeoplayer></div>');

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
        $('.put_video_here').html('<div class="ziggeo_wrapper"><ziggeoplayer ziggeo-theme="modern" class="" ziggeo-video="'+data.video_token+'" ziggeo-stretch ziggeo-responsive> </ziggeoplayer></div>');
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