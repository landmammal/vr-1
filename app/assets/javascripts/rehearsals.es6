

var pageReady = function(){


  $(document).on('click', '.review_request', function() {
    $('.peer_review_form').fadeIn();
  });
  $(document).on('click', '.cancel_peer_review', function(e) {
    e.preventDefault();
    $('.peer_review_form').fadeOut();
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
  
  $(document).on('click', '.stop_video', function() {
    var thisplayer = $(this).closest('.shadebox').find('ziggeoplayer')[0];
    var embedding = ZiggeoApi.V2.Recorder.findByElement( thisplayer );
    embedding.stop();
  });


  $('.show_all_rehearsals').click(function(e){
    e.preventDefault();
    $('.filtered_rehearsals_list').fadeOut();
    $('.all_rehearsals_list').delay(500).fadeIn();
  });


  $('.rhs_course').click(function(){
    $(this).toggleClass('topic-selected');   
    $(this).next( '.rhs_topics' ).toggle();    
  });


  $('.jobs-heading').click(function(){
    $(this).toggleClass('job-selected');   
    $(this).next( '.job-content' ).toggle();    
  });

  $('.rhs_topic').click(function(){
    $(this).toggleClass('topic-selected');
    $(this).next( '.rhs_lessons' ).toggle();    
  });

  $('.rhs_lesson').click(function(){
    let rehearsals = $(this).data( 'rehearsals' );
    $('.all_rehearsals_list').fadeOut();
    $('.filtered_rehearsals_list').empty();
    $('.filtered_rehearsals_list').append(`<div id="filtered_rehearsals_title"></div>`);
    let i=0;

    for( let x in rehearsals ){
      // console.log(x);
      let data = rehearsals[x];
      // console.log(data);
      $('#filtered_rehearsals_title').html(`<h4>${data["lesson_info"][0]}</h4><hr>`);
      $('.filtered_rehearsals_list').append(`
        <a href="/rehearsals/student/?student=${data['student_id']}&lesson=${data["lesson_info"][1]}">
          <button type="submit" class="user_bubble">
            <div class="pic">
              <img src="${data['image']}">
            </div>
            <div class="info">
              ${x}<br>
              <div class="other_info">
                Lesson: ${data["lesson_info"][0]}<br>
                Rehearsals: ${data["rhs_count"]}
              </div>
            </div>
          </button>
        </a>
      `);
      i++;
    };

    if(i===0){
      $('.filtered_rehearsals_list').html(`<center> <h3>No Rehearsals for this lesson</h3> </center>`);
    };
    $('.filtered_rehearsals_list').delay(500).fadeIn();
  });



  $(document).on('click', '.rehearsal_filter', function(){
    $('.rehearsal_filter').removeClass('selected');
    $(this).addClass('selected');
    
    if(this.id == "all_rehearsals"){
      $('.rehearsal_bubble').fadeIn();
    }else{
      $('.rehearsal_bubble').fadeOut();
      $('.rehearsal_bubble[data-status='+this.id+']').fadeIn();
    }
  })



  $(document).on('click', '.mark_rehearsal_status', function() {
    var rehearsalStatus = $(this).data('approvalstatus');
    var rehearsalId = $(this).data('rehearsalid');
    // console.log(rehearsalStatus)

    if(rehearsalStatus == "2"){
      $("#rhs_"+rehearsalId).attr("data-status", "rejected_rehearsal");
    }else if(rehearsalStatus == "1"){
      $("#rhs_"+rehearsalId).attr("data-status", "approved_rehearsal");
    }

    var rehearsal = new Object();
        rehearsal.approval_status = rehearsalStatus;

    $.ajax({
        type:'POST',
        data:rehearsal,
        url:'/rehearsal/'+rehearsalId+'/approved',
        success:function(data){
          // console.log('success')
        },
    });
  });

  $(document).on('click', '.course_rehearsal_item', function(){
    var thisID = $(this).data('id');
    $('.topics #course').html($(this).text());

    $.ajax({
      url:"/courses/"+thisID+"/topics.json",
      type:'GET',
      success: function (data) {
        $('.courses').hide();
        $('.topics_list').empty();
        $('.topics').show();
        for (var item in data) {
          $('.topics_list').append(`<div class="topic_rehearsal_item" data-id="${data[item].id}" id="topic_${item.id}"> ${data[item].title} </div>`);
        }
      }
    });
  });

  $(document).on('click', '.topic_rehearsal_item', function(){
    var thisID = $(this).data('id');
    $('.lessons #topic').text( $(this).text() );

    $.ajax({
      url:"/topics/"+thisID+"/lessons.json",
      type:'GET',
      success: function (data) {
        $('.topics').hide();
        $('.lessons_list').empty();
        $('.lessons').show();
        for (var item in data) {
          $('.lessons_list').append(`<a href="/lessons/${data[item].id}/rehearsals/trainees" data-remote="true">
            <div class="lesson_rehearsal_item" data-id="${data[item].id}" id="lesson_${data[item].id}"> ${data[item].title} </div>
          </a>`);
        }
      }
    });
  });
};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);