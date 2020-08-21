$(document).ready(function(){
    $("body").on('click', "[id*='invite_as_friend_']", function(event) {   
        event.preventDefault();
        $('#invite_message').fadeIn();
    });

    $("#close_invite_message").click(function(event) {
        event.preventDefault();
        $('#invite_message').fadeOut();
    });

    $("body").on('click', "a[id*='invitation_sent'], a[id*='friendship_removed_']", function(event) {
        event.preventDefault();
    });

    $("input[id='send_friend_invite']").click(function(event) {
        var message         = $("textarea[id='invite_friend_message']").val();
        var user_id         = $("input[id='user_id']").val();
        if ( message.length > 200 ) {
            $('#invite_friend_error').html(lang_friend_msg);
            $('#invite_friend_error').fadeIn();
            return false;
        }

        user_posting_load('#user_message', lang_sending );
        $.post(base_url + '/ajax/invite_friend', { user_id: user_id, message: message },
        function (response) {
            $("#invite_message").fadeOut();
            $("#invite_message").html('');
            user_response('#user_message', response);
            $("div[id='add_friend']").html('<a href="#invite_friend" id="invition_sent_{$user.UID}">' + lang_friendship + '</a>');
        });
    });

    $("body").on('click', "a[id*='add_block_'],a[id*='remove_block_']", function(event) {  	
        event.preventDefault();
        var block_id    = $(this).attr('id');
        var id_split    = block_id.split('_');
        var action      = id_split[0];
        var user_id     = id_split[2];
        if ( action == 'add' ) {
            var ajax_act    = 'block';
            var block_msg   = lang_blocking;
        } else {
            var ajax_act    = 'unblock';
            var block_msg   = lang_unblocking;
        }
        user_posting('#user_message', block_msg);
        $.post(base_url + '/ajax/' + ajax_act + '_user', { user_id: user_id },
        function(response) {
            user_response('#user_message', response.msg);
            if ( response.status == 1 ) {
                if ( action == 'add' ) {
                    $("div[id='block_user']").html('<a href="#unblock_user" id="remove_block_' + user_id + '">' + lang_unblock + '</a>');
                } else {
                    $("div[id='block_user']").html('<a href="#block_user" id="add_block_' + user_id + '">' + lang_block + '</a>');
                }
            }
        }, 'json');
    });

    $("body").on('click', "a[id*='block_username_'],a[id*='unblock_username_']", function(event) {  	
        event.preventDefault();
        var act_id      = $(this).attr('id');
        var id_split    = act_id.split('_');
        var action      = id_split[0];
        var user_id     = id_split[2];
        $.post(base_url + '/ajax/' + action + '_user', { user_id: user_id },
        function(response) {
            if (response.status == 1) {
                if ( action == 'block' ) {
                    $('#unblock_' + user_id).html('<a href="#unblock" id="unblock_username_' + user_id + '">' + lang_unblock_user + '</a>');
                } else {
                    $('#unblock_' + user_id).html('<a href="#block" id="block_username_' + user_id + '">' + lang_block_user + '</a>');
                }
            }
        }, 'json');
    });

    $("a[id='open_report_user']").click(function(event) {
        event.preventDefault();
        $('#report_message').fadeIn();
    });

    $("a[id='close_report_message']").click(function(event) {
        event.preventDefault();
        $('#report_message').fadeOut();
    });

    $("input[id*='report_reason_']").click(function() {
        var click_id    = $(this).attr('id');
        if ( click_id == 'report_reason_4' ) {
            $('#other_message').show();
        } else {
            $('#other_message').hide();
        }
    });

    $("input[id*='send_flag_user']").click(function() {
        var click_id    = $(this).attr('id');
        var id_split    = click_id.split('_');
        var user_id     = id_split[3];
        var reason      = $("input[name='report_reason']:checked").val();
        var other       = $("textarea[id='other_reason']").val();
        if ( other.length > 100 ) {
            user_posting('#user_message', lang_report_user_msg_length);
            return false;
        }

        user_posting('#user_message', lang_flaging);
        $.post(base_url + '/ajax/report_user', { user_id: user_id, reason: reason, other: other },
        function(response) {
            if ( response.status == 0 ) {
                user_posting('#user_message', response.msg);
            } else {
                user_response('#user_message', response.msg);
                $('#report_message').fadeOut();
            }
        }, 'json');
    });

    $("body").on('click', "[id*='remove_from_friends_']", function(event) {	
        event.preventDefault();
        var remove_id   = $(this).attr('id');
        var id_split    = remove_id.split('_');
        var user_id     = id_split[3];
        user_posting('#user_message', 'Removing...');
        $.post(base_url + '/ajax/remove_friend', { user_id: user_id },
        function (response) {
			if (response.status == '1') {
					$("div[id='remove_friend']").html('<a href="#friendship_removed" id="friendship_removed_{$user.UID}">Friends Removed</a>');
				}
			user_response('#user_message', response.msg);
        }, 'json');
    });

    $("body").on('click', "[id*='subscribe_to_']", function(event) {		
        event.preventDefault();
        var subscribe_id    = $(this).attr('id');
        var id_split        = subscribe_id.split('_');
        var user_id         = id_split[2];

        user_posting('#user_message', lang_subscribing);
        $.post(base_url + '/ajax/subscribe', { user_id: user_id },
        function (response) {
			if (response.status == '1') {
          		$("div[id='handle_subscription']").html('<a href="#unsubscribe_user" id="unsubscribe_from_' + user_id + '">' + lang_unsubscribe + '</a>');
			}
            user_response('#user_message', response.msg);
        }, 'json');
    });

    $("body").on('click', "[id*='unsubscribe_from_']", function(event) {
        event.preventDefault();
        var subscribe_id    = $(this).attr('id');
        var id_split        = subscribe_id.split('_');
        var user_id         = id_split[2];

        user_posting('#user_message', lang_unsubscribing);
        $.post(base_url + '/ajax/unsubscribe', { user_id: user_id },
        function (response) {
            if (response.status == '1') {
          		$("div[id='handle_subscription']").html('<a href="#subscribe_user" id="subscribe_to_' + user_id + '">' + lang_subscribe + '</a>');
      		}
			
            user_response('#user_message', response.msg);
        }, 'json');
    });

    var rating_user_text     = $('#rating_text_user').html();
    var rating_user_current  = $("input[id='current_user_rating']").val();

    $("[id*='utar_']").click(function(event) {
        event.preventDefault();
        var star_id     = $(this).attr("id");
        var id_split    = star_id.split('_');
        var rating      = id_split[2];
        var user_id     = id_split[3];
        $("#rating_text_user").html(lang_thanks);
        $.post(base_url + '/ajax/rate_user', { user_id: user_id, rating: rating },
            function (response) {
                $("#rating_user").html(response.rating_code);
                $("#rating_text_user").html(response.msg);
        }, "json");
    });

    $("[id*='utar_']").mouseover(function() {
        var star_id     = $(this).attr('id');
        var id_split    = star_id.split('_');
        var rating      = id_split[2];
        var user_id     = id_split[3];
        for ( var i = 1; i<=5; i++ ) {
            var star_sel = $("a[id='utar_user_" + i + "_" + user_id + "']")
            if ( i <= rating )
                $(star_sel).removeClass().addClass('full');
            else
                $(star_sel).removeClass();
        }
        if ( rating == 1 ) {
            $('#rating_text_user').html(lang_lame);
        } else if ( rating == 2 ) {
            $('#rating_text_user').html(lang_bleh);
        } else if ( rating == 3 ) {
            $('#rating_text_user').html(lang_alright);
        } else if ( rating == 4 ) {
            $('#rating_text_user').html(lang_good);
        } else if ( rating == 5 ) {
            $('#rating_text_user').html(lang_awesome);
        }
    });

   $("ul[id='rating_container_user']").mouseout(function(){
        var star_id     = $("[id*='utar_user_1']").attr('id');
        var id_split    = star_id.split('_');
        var user_id     = id_split[3];
        for ( var i = 0; i < 5; i++ ) {
            var star        = i+1;
            var star_sel    = $("a[id='utar_user_" + star + "_" + user_id + "']");
            if ( rating_user_current >= i+1 ) {
                $(star_sel).removeClass().addClass('full');
            } else if ( rating_user_current >= i+0.5 ) {
                $(star_sel).removeClass().addClass('half');
            } else {
                $(star_sel).removeClass();
            }
        }
        $('#rating_text_user').html(rating_user_text);
    });

    $("a[id*='accept_friend_']").click(function(event) {
        event.preventDefault();
        var accept_id       = $(this).attr('id');
        var id_split        = accept_id.split('_');
        var friend_id       = id_split[2];
        var request_message = '#request_message_' + friend_id;
        $("#request_" + friend_id).hide();
        $.post(base_url + '/ajax/accept_friend', { friend_id: friend_id },
			function(response) {
				user_response(request_message, response);
		});
		
    });

    $("a[id*='reject_friend_']").click(function(event) {
        event.preventDefault();
        var accept_id       = $(this).attr('id');
        var id_split        = accept_id.split('_');
        var friend_id       = id_split[2];
        var request_message = '#request_message_' + friend_id;
        $("#request_" + friend_id).hide();
        $.post(base_url + '/ajax/reject_friend', { friend_id: friend_id },
		  function (response) {
			  user_response(request_message, response);
		});	
    });
    
	$("a[id*='remove_profile_friend_']").click(function(event) {
		event.preventDefault();
        var remove_confirm  = confirm(lang_remove_friend_ask);
        if ( !remove_confirm ) {
            return false;
        }

		var remove_id 	= $(this).attr('id');
		var id_split	= remove_id.split('_');
		var user_id		= id_split[3];
        var remove_msg_sel  = '#remove_friend_message';
        user_posting(remove_msg_sel, lang_removing);
		$.post(base_url + '/ajax/remove_friend', { user_id: user_id },
		function (response) {
			if (response.status == '1') {
				$('#friend_' + user_id).hide();
			}
			
			user_posting(remove_msg_sel, response.msg);
		}, 'json');
	});
	
	$("[id*='remove_subscriber_']").click(function(event) {
        event.preventDefault();
        var subscribe_id    = $(this).attr('id');
        var id_split        = subscribe_id.split('_');
        var user_id         = id_split[2];
		var remove_msg_sel  = '#remove_subscriber_message';
        user_posting(remove_msg_sel, lang_removing);
        $.post(base_url + '/ajax/remove_subscriber', { user_id: user_id },
        function (response) {
            if (response.status == '1') {
				$('#subscriber_' + user_id).hide();
            }
          	
			user_response(remove_msg_sel, response.msg);
        }, 'json');
    });

	$("[id*='remove_subscription_']").click(function(event) {
        event.preventDefault();
        var subscription_id = $(this).attr('id');
        var id_split        = subscription_id.split('_');
        var user_id         = id_split[2];
		var remove_msg_sel  = '#remove_subscription_message';
        user_posting(remove_msg_sel, lang_removing);
        $.post(base_url + '/ajax/remove_subscription', { user_id: user_id },
        function (response) {
            if (response.status == '1') {
				$('#subscription_' + user_id).hide();
            }
          	
			user_response(remove_msg_sel, response.msg);
        }, 'json');
    });

	
    $("a[id*='remove_video_from_']").click(function(event) {
        event.preventDefault();
        var remove_id       = $(this).attr('id');
        var id_split        = remove_id.split('_');
        var list            = id_split[3];
		if (list == 'favorite') {
			var question = lang_remove_fav_video_ask;
		} else {
			var question = lang_remove_playlist_ask;
		}
		
        var remove_confirm  = confirm(question);
        if ( !remove_confirm ) {
            return false;
        }
        var video_id        = id_split[4];
        var remove_msg_sel  = '#remove_' + list + '_message';
        user_posting(remove_msg_sel, lang_removing);
        $.post(base_url + '/ajax/remove_video_' + list, { video_id: video_id },
        function (response) {
            if ( response.status == '0' ) {
                user_posting(remove_msg_sel, response.msg);
            } else {
                user_response(remove_msg_sel, response.msg);
                $('#' + list + '_video_' + video_id).hide();
            }
        }, 'json');
    });

    $("a[id*='remove_photo_from_favorite']").click(function(event) {
        event.preventDefault();
        var remove_confirm  = confirm(lang_remove_fav_photo_ask);
        if ( !remove_confirm ) {
            return false;
        }
        var remove_id       = $(this).attr('id');
        var id_split        = remove_id.split('_');
        var photo_id        = id_split[4];
        var remove_msg_sel  = '#remove_favorite_photo_message';
        user_posting(remove_msg_sel, lang_removing);
        $.post(base_url + '/ajax/remove_photo_favorite', { photo_id: photo_id },
        function (response) {
            if ( response.status == '0' ) {
                user_posting(remove_msg_sel, response.msg);
            } else {
                user_response(remove_msg_sel, response.msg);
                $('#favorite_photo_' + photo_id).hide();
            }
        }, 'json');
    });

    $("a[id*='remove_game_from_favorite']").click(function(event) {
        event.preventDefault();
        var remove_confirm  = confirm(lang_remove_fav_game_ask);
        if ( !remove_confirm ) {
            return false;
        }
        var remove_id       = $(this).attr('id');
        var id_split        = remove_id.split('_');
        var game_id        = id_split[4];
        var remove_msg_sel  = '#remove_favorite_game_message';
        user_posting(remove_msg_sel, 'Removing...');
        $.post(base_url + '/ajax/remove_game_favorite', { game_id: game_id },
        function (response) {
            if ( response.status == '0' ) {
                user_posting(remove_msg_sel, response.msg);
            } else {
                user_response(remove_msg_sel, response.msg);
                $('#favorite_game_' + game_id).hide();
            }
        }, 'json');
    });
    
    $("input[id*='post_wall_comment_']").click(function(event) {
        event.preventDefault();
        var wall_msg    = $("#post_message");
        var input_id    = $(this).attr('id');
        var id_split    = input_id.split('_');
        var user_id     = id_split[3];
        var comment     = $("textarea[id='wall_comment']").val();
        if ( comment == '' ) {
            wall_msg.show();
            return false;
        }
        if ( comment.length > 1000 ) {
            wall_msg.html(lang_wall_length);
            wall_msg.show();
            return false;
        }
                    
        wall_msg.hide();
        user_posting_load('#wall_response', lang_posting);
        $.post(base_url + '/ajax/wall_comment', { user_id: user_id, comment: comment },
        function(response) {
            if ( response.status == '0' ) {
                user_posting('#wall_response', response.msg);
            } else {
                $("textarea[id='wall_comment']").val('');
                var bDIV = $("#comments_delimiter");
                var cDIV = document.createElement("div");
                $(cDIV).html(response.code);
                $(bDIV).after(cDIV);
                user_response('#wall_response', response.msg);
				$('#end_num').html(parseInt($('#end_num').html(), 10)+1);
				$('#total_comments').html(parseInt($('#total_comments').html(), 10)+1);				
            }
        }, "json");
    });
    
    $("body").on('click', "a[id*='p_wall_comments_']", function(event) {
        event.preventDefault();
        var page_id     = $(this).attr('id');
        var id_split    = page_id.split('_');
        var user_id     = id_split[3];
        var page        = id_split[4];
        $.post(base_url + '/ajax/wall_pagination', { user_id: user_id, page: page },
        function(response) {
            if ( response != '' ) {
                var comments_id = $('#wall_comments_' + user_id);
                $(comments_id).hide();
                $(comments_id).html(response);
                $(comments_id).show();
            }
        });
    });
    
    $("a[id='attach_photo']").click(function(event) {
        event.preventDefault();
        insert_media('favorite_photos', 1);
    });

    $("a[id='attach_video']").click(function(event) {
        event.preventDefault();
        insert_media('playlist_videos', 1);
    });
	
    $("a[id='info-showmore']").click(function(event) {
        event.preventDefault();
			$("#info-container").fadeIn();
			$(this).hide();
			$("#info-hide").show();
    });
	
    $("a[id='info-hide']").click(function(event) {
        event.preventDefault();
			$("#info-container").fadeOut();
			$(this).hide();
			$("#info-showmore").show();
    });

    $("a[id*='delete_video_']").click(function(event) {
        event.preventDefault();
        var delete_id       = $(this).attr('id');
        var id_split        = delete_id.split('_');
		var question = lang_delete_video_ask;
        var remove_confirm  = confirm(question);
        if ( !remove_confirm ) {
            return false;
        }
        var video_id        = id_split[2];
        var delete_video_msg  = '#remove_' + '_message';
        user_posting('#delete_video_message', lang_removing);
        $.post(base_url + '/ajax/delete_video', { video_id: video_id },
        function (response) {
            if ( response.status == '0' ) {
                user_posting('#delete_video_message', response.msg);
            } else {
                user_response('#delete_video_message', response.msg);
                $('#video_' + video_id).hide();
            }
        }, 'json');
    });	
	
    $("a[id*='delete_game_']").click(function(event) {
        event.preventDefault();
        var delete_id       = $(this).attr('id');
        var id_split        = delete_id.split('_');
		var question = lang_delete_game_ask;
        var remove_confirm  = confirm(question);
        if ( !remove_confirm ) {
            return false;
        }
        var game_id        = id_split[2];
        var delete_game_msg  = '#remove_' + '_message';
        user_posting('#delete_game_message', lang_removing);
        $.post(base_url + '/ajax/delete_game', { game_id: game_id },
        function (response) {
            if ( response.status == '0' ) {
                user_posting('#delete_game_message', response.msg);
            } else {
                user_response('#delete_game_message', response.msg);
                $('#game_' + game_id).hide();
            }
        }, 'json');
    });		
	
});
