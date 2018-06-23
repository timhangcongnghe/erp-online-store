// Generate unique id
function guid() {
  function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
      .toString(16)
      .substring(1);
  }
  return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
    s4() + '-' + s4() + s4() + s4();
}

// Contact form ajax load
function loadContactForm(contact_id) {
    var box = $('.order-contact-form');
    var url = box.attr('data-url');

    if (!box.length) {
        return;
    }

    box.show();

    $.ajax({
        url: url,
        data: {
            contact_id: contact_id
        }
    }).done(function( data ) {
        box.html(data);
        box.find('.ajax-content-control').trigger('change');
        box.find('.contact_form').validate({
            //put error message behind each form element
            errorPlacement: function (error, element) {
                var elem = $(element);

                if (elem.hasClass('select2-hidden-accessible')) {
                    error.insertAfter(elem.parent().find('.select2-container')[0]);
                } else {
                    error.insertAfter(element);
                }
                $('.select2-selection').click(function() {
                    document.getElementById("select-city-error").style.display = "none";
                });
                $('#select2-input-payment-zone-container').click(function() {
                    document.getElementById("input-payment-zone-error").style.display = "none";
                });
            },
        });
        box.find('select').select2({language: "vi"});
    });
}

function fixWithProductListAll(container) {
    var items = $('.products-list');
    if (typeof(container) !== 'undefined' ) {
      items = container.find('.products-list');
    }
    items.each(function() {
        fixWithProductList($(this));
    });
}

function fixWithProductList(list) {
    var count = list.find('.product-item-container').length;
    var item_width = list.find('.product-layout').width();
    var list_width = list.width();
    var per_row = parseInt(list_width/(item_width-10));
    var items = list.find('.product-item-container');

    items.css('height', 'auto');

    var num = -1;
    var rows = [];
    var max_height = 0;
    items.each(function(index) {
        if (parseInt(index%per_row) === 0) {
            num = num + 1;
            max_height = 0;
            rows[num] = [];
            rows[num]["boxes"] = [];
        }

        var box = $(this);
        rows[num]["boxes"].push(box);
        if (box.height() > max_height) {
            max_height = box.height();
        }

        if (index%per_row == per_row-1 || index == items.length-1) {
            rows[num]["max_height"] = max_height;
        }
    });
    rows.forEach(function(entry) {
        entry["boxes"].forEach(function(box) {
            box.height(entry["max_height"]);
        });
    });
}

function countDown(item, year, month, day, hour, minute) {
    month = month - 1

    "use strict";
    var austDay = new Date(year, month, day, hour, minute);
    item.countdown(austDay, function(event) {
        var $this = $(this).html(event.strftime('' + '<div class="time-item time-day"><div class="num-time">%D</div><div class="name-time">Ngày </div></div>' + '<div class="time-item time-hour"><div class="num-time">%H</div><div class="name-time">Giờ </div></div>' + '<div class="time-item time-min"><div class="num-time">%M</div><div class="name-time">Phút </div></div>' + '<div class="time-item time-sec"><div class="num-time">%S</div><div class="name-time">Giây </div></div>'));
    });
}

function toogleFixedNav() {
    if (!$('.sticky-services').length) {
        var top = $(window).scrollTop();
        var nav_top = $('.header-fixed-top').offset().top;

        if (top > 165 && nav_top > 265 && $(window).width() > 992)  {
            $('.header-fixed-top').show();
        } else {
            $('.header-fixed-top').hide();
        }
    }
}

function toogleServicesNav() {
    if ($('.sticky-services').length) {
        var top = $(window).scrollTop();
        var nav_top = $('.sticky-services').offset().top;

        if (top > 690 &&  $(window).width() > 992)  {
            $('.sticky-services').addClass('fixed_nav');
            if (!$('.service-nav-placeholder').length) {
                $('.sticky-services').after('<div class="service-nav-placeholder"></div>');
            }
        } else {
            $('.sticky-services').removeClass('fixed_nav');
            $('.service-nav-placeholder').remove();
        }

        var scrollBottom = $(document).height() - $(window).height() - $(window).scrollTop();
        if (scrollBottom < 50) {
            $('.sticky-services').hide();
        } else {
            $('.sticky-services').show();
        }
    }
}

