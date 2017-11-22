

var pageReady = function(){
	var bgImages = ['1','2','3','4','5']
	function randomFrom(arr){
	    var randomIndex = Math.floor(Math.random() * arr.length);
	    return arr[randomIndex];
	}
	var randomImg = randomFrom(bgImages);

	console.log(randomImg)

	$('body').css('background-image', 'url("/errorcss/error_'+randomImg+'.jpg")');

	$('.current_url').val(window.location.href)

	$('.send_report').click(function(){
		$('.send_report').hide();
		$('form').show();
	});
};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);