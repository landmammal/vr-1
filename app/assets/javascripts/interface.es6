function panel_section(panel_name){
	var name = panel_name;

	$.ajax({
		url:'/'+name+'/api',
		success:function(panel_data){
	        // console.log(panel_data);

	        for(var panel_item in panel_data){
	        	var item = panel_data[panel_item];
	        	// console.log(item.name);

	        	var joinedName = item.name.split(' ').join('_');

	        	if(item.icon === 'svg'){
	        		var icon = `<span class="icon"><img src="/assets/icons/`+item.iname+`.svg" width="23px";></span>`;
	        	}else{
	        		var icon = `<span class="icon `+item.iname+`"></span>`;
	        	};


	        	if(item.link === '#'){ 
	        		var link_class = ` class="js-open_side_`+joinedName+`" `; 
	        	}else{
	        		var link_class = '';         	
	        	};

				var notification = '';

				if(item.notif === true){

					var n = $('.'+item.name+'_notif').text();
					if(parseInt(n) > 0){
						notification = `<div class="notif notif_`+item.name+`"> <div class="notif_num notif_num_`+item.name+`">`+n+`</div></div>`;
					}else{
						notification = ''; 
					}

				}else{ 
					notification = ''; 
				};

				if(item.alert !== '' ){
					var thisAlert = `alert('${item.alert}')`;
				}else{
					var thisAlert = '';
				}


	        	var each_item = `<a href="${item.link}" ${link_class} title="${item.name}" target="${item.link_target}" onClick="${thisAlert}">`+
		        					`<div class="panel_icon ${item.iname}_panel_ico">`+
		        						icon+`<div class="text_label">${item.name}</div>`+
		        						notification+
		        					`</div>`+
	        					`</a>`;

	        	// execute

	        	$('.js-'+name).append(each_item);
		        if(item.link === '#'){
		        	sidepanel(joinedName);
		        }

	        }
		}
	});

}

var panelArr = [];

function sidepanel( panel ){
	panelArr.push(panel);
	// console.log(panelArr);

	$('.js-open_side_'+panel).click(function(event){
		event.preventDefault();
		// console.log("clicked on "+panel);
		
		var newpanelArr = panelArr;
		var i = 0;
		// console.log(newpanelArr);

		do{
			if(newpanelArr[i] !== panel){	
				$('.js-side_'+newpanelArr[i]).removeClass('open');
				// console.log('removed OPEN from '+newpanelArr[i]);
			}	
			i += 1;

		}while(i < newpanelArr.length);

		if($('.js-side_'+panel).hasClass("open")){
			$('.js-side_'+panel).removeClass('open');
		}else{
			$('.js-side_'+panel).addClass('open');
		};
		

	});
}


var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};