function loadTopRightMenu(callback) {
    var block = $('.top-right-menu');
    var url = $('.top-right-menu').attr('data-url');

    $.ajax({
        url: url
    }).done(function( data ) {
        block.html(data);
        if (typeof(callback) !== 'undefined') {
            callback();
        }

        if ( $('.type_1 .compare a span').length) {
          var compare_count = $('.type_1 .compare a span').html().split('(')[1].split(')')[0];
          $('.type_7 .compare a span').html(compare_count);
        }
    });
}

function loadTopCart(callback) {
    var block = $('.block-cart');
    var url = $('.block-cart').attr('data-url');

    $.ajax({
        url: url
    }).done(function( data ) {
        block.html(data);
        if (typeof(callback) !== 'undefined') {
            callback();
        }
    });
}

function showNotice(type, title, message) {
    var tpl = '<h3>' + message + '</h3>';
    $.jGrowl(tpl, {
        life: 4000,
        header: title,
        speed: 'slow',
        theme: type
    });
}

function homeCategoryBox(box) {
    var url = box.attr('data-url');

    box.addClass('loading');

    $.ajax({
        url: url
    }).done(function( data ) {
        box.html(data);
        box.removeClass('loading');
        box.find('.ajax-link').fancybox({
            closeClickOutside : true,
        });

    });
}

function autoSearchMoveUp(box) {
    var current_li = box.find('li.current');
    var prev;
    if (current_li.length) {
        prev = current_li.prev();
    } else {
        prev = box.find('li').last();
    }

    box.find('li').removeClass('current');

    if (prev.length) {
        prev.addClass('current');
    } else{
        current_li.parents('ul').find('li').last().addClass('current');
    }
}

function autoSearchMoveDown(box) {
    var current_li = box.find('li.current');
    var next;
    if (current_li.length) {
        next = current_li.next();
    } else {
        next = box.find('li').first();
    }


    box.find('li').removeClass('current');

    if (next.length) {
        next.addClass('current');
    } else{
        next.parents('ul').find('li').eq(0).addClass('current');
    }
}

var autosearch_xhr;
function autoSearch(box) {
    var input = box.find('.autosearch-input');
    var keyword = input.val();
    var url = box.attr('data-url');
    var result_box = box.find('.autosearch-result-box ul');
    var menu_id = box.find('select').val();

    // if keyword == ''
    if (keyword.trim() == '') {
        result_box.parent().hide();
        return;
    }

    if (!box.find('.autosearch-result-box').length) {
        box.append('<div class="autosearch-result-box"><ul></ul></div>');
        var result_box = box.find('.autosearch-result-box ul');
    }

    // ajax autosearch
	if(autosearch_xhr && autosearch_xhr.readyState != 4){
		autosearch_xhr.abort();
	}
    autosearch_xhr = $.ajax({
        url: url,
        data: {
            keyword: keyword,
            menu_id: menu_id
        }
    }).done(function( items ) {
        result_box.html('');
        result_box.parent().show();
        items.forEach(function(item) {
            result_box.append(
                '<li><a title="' + item.name + '" href="' + item.link + '">' +
                    '<img src="' +item.image+ '" />' +
                    '<span class="title">' + item.name + '</span>' +
                    '<span class="price sold_out_' +item.is_sold_out+ ' is_call_' +item.is_call+ '">' + (item.price ==  "<span style='font-family:sans-serif;'>0₫</span>" || item.is_sold_out || item.is_call ? 'Liên Hệ: (028) 3984 7690' : item.price) + '</span>' +
                    ' <span class="old_price old_price_'+item.old_price+'"><span class="num">' + item.old_price + '</span> (giảm ' + item.deal_percent + '%)</span>' +
                '</a></li>'
            );
        });
        if (items.length) {
            // result_box.find('li').eq(0).addClass('current');
        } else {
            result_box.append(
                '<li class="autosearch-empty-line">Không tìm thấy sản phẩm phù hợp...</li>'
            );
        }
    });
}

