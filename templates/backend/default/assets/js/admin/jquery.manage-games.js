function validateString(input,ml) {
	$(input).change(function(){
		if($(this).val().length < ml) {
			$(this).addClass('error');
		} else {
			$(this).removeClass('error');
		}
	});	
}

function validateNumber(input,dv) {
	$(input).change(function(){
		var iv = parseInt($(this).val().match(/\d+/));
		if (isNaN(iv)) {
			iv = dv;
		}
		$(this).val(iv);
	});
}

function hasErrors(input) {
	var err = false;
	$(input).each(function(){		
		if($(this).hasClass('error')) {
			err = true;
		}
	});
	return err;
}

function thumbLoaded(game_id) {
	var imgs = $('#game-thumbnail-container img').not(function() { return this.complete; });
	var count = imgs.length;
	imgs.each(function() {
		$(this).error(function() {
			$(this).attr('src', base_url + '/media/games/tmb/default.jpg');
		});	
	});	
	if (count) {
		imgs.load(function() {
			count--;
			if (!count) {
				$('#thumb_game_' + game_id).html('<i class="fa fa-picture-o"></i>');
				$('#game-thumbnailModal').modal('show');				
			}
		});
	} else {
		$('#thumb_game_' + game_id).html('<i class="fa fa-picture-o"></i>');
		$('#game-thumbnailModal').modal('show');		
	}
}


function startUpload() {
	$('#game-thumbnail-loading').show();
	return true;
}

function stopUpload(gid, uploaded) {
	var result = '';
	if (uploaded) {
		$('#addthumb').replaceWith($('#addthumb').val('').clone(true));
		$('#upaddthumb').html($('#nofile').val());		

		d = new Date();	
		$("#game-thumbnail-img-" + gid).attr("src", base_url + '/media/games/tmb/' + gid + '.jpg?' + d.getTime());
		$("#thumb-" + gid).attr("src", base_url + '/media/games/tmb/' + gid + '.jpg?' + d.getTime());

		Messenger().post({
			message: 'Game <b>ID ' + gid + '</b>: Thumbnail successfully updated!',
			type: 'success'
		});
	}
	else {
		Messenger().post({
		message: 'Game <b>ID ' + gid + '</b>: Thumbnail updating failed!',
			type: 'error'
		});			 
	}
	$('#game-thumbnail-loading').hide();	  
	return true;   
}

