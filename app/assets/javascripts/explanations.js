ZiggeoApi.Events.on("system_ready", function() {
  // we search for our embedding using the getElementById to find the element first and then to find the video object within the same
  var recorder = ZiggeoApi.V2.Recorder.findByElement( document.getElementById('recorderElement') );

  function postVideoToken(videoToken, streamToken){

    $form = $('#explanationsForm');
    $ziggeotoken = $('#explanation_video_token');
    $webtoken = $('#explanation_token');
    $ziggeotoken.val(videoToken);
    $webtoken.val(streamToken)

    $form.submit();
  };

  recorder.on('verified', function() {
  // console.log(streamToken);
  // getting the string token and storing it in videoToken var to ship it to the outside world
  var streamToken = recorder.get('stream'); //to get the stream token
  var videoToken = recorder.get('video'); //to get the video token
  // console.log(videoToken);
  // console.log(streamToken);

  // here is where we call the postVideoToken function
  postVideoToken(videoToken, streamToken);
  });
});