// Init vars
var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
var category_xhr;
var online_search_xhr;
$(document).ready(function () {
    // Grap link with data-method attribute
    $(document).on('click', 'a.link-method[data-method]', function(e) {

        // return if this is list action
        if($(this).parents('.datalist-list-action').length) {
            return;
        }

        e.preventDefault();

        var method = $(this).attr("data-method");
        var action = $(this).attr("href");

        var newForm = jQuery('<form>', {
            'action': action,
            'method': 'POST',
            'target': '_top'
        });
        newForm.append(jQuery('<input>', {
            'name': 'authenticity_token',
            'value': AUTH_TOKEN,
            'type': 'hidden'
        }));
        newForm.append(jQuery('<input>', {
            'name': '_method',
            'value': method,
            'type': 'hidden'
        }));
        $(document.body).append(newForm);
        newForm.submit();
    });

    $(document).on('keyup', '.autosearch-input', function(e) {
        var box = $(this).parents('.autosearch');
        var form = $(this).parents('form');

        var code = (e.keyCode ? e.keyCode : e.which);
        if (code === 38) {
            autoSearchMoveUp(box);
            return;
        }
        if (code === 40) {
            autoSearchMoveDown(box);
            return;
        }
        if (code === 13) {
            if (box.find('li.current a').length) {
                var link = box.find('li.current a').attr('href');
                window.location = link;
                return;
            } else {
                form.submit();
            }
        }
        autoSearch(box);
    });

    $(document).on('change', '.autosearch select', function(e) {
        var box = $(this).parents('.autosearch');

        autoSearch(box);
    });

    $(document).on('focusout', '.autosearch-input', function() {
        var box = $(this).parents('.autosearch');
        setTimeout(function() {
            box.find('.autosearch-result-box').hide();
        }, 500);
    });

    $(document).on('focusin', '.autosearch-input', function() {
        var box = $(this).parents('.autosearch');
        box.find('.autosearch-result-box').show();
    });

    $('.category_box').each(function() {
        var box = $(this);

        // Render home category box
        homeCategoryBox(box);
    });

    $(document).on('click', '.category_box a.ajax_link', function(e) {
        e.preventDefault();

        var box = $(this).parents('.category_box');
        box.attr('data-url', $(this).attr('href'));

        // Render home category box
        homeCategoryBox(box);
    });

    $(document).on('submit', '#new_newsletter', function(e) {
        e.preventDefault();

        var form = $(this);
        var url = form.attr('action');
        var input = form.find('input[type=text]');
        var value = input.val();

        if (value.trim() == '') {
            input.focus();
            input.addClass('error');
            var tpl = '<h3>Bạn phải nhập email đăng ký</h3>';
            $.jGrowl(tpl, {
                life: 4000,
                header: 'Thông báo',
                speed: 'fast',
                theme: 'warning'
            });
            return;
        }

        $.ajax({
            url: url,
            data: form.serialize()
        }).done(function( data ) {
            var tpl = '<h3>' + data.message + '</h3>';
            $.jGrowl(tpl, {
                life: 4000,
                header: 'Thông báo',
                speed: 'slow',
                theme: data.status
            });
            input.val('');
            input.removeClass('error');
        });
    });

    $(document).on('mousedown', '.ajax-link', function() {
        if (typeof($(this).attr('dont-close')) != 'undefined' && $(this).attr('dont-close') == 'true') {
            return;
        }

        $.fancybox.close( 'all' );
    });

    $('.ajax-link').fancybox({
        closeClickOutside : true,
    });

    $(document).on('submit', '.ajax-form', function(e) {
        e.preventDefault();

        var form = $(this);
        var url = form.attr('action');
        var method = form.attr('method');

        form.find('.notice').hide();

        $.ajax({
            url: url,
            method: method,
            data: form.serialize(),
            dataType: 'text',
        }).done(function( data ) {
            location.reload();
        }).fail(function(xhr, status, error) {
            form.find('.notice').html('<span class=\'flash_error alert alert-danger\'> ' +xhr.responseText+ '</span>');
            form.find('.notice').fadeIn();
        });
    });

    $(document).on('submit', '.register-form', function(e) {
        e.preventDefault();

        var form = $(this);
        var url = form.attr('action');
        var method = form.attr('method');

        form.find('.notice').hide();
        form.find('input[type=submit]').after('<div class="btn-loading text-center">Đang xử lý...</div>')
        form.find('input[type=submit]').hide();

        $.ajax({
            url: url,
            method: method,
            data: form.serialize(),
            dataType: 'text',
        }).done(function( data ) {
            if ( $('<div>').html(data).find('form').length ) {
                form.find('.form-content').html($('<div>').html(data).find('.form-content').html());
            } else {
                form.find('.form-content').html(data);
            }
        });
    });

    // JS Profile Account with Tabs
    $(".btn-pref .btn").click(function () {
        $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
        // $(".tab").addClass("active"); // instead of this do the below
        $(this).removeClass("btn-default").addClass("btn-primary");
    });

    $(document).on('click', '.product-item-container .right-block', function() {
        var url = $(this).find('a').attr('href');

        document.location.href = url;
    });

    // Cart form
    $(document).on('submit', '.add-cart-form', function(e) {
        e.preventDefault();

        var form = $(this);
        var url = form.attr('action');
        form.addClass('loading');

        $.ajax({
            url: url,
            method: 'POST',
            data: form.serialize()
        }).done(function( data ) {
            showNotice('success', 'Thành công', data);
            loadTopCart();
            form.removeClass('loading');
            form.find('input[name=quantity]').val(1);
        });
    });

    // Compare form
    $(document).on('submit', '.add-compare-form', function(e) {
        e.preventDefault();

        var form = $(this);
        var url = form.attr('action');
        form.addClass('loading');

        $.ajax({
            url: url,
            method: 'POST',
            data: form.serialize()
        }).done(function( data ) {
            showNotice(data.type, data.title, data.message);
            loadTopRightMenu();
            form.removeClass('loading');
        });
    });

    // Wishlist form
    $(document).on('submit', '.add-wishlist-form', function(e) {
        e.preventDefault();

        var form = $(this);
        var url = form.attr('action');
        form.addClass('loading');

        $.ajax({
            url: url,
            method: 'POST',
            data: form.serialize()
        }).done(function( data ) {
            showNotice(data.type, data.title, data.message);
            loadTopRightMenu();
            form.removeClass('loading');
        });
    });

    // Forget password form
    $(document).on('submit', '.reset-password', function(e) {
        e.preventDefault();

        var form = $(this);
        var url = form.attr('action');
        var method = form.attr('method');

        form.find('.notice').hide();
        form.find('input[type=submit]').after('<div class="btn-loading text-right">Đang xử lý...</div>')
        form.find('input[type=submit]').hide();

        $.ajax({
            url: url,
            method: method,
            data: form.serialize(),
            dataType: 'text',
        }).done(function( data ) {
            if ( $('<div>').html(data).find('form').length ) {
                form.find('.form-content').html($('<div>').html(data).find('.form-content').html());
            } else {
                form.find('.form-content').html(data);
            }
        });
    });


    //// TODO: js upload image in my account
    $(document).on('click', '#close-preview', function(){
        $('.image-preview').popover('hide');
        // Hover befor close the preview
        $('.image-preview').hover(
            function () {
               $('.image-preview').popover('show');
            },
             function () {
               $('.image-preview').popover('hide');
            }
        );
    });
    ////

    $(function() {
        //// js upload image in my account
        // Create the close button
        var closebtn = $('<button/>', {
            type:"button",
            text: 'x',
            id: 'close-preview',
            style: 'font-size: initial;',
        });
        closebtn.attr("class","close pull-right");
        // Set the popover default content
        $('.image-preview').popover({
            trigger:'manual',
            html:true,
            title: "<strong>Xem trước</strong>"+$(closebtn)[0].outerHTML,
            content: "There's no image",
            placement:'bottom'
        });
        // Clear event
        $('.image-preview-clear').click(function(){
            $('.image-preview').attr("data-content","").popover('hide');
            $('.image-preview-filename').val("");
            $('.image-preview-clear').hide();
            $('.image-preview-input input:file').val("");
            $(".image-preview-input-title").text("Chọn ảnh");
        });
        // Create the preview image
        $(".image-preview-input input:file").change(function (){
            var img = $('<img/>', {
                id: 'dynamic',
                width:250,
                height:200
            });
            var file = this.files[0];
            var reader = new FileReader();
            // Set preview image into the popover data-content
            reader.onload = function (e) {
                $(".image-preview-input-title").text("Thay đổi");
                $(".image-preview-clear").show();
                $(".image-preview-filename").val(file.name);
                img.attr('src', e.target.result);
                $(".image-preview").attr("data-content",$(img)[0].outerHTML).popover("show");
            }
            reader.readAsDataURL(file);
        });
        //// end - js upload image in my account

        // toggle fixed bar
        setInterval(function() {toogleFixedNav();btnMenuFixed();}, 200);

        // validate contact form, comment form, rating form
        $('.contact_form').validate();
        $('.comment_form').validate();
        $('.rating_form').validate({
            rules: {
              'rating[content]': {
                required: true,
                minlength: 50
              }
            }
        });
        $('.password_form').validate();
        $('.account_form').validate();
        $('.checkout_form').validate();

        // Count Down
        $('.count-down').each(function() {
            var times = $(this).attr('rel').split(',');

            countDown($(this), times[0], times[1], times[2], times[3], times[4]);
        });


        // Top toggle menu for product detail
        $('.layout-subpage .top-link li').hover(function() {
            $(this).find('ul').slideDown(200);
        }, function() {
            $(this).find('ul').hide();
        });

        //// auto height product list
        setInterval(function() {
            fixWithProductListAll();
        }, 1000);

        //$('div.lazy img').load(function() {
        //    var container = $(this).parents('.products-list').parent();
        //    setTimeout(function() {
        //        fixWithProductListAll(container);
        //    }, 1000);
        //});
    });

    // autosearch
    $('.autosearch select').select2({
        minimumResultsForSearch: 10,
        dropdownAutoWidth: 'true',
        language: "vi"
    });

    // Mobile top menu fix
    $(document).on('click', '.header-top-right .tabBlockTitle', function() {
        var parent = $(this).parents('.header-top-right');
        parent.find('.tabBlock.top-right-menu').toggle();
    });

    // hover main menu
    $('.container-megamenu.vertical').hover(
        function () {
           $(this).find('.vertical-wrapper').slideDown();
        },
         function () {
           $(this).find('.vertical-wrapper').hide();
        }
    );

    // autosearch
    $('select').each(function() {
        var placeholder = $(this).attr('placeholder');

        if (typeof(placeholder) == 'undefined') {
            placeholder = false;
        }

        $(this).select2({
            minimumResultsForSearch: 10,
            dropdownAutoWidth: 'true',
            language: "vi",
            placeholder: placeholder,
        });
    });

    // Ajax content
    $(document).on('change', '.ajax-content-control', function() {
        var container = $($(this).attr('data-content-selector'));
        var url = $(this).attr('data-url');
        var value = $(this).val();

        container.html('');

        $.ajax({
            url: url,
            data: {
                state_id: value
            }
        }).done(function( data ) {
            container.html(data);
            if (!container.parents('.fancybox-inner').length) {
              container.find('select').select2({
                  minimumResultsForSearch: 10,
                  dropdownAutoWidth: 'true',
                  language: "vi"
              });
            }
        });
    });
    $('.ajax-content-control').trigger('change');

    setTimeout(function() {$('.contacts-create-hide').hide();}, 2000);

    $(document).on('click', '.fancybox-slide--current', function(e) {
        if($(e.target).parents('.product-box-desc').length || $(e.target).parents('.fancybox-content-no, .fancybox-slide').length || $(e.target).parents('.row').length) {
            return;
        }
        $.fancybox.close( 'all' );
    });

    $(document).on('change', '.category-filter-box input, .category-filter-box select, .category-filter-top input, .category-filter-top select', function() {
        var form = $(this).parents('form');
        var url = form.attr('action');
        var container = form.parent().find('.main-products-list');

        if(container.length === 0) {
          container = $('.main-products-list');
        }

        container.prepend('<div class="category-loading"></div>');
        container.find(".products-list").css('opacity', '0.6');

        // Add uniq id to form
        var uuid = form.attr('id');
        if (typeof(uuid) === 'undefined') {
            uuid = guid();
            form.attr('id', uuid);
        }

        //$( "body" ).scrollTop( $('#content').offset().top - 100 );
        //$( "body" ).animate({scrollTop:$('#content').offset().top - 100}, 'slow');

        // ajax autosearch
        //if(category_xhr && category_xhr.readyState != 4){
        //    category_xhr.abort();
        //}
        //category_xhr =
        $.ajax({
            url: url,
            data: $('.category-filter-box, #' + uuid).serialize()
        }).done(function( data ) {
            container.html($('<div>').html(data).find('.main-products-list').html());
            setTimeout(function () {
                container.find('.product-image-container').addClass('lazy-loaded');
                container.find('.product-image-container').removeClass('lazy');
                container.find('.products-list').removeClass('list').addClass('grid');
                //fixWithProductListAll(container);
            }, 500);
            container.find('.ajax-link').fancybox({
                closeClickOutside : true,
            });
        });
    });

    $(document).on('click', '.box-pagination .pagination a', function(e) {
        e.preventDefault();

        var url = $(this).attr('href');
        var container = $(this).parents('.main-products-list');
        var form = container.find('form');

        // Add uniq id to form
        var uuid = form.attr('id');
        if (typeof(uuid) === 'undefined') {
            uuid = guid();
            form.attr('id', uuid);
        }

        container.prepend('<div class="category-loading"></div>');
        container.find(".products-list").css('opacity', '0.6');

        $( window ).scrollTop( $('#content').offset().top - 100 );

        // ajax autosearch
        //if(category_xhr && category_xhr.readyState != 4){
        //    category_xhr.abort();
        //}
        //category_xhr =
        $.ajax({
            url: url,
            data: $('.category-filter-box, #' + uuid).serialize()
        }).done(function( data ) {
            container.html($('<div>').html(data).find('.main-products-list').html());
            setTimeout(function () {
                container.find('.product-image-container').addClass('lazy-loaded');
                container.find('.product-image-container').removeClass('lazy');
                container.find('.products-list').removeClass('list').addClass('grid');
                //fixWithProductListAll(container);
            }, 500);
            container.find('.ajax-link').fancybox({
                closeClickOutside : true,
            });
        });
    });

    // $('.category-filter-top.auto-load input, .category-filter-top.auto-load select').trigger('change');
    $('.products-category').each(function() {
      $(this).find('.category-filter-top.auto-load input, .category-filter-top.auto-load select').eq(0).trigger('change');
    });

    // delete contact confirm form
    $(document).on('click', '[link-method]', function(e) {
        e.preventDefault();
        var method = $(this).attr('link-method');
        var url = $(this).attr('href');
        var confirm_text = $(this).attr('link-confirm');
        var ok = confirm(confirm_text);

        if (ok) {
            var newForm = jQuery('<form>', {
                'action': url,
                'method': 'POST',
                'target': '_top'
            });
            newForm.append(jQuery('<input>', {
                'name': 'authenticity_token',
                'value': AUTH_TOKEN,
                'type': 'hidden'
            }));
            newForm.append(jQuery('<input>', {
                'name': '_method',
                'value': method,
                'type': 'hidden'
            }));
            $(document.body).append(newForm);
            newForm.submit();
        }
    });

    // prevent autosearch-form
    $(document).on('submit', '.autosearch-form', function(e) {
        var val = $(this).find('input[name=keyword]').val();

        if (val.trim() === '') {
            e.preventDefault();
            return false;
        } else {
            return true;
        }
    });

    // compare style
    $('.product-compare tr').each(function() {
        if($(this).find('.property-value').length) {
          var same = true
          var value = $(this).find('.property-value').first().html();
          $(this).find('.property-value').each(function() {
            if ($(this).html() != value) {
              same = false;
              return;
            }
          });
          if (!same) {
            $(this).find('.property-value').addClass('diff');
          }
        }
    })

    // Compare form
    $(document).on('click', '.quick-view.btn_compare', function(e) {
        e.preventDefault();

        var url = $(this).attr('data-url');
        var product_id = $(this).attr('product_id');

        $.ajax({
            url: url,
            method: 'POST',
            data: {
                authenticity_token: AUTH_TOKEN,
                product_id: product_id
            }
        }).done(function( data ) {
            showNotice(data.type, data.title, data.message);
            loadTopRightMenu();
        });
    });

    // Select2 ajax
    $(".select-ajax").each(function() {
        var url = $(this).attr('data-url');
        var placeholder = $(this).attr('data-placeholder');

        if(typeof(placeholder) === 'undefined') {
            placeholder = '';
        }

        $(this).select2({
            ajax: {
              url: url,
              dataType: 'json',
              delay: 250,
              data: function (params) {
                return {
                  q: params.term, // search term
                  page: params.page
                };
              },
              processResults: function (data) {
                return {
                    results: $.map(data.items, function (item) {
                        return {
                            text: item.text,
                            id: item.value
                        }
                    })
                };
              },
              cache: true
            },
            escapeMarkup: function (markup) {
              return markup;
            }, // let our custom formatter work
            minimumInputLength: 0,
            language: "vi",
            allowClear: true,
            placeholder: placeholder
        });
    });

    // Online search
    $(document).on('submit', '.online_search_form', function(e) {
        e.preventDefault();

        var form = $(this);
        var url = form.attr('action');
        var method = form.attr('method');
        var keywords = form.find('input[name=keywords]').val();
        var container = $('.online_search_result_container');

        if (keywords.trim() === '') {
            return;
        }

        container.html('<div class="category-loading"></div>');

        if(online_search_xhr && online_search_xhr.readyState != 4){
            online_search_xhr.abort();
        }
        online_search_xhr = $.ajax({
            url: url,
            method: method,
            data: form.serialize()
        }).done(function( data ) {
            container.html(data);
            setTimeout(function () {
                container.find('.product-image-container').addClass('lazy-loaded');
                container.find('.product-image-container').removeClass('lazy');
                container.find('.products-list').removeClass('list').addClass('grid');
                //fixWithProductListAll(container);
            }, 500);
        });
    });

    $(document).on('click', '.service_box_list .pagination a', function(e) {
        e.preventDefault();

        var link = $(this);
        var url = link.attr('href');
        var method = 'GET';
        var container = $('.online_search_result_container');

        container.html('<div class="category-loading"></div>');

        if(online_search_xhr && online_search_xhr.readyState != 4){
            online_search_xhr.abort();
        }
        online_search_xhr = $.ajax({
            url: url,
            method: method
        }).done(function( data ) {
            container.html(data);
            setTimeout(function () {
                container.find('.product-image-container').addClass('lazy-loaded');
                container.find('.product-image-container').removeClass('lazy');
                container.find('.products-list').removeClass('list').addClass('grid');
                //fixWithProductListAll(container);
            }, 500);
            $(window).scrollTop();
        });
    });

    $(document).on('submit', '.checkout_form', function(e) {
      return $(this).valid();
    });

    // Quick view form
    $(document).on('submit', '.quick-view-form', function(e) {
      e.preventDefault();

      var form = $(this);
      var url = form.attr('action');
      var method = form.attr('method');

      $.ajax({
            url: url,
            method: method,
            data: form.serialize()
      }).error(function() {
            var url = $('.shopping-cart').attr('data-url');
            $.ajax({
                url: url
            }).done(function( html ) {
                showNotice('success', 'Thành công', 'Giỏ hàng đã được cập nhật');
                $('.shopping-cart .table-responsive.form-group').html($('<div>').html(html).find('.shopping-cart .table-responsive.form-group').html());
                loadTopCart();
            });
      });

      return false;
    });
    // Quick view form
    $(document).on('click', '.cart-item-delete', function(e) {
      e.preventDefault();

      var a_ = $(this);
      var url = a_.attr('href');

      $.ajax({
            url: url
      }).done(function() {
            var url = $('.shopping-cart').attr('data-url');
            $.ajax({
                url: url
            }).done(function( html ) {
                showNotice('success', 'Thành công', 'Giỏ hàng đã được cập nhật');
                $('.shopping-cart .table-responsive.form-group').html($('<div>').html(html).find('.shopping-cart .table-responsive.form-group').html());
                if (!$('<div>').html(html).find('.shopping-cart .table-responsive.form-group').length) {
                  $.fancybox.close();
                }
                loadTopCart();
            });
      });

      return false;
    });

    // Click product in mobile
    $(document).on('click', '.product-layout', function() {
        if ($(window).width() < 767) {
            window.location = $(this).find('.right-block a').attr('href');
        }
    });
});
$(window).scroll(function () {
    toogleFixedNav();
    toogleServicesNav();
    btnMenuFixed();
    showHideMenuFixed();
});
$( window ).resize(function() {
    // auto height product list
    //fixWithProductListAll();
});


