ZiggeoApi.Events.on("system_ready", function() {

    // we search for our embedding using the getElementById to find the element first and then to find the video object within the same
    var recorder = ZiggeoApi.V2.Recorder.findByElement( document.getElementById('recorderElement') );

    function postVideoToken(videoToken, streamToken){

        $form = $('#feedbackForm');
        $ziggeotoken = $('#feedback_video_token');
        $webtoken = $('#feedback_token');
        $ziggeotoken.val(videoToken);
        $webtoken.val(streamToken)
        $form.submit();
        console.log('form submited')
    };

    $('.submit_feedback').hide()
    recorder.on('verified', function() {
        // console.log(streamToken);
        // getting the string token and storing it in videoToken var to ship it to the outside world
        var streamToken = recorder.get('stream'); //to get the stream token
        var videoToken = recorder.get('video'); //to get the video token
        // console.log(videoToken);
        // console.log(streamToken);
        $('.submit_feedback').show()
        // here is where we call the postVideoToken function
        $('.submit_feedback').click(function(){
            if(videoToken != ''){
                postVideoToken(videoToken, streamToken);
                $('.submit_feedback').hide()
                window.location.href = "/rehearsals/all";
            }else{
                
            }
        });
    });

    $()
});