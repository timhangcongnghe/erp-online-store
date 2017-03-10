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
            keyword: keyword
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
    
    $(document).on('focusout', '.autosearch-input', function() {
        var box = $(this).parents('.autosearch');        
        setTimeout(function() {
            box.find('.autosearch-result-box').hide();
        }, 100);
    });
    
    $(document).on('focusin', '.autosearch-input', function() {
        var box = $(this).parents('.autosearch');        
        box.find('.autosearch-result-box').show();
    });
});