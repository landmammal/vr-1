function allCoursesjson(courses){
	var coursejson = railsToJson(courses);
	
	// console.log(coursejson);
};

function TermsandServices(data){
	if(!data){$('.terms_not_aggreed').show()}else{$('.terms_not_aggreed').hide()}
}

function acceptTermsandServices(){
	$('.accept_terms').click(function(event){
		event.preventDefault();
		// console.log('clicked');

		if($('.js-i_read').prop('checked')){
			var new_accept = new Object();

			$.ajax({
				type:'POST',
				data:new_accept,
				url:'/accepttermsandservices',
				success:function(data){
					// console.log('Terms Changed');
					// console.log(data);
					$('.terms_and_service_button').fadeOut(500);
					$('.terms_and_service_button').delay(500).empty();
					$('.terms_and_service_button').delay(500).html('<img src="/assets/checkmark.png" width="40px"> <br> Thank you for accepting the new Terms of Use.');
					$('.terms_and_service_button').delay(600).fadeIn(500);
					$('.terms_not_aggreed').delay(1500).fadeOut(500);
					setTimeout(function(){
						introJs().start();
					},1500);
				}
			});

		}else{
			$('.js-accept_error').fadeIn(500);
			$('.js-accept_error').delay(3500).fadeOut(500);
		}
	});
};



//APP LOADING SPLASH PAGE
function startLoadingProg(){
	var load_val = 0;
	setTimeout(function(){ load_val += 1; $('.loading_prog').prop('value', load_val) }, 100);

	// console.log($('.loading_prog').prop('value'));

	var startProg = setInterval(function(){
		if(load_val <= 101){
			$('.loading_prog').prop('value', load_val); load_val += 5;
		}else{
			clearInterval(startProg); startchangeLoadText();
		}
	}, 100);

	function startchangeLoadText(){
		var loadText = ['Mixing codes <span class="ion-ios-flask"></span>', 
						'Adding love <span class="ion-ios-heart"></span>', 
						'Fixing gears <span class="ion-gear-b"></span>', 
						'Sharing happiness <span class="ion-happy"></span>', 
						'Screwing bulbs <span class="ion-ios-lightbulb"></span>', 
						'Making coffee <span class="ion-coffee"></span>']; 

		var lt=0;
		function changeLoadText(){
			$('.load_text').hide(); $('.load_text').empty();
			$('.load_text').html(loadText[lt]); $('.load_text').fadeIn(500);
			lt+=1;
		}

		changeLoadText();
		setInterval(function(){
			if(lt < loadText.length){ changeLoadText(); }else{ lt=0; changeLoadText(); }
		}, 5000);
	}
	$('.loading_reload').delay(12000).fadeIn(500);
	$('.loading_reload').click(function(){ location.reload(); });
}

function endLoadingProg(){
	if($('.loading_prog').prop('value') >= 1){	
		$('.loading_prog').prop('value', 100); 
		$('.loading_app').delay(1000).hide();
	}else{
		$('.loading_app').hide();
	}
}


function reload_to(url, time){

	setTimeout(function(){
		window.location.href = url;
	}, time);

}




function myFunction() {
    $("#myTopnav").toggleClass("responsive");
}





