

var pageReady = function(){
	
	var funFacts = [
		// {title:'', fact:'', source:'', image:''},
		{subject:"hippos", fact:"When hippos are upset, their sweat turns red", source:"https://en.wikipedia.org/wiki/Hippopotamus", image:""},
		{subject:"cherophobia", fact:"Cherophobia is the fear of fun", source:"http://common-phobias.com/chero/phobia.htm", image:""},
		{subject:"kangaroos", fact:"If you lift a kangaroo's tail off the ground it can't hop", source:"http://www.thefactsite.com/2012/12/awesome-kangaroo-facts.html", image:""},
		{subject:"indonesian volcanoes", fact:"There's volcano in Indonesia that spews blue lava", source:"http://www.dailymail.co.uk/news/article-2537670/Blue-warmest-colour-Indonesian-volcano-spews-molten-sulphur-heated-220F-gives-eerie-flames.html", image:""},
		{subject:"cartoon physics", fact:"First law of cartoon physics: gravity doesn't work until you look down", source:"http://factsd.com/funny-facts/", image:""},
		{subject:"Facebook", fact:"You can change your language on Facebook to 'Pirate.'", source:"", image:""}];

	function randomFrom(arr){
	    var randomIndex = Math.floor(Math.random() * arr.length);
	    return arr[randomIndex];
	}

	function runFact(){
		var randomfact = randomFrom(funFacts);
		$('.fun_fact_subject').text(randomfact.subject);
		$('.fun_fact').html('" <i>'+randomfact.fact+'</i> "');
		$('.fact_source').html('source: <a href="'+randomfact.source+'" target="_blank"> click to view </a>');
		if(randomfact.image != ''){
			$('.fact_img').text(randomfact.image);
		}
	}

	runFact();

	$('.fun_fact_btn').click(function(){
		$('.fun_fact').show();
		$('.fact_source').show();
		$('.ion-refresh').show();
	});
	$('.reload_fact').click(function(){
		runFact();
	});


};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);