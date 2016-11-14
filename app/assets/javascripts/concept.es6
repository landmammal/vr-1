var pageReady = function(){

	$('.js-concept_weight').text($('#concept_weight').val());
	$('#concept_weight').on('input', function(){
		$('.js-concept_weight').text($(this).val());
	});


};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);