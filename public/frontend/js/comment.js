function loadCommentList(box, custom_url) {
    var url = box.attr('data-url');

    if (typeof(custom_url) != 'undefined') {
        url = custom_url;
    }

    $.ajax({
        url: url,
        method: 'GET'
    }).done(function( data ) {
        box.html(data);

        box.find('.ajax-link').fancybox({closeClickOutside : true}); // on
    });
}

$(document).ready(function() {
    $('.comment_box').each(function () { loadCommentList($(this)) });

    $(document).on('submit', '.comment_box form', function(e) {
        e.preventDefault();

        var form = $(this);
        var url = form.attr('action');
        var box = form.parents('.comment_box');

        // Check if not rate
        if (box.find('input[name="rating[star]"]').val() == '') {
            // alert('<%= value %>');
            var tpl = '<h3>Vui lòng đánh giá sao trước khi gửi</h3>';
            $.jGrowl(tpl, {
                life: 4000,
                header: 'Bạn chưa đánh giá sao',
                speed: 'slow',
                theme: 'error'
            });

            box.find('.ratingStar').addClass('error');

            return;
        }

        if (form.valid()) {
            $.ajax({
                url: url,
                method: 'POST',
                data: form.serialize()
            }).done(function() {
                loadCommentList(box);

                // alert('<%= value %>');
                var tpl = '<h3>Bạn đã đăng bình luận thành công</h3>';
                $.jGrowl(tpl, {
                    life: 4000,
                    header: 'Thành công',
                    speed: 'slow',
                    theme: 'success'
                });

                form.find('input[type=text], input[type=email], select, textarea').val('');
            });
        }
    });

    $(document).on('click', '.comment-reply-link', function(e) {
        var box = $(this).parents('.media').find('.reply-box');
        box.toggle();

        if (box.is(':visible')) {
            $(this).html('<i class="fa fa-close"></i> Hủy trả lời');
        } else {
            $(this).html('<i class="fa fa-reply"></i> Trả lời');
        }
    });

    $(document).on('click', '.comment_box .pagination a', function(e) {
        e.preventDefault();

        var box = $(this).parents('.comment_box');
        var url = $(this).attr('href');

        loadCommentList(box, url);
    });

    // Forget password form
    $(document).on('click', 'a.remove-comment', function(e) {
        e.preventDefault();

        var link = $(this);
        var url = link.attr('href');
        var method = link.attr('data-method');
        var box = link.parents('.comment_box');
        var confirm_message = link.attr('data-confirm');

        if (typeof(confirm_message) !== 'undefined') {
            var r = confirm(confirm_message);
            if (r == true) {
            } else {
                return;
            }
        }

        if (typeof(method) == 'undefined') {
            method = 'GET';
        }

        $.ajax({
            url: url,
            method: method
        }).done(function( data ) {
            loadCommentList(box);
        }).fail(function(xhr, status, error) {
            loadCommentList(box);
        });
    });
});
