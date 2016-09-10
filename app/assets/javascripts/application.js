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



window.getCount = function(parent, getChildrensChildren){
    var relevantChildren = 0;
    var children = parent.childNodes.length;
    for(var i=0; i < children; i++){
        if(parent.childNodes[i].nodeType != 3){
            if(getChildrensChildren)
                relevantChildren += getCount(parent.childNodes[i],true);
            relevantChildren++;
        }
    }
    return relevantChildren;
}

// getCount(document.getElementById('test'), true);



var pageReady = function(){
	$('#myModal').on('shown.bs.modal', function () {
		$('#myInput').focus();
	})
	$('.agreeTerms').click(function(){
		$('#termsServices').prop('checked', true);
	});
};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);
