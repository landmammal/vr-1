// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


var window_width = $(window).width();
var window_height = $(window).height();
var document_width = $(document).width();
var document_height = $(document).height();


function railsToJson(json_string){
	var newjson = jQuery.parseJSON(json_string.replace(/&quot;/g, '"'));
    return newjson;
}

var pageReady = function(){


	setTimeout(function(){
		$('.flash-notice').fadeOut(2000);
	},4000)

	setTimeout(function(){
		$('#notice').fadeOut(2000);
	},4000)

};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);
