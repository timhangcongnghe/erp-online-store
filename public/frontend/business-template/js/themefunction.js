jQuery(document).on('ready', function() {
	"use strict";
	/* -------------------------------------
			PRELOADER
	-------------------------------------- */
	jQuery(window).on('load', function() {
		jQuery(".tg-preloaderouter").delay(2500).fadeOut();
		jQuery(".tg-cssloadcontainer").delay(2500).fadeOut("slow");
	});
	/* -------------------------------------
			COLLAPSE MENU SMALL DEVICES
	-------------------------------------- */
	function collapseMenu(){
		jQuery('.bt-navigation ul li.menu-item-has-children').prepend('<span class="bt-dropdowarrow"><i class="fa fa-angle-down"></i></span>');
		jQuery('.menu-item-has-children span').on('click', function() {
			jQuery(this).next().next().slideToggle(300);
		});
	}
	collapseMenu();
	/* -------------------------------------
			MAIN NAVIGATION					
	-------------------------------------- */
	jQuery(window).on('scroll', function() {
		var scroll = jQuery(window).scrollTop();
		if (scroll >= 10) {
			jQuery("#bt-wrapper").addClass("bt-fixedheader");
		} else {
			jQuery("#bt-wrapper").removeClass("bt-fixedheader");
		}
	});
	jQuery('.navbar-collapse').singlePageNav({
		updateHash: true,
		filter: ':not(.external)',
		beforeStart: function() {
			console.log('begin scrolling');
		},
		onComplete: function() {
			console.log('done scrolling');
		}
	});
	/* -------------------------------------
			SIDE NAVIGATION					
	-------------------------------------- */
	function sideNav() {
		var trigger = jQuery('.hamburger'),
		overlay = jQuery('.overlay'),
		isClosed = false;
		trigger.on('click', function () {
			hamburger_cross();
		});
		function hamburger_cross() {
			if (isClosed == true) {
				overlay.hide();
				trigger.removeClass('is-open');
				trigger.addClass('is-closed');
				isClosed = false;
			} else {
				overlay.show();
				trigger.removeClass('is-closed');
				trigger.addClass('is-open');
				isClosed = true;
			}
		}
		jQuery('[data-toggle="offcanvas"]').on('click', function () {
			jQuery('body').toggleClass('toggled');
		});
	}
	sideNav();
	/* -------------------------------------
			HOME SLIDER
	-------------------------------------- */
	jQuery("#bt-homeslider").owlCarousel({
		autoPlay: false,
		singleItem:true,
		slideSpeed : 300,
		pagination : true,
		navigation : false,
		paginationSpeed : 400,
		navigationText: [
			"<span class='th-btnsquareprev'><i class='fa fa-long-arrow-left'></i></span>",
			"<span class='th-btnsquarenext'><i class='fa fa-long-arrow-right'></i></span>"
		],
	});
	/* -------------------------------------
			PRETTY PHOTO GALLERY
	-------------------------------------- */
	jQuery("a[data-rel]").each(function () {
		jQuery(this).attr("rel", jQuery(this).data("rel"));
	});
	jQuery("a[data-rel^='prettyPhoto']").prettyPhoto({
		animation_speed: 'normal',
		theme: 'dark_square',
		slideshow: 3000,
		autoplay_slideshow: false,
		social_tools: false
	});
	/*--------------------------------------
				ABOUT POWAX SLIDER			
	--------------------------------------*/
	function aboutPowaxSlider(){
		var sync1 = jQuery("#bt-descriptionslider");
		var sync2 = jQuery("#bt-iconsslider");
		sync1.owlCarousel({
			singleItem : true,
			slideSpeed : 1000,
			navigation: false,
			pagination:false,
			afterAction : syncPosition,
			responsiveRefreshRate : 200,
		});
		sync2.owlCarousel({
			items : 5,
			itemsDesktop			: [1199,5],
			itemsDesktopSmall		: [991,4],
			itemsTablet				: [767,3],
			itemsMobile				: [639,2],
			pagination:false,
			responsiveRefreshRate : 100,
			afterInit : function(el){
				el.find(".owl-item").eq(0).addClass("bt-active");
			}
		});
		function syncPosition(el){
			var current = this.currentItem;
			jQuery("#bt-iconsslider")
				.find(".owl-item")
				.removeClass("bt-active")
				.eq(current)
				.addClass("bt-active");
			if(jQuery("#bt-iconsslider").data("owlCarousel") !== undefined){
				center(current);
			}
		}
		jQuery("#bt-iconsslider").on("click", ".owl-item", function(e){
			e.preventDefault();
			var number = jQuery(this).data("owlItem");
			sync1.trigger("owl.goTo",number);
		});
		function center(number){
			var sync2visible = sync2.data("owlCarousel").owl.visibleItems;
			var num = number;
			var found = false;
			for(var i in sync2visible){
				if(num === sync2visible[i]){
					var found = true;
				}
			}
			if(found===false){
				if(num>sync2visible[sync2visible.length-1]){
					sync2.trigger("owl.goTo", num - sync2visible.length+2);
				}else{
					if(num - 1 === -1){
					num = 0;
				}
				sync2.trigger("owl.goTo", num);
			}
			} else if(num === sync2visible[sync2visible.length-1]){
				sync2.trigger("owl.goTo", sync2visible[1]);
			} else if(num === sync2visible[0]){
				sync2.trigger("owl.goTo", num-1);
			}
		}
	}
	aboutPowaxSlider();
	/*--------------------------------------
				TEAM MEMBERS SLIDER			
	--------------------------------------*/
	function teamMemberslider(){
		var sync1 = jQuery("#bt-teammembercontentslider");
		var sync2 = jQuery("#bt-teammembernavigationslider");
		sync1.owlCarousel({
			autoPlay: true,
			singleItem : true,
			slideSpeed : 1000,
			navigation: false,
			pagination:false,
			afterAction : syncPosition,
			responsiveRefreshRate : 200,
		});
		sync2.owlCarousel({
			items : 4,
			autoPlay: true,
			itemsDesktop			: [1199,4],
			itemsDesktopSmall		: [991,3],
			itemsTablet				: [767,3],
			itemsMobile				: [639,2],
			pagination:false,
			responsiveRefreshRate : 100,
			afterInit : function(el){
				el.find(".owl-item").eq(0).addClass("bt-active");
			}
		});
		function syncPosition(el){
			var current = this.currentItem;
			jQuery("#bt-teammembernavigationslider")
			.find(".owl-item")
			.removeClass("bt-active")
			.eq(current)
			.addClass("bt-active");
			var currentValue = jQuery("#bt-teammembernavigationslider .owl-item.bt-active figure img").attr('src');
			jQuery('.bt-memberlargedp').find('img').attr('src', currentValue);
			if(jQuery("#bt-teammembernavigationslider").data("owlCarousel") !== undefined){
				center(current);
			}
		}
		jQuery("#bt-teammembernavigationslider").on("click", ".owl-item", function(e){
			e.preventDefault();
			var number = jQuery(this).data("owlItem");
			sync1.trigger("owl.goTo",number);
		});
		function center(number){
			var sync2visible = sync2.data("owlCarousel").owl.visibleItems;
			var num = number;
			var found = false;
			for(var i in sync2visible){
				if(num === sync2visible[i]){
					var found = true;
				}
			}
			if(found===false){
				if(num>sync2visible[sync2visible.length-1]){
					sync2.trigger("owl.goTo", num - sync2visible.length+2);
				}else{
					if(num - 1 === -1){
					num = 0;
				}
				sync2.trigger("owl.goTo", num);
			}
			} else if(num === sync2visible[sync2visible.length-1]){
				sync2.trigger("owl.goTo", sync2visible[1]);
			} else if(num === sync2visible[0]){
				sync2.trigger("owl.goTo", num-1);
			}
		}
		jQuery('#bt-teammembernavigationslider .owl-item figure img').on('click', function(){
			var _this = jQuery(this).attr('src');
			jQuery('.bt-memberlargedp').find('img').attr('src', _this);
		});
	}
	teamMemberslider();
	/*---------------------------------------
			STATISTICS
	-------------------------------------- */
	try {
		jQuery('.bt-counter').appear(function () {
			jQuery('.bt-count').countTo();
		});
	} catch (err) {}
	/*---------------------------------------
			SKILLS PROGRESS BAR
	---------------------------------------*/
	try {
		jQuery('#bt-ourskill').appear(function () {
			jQuery('.bt-skillholder').each(function () {
				jQuery(this).find('.bt-skillbar').animate({
					width: jQuery(this).attr('data-percent')
				}, 2500);
			});
		});
	} catch (err) {}
	/* -------------------------------------
			TESTIMONIALS SLIDER
	-------------------------------------- */
	jQuery("#bt-testimonialsslider").owlCarousel({
		autoPlay: false,
		singleItem:true,
		slideSpeed : 300,
		pagination : false,
		navigation : true,
		paginationSpeed : 400,
		navigationText: [
			"<span class='th-btnsquareprev'><i class='icon-arrow-left5'></i></span>",
			"<span class='th-btnsquarenext'><i class='icon-arrow-right5'></i></span>"
		],
	});
	/* -------------------------------------
			LATEST NEWS SLIDER
	-------------------------------------- */
	jQuery("#bt-postsslider").owlCarousel({
		autoPlay: false,
		slideSpeed : 300,
		pagination : false,
		navigation : true,
		paginationSpeed : 400,
		navigationText: [
			"<span class='th-btnsquareprev'><i class='icon-arrow-left5'></i></span>",
			"<span class='th-btnsquarenext'><i class='icon-arrow-right5'></i></span>"
		],
		itemsCustom : [
			[0, 1],
			[480, 1],
			[992, 2],
			[1200, 2],
		],
	});
	/* -------------------------------------
			GOOGLE MAP
	-------------------------------------- */
	jQuery("#bt-locationmap").gmap3({
		marker: {
			address: "1600 Elizabeth St, Melbourne, Victoria, Australia",
			options: {
				title: "Powax HTML5 CSS3 Theme",
				icon: "frontend/business-template/images/mapmarker.png",
			}
		},
		map: {
			options: {
				zoom: 16,
				scrollwheel: false,
				disableDoubleClickZoom: true,
			}
		}
	});
	/* -------------------------------------
			LATEST NEWS SLIDER
	-------------------------------------- */
	jQuery("#bt-postslidertwo").owlCarousel({
		autoPlay: false,
		slideSpeed : 300,
		pagination : true,
		navigation : false,
		paginationSpeed : 400,
		navigationText: [
			"<span class='th-btnsquareprev'><i class='icon-arrow-left5'></i></span>",
			"<span class='th-btnsquarenext'><i class='icon-arrow-right5'></i></span>"
		],
		itemsCustom : [
			[0, 1],
			[639, 1],
			[992, 2],
			[1200, 3],
		],
	});
	/* -------------------------------------
			ALL SERVICES SLIDER
	-------------------------------------- */
	jQuery("#bt-allservicesslider").owlCarousel({
		autoPlay: false,
		slideSpeed : 300,
		pagination : true,
		navigation : false,
		paginationSpeed : 400,
		navigationText: [
			"<span class='th-btnsquareprev'><i class='fa fa-long-arrow-left'></i></span>",
			"<span class='th-btnsquarenext'><i class='fa fa-long-arrow-right'></i></span>"
		],
		itemsCustom : [
			[0, 1],
			[480, 1],
			[992, 3],
			[1200, 3],
		],
	});
});