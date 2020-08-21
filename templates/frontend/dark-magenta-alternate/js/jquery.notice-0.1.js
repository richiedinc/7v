$(document).ready(function(){
    $("input[id*='post_notice_comment_']").click(function() {
        var notice_msg  = $("#post_message");
        var input_id    = $(this).attr('id');
        var id_split    = input_id.split('_');
        var notice_id    = id_split[3];
        var comment     = $("textarea[id='notice_comment']").val();
        if ( comment == '' ) {
            notice_msg.fadeIn();
            return false;
        }
        
        if ( comment.length > 1000 ) {
            notice_msg.html(lang_comment_limit);
			notice_msg.fadeIn();
            return false;			
        }
                    
        notice_msg.hide();
        user_posting('#notice_response', 'Posting...');
        reset_chars_counter();
        $.post(base_url + '/ajax/notice_comment', { notice_id: notice_id, comment: comment },
        function(response) {
            if ( response.status == '0' ) {
                $("textarea[id='notice_comment']").val('');
                user_posting('#notice_response', response.msg);
            } else {
                $("textarea[id='notice_comment']").val('');
                var bDIV = $("#comments_delimiter");
                var cDIV = document.createElement("div");
                $(cDIV).html(response.code);
                $(bDIV).after(cDIV);
                user_response('#notice_response', response.msg);
				$('#end_num').html(parseInt($('#end_num').html(), 10)+1);
				$('#total_comments').html(parseInt($('#total_comments').html(), 10)+1);					
            }
        }, "json");
    });

	$("body").on('click', "a[id*='p_notice_comments_']", function(event) {        
        event.preventDefault();
        var page_id     = $(this).attr('id');
        var id_split    = page_id.split('_');
        var notice_id   = id_split[3];
        var page        = id_split[4];
        $.post(base_url + '/ajax/notice_pagination', { notice_id: notice_id, page: page },
        function(response) {
            if ( response.comments_code != '' ) {
                var comments_id = $('#notice_comments_' + notice_id);
                $(comments_id).hide();
                $(comments_id).html(response.comments_code);
                $(comments_id).fadeIn();
            }
        }, "json");
    });


});
