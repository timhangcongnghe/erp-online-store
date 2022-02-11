/* global jQuery:false */
/*jshint esversion: 6 */
(function(jQuery) {
	
	//"use strict";
	
	if (jQuery(window).width() > 992) {
		
		cursor();
	
	}

	function cursor() {
		
		if (jQuery('.wpisset-cursor').length) {
				
			var cursor = jQuery(".wpisset-cursor"),
				cursor_bg = jQuery(".wpisset-cursor-bg"),
				cursor_content = jQuery(".wpisset-cursor-content");
			
			var posX = 0,
			    posY = 0,
			    mouseX = 0,
			    mouseY = 0;
			
			TweenMax.to({}, 0.016, {
			    repeat: -1,
			    onRepeat: function() {
			        posX += (mouseX - posX) / 9;
			        posY += (mouseY - posY) / 9;
			
			        TweenMax.set(cursor, {
						x: mouseX,
			            y: mouseY,
			            delay: 0.02,
			            ease: Power3.easeOut
			        });
			    }
			});
			
			jQuery(document).on("mousemove", function(e) {
			    mouseX = e.clientX;
			    mouseY = e.clientY;
			});
			
			jQuery(".wpisset-cursor-anim-element")
			.mouseenter(function() {
				
			    cursor.addClass("wpisset-cursor-active");
			    cursor_content.stop(false,true).css({opacity: 0, display: 'flex'}).animate({ opacity: 1 }, 200);
			    
			    if (jQuery(this).attr('data-cursor-text') !== undefined) {
					
					if (jQuery(this).attr('data-cursor-text') == "image_icon_value" ) {
						
						cursor_content.html(jQuery(this).children('.anim_image_icon').html());
						
					}else{
						
						var cursor_subtitle = '';
						var cursor_wrap_before = '';
						var cursor_wrap_after = '';
						var cursor_subtitle_color = '';
						
						if (jQuery(this).attr('data-cursor-subtitle-color') !== undefined) {
							var cursor_subtitle_color = 'style="color:'+jQuery(this).attr("data-cursor-subtitle-color")+'"';
						}
						
						if (jQuery(this).attr('data-cursor-subtitle') !== undefined) {
							if (jQuery(this).attr('data-cursor-subtitle') != '') {
								var cursor_subtitle = '<span class="wpisset-cursor-subtitle"'+cursor_subtitle_color+'>'+jQuery(this).attr("data-cursor-subtitle")+'</span>';
							}
						}
						
						if (jQuery(this).hasClass('wpisset-cursor-anim-element-2')) {
							var cursor_wrap_before = '<span>';
							var cursor_wrap_after = '</span>';
						}
						
						if (jQuery(this).hasClass('wpisset-cursor-anim-element-3')) {
							var cursor_wrap_before = '<span>';
							var cursor_wrap_after = '</span>';
						}
						
						cursor_content.html(cursor_wrap_before+jQuery(this).attr("data-cursor-text")+cursor_wrap_after+cursor_subtitle);
					}
					
					cursor_content.css( "color", jQuery(this).attr("data-cursor-text-color"));
					cursor_bg.css( "background", jQuery(this).attr("data-cursor-color") );
					cursor_bg.css( "transform-origin", 'center center' );
					cursor.css( "border-radius", '50%' );
					cursor_bg.css( "border-radius", '50%' );
					cursor.css( "padding-top", 0 );
					cursor.css( "padding-bottom", 0 );
					
					if (jQuery(this).attr('data-cursor-font-size') !== undefined) {
						cursor.css( "font-size", jQuery(this).attr("data-cursor-font-size") );
					}else{
						cursor.css( "font-size", '90%' );
					}
					
					if (jQuery(this).attr('data-cursor-size') !== undefined) {
						cursor.css( "width", jQuery(this).attr("data-cursor-size") );
						cursor.css( "height", jQuery(this).attr("data-cursor-size") );
						cursor.css( "margin-left", (jQuery(this).attr("data-cursor-size")*-1)/2 );
						cursor.css( "margin-top", 24 );
					}else{
						cursor.css( "width", 90 );
						cursor.css( "height", 90 );
						//cursor.css( "margin-left", 20 );
						//cursor.css( "margin-top", 20 );
					}
					
					if (jQuery(this).hasClass('wpisset-cursor-anim-element-2')) {
						
						cursor_bg.css( "transform-origin", 'center center' );
						cursor.css( "border-radius", '0' );
						cursor_bg.css( "border-radius", '0' );
						
						cursor.css( "width", 'auto' );
						cursor.css( "height", 'auto' );
						cursor.css( "padding-top", 0 );
						cursor.css( "padding-bottom", 0 );
						
						cursor.css({ 'margin-left': -cursor.width()/2 });
						cursor.css( "margin-top", 24 );
						cursor.css( "font-size", '80%' );
					}
					
					if (jQuery(this).hasClass('wpisset-cursor-anim-element-3')) {
						
						cursor_bg.css( "transform-origin", 'center center' );
						cursor.css( "border-radius", '0' );
						cursor_bg.css( "border-radius", '0' );
						
						cursor.css( "width", 120 );
						cursor.css( "height", 'auto' );
						cursor.css( "padding-top", 4 );
						cursor.css( "padding-bottom", 4 );
						
						
						cursor.css({ 'margin-left': -cursor.width()/2 });
						cursor.css( "margin-top", 24 );
						cursor.css( "font-size", '80%' );
					}
					
					if (jQuery(this).hasClass('wpisset-cursor-center-center')) {
						
						cursor_bg.css( "transform-origin", 'center center' );
						
						if (jQuery(this).attr('data-cursor-size') !== undefined) {
							cursor.css( "margin-left", (jQuery(this).attr("data-cursor-size")/2)*-1 );
							cursor.css( "margin-top", (jQuery(this).attr("data-cursor-size")/2)*-1 );
						}else{
							
							if (jQuery(this).hasClass('wpisset-cursor-center-center')) {
								
							//cursor.css( "margin-left", -85 );
							//cursor.css( "margin-top", -50 );
								
							}else{
								
							//cursor.css( "margin-left", -45 );
							//cursor.css( "margin-top", -45 );
								
							}
							
						}
						
						jQuery("body").addClass("wpisset-hide-default-cursor");
						
					}
			    }
			    
			    jQuery("body").addClass("wpisset-custom-cursor-active");
			    
			})
			.mouseleave(function() {
				
			    cursor.removeClass("wpisset-cursor-active");
			    cursor_content.stop(false,true).fadeOut(200);
			    
			    jQuery("body").removeClass("wpisset-custom-cursor-active");
			    jQuery("body").removeClass("wpisset-hide-default-cursor");
			
			});
			
			jQuery(".wpisset-cursor-anim-element .wpisset-button")
			.mouseenter(function() {
				
			    cursor.removeClass("wpisset-cursor-active");
			    cursor_content.stop(false,true).fadeOut(200);
			    
			    jQuery("body").removeClass("wpisset-custom-cursor-active");
			    jQuery("body").removeClass("wpisset-hide-default-cursor");
			    
			})
			.mouseleave(function() {
				
			    cursor.addClass("wpisset-cursor-active");
			    cursor_content.stop(false,true).fadeIn(200);
			    
			    jQuery("body").addClass("wpisset-custom-cursor-active");
			    
				if (jQuery(this).parents().hasClass('wpisset-cursor-center-center')) {
					
					jQuery("body").addClass("wpisset-hide-default-cursor");
					
				}
			
			});
			
			jQuery(".wpisset-cursor-anim-element .wpisset-cursor-disable-anim")
			.mouseenter(function() {
				
			    cursor.removeClass("wpisset-cursor-active");
			    cursor_content.stop(false,true).fadeOut(200);
			    
			    jQuery("body").removeClass("wpisset-custom-cursor-active");
			    jQuery("body").removeClass("wpisset-hide-default-cursor");
			    
			})
			.mouseleave(function() {
				
			    cursor.addClass("wpisset-cursor-active");
			    cursor_content.stop(false,true).fadeIn(200);
			    
			    jQuery("body").addClass("wpisset-custom-cursor-active");
			    
				if (jQuery(this).parents().hasClass('wpisset-cursor-center-center')) {
					
					jQuery("body").addClass("wpisset-hide-default-cursor");
					
				}
			
			});
			
		}
	
	}
	
	// function menuCursor() {
  // 
	// 	var mouseX = 0,
	// 	    mouseY = 0;
  // 
	// 	jQuery(".wpisset-menu > li > span").each(function() {
  // 
  //       	jQuery(this).append('<span class="wpisset-menu-cursor-wrap"><span class="wpisset-menu-cursor-holder"><span class="wpisset-menu-cursor"></span></span></span>');
  // 
	//    });
  // 
	// 	jQuery(".wpisset-menu > li > span > a")
	// 	.mouseenter(function(e) {
  // 
	// 		jQuery(this).on("mousemove", function(e) {
  // 
	// 			mouseX = e.pageX;
	// 			mouseY = e.pageY;
  // 
	// 		});
  // 
	// 		var img_wrap = jQuery(this).parent().find(".wpisset-menu-cursor-holder");
  // 
	// 		var offset = jQuery(this).offset();
  // 
	// 		//console.log(offset.left);
  // 
	// 		jQuery(this).parent().parent().addClass("wmc-active");
  // 
	// 		TweenMax.to(img_wrap, 0.016, {
	// 			repeat: -1,
  // 
	// 			onRepeat: function() {
  // 
	// 				TweenMax.set(img_wrap, {
	// 			        x: mouseX - offset.left,
	// 					y: mouseY - offset.top,
	// 		            delay: 0.02,
	// 		            ease: Power3.easeOut
	// 			    });
  // 
	// 			}
	// 		});
  // 
	// 	})
	// 	.mouseleave(function(e) {
  // 
	// 		var img_wrap = jQuery(this).parent().find(".wpisset-menu-cursor-holder");
  // 
	// 		jQuery(this).parent().parent().removeClass("wmc-active");
  // 
	// 		TweenMax.killTweensOf(img_wrap);
  // 
	// 	});
  // 
	// }
  // 
	// menuCursor();
	
	// function icons1Cursor() {
  // 
	// 	var mouseX = 0,
	// 	    mouseY = 0;
  // 
  // 
	// 	jQuery(".wpisset-ele-es-icons1-item-inner")
	// 	.mouseenter(function(e) {
  // 
	// 		jQuery(this).on("mousemove", function(e) {
  // 
	// 			mouseX = e.pageX;
	// 			mouseY = e.pageY;
  // 
	// 		});
  // 
	// 		var img_wrap = jQuery(this).parent().find(".wpisset-ele-es-icons1-cursor-holder");
  // 
	// 		var offset = jQuery(this).offset();
  // 
	// 		//console.log(offset.left);
  // 
	// 		jQuery(this).parent().addClass("weei1c-active");
  // 
	// 		TweenMax.to(img_wrap, 0.016, {
	// 			repeat: -1,
  // 
	// 			onRepeat: function() {
  // 
	// 				TweenMax.set(img_wrap, {
	// 			        x: mouseX - offset.left,
	// 					y: mouseY - offset.top,
	// 		            delay: 0.02,
	// 		            ease: Power3.easeOut
	// 			    });
  // 
	// 			}
	// 		});
  // 
	// 	})
	// 	.mouseleave(function(e) {
  // 
	// 		var img_wrap = jQuery(this).parent().find(".wpisset-ele-es-icons1-cursor-holder");
  // 
	// 		jQuery(this).parent().removeClass("weei1c-active");
  // 
	// 		TweenMax.killTweensOf(img_wrap);
  // 
	// 	});
  // 
	// }
  // 
	// icons1Cursor();
  // 
	// function icons2Cursor() {
  // 
	// 	var mouseX = 0,
	// 	    mouseY = 0;
  // 
  // 
	// 	jQuery(".wpisset-ele-es-icons2-item-inner")
	// 	.mouseenter(function(e) {
  // 
	// 		jQuery(this).on("mousemove", function(e) {
  // 
	// 			mouseX = e.pageX;
	// 			mouseY = e.pageY;
  // 
	// 		});
  // 
	// 		var img_wrap = jQuery(this).parent().find(".wpisset-ele-es-icons2-cursor-holder");
  // 
	// 		var offset = jQuery(this).offset();
  // 
	// 		//console.log(offset.left);
  // 
	// 		jQuery(this).parent().addClass("weei2c-active");
  // 
	// 		TweenMax.to(img_wrap, 0.016, {
	// 			repeat: -1,
  // 
	// 			onRepeat: function() {
  // 
	// 				TweenMax.set(img_wrap, {
	// 			        x: mouseX - offset.left,
	// 					y: mouseY - offset.top,
	// 		            delay: 0.02,
	// 		            ease: Power3.easeOut
	// 			    });
  // 
	// 			}
	// 		});
  // 
	// 	})
	// 	.mouseleave(function(e) {
  // 
	// 		var img_wrap = jQuery(this).parent().find(".wpisset-ele-es-icons2-cursor-holder");
  // 
	// 		jQuery(this).parent().removeClass("weei2c-active");
  // 
	// 		TweenMax.killTweensOf(img_wrap);
  // 
	// 	});
  // 
	// }
  // 
	// icons2Cursor();
  // 
	// function catban1Cursor() {
  // 
	// 	var mouseX = 0,
	// 	    mouseY = 0;
  // 
  // 
	// 	jQuery(".wpisset-ele-es-categorybanner1-nav-inner")
	// 	.mouseenter(function(e) {
  // 
	// 		jQuery(this).on("mousemove", function(e) {
  // 
	// 			mouseX = e.pageX;
	// 			mouseY = e.pageY;
  // 
	// 		});
  // 
	// 		var img_wrap = jQuery(this).parent().find(".wpisset-ele-es-categorybanner1-cursor-holder");
  // 
	// 		var offset = jQuery(this).offset();
  // 
	// 		//console.log(offset.left);
  // 
	// 		jQuery(this).parent().addClass("weec1c-active");
  // 
	// 		TweenMax.to(img_wrap, 0.016, {
	// 			repeat: -1,
  // 
	// 			onRepeat: function() {
  // 
	// 				TweenMax.set(img_wrap, {
	// 			        x: mouseX - offset.left,
	// 					y: mouseY - offset.top,
	// 		            delay: 0.02,
	// 		            ease: Power3.easeOut
	// 			    });
  // 
	// 			}
	// 		});
  // 
	// 	})
	// 	.mouseleave(function(e) {
  // 
	// 		var img_wrap = jQuery(this).parent().find(".wpisset-ele-es-categorybanner1-cursor-holder");
  // 
	// 		jQuery(this).parent().removeClass("weec1c-active");
  // 
	// 		TweenMax.killTweensOf(img_wrap);
  // 
	// 	});
  // 
	// }
  // 
	// catban1Cursor();
  // 
	// function catban2Cursor() {
  // 
	// 	var mouseX = 0,
	// 	    mouseY = 0;
  // 
  // 
	// 	jQuery(".wpisset-ele-es-categorybanner2-nav-inner")
	// 	.mouseenter(function(e) {
  // 
	// 		jQuery(this).on("mousemove", function(e) {
  // 
	// 			mouseX = e.pageX;
	// 			mouseY = e.pageY;
  // 
	// 		});
  // 
	// 		var img_wrap = jQuery(this).parent().find(".wpisset-ele-es-categorybanner2-cursor-holder");
  // 
	// 		var offset = jQuery(this).offset();
  // 
	// 		//console.log(offset.left);
  // 
	// 		jQuery(this).parent().addClass("weec2c-active");
  // 
	// 		TweenMax.to(img_wrap, 0.016, {
	// 			repeat: -1,
  // 
	// 			onRepeat: function() {
  // 
	// 				TweenMax.set(img_wrap, {
	// 			        x: mouseX - offset.left,
	// 					y: mouseY - offset.top,
	// 		            delay: 0.02,
	// 		            ease: Power3.easeOut
	// 			    });
  // 
	// 			}
	// 		});
  // 
	// 	})
	// 	.mouseleave(function(e) {
  // 
	// 		var img_wrap = jQuery(this).parent().find(".wpisset-ele-es-categorybanner2-cursor-holder");
  // 
	// 		jQuery(this).parent().removeClass("weec2c-active");
  // 
	// 		TweenMax.killTweensOf(img_wrap);
  // 
	// 	});
  // 
	// }
  // 
	// catban2Cursor();
	
	function productTabs(){
		
		jQuery('ul.wpisset-ele-es-producttabs-tabs li').click(function(){
			var tab_id = jQuery(this).attr('data-tab');
	
			jQuery('ul.wpisset-ele-es-producttabs-tabs li').removeClass('current');
			jQuery('.wpisset-ele-es-producttabs-tab-panel').removeClass('current');
	
			jQuery(this).addClass('current');
			jQuery("#"+tab_id).addClass('current');
		});
	}
	
	productTabs();
	
	function countDown(){
	
		function makeTimer(id, endTime, timerHours) {
			
			var input = jQuery(id);
			
			endTime = (endTime + (timerHours * 60 * 60 * 1000) ) / 1000;

			var now = new Date();
			now = (Date.parse(now) / 1000);
			
			var timeLeft = endTime - now;

			var days = Math.floor(timeLeft / 86400); 
			var hours = Math.floor((timeLeft - (days * 86400)) / 3600);
			var minutes = Math.floor((timeLeft - (days * 86400) - (hours * 3600 )) / 60);
			var seconds = Math.floor((timeLeft - (days * 86400) - (hours * 3600) - (minutes * 60)));
  
			if (days < "10") { days = "0" + days; }
			
			if(jQuery(input).find(".wpisset-countdown-days").hasClass('wpisset-countdown-day')){
				if (days < "01") { days = ""; }
			}
			
			if (hours < "10") { hours = "0" + hours; }
			if (minutes < "10") { minutes = "0" + minutes; }
			if (seconds < "10") { seconds = "0" + seconds; }
			
			if (endTime < now) {
				var days = 0; 
				var hours = 0;
				var minutes = 0;
				var seconds = 0;
			}

			jQuery(input).find(".wpisset-countdown-days").html(days);
			jQuery(input).find(".wpisset-countdown-hours").html(hours);
			jQuery(input).find(".wpisset-countdown-minutes").html(minutes);
			jQuery(input).find(".wpisset-countdown-seconds").html(seconds);	
	
		}
		
		var deadline = new Date();
						
		setInterval(function() {
			
			var input = jQuery('.wpisset-countdown-timer');
			
			var cookieCountdown = '';
		
			if (input.length) {
			
				jQuery(input).each(function() {
					
					var cookieName = jQuery(this).data('cookie-name');
					
					if (!jQuery.cookie(cookieName)) {
						
						jQuery.cookie(cookieName, deadline, {expires: 3, path: '/'});
						
					}else{
						
						jQuery.cookie.raw = true;
						cookieCountdown = jQuery.cookie(cookieName, unescape);	
					}
					
					//console.log(cookieName);
					
					//console.log(Date.parse(new Date(cookieCountdown)));
					
					deadline1 = Date.parse(new Date(cookieCountdown));
					
					var timerHours = jQuery(this).data('countdown-timer-hours');			
				
					makeTimer(this, deadline1, timerHours );
				
				});
			
			}
			
		}, 1000);
	
	}

	countDown();
	
	banner6();
	
	function banner6() {
		
		var mouseX = 0,
		    mouseY = 0;
		    
		jQuery(".wpisset-ele-es-banner6").on("mousemove", function(e) {
			
			mouseX = e.pageX;
			mouseY = e.pageY;
		  
		});
		
		var hoverEffect = new TimelineMax({paused:true});
		var hoverEffect1 = new TimelineMax({paused:true});
	
		jQuery(".wpisset-ele-es-banner6")
		.mouseenter(function(e) {
			
			jQuery(this).parent().addClass("nl-active");
			
			var img_wrap = jQuery(this).find(".wpisset-ele-es-banner6-label-inner");
			
			var offset = jQuery(this).find(".wpisset-ele-es-banner6-label-inner").offset();
			
			hoverEffect.to(img_wrap, 0.016, {
				repeat: -1,
				
				onRepeat: function() {
				
					TweenMax.set(img_wrap, {
				        x: mouseX - offset.left - 100,
						y: mouseY - offset.top - 100,
				    });
				    
				}
			}).play();
		    
		})
		.mouseleave(function(e) {
		
			var img_wrap = jQuery(this).find(".wpisset-ele-es-banner6-label-inner");
			
			jQuery(this).parent().removeClass("nl-active");
			
			hoverEffect.pause();
			
			hoverEffect1.to(img_wrap, 0.25, {
				x: 0,
				y: 0,
			}).play();
		
		});
		
		/*jQuery('.wpisset-ele-es-banner6')
		.on('mouseenter', function() {
			
			var element = jQuery(this).find('.wpisset-ele-es-banner6-imgs img');
			

				TweenMax.to(element, 0.6,
					{
						delay: 0,
						scale: 1.025,
						ease:Power2.easeOut,
						
					}
				);


		    
		})
		.on('mouseleave', function() {
			
				var element = jQuery(this).find('.wpisset-ele-es-banner6-imgs img');
			

				TweenMax.to(element, 0.6,
					{
						delay: 0,
						scale: 1,
						ease:Power2.easeIn,
						
					}
				);
		
		
		});*/

		
        jQuery(".wpisset-ele-es-banner6").each(function() {
            
            var chars = jQuery(this).find(".wpisset-ele-es-banner6-label-chars"),
            	holder = jQuery(this).find(".wpisset-ele-es-banner6-label-chars-holder"),
            	title = jQuery(this).find(".wpisset-ele-es-banner6-label"),
            	number = jQuery(this).find('.wpisset-ele-es-banner6-label-char').length+1;

			
			setTimeout(function(){
				
				TweenMax.to(title, 0.4,
					{
					  opacity: 1,
					}
				);
			
			},500)

			TweenMax.to(holder, 200,
				{
				  rotation: 3600, 
				  duration:0.3,
				  ease: 'none',
				  repeat: -1,
				}
			);
            	
            chars.animate({opacity:'1'},200);
            
            chars.children().each(function(event) {
	            
                var angle = -11 * (number - 2) / 2 + 11 * event;
                jQuery(this).css({
                    transform: "rotate(" + angle + "deg) translateZ(0)"
                })
                
            })
            
            
        })
        
		jQuery('.wpisset-ele-es-banner6-video').magnificPopup({
		type: 'iframe',
		
		
		iframe: {
		markup: '<div class="mfp-iframe-scaler">'+
			'<div class="mfp-close"></div>'+
			'<iframe class="mfp-iframe" frameborder="0" allowfullscreen></iframe>'+
			'<div class="mfp-title">Some caption</div>'+
			'</div>'
		},
		callbacks: {
			markupParse: function(template, values, item) {
			values.title = item.el.attr('title');
			}
		}
		
		
		});
		

	}
	
	
	function animateHeading() {
			
		jQuery(document).ready(function(){
			
				jQuery('.wpisset-ele-es-productcarousel1-title, .wpisset-ele-es-productcarousel2-title, .wpisset-ele-es-productcarousel3-title, .wpisset-ele-es-header3-title, .wpisset-ele-es-header2-title').each(function() {
			
					var controller = new ScrollMagic.Controller();

					var scene = new ScrollMagic.Scene({
						triggerElement: this,
						triggerHook: 0.85
					})
					.setClassToggle(this, 'wpisset-ele-es-animate-heading-animated')
					.reverse(false)
					.addTo(controller);
				
				});

		});
			    
	}	
	function animateImg() {
			
		jQuery(document).ready(function(){
			
				jQuery('.wpisset-ele-es-animate-image').each(function() {
			
					var controller = new ScrollMagic.Controller();
					
					var action = new TimelineMax();
					action.set(jQuery(this).find('img'), {scale: 1.10});
					action.to(jQuery(this).find('img'), 1, {scale: 1});

					var scene = new ScrollMagic.Scene({
						triggerElement: this,
						triggerHook: 0.90
					})
					.setClassToggle(this, 'wpisset-ele-es-animate-image-animated')
					.reverse(false)
					.setTween(action)
					.addTo(controller);
				
				});

		});
			    
	}
	
	function animateFadeIn() {
			
		jQuery(document).ready(function(){
			
				jQuery('.wpisset-ele-es-animate-fadein').each(function() {
			
					var controller = new ScrollMagic.Controller();
					
					var action = new TimelineMax();
					action.set(jQuery(this), {opacity: 0});
					action.to(jQuery(this), 1, {opacity: 1});

					var scene = new ScrollMagic.Scene({
						triggerElement: this,
						triggerHook: 0.95
					})
					.setClassToggle(this, 'wpisset-ele-es-animate-fadein-animated')
					.reverse(false)
					.setTween(action)
					.addTo(controller);
				
				});

		});
			    
	}
	
	
	
	function animateBannerFont() {
			
		jQuery('.wpisset-ele-es-banner-font-animate').each(function (index) {
			
		    var characters = jQuery(this).text().split("");
		    
		    $this = jQuery(this);
		    $this.empty();
		    
		    jQuery.each(characters, function (i, el) {
		    	//$this.append("<span>" + el + "</span");
		    	$this.append("<span>" + el + "</span>");
		    });
		
		});
		
		jQuery(document).ready(function(){
			
				jQuery('.wpisset-ele-es-banner-font-animate').each(function() {
		
				var controller = new ScrollMagic.Controller();

				var scene = new ScrollMagic.Scene({
					triggerElement: this,
					triggerHook: 0.85
				})
				.setClassToggle(this, 'wpisset-ele-es-banner-font-animated')
				.reverse(false)
				//.addIndicators()
				.addTo(controller);
				
				});

		});
			    
	}
	
	function animateFont() {
			
		jQuery('.wpisset-ele-es-custom-text-animate').each(function (index) {
			
		    var characters = jQuery(this).text().split("");
		    
		    $this = jQuery(this);
		    $this.empty();
		    
		    jQuery.each(characters, function (i, el) {
		    	//$this.append("<span>" + el + "</span");
		    	$this.append("<span>" + el + "</span>");
		    });
		
		});
		
		jQuery(document).ready(function(){
			
				jQuery('.wpisset-ele-es-custom-text-animate').each(function() {
					
					
					if(!jQuery(this).closest(".wpisset-subcription-popup-content").length ) {
		
						var controller = new ScrollMagic.Controller();
		
						var scene = new ScrollMagic.Scene({
							triggerElement: this,
							triggerHook: 0.85
						})
						.setClassToggle(this, 'wpisset-ele-es-custom-text-animated')
						.reverse(false)
						//.addIndicators()
						.addTo(controller);
					
					}
					
				});

		});
			    
	}
	
	function animateBadge() {
			
		jQuery(document).ready(function(){
			
				jQuery('.wpisset-ele-es-banner2-item-content-badge').each(function() {
			
					var controller = new ScrollMagic.Controller();
					
					var action = new TimelineMax();
					action.set(jQuery(this), {opacity: 0, top: "60%"});
					action.to(jQuery(this), 0.4, {opacity: 1, top: "55%"});

					var scene = new ScrollMagic.Scene({
						triggerElement: this,
						triggerHook: 0.75
					})
					//.setClassToggle(this, 'wpisset-ele-es-animate-image-animated')
					.reverse(false)
					.setTween(action)
					.addTo(controller);
				
				});
				
				jQuery('.wpisset-ele-es-banner3-item-content-badge, .wpisset-ele-es-categoryblock-item-content-badge').each(function() {
			
					var controller = new ScrollMagic.Controller();
					
					var action = new TimelineMax();
					action.set(jQuery(this), {opacity: 0, top: 48});
					action.to(jQuery(this), 0.4, {opacity: 1, top: 32});

					var scene = new ScrollMagic.Scene({
						triggerElement: this,
						triggerHook: 0.75
					})
					//.setClassToggle(this, 'wpisset-ele-es-animate-image-animated')
					.reverse(false)
					.setTween(action)
					.addTo(controller);
				
				});


		});
			    
	}
	
	jQuery(window).bind("load", function() {
	  	animateImg();
	  	animateFadeIn();
	  	animateHeading();
	  	animateBannerFont();
	  	animateFont();
	  	animateBadge();
	});

	

})( jQuery );