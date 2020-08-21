$(document).ready(function(){
    var rating_text     = $('#rating_text').html();
    var rating_current  = $("input[id='current_rating']").val();
    $("#share_game a").click(function(event) {
        event.preventDefault();
		if ($("#share_game_box").is(':hidden')) {
			$("#share_game_box").fadeIn();
		}
		else {
			$("#share_game_box").hide();
		}
    });
    $("#flag_game a").click(function(event) {
        event.preventDefault();
		if ($("#flag_game_box").is(':hidden')) {
			$("#flag_game_box").fadeIn();
		}
		else {
			$("#flag_game_box").hide();
		}
    });
    $("#close_flag").click(function(event) {
        event.preventDefault();
        $("#flag_game_box").fadeOut();
    });
    
    $("#close_share").click(function(event) {
        event.preventDefault();
        $("#share_game_box").fadeOut();
    });
    $("#close_favorite").click(function(event) {
        event.preventDefault();
        $("#favorite_game_box").fadeOut();
    });
    
    $("a[id*='favorite_game_']").click(function(event) {
        event.preventDefault();
        var fav_id      = $(this).attr('id');
        var id_split    = fav_id.split('_');
        var game_id    = id_split[2];
        user_posting('#response_message', lang_favoriting);
        $.post(base_url + '/ajax/favorite_game', { game_id: game_id },
        function (response) {
            if ( response.status == 0 ) {
                user_posting('#response_message', response.msg);
            } else {
                user_response('#response_message', response.msg);
            }    
        }, 'json');                          
    });
    
    $("[id*='star_']").click(function(event) {
        event.preventDefault();
        var star_id     = $(this).attr("id");
        var id_split    = star_id.split('_');
        var rating      = id_split[2];
        var game_id     = id_split[3];
        $("#rating_text").html(lang_thanks);
        $.post(base_url + '/ajax/rate_game', { game_id: game_id, rating: rating },
        function (response) {
            $("#rating").html(response.rating_code);
            $("#rating_text").html(response.msg);
        }, "json");            
    });
    
    $("[id*='star_']").mouseover(function(){
        var star_id     = $(this).attr('id');
        var id_split    = star_id.split('_');
        var rating      = id_split[2];
        var game_id     = id_split[3];
        for ( var i = 1; i<=5; i++ ) {
            var star_sel = $("a[id='star_game_" + i + "_" + game_id + "']");
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
    
    $("ul[id='rating_container_game']").mouseout(function(){
        var star_id     = $("[id*='star_game_1_']").attr('id');
        var id_split    = star_id.split('_');
        var game_id     = id_split[3];
        for ( var i = 0; i < 5; i++ ) {
            var star        = i+1;
            var star_sel    = $("a[id='star_game_" + star + "_" + game_id + "']");
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
    
    $("a#show_related_games").click(function(event) {
        event.preventDefault();
        $("#game_comments").hide();
        $("#related_games").fadeIn();
    });

    $("a#show_comments").click(function(event) {
        event.preventDefault();
        $("#related_games").hide();
        $("#game_comments").fadeIn();
    });
    
    $("input[id*='post_game_comment_']").click(function() {
        var game_msg   = $("#post_message");
        var input_id    = $(this).attr('id');
        var id_split    = input_id.split('_');
        var game_id     = id_split[3];                    
        var comment     = $("textarea[id='game_comment']").val();
        if ( comment == '' ) {
            game_msg.fadeIn();
            return false;
        }
                    
        game_msg.hide();
        user_posting_load('#game_response', lang_posting);
        reset_chars_counter();
        $.post(base_url + '/ajax/game_comment', { game_id: game_id, comment: comment },
        function(response) {
            if ( response.status == '0' ) {
                $("textarea[id='game_comment']").val('');
                user_posting('#game_response', response.msg);
            } else {
                $(".no_comments").hide();
                $("textarea[id='game_comment']").val('');
                var bDIV = $("#comments_delimiter");
                var cDIV = document.createElement("div");
                $(cDIV).html(response.code);
                $(bDIV).after(cDIV);
                user_response('#game_response', response.msg);
            }
        }, "json");
    });

    $("body").on('click', "a[id*='p_game_comments_']", function(event) {
        event.preventDefault();
        var page_id     = $(this).attr('id');
        var id_split    = page_id.split('_');
        var game_id     = id_split[3];
        var page        = id_split[4];
        $.post(base_url + '/ajax/game_pagination', { game_id: game_id, page: page },
        function(response) {
            if ( response != '' ) {
                var comments_id = $('#game_comments_' + game_id);
                $(comments_id).hide();
                $(comments_id).html(response);
                $(comments_id).fadeIn();
            }
        });
    });

    $("body").on('click', "a[id*='_related_games_']", function(event) {    
        event.preventDefault();
        var bar_id      = $(this).attr('id');
        var id_split    = bar_id.split('_');
        var move        = id_split[0];
        var game_id     = id_split[3];
        var page        = $("input[id='current_page_related_games']").val();
        var prev_bar    = $('#prev_related_games_' + game_id);
        var next_bar    = $('#next_related_games_' + game_id);
        $('.center_related').fadeIn();
        $.post(base_url + '/ajax/related_games', { game_id: game_id, page: page, move: move },
        function(response) {
            if ( response.status == '1' ) {
                var related_div = $('#related_games_container_' + page);
				if ( response.move == 'next' ) {
				$(related_div).hide();
                $(related_div).html(response.games);
                $(related_div).fadeIn();
				}
				else {
				related_div = $('#related_games_container_' + response.page);
				related_div.fadeOut();
				}
                $("input[id='current_page_related_games']").val(response.page);
                if ( response.pages <= 1 ) {
                    $(prev_bar).hide();
                    $(next_bar).hide();
                }
            
                if ( response.page > 1 ) {
                    $(prev_bar).show();
                } else {
                    $(prev_bar).hide();
                }
            
                if ( response.page >= response.pages ) {
                    $(next_bar).hide();
                } else {
                    $(next_bar).show();
                }
            }
            $('.center_related').hide();
        }, 'json');
    });
});
