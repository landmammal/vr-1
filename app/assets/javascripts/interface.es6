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
	        		var icon = `<img class="icon" src="/assets/icons/`+item.iname+`.svg">`;
	        	}else{
	        		var icon = `<span class="icon `+item.iname+`"></span>`;
	        	};

	        	if(item.notif === true){
	        		var notification = `<div class="notif"> <div class="notif_num"></div></div>`;
	        		$.ajax({
						url:'/'+item.name.toLowerCase()+'/api',
						success:function(notifi){
						}
					});
	        	}else{
	        		var notification = ''; 
	        	};

	        	if(item.link === '#'){ 
	        		var link_class = ` class="js-open_side_`+joinedName+`" `; 
	        	}else{
	        		var link_class = '';         	
	        	};


	        	var each_item = `<a href="`+item.link+`"`+link_class+`title="`+item.name+`">`+
		        					`<div class="panel_icon">`+
		        						icon+`<div class="text_label">`+item.name+`</div>`+
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

$('.liveninja-iframe-chat-min-wide').css('height','100px');

var pageReady = function(){
	var doc_cookie = document.cookie;

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








	//=============== MANAGING WINDOW RESIZING ============ //

	var zig_rec_w = $('.lesson_half').width() - 10;
	var zig_play_w = $('.lesson_half').width() - 10;
	var zig_rec_h = zig_rec_w  / 1.77;
	var zig_play_h = zig_play_w  / 1.77;

	function recSize(item){ $(item).width(zig_rec_w).height(zig_rec_h); }
	function playSize(item){ $(item).width(zig_play_w).height(zig_play_h); }
	function changePropSize(element){ $(element).prop('width', zig_play_w); $(element).prop('height', zig_play_h); }
	function runChangeSize(){

		changePropSize('embed'); changePropSize('object'); changePropSize('ba-ziggeoplayer');

		playSize('.ziggeo_play_elem'); playSize('.video-player-inner'); playSize('.video-player-outer');
		playSize('.ba-videoplayer-theme-modern-overlay');
		playSize('.ba-videoplayer-theme-modern-stretch-height');

		recSize('.ziggeo_rec_elem'); recSize('div[data-view-id=cid_3]'); recSize('.video-recorder-flash');
		recSize('.ba-videorecorder-theme-modern-chooser-container');
		recSize('.ba-videorecorder-theme-modern-size-normal');
		recSize('.ba-videorecorder-theme-modern-size-medium');
		recSize('.ba-videorecorder-theme-modern-blue');
		recSize('.ba-videorecorder-noie8s');
		recSize('.ba-videorecorder-theme-modern-container');
		recSize('.ba-videorecorder-theme-modern-norecorder');
		recSize('.ba-videorecorder-theme-modern-video');
		recSize('.ba-videorecorder-theme-modern-overlay');
	}
	
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

	function searchBtn(){
		if (window_width < 481) {
			$('.search_course_btn').empty();
			$('.search_course_btn').html('<span class="ion-search"></span>');
		}
	}



	// RESIZE RUN ON WINDOW CHANGE ======= //
		setTimeout(function(){ 
			runChangeSize(); 
			youtubeSize();
			searchBtn();
			runChangeSize(); 
		}, 100);

		$(window).resize(function(){

			zig_rec_w = $('.lesson_half').width() - 10;
			zig_play_w = $('.lesson_half').width() - 10;
			zig_rec_h = zig_rec_w  / 1.77;
			zig_play_h = zig_play_w  / 1.77;

			
			// devicesHome();
			setTimeout(function(){ 
				youtubeSize();
				searchBtn();
				runChangeSize(); 
			}, 100);
		});

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);