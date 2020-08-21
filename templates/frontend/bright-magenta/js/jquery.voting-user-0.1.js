$(document).ready(function(){            
    $("[id*='voteu_']").click(function(event) {
        event.preventDefault();
        var vote_id     = $(this).attr("id");
        var id_split    = vote_id.split('_');
        var vote      = id_split[1];
        var item_id     = id_split[2];
        $.post(base_url + '/ajax/vote_user', { item_id: item_id, vote: vote },
            function (response) {
			if (response.msg =='') {
			if (response.likes != 0 || response.dislikes != 0) {
				if ($(".user-dislikes").hasClass("not-voted")) {
					$(".user-dislikes").removeClass("not-voted");
				}
				$("#user_rate").css("width", response.rate + "%");
                if (response.likes != $("#user_likes").text()) {
					$("#user_likes").animate({'opacity': 0}, 200, function () {
					$(this).text(response.likes);
					}).animate({'opacity': 1}, 200);
				}
                if (response.dislikes != $("#user_dislikes").text()) {
					$("#user_dislikes").animate({'opacity': 0}, 200, function () {
					$(this).text(response.dislikes);
					}).animate({'opacity': 1}, 200);
				}
			}
			}
			else {
					$("#user_vote_msg").animate({'opacity': 0}, 200, function () {
					$(this).html('<center class="text-danger">' + response.msg + '</center>');
					}).animate({'opacity': 1}, 200);
					
					$("#user_vote_msg").delay(5000).animate({'opacity': 0}, 200, function () {
					$(this).html(response.construct);
					}).animate({'opacity': 1}, 200);					
			}
        }, "json");            
    });
});

    

