$(document).ready(function(){            
    $("[id*='vote_']").click(function(event) {
        event.preventDefault();
        var vote_id     = $(this).attr("id");
        var id_split    = vote_id.split('_');
        var vote      = id_split[1];
        var item_id     = id_split[2];
        $.post(base_url + '/ajax/vote_video', { item_id: item_id, vote: vote },
            function (response) {
			if (response.msg =='') {
			if (response.likes != 0 || response.dislikes != 0) {
				if ($(".dislikes").hasClass("not-voted")) {
					$(".dislikes").removeClass("not-voted");
				}
				$("#video_rate").css("width", response.rate + "%");
                if (response.likes != $("#video_likes").text()) {
					$("#video_likes").animate({'opacity': 0}, 200, function () {
					$(this).text(response.likes);
					}).animate({'opacity': 1}, 200);
				}
                if (response.dislikes != $("#video_dislikes").text()) {
					$("#video_dislikes").animate({'opacity': 0}, 200, function () {
					$(this).text(response.dislikes);
					}).animate({'opacity': 1}, 200);
				}
			}
			}
			else {
					$("#vote_msg").animate({'opacity': 0}, 200, function () {
					$(this).html('<center class="text-danger">' + response.msg + '</center>');
					}).animate({'opacity': 1}, 200);
					
					$("#vote_msg").delay(5000).animate({'opacity': 0}, 200, function () {
					$(this).html(response.construct);
					}).animate({'opacity': 1}, 200);					
			}
        }, "json");            
    });
});

    