// Custom js



// get height show menu fixed
function getHeightMenuFixed() {
    var height;
    if ($('.vertical').hasClass('open'))
    {
        height = 560;
    }
    else
    {
        height = 265;
    }
    return height;
}

// show or hide buttom menu fixed
function btnMenuFixed() {
    var top = $(window).scrollTop();
    var height = getHeightMenuFixed();
    if (top > height &&  $(window).width() > 992)  {
        $('.btn-menu-fixed').show();
    } else {
        $('.btn-menu-fixed').hide();
    }
}
$(window).resize(function() {
    var top = $(window).scrollTop();
    var height = getHeightMenuFixed();
    if ($(window).width() > 992 && top > height) {
        $('.btn-menu-fixed').show();
    }
    else {
       $('.btn-menu-fixed').hide();
    }
});

// add class active-content-menu into vertical-wrapper
function showHideMenuFixed() {
    var height = getHeightMenuFixed();
    var top = $(window).scrollTop();
    if (top > 165 && $(window).scrollTop() > height && $(window).width() > 992) {
        $('.vertical-wrapper').addClass('active-content-menu');
    }
    else
    {
        $('.vertical-wrapper').removeClass('active-content-menu');
        if ($('.vertical-wrapper').hasClass('transition'))
        {
            $('.vertical-wrapper').removeClass('transition');
        }
    }
}

