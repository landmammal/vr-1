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

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);