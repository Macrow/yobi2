// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//= require jquery
//= require jquery_ujs
//= require slides.min.jquery
//= require jquery.tools.min
//= require jquery.lightbox-0.5.min

$(document).ready(function() {
	$('#slides').slides({
		preload: true,
		preloadImage: '/assets/slidesjs/loading.gif',
		play: 5000,
		pause: 2500,
		hoverPause: true,
		animationStart: function(current){
			$('.caption').animate({
				bottom:-35
			},100);
		},
		animationComplete: function(current){
			$('.caption').animate({
				bottom:0
			},200);
		},
		slidesLoaded: function() {
			$('.caption').animate({
				bottom:0
			},200);
		}
	});
	
	$(".tooltip_container img[title]").tooltip({
		offset: [10, 2],
		effect: 'slide'
	}).dynamic({ bottom: { direction: 'down', bounce: true } });
	
	$('a.lightbox').lightBox();
});

