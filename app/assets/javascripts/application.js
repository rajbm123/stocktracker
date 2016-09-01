// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-material-design
// require turbolinks
//= require_tree .


var init_stock_lookup;

init_stock_lookup = function(){
	$("#look-up-form").on('ajax:before', function(event, data, status){
		$('#spin-lookup').show(); 
		$('#search-stock-cont').hide();
	});
	$("#look-up-form").on('ajax:after', function(event, data, status){
		$('#spin-lookup').hide(); 
		$('#search-stock-cont').show();
	});
	$("#look-up-form").on('ajax:success', function(event, data, status){
		$('#lookup-main-block').replaceWith(data);
		$('#stock-lookup-results').addClass('animated rollIn');
		init_stock_lookup(); 
	});
	$("#look-up-form").on('ajax:error', function(event, xhr, status, error){
		$('#stock-lookup-results').replaceWith(' ');
		$('#lookup-errors').replaceWith('Stock Not Found');
		$('#spin-lookup').hide(); 
		$('#search-stock-cont').show();
	});
}
$(document).on('turbolinks:load', init_stock_lookup);
$(document).ready(init_stock_lookup);
$(document).bind('page:change', init_stock_lookup);
$(document).ready(function(){
	$.material.init();
});