var pageReady = function(){

	// $(".menu-control").click(function () {
	// 	$(".main-content.in_app").toggleClass('menu-large');
	// 	var src = $(this).attr('src');
	// 	var newsrc = (src == '/assets/menu.png') ? '/assets/menu-close.png' : '/assets/menu.png';
	// 	$(this).attr('src', newsrc);
	// });

	$('button.submit_job_application').click(function(){
		$('form.application_form').submit();
	});
	
	$('.apply_job').click(function(){
		$('form.application_form')[0].reset();
		$('.success').fadeOut(500);
		$('.jobs-form').delay(500).fadeIn();
		$('.submit_job_application').fadeIn();
	});


	$(document).on("click", '.introjs-donebutton', function(){
		$.ajax({
			url:"/change_first_contact",
			type: "GET",
			success: function(data){
				console.log(data);
			},
			error: function(e){
				console.log("ERROR");
			}
		});
	});




	// User Profile drop Menu
	$('.dropdownToggle').click(function(event){
		event.preventDefault();
		let drop = $(this).data('drop');
		let dropdown = $(`div[data-dropdown="${drop}"]`);
		let rightOffset = $(this).data('offset');

		dropdown.fadeToggle('fast');
		dropdown.css( 'right', rightOffset );
		
	});
	$(document).mouseup(function(e) {
		let dd = $('.dropdown');
		if ( !dd.is(e.target) && dd.has(e.target).length === 0 && e.target!==dd.prev('.dropdownToggle') ) { 
			dd.hide(); 
		}
	});


	function formERR(err){
		$('.form_err').fadeIn(500);
		$('.form_err').text(err);
		$('.form_err').delay(3000).fadeOut(500);
	}




	//REGISTER CHECK AND FUNCTION
	function checkRegisForm(){

		var regisFormErr = false;
		
		function runErr(err){	
			regisFormErr = true;
			formERR(err);
		}

		if( $('.firstname').val().length === 0 ){
			var err = 'First name field not filled in.'; runErr(err);
		}else if( $('.lastname').val().length === 0 ){
			var err = 'Last name field not filled in.'; runErr(err);
		}else if( $('.username').val().length === 0 ){
			var err = 'Username field not filled in.'; runErr(err);
		}else if( $('.email').val().length === 0 ){
			var err = 'Email field not filled in.'; runErr(err);
		}else if( $('.pass').val().length === 0 ){
			var err = 'Password field not filled in.'; runErr(err);
		}else if( $('.pass').val().length < 6 ){
			var err = 'Password is less than 6 Characters.'; runErr(err);
		}else if( $('.passComf').val() !== $('.pass').val() ){
			var err = 'Password and Comfirm Password are not the same.'; runErr(err);
		}else if( $('#user_age').val() === '' ){
			var err = 'Please select your date of birth.'; runErr(err);
		}else if( $('#termsServices:checked').length != $('#termsServices').length ){
			var err = 'Please read Terms and Services'; runErr(err);
		}

		return regisFormErr;
	}

	$('.register_btn').click(function(){

		var regisForm = $('#new_user');
		
		if(!checkRegisForm()){ 
			regisForm.submit(); 
			$('.clearform').val('');
			$('#user_age').val('');
			$('#termsServices').prop('checked', false);

			$('.form').fadeOut(500);
			$('.registered_confirmation').html('Thank you for signing up with videoRehearser.<br>  <br> <img src="/assets/checkmark.png" width="50px"><br> <br> You will recieve an email shortly.');

			$('.form').delay(500).empty();
			$('.registered_confirmation').delay(500).fadeIn(500);

		}

	});



	//TERMS AND SERVICES AGGREEMENT
	function changeSignupBtn(){
		if($('#termsServices:checked').length == $('#termsServices').length && !checkRegisForm()) {
			$('.register_btn').removeClass('reg_btn');
			$('.register_btn').addClass('big_btn');
		}else{
			$('.register_btn').removeClass('big_btn');
			$('.register_btn').addClass('reg_btn');
		}
	}

	$('.agreeTerms').click(function(){
		$('#termsServices').prop('checked', true);
		changeSignupBtn();
	});

	$("#termsServices").change(function(){
		changeSignupBtn();
	});

	$('.disagreeTerms').click(function(){
		$('#termsServices').prop('checked', false);
		changeSignupBtn();
	});







	// NOTICES AND FLASHES FADEOUT
	$('.close_notice').click(function(){
		$('#notice_wrapper').empty();
		$('#notice_wrapper').addClass('remove');
	});
	$('#notice_wrapper').click(function(){
		$('#notice_wrapper').empty();
		$('#notice_wrapper').addClass('remove');
	});
	setTimeout(function(){
		$('#notice_wrapper').addClass('remove');
	}, 3500);







	//HOME TITLE AND SLIDESHOW
	// var homeTitleChange = ['Interview Skills', 'Languages', 'Pronunciation', 'Customer Service', 'Anything'];
	// $('.js-learn_home').text(homeTitleChange[0]);
	
	// console.log(homeTitleChange.length);


	// var homeSlide = [{image:'public_speacking', text_location:'center_right', text_animation:'slide_right', 
	// 				   text:'<span class="ht1">Control the room</span><br><span class="ht2">Become a more polished speaker</span>'
	// 				 },
	// 				 { image:'job_interview', text_location:'bottom_left', text_animation:'slide_left', 
	// 				   text:'<span class="ht2">Crush your next interview</span><br><span class="ht1">Sharpen your interview skills</span>'
	// 				 },
	// 				 {image:'language', text_location:'center_left', text_animation:'slide_right', 
	// 				   text:'<span class="ht1">Expand your horizon</span><br><span class="ht2">By conquering a new language</span>'
	// 				 },
	// 				 {image:'frame_home', text_location:'center_left', text_animation:'slide_right', 
	// 				   text:'<span class="ht3">Effective training at your fingertips</span><br><span class="ht1">Anytime, anywhere</span>'
	// 				 },
	// 				 { image:'singer', text_location:'bottom_left', text_animation:'slide_left', 
	// 				   text:'<span class="ht2">Give the performance of a lifetime</span><br><span class="ht1">Rehearse to rock the world</span>'
	// 				 },
	// 				 { image:'dancer', text_location:'center_left', text_animation:'slide_left', 
	// 				   text:'<span class="ht2">Fine-tune your performance</span><br><span class="ht1">Reflect to perfect</span>'
	// 				 },
	// 				 { image:'better_you', text_location:'center_right', text_animation:'slide_right', 
	// 				   text:'<span class="ht3">Rehearse to become</span><br><span class="ht1">A BETTER YOU</span>'
	// 				 }];





	
	// var hbg = 0;

	// setInterval(function(){
	// 	if( hbg >= homeSlide.length ){ hbg = 0; }
	// 	$('#home_top_text').fadeOut(1000);
	// 	setTimeout(function(){
	// 		$('.home_top_wrapper').css("background-image", "url(/assets/"+homeSlide[hbg].image+".jpg)"); 
	// 		$('#home_top_text').prop('class', homeSlide[hbg].text_location);
	// 		$('#home_top_text .content').html(homeSlide[hbg].text);
	// 	}, 1000);
	// 	setTimeout(function(){
	// 		$('#home_top_text').fadeIn(1000);
	// 		hbg+=1;
	// 	},1500);
	// }, 6500);








	// var i = 1;
	
	// function homeChange(){
	// 	if(i < homeTitleChange.length){
	// 		setTimeout(function(){
	// 			$('.js-learn_home').text(homeTitleChange[i]);
	// 			// console.log(i);
	// 			i+=1;
	// 			runChange();
	// 		}, 2500);
	// 	}else{
	// 		setTimeout(function(){
	// 			$('.js-learn_home').fadeOut(1000);
	// 			$('.js-start').fadeOut(1000);
	// 		}, 1100);
	// 		setTimeout(function(){
	// 			$('.js-title').fadeIn(1000);
	// 		}, 2100);

	// 		setTimeout(function(){
	// 			i = 0;
	// 			$('.js-title').fadeOut(500);
	// 			$('.js-learn_home').text(homeTitleChange[i]);
	// 			setTimeout(function(){
	// 				$('.js-learn_home').fadeIn(1500);
	// 				$('.js-start').fadeIn(1500);
	// 			}, 500);
	// 			runChange();
	// 		}, 50000);
	// 	}
	// }

	// function runChange(){ homeChange(); }


	// homeChange();

	// var bgChange = ['language_1','language_2','bg1','anything','frame_home'];
	// var bg = 0;

	// setInterval(function(){
	// 	if( bg < bgChange.length ){
	// 		$('.home_top_wrapper').css("background-image", "url(/assets/"+bgChange[bg]+".jpg)"); 
	// 		bg+=1;
	// 	}else{
	// 		bg = 0;
	// 		$('.home_top_wrapper').css("background-image", "url(/assets/"+bgChange[bg]+".jpg)");
	// 		bg += 1;
	// 	}
	// }, 10000);


	$('.submenu_item').click(function(event){
		event.preventDefault();
	    var bodyHTML = $('html, body');
	    // console.log(bodyHTML[1].scrollTop);

		if(bodyHTML[1].scrollTop < 628){
			bodyHTML.animate({
		        scrollTop: $(".submenu_item").offset().top
		    }, 1000);
		}
		$('.home_top_info').fadeOut(500);

		var topinfo = $(this).data('topinfo');

		setTimeout(function(){
			$('.home_top_info[data-topinfo="'+topinfo+'"]').fadeIn(1000);
		},500);
	});









	//HOME SEARCH FUNCTIONALITY
	$('.search_popup').click(function(event){
		event.preventDefault();
		$('.search_box').toggleClass('popup');
		$('.search_popup').toggleClass('fade');

		if($('.search_popup').hasClass('fade')){
			setTimeout(function(){
				$( ".search_course_term" ).focus();
	    	}, 500);
			$('html, body').animate({
	        	scrollTop: $(".demo").offset().top
	    	}, 1500);
		}else{
			$('html, body').animate({
	        	scrollTop: $(".home_top_wrapper").offset().top
	    	}, 1500);
		}
	});

	$('.search_course_btn').click(function(event){
		event.preventDefault();
		if(!$('.search_results_home').hasClass('show')){
			$('.search_results_home').addClass('show');
		}
	});

	$('.search_course_form').on('input', function(){
		if($('.search_course_term').val.length !== 0 ){

			if(!$('.search_results_home').hasClass('show')){
				$('.search_results_home').addClass('show');
			}
			$('.result_search_terms').text("Searching for : '"+$('.search_course_term').val()+"'");
			
			var newSearch = new Object();
				newSearch.search = $('.search_course_term').val();
				newSearch.search_type = $('#search_course_type option:selected').val();

			$.ajax({
				type:'POST',
				data:newSearch,
				url:'/courses_search/api',
				success:function(data){
					$('.search_result').empty();
					// console.log(data);
					if(data.length !== 0){
						for(var i in data){
							var item = data[i];
							// console.log(item);
							var searchResults = '<a href="/display_course/'+item.id+'"><div class="searchResultItem" style="display:none;">'+item.title+'</div></a>';
							$('.search_result').append(searchResults);
							$('.searchResultItem').delay(300).slideDown(500);
						}
					}else{
						$('.search_result').text("NO RESULTS FOUND");
					}
					
				},
			});
			// $('.search_course_form').submit();
		}
		
		if($('.search_course_term').val.length === 0 || $('.search_course_term').val() === ''){

			if($('.search_results_home').hasClass('show')){
				$('.search_result').text("NO RESULTS FOUND");
				$('.result_search_terms').empty();
				$('.search_results_home').removeClass('show');
			}

		}


	});

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);