$(document).ready(function() {
    $(document).on('submit', '.comment_form', function(e) {
        e.preventDefault();
        
        var form = $(this);
        var url = form.attr('action');
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
            
            form.find('input, select, textarea').val('');
        });
    });
});