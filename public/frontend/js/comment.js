$(document).ready(function() {
    $(document).on('submit', '.comment_form', function(e) {
        e.preventDefault();
        
        var form = $(this);
        var url = form.attr('action');
        
        if (form.valid()) {
            $.ajax({
                url: url,
                method: 'POST',
                data: form.serialize()
            }).done(function( data ) {
                $('.comments-list').html(data);
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
});