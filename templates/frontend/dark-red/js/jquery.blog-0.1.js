$(document).ready(function(){
    $("input[id*='post_blog_comment_']").click(function() {
        var photo_msg   = $("#post_message");
        var input_id    = $(this).attr('id');
        var id_split    = input_id.split('_');
        var blog_id     = id_split[3];                    
        var comment     = $("textarea[id='blog_comment']").val();
        if ( comment == '' ) {
            photo_msg.fadeIn();
            return false;
        }

        if ( comment.length > 1000 ) {
            photo_msg.html(lang_comment_limit);
			photo_msg.fadeIn();
            return false;
        }
                    
        photo_msg.hide();
        user_posting_load('#blog_response', lang_posting);
        reset_chars_counter();    
        $.post(base_url + '/ajax/blog_comment', { blog_id: blog_id, comment: comment },
        function(response) {
            if ( response.status == '0' ) {
                $("textarea[id='blog_comment']").val('');
                user_posting('#blog_response', response.msg);    
            } else {
                $("textarea[id='blog_comment']").val('');
                var bDIV = $("#comments_delimiter");
                var cDIV = document.createElement("div");
                $(cDIV).html(response.code);
                $(bDIV).after(cDIV);
                user_response('#blog_response', response.msg);
				$('#end_num').html(parseInt($('#end_num').html(), 10)+1);
				$('#total_comments').html(parseInt($('#total_comments').html(), 10)+1);					
            }
        }, "json");
    });

    $("body").on('click', "a[id*='p_blog_comments_']", function(event) {    
        event.preventDefault();
        var page_id     = $(this).attr('id');
        var id_split    = page_id.split('_');
        var blog_id     = id_split[3];
        var page        = id_split[4];
        $.post(base_url + '/ajax/blog_pagination', { blog_id: blog_id, page: page },
        function(response) {
            if ( response != '' ) {
                var comments_id = $('#blog_comments_' + blog_id);
                $(comments_id).hide();
                $(comments_id).html(response);
                $(comments_id).fadeIn();
            }
        });
    });
    
    $("a[id='attach_photo']").click(function(event) {
        event.preventDefault();
        insert_media('favorite_photos', 1);
    });
});