$(document).ready(function(){
		
	$("#filter_status").select2();
	$("#filter_status").select2 ('container').find ('.select2-search').addClass ('hidden');
	$("#filter_category").select2();
	//$("#filter_category").select2 ('container').find ('.select2-search').addClass ('hidden');
	$("#filter_type").select2();
	$("#filter_type").select2 ('container').find ('.select2-search').addClass ('hidden');		
	$("#edit-category").select2();
	//$("#edit-category").select2 ('container').find ('.select2-search').addClass ('hidden');
	
	$('#check_all_games').change(function() {
		var checkboxes = $(this).closest('form').find(':checkbox');
		if($(this).is(':checked')) {
			checkboxes.prop('checked', true);
			$('.item-main-container').addClass('selected');
		} else {
			checkboxes.prop('checked', false);
			$('.item-main-container').removeClass('selected');
		}
	});

	//Multiple Selection
	var checkboxes = $('.select-multiple');
	var lastChecked = null;	
	checkboxes.click(function(e) {
		if(!lastChecked) {
			lastChecked = this;
			return;
		}
		if(e.shiftKey) {
			var start = checkboxes.index(this);
			var end = checkboxes.index(lastChecked);
			if (lastChecked.checked) {
				checkboxes.slice(Math.min(start,end), Math.max(start,end)+ 1).prop('checked', lastChecked.checked);				
				checkboxes.slice(Math.min(start,end), Math.max(start,end)+ 1).closest('.item-main-container').addClass('selected');
			} else {
				$(this).prop('checked', true);
			}
		}
		lastChecked = this;
	});
	
	$('input[type=checkbox]').each(function () {
		 $(this).change(function() {
		   if (this.checked) {
			   $(this).closest('.item-main-container').addClass('selected');
		   } else {
			   $(this).closest('.item-main-container').removeClass('selected');
		   }
		});
	});	
	

	$( "#reset_search" ).click(function() {
		document.getElementById('sort_items').innerText = 'ID';
		document.getElementById('sort').value = 'g.GID';
		document.getElementById('order_items').innerText = 'Descending';
		document.getElementById('order').value = 'DESC';
		document.getElementById('display_items').innerText = '100';
		document.getElementById('display').value = '100';
		
		$("#filter_category").select2("val", "");
		$("#filter_status").select2("val", "");
		$("#filter_type").select2("val", "");
		
		$("select[id*='filter_']" ).each(function() {
			$(this).select2("val", "");
			$(this).removeClass("filter-active");	
		});

		$("input[id*='filter_']" ).each(function() {
			var id = $(this).attr('id');
			var split = id.split('_');
			var filter_name = split[1];		
			$(this).val("");
			$(this).removeClass("filter-active");
			$("i[id='filter_remove_" + filter_name + "']").hide();
		});
	});	

    $("body").on('click', "i[id*='filter_remove_']", function(event) {
        event.preventDefault();
		var id = $(this).attr('id');
		var split = id.split('_');
		var filter_name = split[2];
		$("input[name='" + filter_name + "']").val('');
		$("input[name='" + filter_name + "']").removeClass("filter-active");
		$(this).hide();
    });

	$("input[id*='filter_']" ).each(function() {
		var id = $(this).attr('id');
		var split = id.split('_');
		var filter_name = split[1];		
		$(this).on('input', function() {
			if($(this).val() != '') {
				$("i[id='filter_remove_" + filter_name + "']").show();
				$(this).addClass("filter-active");
			} else {
				$("i[id='filter_remove_" + filter_name + "']").hide();
				$(this).removeClass("filter-active");
			}
		});
	});	

	$("select[id*='filter_']" ).each(function() {
		var id = $(this).attr('id');
		var split = id.split('_');
		var filter_name = split[1];		
		if($(this).val() != '') {
			$("#s2id_" + id).addClass("filter-active");
		}
	});	
	
	$("select[id*='filter_']" ).each(function() {
		var id = $(this).attr('id');
		var split = id.split('_');
		var filter_name = split[1];		
		$(this).change(function() {
			if($(this).val() != '') {
				$("#s2id_" + id).addClass("filter-active");
			} else {
				$("#s2id_" + id).removeClass("filter-active");
			}
		});
	});
	
	//Ajax:

    $("body").on('click', "a[id='view_del_game']", function(event) {
        event.preventDefault();	
		var game_id = $(this).attr("data-id");
		$.post(base_url + '/ajax/admin_delete_game', { game_id: game_id },
			function (response) {
				if (response.status) {
					Messenger().post({
						message: 'Game <b>ID ' + game_id + '</b>: Successfully deleted!',
						type: 'success'
					});
					$('#viewModal').modal('hide');					
					$('#item-' + game_id).fadeOut();
				} else {
					Messenger().post({
						message: 'Game <b>ID ' + game_id + '</b>: Delete failed!',
						type: 'error'
					});					
				}
		}, "json"); 
	});	
	
    $("body").on('click', "a[id*='delete_game_']", function(event) {
        event.preventDefault();	
		var id = $(this).attr('id');
		var split = id.split('_');
		var game_id = split[2];
		$('#delete__game_' + game_id).html('<i class="small-loader"></i>');
		$('#' + id).html('<i class="small-loader"></i>');
		$.post(base_url + '/ajax/admin_delete_game', { game_id: game_id },
			function (response) {
				if (response.status) {
					Messenger().post({
						message: 'Game <b>ID ' + game_id + '</b>: Successfully deleted!',
						type: 'success'
					});
					$('#item-' + game_id).fadeOut();
				} else {
					Messenger().post({
						message: 'Game <b>ID ' + game_id + '</b>: Delete failed!',
						type: 'error'
					});					
				}
		}, "json"); 
	});

    $("body").on('click', "a[id*='unflag_game_']", function(event) {
        event.preventDefault();	
		var id = $(this).attr('id');
		var split = id.split('_');
		var f_id = split[2];
		var game_id = split[3];		
		$('#unflag__game_' + game_id).html('<i class="small-loader"></i>');
		$('#' + id).html('<i class="small-loader"></i>');
		$.post(base_url + '/ajax/admin_unflag_game', { f_id: f_id },
			function (response) {
				if (response.status) {
					Messenger().post({
						message: 'Game <b>ID ' + game_id + '</b>: Successfully unflagged!',
						type: 'success'
					});
					$('#item-' + game_id).fadeOut();
				} else {
					Messenger().post({
						message: 'Game <b>ID ' + game_id + '</b>: Unflag failed!',
						type: 'error'
					});					
				}
		}, "json"); 
	});
	
    $("body").on('click', "a[id*='status_game_']", function(event) {
        event.preventDefault();
		var processing = $(this).attr('data-processing');
		if (processing == 0) {
			$(this).attr('data-processing', 1);	
			var game_status = $(this).attr('data-status');
			var id = $(this).attr('id');
			var split = id.split('_');
			var game_id = split[2];
			$('#' + id).html('<i class="small-loader"></i>');
			$.post(base_url + '/ajax/admin_status_game', { game_id: game_id, game_status: game_status},
				function (response) {
					if (response.status) {
						if (game_status == 0) {
							Messenger().post({
								message: 'Game <b>ID ' + game_id + '</b>: Successfully activated!',
								type: 'success'
							});						
							$('#status_game_' + game_id).attr('data-status', 1);							
							$('#status_game_' + game_id).attr('alt', 'Suspend');
							$('#status_game_' + game_id).attr('title', 'Suspend');
							$('#status_game_' + game_id).html('<i class="fa fa-times"></i>');
							$('#status-' + game_id).html('<span class="text-green" alt="Active" title="Active">Active</span>');							
						} else {
							Messenger().post({
								message: 'Game <b>ID ' + game_id + '</b>: Successfully suspended!',
								type: 'success'
							});
							$('#status_game_' + game_id).attr('data-status', 0);
							$('#status_game_' + game_id).attr('alt', 'Activate');
							$('#status_game_' + game_id).attr('title', 'Activate');
							$('#status_game_' + game_id).html('<i class="fa fa-check"></i>');
							$('#status-' + game_id).html('<span class="text-red" alt="Inactive" title="Inactive">Inactive</span>');
						}

					} else {
						if (game_status == 0) {
							Messenger().post({
								message: 'Game <b>ID ' + game_id + '</b>: Failed activating or already active!',
								type: 'error'
							});
							$('#status_game_' + game_id).html('<i class="fa fa-check"></i>');							
						} else {
							Messenger().post({
								message: 'Game <b>ID ' + game_id + '</b>: Failed suspending or already inactive!',
								type: 'error'
							});
							$('#status_game_' + game_id).html('<i class="fa fa-times"></i>');							
						}
					}
					$('#status_game_' + game_id).attr('data-processing', 0);
			}, "json"); 			
		}
	});	
	
	//View Game
    $("body").on('click', "a[id*='view_game_']", function(event) {
        event.preventDefault();
		var id = $(this).attr('id');
		var split = id.split('_');
		var game_id = split[2];		
		$.post(base_url + '/ajax/admin_get_game', { game_id: game_id },
			function (response) {
				if (response.status) {
					//Load Game Data
					$('#view_del_game').attr('data-id', response.GID);										
					$('#view-id-span').text(response.GID);
					$('#view-id').val(response.GID);
					$('#view-title').text(response.title);
					$('#view-game-container').attr('src', base_url + '/siteadmin/view_game.php?GID=' + game_id);
					$('#viewModal').modal('show');
					
				} else {
					Messenger().post({
						message: 'Game <b>ID ' + game_id + '</b>: Failed getting game details!',
						type: 'error'
					});
				}				
		}, "json");	
	});		
	
	//Close View Modal
	$('#viewModal').on('hidden.bs.modal', function () {
		$('#view-game-container').attr('src', '');
		$('#view_del_game').attr('data-id', '');
	})		
	
	//Edit Game
    $("body").on('click', "a[id*='edit_game_']", function(event) {
        event.preventDefault();
		var id = $(this).attr('id');
		var split = id.split('_');
		var game_id = split[2];


		$.post(base_url + '/ajax/admin_get_game', { game_id: game_id },
			function (response) {
				if (response.status) {
					//Reset Errors
					$('.form-control').each(function(){
						$(this).removeClass('error');
					});
					
					//Load Game Data
					$('#edit-id-span').text(response.GID);					
					$('#edit-id').val(response.GID);
					$('#edit-title').val(response.title);
					$('#edit-tags').val(response.tags);
					$('#edit-category').val(response.category);	
					$('#edit-category').select2('val', response.category);
					$('input:radio[name="edit-type"]').filter('[value="' + response.type + '"]').attr('checked', true);
					$('input:radio[name="edit-status"]').filter('[value="' + response.active + '"]').attr('checked', true);
					$('input:radio[name="edit-featured"]').filter('[value="' + response.featured + '"]').attr('checked', true);
					$('input:radio[name="edit-be_commented"]').filter('[value="' + response.be_commented + '"]').attr('checked', true);
					$('input:radio[name="edit-be_rated"]').filter('[value="' + response.be_rated + '"]').attr('checked', true);
					$('#edit-likes').val(response.likes);
					$('#edit-dislikes').val(response.dislikes);
					$('#edit-viewnumber').val(response.total_plays);

					//Adjust margin left to integer value - Center
					var modal_ml = parseInt(($(window).width()-$('#editModalDialog').width())/2);					
					$('#editModal').modal('show');
					if ($(window).width()>768) {
						$('#editModalDialog').css('margin-left',Math.floor(modal_ml)+'px');
					}
					
				} else {
					Messenger().post({
						message: 'Game <b>ID ' + game_id + '</b>: Failed getting game details!',
						type: 'error'
					});
				}				
		}, "json"); 		
	});	

	//Reset
	$("body").on('click', "button[id='edit-reset']", function(event) {
        event.preventDefault();
		var game_id = $('#edit-id').val();

		$.post(base_url + '/ajax/admin_get_game', { game_id: game_id },
			function (response) {
				if (response.status) {
					//Reset Errors
					$('.form-control').each(function(){
						$(this).removeClass('error');
					});
					
					//Load Game Data
					$('#edit-title').val(response.title);
					$('#edit-tags').val(response.tags);
					$('#edit-category').val(response.category);	
					$('#edit-category').select2('val', response.category);
					$('input:radio[name="edit-type"]').filter('[value="' + response.type + '"]').attr('checked', true);
					$('input:radio[name="edit-status"]').filter('[value="' + response.active + '"]').attr('checked', true);
					$('input:radio[name="edit-featured"]').filter('[value="' + response.featured + '"]').attr('checked', true);
					$('input:radio[name="edit-be_commented"]').filter('[value="' + response.be_commented + '"]').attr('checked', true);
					$('input:radio[name="edit-be_rated"]').filter('[value="' + response.be_rated + '"]').attr('checked', true);
					$('#edit-likes').val(response.likes);
					$('#edit-dislikes').val(response.dislikes);
					$('#edit-viewnumber').val(response.total_plays);
					
				} else {
					Messenger().post({
						message: 'Game <b>ID ' + game_id + '</b>: Failed getting game details!',
						type: 'error'
					});
				}				
		}, "json"); 					
	});	
	
	//Edit Save
	$("body").on('click', "button[id='edit-save']", function(event) {		
		event.preventDefault();
		var game_id = $('#edit-id').val();
		if (!hasErrors("input[id*='edit-']") && !hasErrors("textarea[id*='edit-']")) {
			//save code
			$('#edit_game_' + game_id).html('<i class="small-loader"></i>');			
			var gameData = {
				id 		     : $('#edit-id').val(),
				title 		 : $('#edit-title').val(),
				tags		 : $('#edit-tags').val().replace(/\n/g, " ").replace(/\r/g, " ").replace(/\t/g, " "),
				category	 : $('#edit-category').val(),
				type		 : $('input[name="edit-type"]:checked').val(),
				active		 : $('input[name="edit-status"]:checked').val(),
				be_commented : $('input[name="edit-be_commented"]:checked').val(),
				be_rated	 : $('input[name="edit-be_rated"]:checked').val(),
				likes		 : $('#edit-likes').val(),
				dislikes	 : $('#edit-dislikes').val(),
				viewnumber	 : $('#edit-viewnumber').val()
			};
			
			$.post(base_url + '/ajax/admin_save_game', { data: gameData },
				function (response) {					
					$('#editModal').modal('hide');
					if (response.status) {						
						Messenger().post({
							message: 'Game <b>ID ' + game_id + '</b>: Successfully updated!',
							type: 'success'
						});
						$('#title-' + game_id).text(gameData.title);
						if (gameData.active == 1) {
							$('#status_game_' + game_id).attr('data-status', 1);							
							$('#status_game_' + game_id).attr('alt', 'Suspend');
							$('#status_game_' + game_id).attr('title', 'Suspend');
							$('#status_game_' + game_id).html('<i class="fa fa-times"></i>');
							$('#status-' + game_id).html('<span class="text-green" alt="Active" title="Active">Active</span>');							
						} else {
							$('#status_game_' + game_id).attr('data-status', 0);
							$('#status_game_' + game_id).attr('alt', 'Activate');
							$('#status_game_' + game_id).attr('title', 'Activate');
							$('#status_game_' + game_id).html('<i class="fa fa-check"></i>');
							$('#status-' + game_id).html('<span class="text-red" alt="Inactive" title="Inactive">Inactive</span>');
						}
						if (gameData.type == 'public') {
							$('#private-' + game_id).html('');
						} else {
							$('#private-' + game_id).html('<div class="item-private">PRIVATE</div>');
						}						
						$('#views-' + game_id).text(gameData.viewnumber);
					} else {
						Messenger().post({
							message: 'Game <b>ID ' + game_id + '</b>: Failed updating!',
							type: 'error'
						});
					}
					$('#edit_game_' + game_id).html('<i class="fa fa-pencil"></i>');	
			}, "json");			
		}
		
	});

	//Thumbnail
    $("body").on('click', "a[id*='thumb_game_']", function(event) {
        event.preventDefault();
		var id = $(this).attr('id');
		var split = id.split('_');
		var game_id = split[2];
		$('#thumb_game_' + game_id).html('<i class="small-loader"></i>');
		
		$('#addthumb').replaceWith($('#addthumb').val('').clone(true));
		$('#upaddthumb').html($('#nofile').val());		
		
		d = new Date();
		thumb_block = '<div class="col-sm-4 col-sm-offset-4"><img id="game-thumbnail-img-' + game_id + '" src="' + base_url + '/media/games/tmb/' + game_id + '.jpg?' + d.getTime() + '" class="img-responsive" title="Game Thumbnail" alt="Game Thumbnail" /></div>';
		$("#game-thumbnail-container").html(thumb_block);		
		$('#game-thumbnail-id-span').html(game_id);
		$('#game-thumbnail-id').val(game_id);					
		//Load Thumb
		thumbLoaded(game_id);
							
			
	});	

	//Validate
	validateString('#edit-title',2);
	validateString('#edit-tags',2);
	validateNumber('#edit-likes',0);
	validateNumber('#edit-dislikes',0);
	validateNumber('#edit-viewnumber',0);	
	
	$(window).on('resize', function(){	
		if ($(window).width()>768) {
			var modal_ml = parseInt(($(window).width()-$('#editModalDialog').width())/2);
			$('#editModalDialog').css('margin-left',Math.floor(modal_ml)+'px');
		} else {
			$('#editModalDialog').css('margin-left','10px');
			$('#editModalDialog').css('margin-right','10px');
		}
		
	});			
	
});