var pageReady = function(){
	var doc_cookie = document.cookie;

	$(document).on("click", '.videocall-button_panel_ico', function(event){
		event.preventDefault();

		var answer = confirm("This will open a live video chat with a vR Representative. Click OK to chat with a live person");
		if(answer===true){
			window.location = $(this).closest('a').attr("href");
		}
	});

	$('.js-click_back').click(function(event){
		event.preventDefault();
		window.history.back();
		setTimeout(function(){ changeContent();}, 20);
	});
	$('.js-click_forward').click(function(event){
		event.preventDefault();
		window.history.forward();
		setTimeout(function(){ changeContent();}, 20);
	});
	window.onpopstate = function() {
	  setTimeout(function(){ changeContent();}, 20);
	}


	function changeContent(){
		if(getUrlParameter('view')){
			var viewTag = getUrlParameter('view');
			var viewGroup = getUrlParameter('group');

			$('button[data-group="'+viewGroup+'"]').removeClass('selected');
			$('button[data-frame="'+viewTag+'"]').addClass('selected');
			$('.all_content').hide();
			$('.js-player').addClass('hide');
			$('.js-'+viewTag+'_content').show();
			$('.'+viewTag).removeClass('hide');
		}
	}

	setTimeout(function(){ changeContent();}, 20);

	function tabURLChange(data){
		var thisGroup = $(data).data('group');
		var thisFrame = $(data).data('frame');

		// console.log(thisGroup+' '+thisFrame)

		$('button[data-group="'+thisGroup+'"]').removeClass('selected');
		$('button[data-frame="'+thisFrame+'"]').addClass('selected');
		$(data).addClass('selected');
		
		var thisTab = $(data).data('frame');
		var frame = '.js-'+thisTab+'_content';
		function showFrame(){
			$('.all_content').hide(); 
			$(frame).show();
		}
		window.history.pushState(showFrame(), thisTab, '?view='+thisTab+'&group='+thisGroup );
	}

	$(document).on('click', '.tab', function(){
		tabURLChange(this);
	});
	$(document).on('click', '.lesson_btn', function(){
		tabURLChange(this);
	});


	$('.js-max_min').click(function(event){
		event.preventDefault();

		$('.leftpanel').toggleClass('max');
		$('.sidepanel').toggleClass('max');
		$('.inter_content').toggleClass('max');
		$('.panel_icon').toggleClass('max');
		$('.text_label').toggle();
		$('.icon').toggleClass('max');
		$('.notif_num').toggleClass('max');
		$('.notif').toggleClass('max');
	});



	// =========== SHADEBOX ============= //
	// $('.shadebox_header').prepend('<button class="shade_close red small_btn">x</button>');
	
	$(document).on('click', '.shadebox_bg', function(e) {
		let sbx = $('.shadebox');
		if ( !sbx.is(e.target) && sbx.has(e.target).length === 0 ) { 
			$('.shadebox_bg').removeClass('open'); 
		}
	});

	$(document).on('click', '.shadebox_btn', function() {
		var thisShadebox = $(this).data('shadebox');
		$('.shadebox_bg[data-name='+thisShadebox+']').addClass('open');
	});

	$(document).on('click', '.shade_close', function() {
		$('.shadebox_bg').removeClass('open');
	});

	$(document).on('click', '.shadebox_close', function() {
		$('.shadebox_bg').removeClass('open');
	});

	$(document).on('click', '.reset_form', function() {
		$(this).closest('form')[0].reset();
	});

	$(document).on('click', '.empty_shadebox_content', function() {
		$('.shadebox_content').delay(2500).empty();
		$(this).removeClass('empty_shadebox_content');
	});






	//=============== RIGHT PANEL ============ //

	$(document).on('click', '.right_panel_btn', function() {
		var thisPanel = $(this).data('rightpanel');
		$('.right_panel[data-name='+thisPanel+']').toggleClass('pop');
	});

	$(document).on('click', '.right_panel .close_panel', function() {
		$(this).closest('.right_panel').removeClass('pop');
	});
	
	$('.right_panel').click(function(e){
		if(e.target != this) return;
		$(this).removeClass('pop');
	});








	//=============== MANAGING WINDOW RESIZING ============ //

	// function aspect16_9(element){
	// 	$(element).height($(element).width() / 1.778);
	// }
	// function height100(element){
	// 	$(element).height('100%');
	// }
	// function runChangeSize(){
	// 	var media_wrapper = document.getElementsByClassName("media_wrapper");
	// 	for( var i = 0; i < media_wrapper.length; i++ ){
	// 		aspect16_9(media_wrapper[i]);
	// 	}
	// 	aspect16_9('div.ba-videoplayer-theme-modern-container video'); //NEED THIS FOR videoplayers in lesson_show
	// 	height100('ziggeoplayer div video'); //NEED THIS FOR videoplayers in lesson_show
	// 	height100('ziggeorecorder div.ba-videorecorder-theme-modern-container video');
	// 	height100('.ba-videoplayer-theme-modern-container'); //NEED THIS FOR videoplayers in lesson_show
	// 	height100('.ba-videoplayer-theme-modern-video'); //NEED THIS FOR videoplayers in lesson_show

	// 	aspect16_9('.ba-videorecorder-theme-modern-container'); 
	// 	aspect16_9('.ziggeo_lesson_create');
	// 	aspect16_9('embed');
	// }
	
	// function devicesHome(){
	// 	var halfsec = $('.halfsec').width();
	// 	$('.halfsec').height(halfsec / 4.85);
	// 	if (window_width < 481) {
	// 		$('.halfsec').height(halfsec);
	// 	}
	// }

	function youtubeSize(){
		if (window_width < 481) {
			$('iframe[class=youtube_home]').width('100%');
			$('iframe[class=youtube_home]').height($('iframe[class=youtube_home]').width()/1.77);
		}else{
			$('iframe[class=youtube_home]').width('520');
			$('iframe[class=youtube_home]').height('315');
		}
	}

	function homeBannerChange(){
		$('.home_top').height( $('.home_top_wrapper').height() );
	}

	function searchBtn(){
		if (window_width < 481) {
			$('.search_course_btn').empty();
			$('.search_course_btn').html('<span class="ion-search"></span>');
		}
	}



	// RESIZE RUN ON WINDOW CHANGE ======= //
		setInterval(function(){ 
			youtubeSize();
			searchBtn();
			// runChangeSize();
			homeBannerChange();
		}, 100);

		$(window).resize(function(){

			setInterval(function(){ 
				youtubeSize();
				searchBtn();
				// runChangeSize();
				homeBannerChange();
			}, 1000);
		});

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);