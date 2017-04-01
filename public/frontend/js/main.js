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
    });
}

function autoSearchMoveUp(box) {
    var current_li = box.find('li.current');
    var prev = current_li.prev();

    box.find('li').removeClass('current');

    if (prev.length) {
        prev.addClass('current');
    } else{
        current_li.parents('ul').find('li').last().addClass('current');
    }
}

function autoSearchMoveDown(box) {
    var current_li = box.find('li.current');
    var next = current_li.next();

    box.find('li').removeClass('current');

    if (next.length) {
        next.addClass('current');
    } else{
        current_li.parents('ul').find('li').eq(0).addClass('current');
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
                '<li><a href="' + item.link + '">' +
                    '<img src="' +item.image+ '" />' +
                    '<span class="title">' + item.name + '</span>' +
                    '<br /><span class="price">' + item.price + '</span>' +
                '</a></li>'
            );
        });
        if (items.length) {
            result_box.find('li').eq(0).addClass('current');
        }
    });
}

// Init vars
var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

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
            var link = box.find('li.current a').attr('href');
            window.location = link;
            return;
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

    $('.ajax-link').fancybox({closeClickOutside : true}); // on

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

        $.ajax({
            url: url,
            method: method,
            data: form.serialize(),
            dataType: 'text',
        }).done(function( data ) {
            if ( $('<div>').html(data).find('form').length ) {
                form.find('.form-content').html($('<div>').html(data).find('.form-content').html());
            } else {
                location.reload();
            }
        });
    });

    // JS Profile Account with Tabs
    $(".btn-pref .btn").click(function () {
        $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
        // $(".tab").addClass("active"); // instead of this do the below
        $(this).removeClass("btn-default").addClass("btn-primary");
    });

    $(document).on('click', '.product-item-container .left-block, .product-item-container .right-block', function() {
        var url = $(this).parents('.product-item-container').find('a.hover-product-name').attr('href');

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
    
    
    // TODO: JS CHO UPLOAD HÌNH TRÊN MY ACCOUNT
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
    
    $(function() {
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
    });
    // TODO: JS CHO UPLOAD HÌNH TRÊN MY ACCOUNT ----- END
});$(window).scroll(function () {
    var top = $(window).scrollTop();

    if (top > 165 &&  $(window).width() > 992)  {
        $('.header-fixed-top').slideDown();
    } else {
        $('.header-fixed-top').hide();
    }
});
