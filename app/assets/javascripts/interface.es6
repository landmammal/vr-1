var pageReady = function(){
	var doc_cookie = document.cookie;

	$('.js-max_min').click(function(event){
		event.preventDefault();

		var ltpnl_size = 'max';

		document.cookie = "leftpanel="+ltpnl_size;

		$('.leftpanel').toggleClass('max');
		$('.panel_icon').toggleClass('max');
		$('.text_label').toggle();
		$('.icon').toggleClass('max');
		$('.inter_content').toggleClass('max');
		$('.notif_num').toggleClass('max');
	});
	$('.js-tmax_tmin').click(function(event){
		event.preventDefault();

		$('.tasks').toggleClass('tmax');
		$('.task_label').toggle();
		$('.ticon').toggleClass('max');
		$('.task_list').toggleClass('max');
		$('.inter_content').toggleClass('tmax');
		$('.notif_num').toggleClass('tmax');
	});

	
	function getCookie(cname) {
	    var name = cname + "=";
	    var ca = document.cookie.split(';');
	    for(var i = 0; i <ca.length; i++) {
	        var c = ca[i];
	        while (c.charAt(0)==' ') {
	            c = c.substring(1);
	        }
	        if (c.indexOf(name) == 0) {
	            return c.substring(name.length,c.length);
	        }
	    }
	    console.log(ca);
	    // return "";
	}
	getCookie('leftpanel');

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);