// add function click add new, edit tab content(back end)
function tabContent() {
    var height = $('#header').height() + $('.breadcrumb').height() + 68 + $('.account-address-book .title').height() + $('.dashboard-address').height() + $('.add-address').height();
    $('body,html').animate({
        scrollTop: height
    }, 400);
}

$('.edit-customer-address').click(function() {
    tabContent();
});

$('.add-address').click(function() {
    tabContent();
});

// Custom sidebar menu
var flag = 0;
$('.megamenu').hover(function() {
        flag = 1;
    }, function() {
        flag = 0;
});
$('.item-vertical').hover(function() {
        if (flag === 0)
        {
            $(this).addClass('active1');
        }
    }, function() {
        $(this).removeClass('active1');
});
// zoom images detail product
$( document ).ready(function() {
    //$('#large-image').click( function() {
    //    setTimeout(function(){
    //        autoWidthImg();
    //    }, 70);
    //});

    //function autoWidthImg() {
    //    if ($('.mfp-arrow-right').length>0)
    //    {
    //        var width = ((($(document).width() - $('.mfp-content').width()) / 2) - 15);
    //        $('.mfp-arrow-left').attr("id","my-mft-left");
    //        $('.mfp-arrow-right').attr("id","my-mft-right");
    //        document.getElementById("my-mft-left").style.left = width + "px";
    //        document.getElementById("my-mft-right").style.right = width + "px";
    //    }
    //}

    $( window ).resize(function() {
        //fixWithProductListAll();
        // autoWidthImg();
    });

    // auto set width box-Cart
    if ($(window).width() < 560) {
      var box_cart_width = $('.header-bottom-inner').width();
      document.getElementById("shoppingcart-box").style.width = box_cart_width + "px";
    }

    // Main Submenu box still apear when scrolling window down
    $(window).scroll(function () {
      if ($(window).width() >= 1010 && $(window).scrollTop() > ($('#header').height() + $('#yt_header_right').height()))
      {
        if ($('#btn-menu-fixed-title').hasClass('active-btn'))
        {
          $('.megamenu').removeClass("display_none");
        }
        else
        {
          $('.megamenu').addClass("display_none");
        }
      }
      else
      {
        $('.megamenu').removeClass("display_none");
      }
      $('#btn-menu-fixed').hover(function() {
        $('.megamenu').removeClass("display_none");
      }, function() {});
  });

  $(".shopping_cart_form").on("keypress", function(event) {
    return event.keyCode != 13;
  });

  //// mobile cart fix
  //$(document).on("click", ".shopping_cart", function() {
  //
  //    if ($('.shoppingcart-box').hasClass('chide')) {
  //      $('.shoppingcart-box').removeClass('chide');
  //    } else {
  //      setTimeout(function() {
  //        $('.shoppingcart-box').addClass('chide');
  //      }, 500);
  //    }
  //
  //});

  // show or hide menu fixed
  $('#btn-menu-fixed').hover(function () {
    $('#btn-menu-fixed-title').addClass('active-btn');
    $('.vertical-wrapper').addClass('active-sub-menu');
  }, function() {});

  // show or hide menu fixed
  $('.vertical-wrapper').hover(function() {}, function () {
    $('#btn-menu-fixed-title').removeClass('active-btn');
    $('.vertical-wrapper').addClass('transition');
    $('.vertical-wrapper').removeClass('active-sub-menu');
  });

});
