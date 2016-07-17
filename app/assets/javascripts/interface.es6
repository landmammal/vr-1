function panel_section(panel_name){
	var name = panel_name;

	$.ajax({
		url:'/'+name+'/api',
		success:function(panel_data){
	        // console.log(panel_data);

	        for(var panel_item in panel_data){
	        	var item = panel_data[panel_item];
	        	console.log(item.name);

	        	if(item.icon === 'svg'){
	        		var icon = `<img class="icon" src="/assets/icons/`+item.iname+`.svg">`;
	        	}else{
	        		var icon = `<span class="icon `+item.iname+`"></span>`;
	        	};

	        	if(item.notif){ 
	        		var notif = `<div class="notif"> <div class="notif_num">0</div></div>`; 
	        	}else{
	        		var notif = ``; 
	        	}

	        	if(item.link === '#'){ 
	        		var link_class = ` class="js-open_sidepanel" `; 
	        	}else{
	        		var link_class = ``; 
	        	}

	        	var each_item = `<a href="`+item.link+`"`+link_class+`title="`+item.name+`">`+
		        					`<div class="panel_icon">`+
		        						icon+`<div class="text_label">`+item.name+`</div>`+
		        						notif+
		        					`</div>`+
	        					`</a>`;

	        	$('.js-'+name).append(each_item)


				$('.js-open_sidepanel').click(function(event){
					event.preventDefault();
					$('.sidepanel').toggle();
				});

	        }

		}
	});
}


var pageReady = function(){
	var doc_cookie = document.cookie;

	$('.js-max_min').click(function(event){
		event.preventDefault();

		// var ltpnl_size = 'max';
		// document.cookie = "leftpanel="+ltpnl_size;

		$('.leftpanel').toggleClass('max');
		$('.sidepanel').toggleClass('max');
		$('.inter_content').toggleClass('max');
		$('.panel_icon').toggleClass('max');
		$('.text_label').toggle();
		$('.icon').toggleClass('max');
		$('.notif_num').toggleClass('max');
		$('.notif').toggleClass('max');
	});



	
	// function getCookie(cname) {
	//     var name = cname + "=";
	//     var ca = document.cookie.split(';');
	//     for(var i = 0; i <ca.length; i++) {
	//         var c = ca[i];
	//         while (c.charAt(0)==' ') {
	//             c = c.substring(1);
	//         }
	//         if (c.indexOf(name) == 0) {
	//             return c.substring(name.length,c.length);
	//         }
	//     }
	//     console.log(ca);
	//     // return "";
	// }
	// getCookie('leftpanel');

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);