$(function(){
	$('.nav button.menu').click(function(){
		$('.nav').toggleClass('expand');
	});

	$('.nav li').click(function(){
		window.location = $(this).find('a').attr('href');
	});
});