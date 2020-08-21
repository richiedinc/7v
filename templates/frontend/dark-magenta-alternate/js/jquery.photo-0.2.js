$(document).ready(function(){
    var rating_text     = $('#rating_text').html();
    var rating_current  = $("input[id='current_rating']").val();
    $("input[id*='post_photo_comment_']").click(function() {
        var photo_msg   = $("#post_message");
        var input_id    = $(this).attr('id');
        var id_split    = input_id.split('_');
        var album_id    = id_split[3]
        var photo_id    = id_split[4];                    
        var comment     = $("textarea[id='photo_comment']").val();
        if ( comment == '' ) {
            photo_msg.show();
            return false;
        }
        
        if ( comment.length > 1000 ) {
            photo_msg.html('Comment can contain maximum 1000 characters!');
            $("textarea[id='photo_comment']").val('');
        }
                    
        photo_msg.hide();
        user_posting_load('#photo_response', lang_posting);
        reset_chars_counter();
        $.post(base_url + '/ajax/photo_comment', { photo_id: photo_id, album_id: album_id, comment: comment },
        function(response) {
            if ( response.status == '0' ) {
                $("textarea[id='photo_comment']").val('');
                user_posting('#photo_response', response.msg);
            } else {
                $("textarea[id='photo_comment']").val('');
                var bDIV = $("#comments_delimiter");
                var cDIV = document.createElement("div");
                $(cDIV).html(response.code);
                $(bDIV).after(cDIV);
                user_response('#photo_response', response.msg);
				$('#end_num').html(parseInt($('#end_num').html(), 10)+1);
				$('#total_comments').html(parseInt($('#total_comments').html(), 10)+1);					
            }
        }, "json");
    });

    $("body").on('click', "a[id*='p_photo_comments_']", function(event) {    
        event.preventDefault();
        var page_id     = $(this).attr('id');
        var id_split    = page_id.split('_');
        var photo_id    = id_split[3];
        var page        = id_split[4];
        $.post(base_url + '/ajax/photo_pagination', { photo_id: photo_id, page: page },
        function(response) {
            if ( response.items_code != '' && response.comments_code) {
                var comments_id = $('#photo_comments_' + photo_id);
                $("#photo_items").html(response.items_code);
                $(comments_id).hide();
                $(comments_id).html(response.comments_code);
                $(comments_id).show();
            }
        }, "json");
    });

    $("#share_photo a").click(function(event) {
        event.preventDefault();
		if ($("#share_photo_box").is(':hidden')) {
			$("#share_photo_box").fadeIn();
		}
		else {
			$("#share_photo_box").hide();
		}
    });
    
    $("#flag_photo a").click(function(event) {
        event.preventDefault();
		if ($("#flag_photo_box").is(':hidden')) {
			$("#flag_photo_box").fadeIn();
		}
		else {
			$("#flag_photo_box").hide();
		}
    });
    
    $("#close_flag").click(function(event) {
        event.preventDefault();
        $("#flag_photo_box").hide();
    });
    
    $("#close_share").click(function(event) {
        event.preventDefault();
        $("#share_photo_box").hide();
    });

    $("#close_favorite").click(function(event) {
        event.preventDefault();
        $("#favorite_photo_box").hide();
    });
    
    $("a[id*='favorite_photo_']").click(function(event) {
        event.preventDefault();
        var fav_id      = $(this).attr('id');
        var id_split    = fav_id.split('_');
        var photo_id    = id_split[2];
        var album_id    = id_split[3];
        user_posting('#response_message', 'Favoriting...');
        $.post(base_url + '/ajax/favorite_photo', { photo_id: photo_id, album_id: album_id },
        function (response) {
            if ( response.status == 0 ) {
                user_posting('#response_message', response.msg);
            } else {
                user_response('#response_message', response.msg);
            }
        }, 'json');                                                
    });
    
    $("#flag_photo_form").submit(function() {
        $("#flag_photo_message").show();
        $.post(base_url + '/ajax/flag_photo', { photo_id: $('#flag_photo_id').val() },
        function (response) {
            $("#flag_photo_message").html(response + '<br>');
        });
        return false;
    });
            
    $("[id*='star_']").click(function(event) {
        event.preventDefault();
        var star_id     = $(this).attr("id");
        var id_split    = star_id.split('_');
        var rating      = id_split[2];
        var item_id     = id_split[3];
        $("#rating_text").html(lang_thanks);
        $.post(base_url + '/ajax/rate_photo', { item_id: item_id, rating: rating },
        function (response) {
            $("#rating").html(response.rating_code);
            $("#rating_text").html(response.msg);
        }, "json");            
    });

    $("[id*='star_']").mouseover(function() {
        var star_id     = $(this).attr('id');
        var id_split    = star_id.split('_');
        var rating      = id_split[2];
        var item_id     = id_split[3];
        for ( var i = 1; i<=5; i++ ) {
            var star_sel = $("a[id='star_photo_" + i + "_" + item_id + "']")
            if ( i <= rating )
                $(star_sel).removeClass().addClass('full');
            else
                $(star_sel).removeClass();
        }
        if ( rating == 1 ) {
            $('#rating_text').html(lang_lame);
        } else if ( rating == 2 ) {
            $('#rating_text').html(lang_bleh);
        } else if ( rating == 3 ) {
            $('#rating_text').html(lang_alright);
        } else if ( rating == 4 ) {
            $('#rating_text').html(lang_good);
        } else if ( rating == 5 ) {
            $('#rating_text').html(lang_awesome);
        }
    });
    
    $("ul[id='rating_container_photo']").mouseout(function(){
        var star_id     = $("[id*='star_photo_1']").attr('id');
        var id_split    = star_id.split('_');
        var item_id     = id_split[3];
        for ( var i = 0; i < 5; i++ ) {
            var star        = i+1;
            var star_sel    = $("a[id='star_photo_" + star + "_" + item_id + "']");
            if ( rating_current >= i+1 ) {
                $(star_sel).removeClass().addClass('full');
            } else if ( rating_current >= i+0.5 ) {
                $(star_sel).removeClass().addClass('half');
            } else {
                $(star_sel).removeClass();
            }     
        }
        $('#rating_text').html(rating_text);
    });
    
    $("textarea[id='photo_comment']").keyup(function(){
        var chars_left = 1000 - $("textarea[id='photo_comment']").val().length;
        if ( chars_left < 0 ) {
            chars_left = 0;
        }
        $('#chars_left').html(chars_left);
    });
});
