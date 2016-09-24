function allCoursesjson(courses){
	var coursejson = railsToJson(courses);
	
	// console.log(coursejson);
}


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
	setTimeout(function(){ 
		$('.loading_reload').fadeIn(500) 
	}, 12000);
	$('.loading_reload').click(function(){ location.reload(); });
}

function endLoadingProg(){
	if($('.loading_prog').prop('value') >= 1){	
		$('.loading_prog').prop('value', 100); 
		setTimeout(function(){ $('.loading_app').hide(); }, 1000);
	}else{
		$('.loading_app').hide();
	}
}




var pageReady = function(){

	function formERR(err){
		$('.form_err').fadeIn(500);
		$('.form_err').text(err);
		setTimeout(function(){ $('.form_err').fadeOut(500); }, 3000);
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
			$('.registered_confirmation').html('Thank you for signing up with Video Rehearser.<br>  <br> <img src="/assets/checkmark_white.png" width="50px"><br> <br> You will recieve an email shortly.');
			setTimeout(function(){
				$('.form').empty();
				$('.registered_confirmation').fadeIn(500);
			}, 500);
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
		$('.notice').empty();
		$('#notice').empty();

		$('.notice').fadeOut(100);
		$('#notice').fadeOut(100);
	});
	setTimeout(function(){
		$('.notice').fadeOut(400);
		$('#notice').fadeOut(400);
	},4000);






	//HOME TITLE AND SLIDESHOW
	var homeTitleChange = ['Interview Skills', 'Languages', 'Pronunciation', 'Customer Service', 'Anything'];
	$('.js-learn_home').text(homeTitleChange[0]);
	
	// console.log(homeTitleChange.length);

	var i = 1;
	
	function homeChange(){
		if(i < homeTitleChange.length){
			setTimeout(function(){
				$('.js-learn_home').text(homeTitleChange[i]);
				// console.log(i);
				i+=1;
				runChange();
			}, 2500);
		}else{
			setTimeout(function(){
				$('.js-learn_home').fadeOut(1000);
				$('.js-start').fadeOut(1000);
			}, 1100);
			setTimeout(function(){
				$('.js-title').fadeIn(1000);
			}, 2100);

			setTimeout(function(){
				i = 0;
				$('.js-title').fadeOut(500);
				$('.js-learn_home').text(homeTitleChange[i]);
				setTimeout(function(){
					$('.js-learn_home').fadeIn(1500);
					$('.js-start').fadeIn(1500);
				}, 500);
				runChange();
			}, 50000);
		}
	}

	function runChange(){
		homeChange();
	}


	homeChange();

	var bgChange = ['language_1','language_2','bg1','anything','frame_home'];
	var bg = 0;

	setInterval(function(){
		if( bg < bgChange.length ){
			$('.home_top_wrapper').css("background-image", "url(/assets/"+bgChange[bg]+".jpg)"); 
			bg+=1;
		}else{
			bg = 0;
			$('.home_top_wrapper').css("background-image", "url(/assets/"+bgChange[bg]+".jpg)");
			bg += 1;
		}
	}, 10000);


	$('.submenu_item').click(function(event){
		event.preventDefault();

		$('html, body').animate({
	        scrollTop: $(".home_submenu").offset().top
	    }, 1000);
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