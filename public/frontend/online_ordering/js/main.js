function loadOnlineSearchBox(box, custom_url, scroll) {
    var url = box.attr('data-url');

    if (typeof(custom_url) !== 'undefined') {
        url = custom_url;
    }

    if (typeof(scroll) !== 'undefined') {
        $('html,body').animate({
            scrollTop: box.offset().top-60},
            'slow');
    }

    var height = box.height();
    box.html('<div class="box-loading"></div>');
    if (height > 400) {
        box.find('.box-loading').height(height);
    }

    $.ajax({
        url: url,
        method: 'GET'
    }).done(function( data ) {
        box.html(data);
    });
}

$(document).ready(function() {
    $('.online_search_box').each(function() {
        loadOnlineSearchBox($(this));
    });

    $(document).on('click', '.online_search_box .pagination a', function(e) {
        e.preventDefault();

        var url = $(this).attr('href');
        var box = $(this).parents('.online_search_box');

        loadOnlineSearchBox(box, url, true);
    });
});
