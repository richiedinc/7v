var index   = 1;
var pic     = 2;

function getFile(d){
   document.getElementById(d).click();
}
 
function sub(obj,dn,dn_none){
	var file = obj.value;
	var fileName = file.split("\\");
	var fileTr = fileName[fileName.length-1];
	if (fileTr != '')
		{document.getElementById(dn).innerHTML = fileTr;}
	else
		{document.getElementById(dn).innerHTML = document.getElementById(dn_none).value;}
}

function validateSize(size, maxfilesize, error_id) {
	if (size != null && size > maxfilesize) {
		$('#' + error_id).fadeIn();
		$("div[id='upload_file']").addClass( " has-error" );
		$('#' + error_id + '_').val(1);
	} else {
		if ( $('#'+ error_id).is(':visible') ) {
			$('#'+ error_id).hide();		
		}				
		$('#' + error_id + '_').val(0);	
	}
}

$(document).ready(function(){
    $("#uploadGame").submit(function(e) {	
        e.preventDefault();
        var error           = false;
        var game_title      = $("input[id='upload_game_title']").val();
        var game_tags       = $("textarea[id='upload_game_keywords']").val();
        var game_category   = $("select[id='upload_game_category']").val();
        var game_file       = $("input[id='upload_game_file']").val();
        var game_thumb_file = $("input[id='upload_game_thumb_file']").val();
        var title_error     = $("div[id='game_title_error']");
        var tags_error      = $("div[id='game_tags_error']");
        var category_error  = $("div[id='game_category_error']");
        var file_error      = $("div[id='game_file_error']");
        var thumb_error     = $("div[id='game_thumb_file_error']");
        
        if ( game_title == '' ) {
            error   = true;
            $(title_error).fadeIn();
			$("div[id='upload_title']").addClass( " has-error" );			
        } else {
            if ( $(title_error).is(':visible') ) {
                $(title_error).hide();
				$("div[id='upload_title']").removeClass( " has-error" );				
            }
        }
        if ( game_tags == '' ) {
            error   = true;
            $(tags_error).fadeIn();
			$("div[id='upload_tags']").addClass( " has-error" );			
        } else {
            if ( $(tags_error).is(':visible') ) {            
                $(tags_error).hide();
				$("div[id='upload_tags']").removeClass( " has-error" );				
            }
        }
        if ( game_category == '0' ) {
            error   = true;
            $(category_error).fadeIn();
			$("div[id='upload_category']").addClass( " has-error" );			
        } else {
            if ( $(category_error).is(':visible') ) {
                $(category_error).hide();
				$("div[id='upload_category']").removeClass( " has-error" );							
            }    
        }
        if ( game_file == '' ) {
            error   = true;
            $(file_error).fadeIn();
			$("div[id='upload_file']").addClass( " has-error" );			
        } else {
            if ( $(file_error).is(':visible') ) {
                $(file_error).hide();
				$("div[id='upload_file']").removeClass( " has-error" );
            }    
        }
        if ( game_thumb_file == '' ) {
            error   = true;
            $(thumb_error).fadeIn();
			$("div[id='upload_thumb_file']").addClass( " has-error" );
        } else {
            if ( $(thumb_error).is(':visible') ) {
                $(thumb_error).hide();
				$("div[id='upload_thumb_file']").removeClass( " has-error" );
            }
        }
        
		var ext_error   = $("div[id='game_file_ext_error']");
		var extension   = game_file.slice(game_file.indexOf(".")).toLowerCase();
		if ( ( !extension.match(game_allowed_extensions) ) && ( game_file != '' ) ){
			error = true;
			$(ext_error).html(lang_game_ext.replace('%s', extension));
			$(ext_error).fadeIn();
			$("div[id='upload_file']").addClass( " has-error" );				
		} else {
			if ( $(ext_error).is(':visible') ) {
				$(ext_error).hide();
				$("div[id='upload_file']").removeClass( " has-error" );					
			}
		}
		
		var tmb_ext_err = $("div[id='game_thumb_file_ext_error']");
		var tmb_ext     = game_thumb_file.slice(game_thumb_file.indexOf(".")).toLowerCase();
		if (( !tmb_ext.match(image_allowed_extensions) ) && ( game_thumb_file != '' )) {
			error = true;
			$(tmb_ext_err).html(lang_game_thumb_ext.replace('%s', tmb_ext));
			$(tmb_ext_err).fadeIn();
			$("div[id='upload_thumb_file']").addClass( " has-error" );				
		} else {
			if ( $(tmb_ext_err).is(':visible') ) {
				$(tmb_ext_err).hide();
				$("div[id='upload_thumb_file']").removeClass( " has-error" );					
			}
		}

		if (!error) {
			$(this).ajaxSubmit({ 
				target: '#notifications',
				beforeSubmit: function() {
					$("#bar").width('0');
					$("#notifications").html('');					
				},
				uploadProgress: function (event, position, total, percentComplete){	
					$('#upload_status').show();
					$("#bar").width(percentComplete+'%');				   
				},
				success:function (){
					$('#upload_status').hide();
					$("#bar").width('0');		
					$("#uptname").text($("#nofile").text());
					$("#upgname").text($("#nofile").text());					
				},
				resetForm: true 
			});
		}
		return false;         

    });

	$("#uploadVideo").submit(function(e) {	
		e.preventDefault();
		var error           = false;
		var video_title     = $("input[id='upload_video_title']").val();
		var video_tags      = $("textarea[id='upload_video_keywords']").val();
		var video_category  = $("select[id='upload_video_category']").val();
		var video_file      = $("input[id='upload_video_file']").val();
		var title_error     = $("div[id='video_title_error']");
		var tags_error      = $("div[id='video_tags_error']");
		var category_error  = $("div[id='video_category_error']");
		var file_error      = $("div[id='video_file_error']");
		
		if ( video_title == '' ) {
			error   = true;
			$(title_error).fadeIn();
			$("div[id='upload_title']").addClass( " has-error" );			
		} else {
			if ( $(title_error).is(':visible') ) {
				$(title_error).hide();
				$("div[id='upload_title']").removeClass( " has-error" );				
			}
		}
		if ( video_tags == '' ) {
			error   = true;
			$(tags_error).fadeIn();
			$("div[id='upload_tags']").addClass( " has-error" );			
		} else {
			if ( $(tags_error).is(':visible') ) {            
				$(tags_error).hide();
				$("div[id='upload_tags']").removeClass( " has-error" );
			}
		}
		if ( video_category == '0' ) {
			error   = true;
			$(category_error).fadeIn();
			$("div[id='upload_category']").addClass( " has-error" );						
		} else {
			if ( $(category_error).is(':visible') ) {
				$(category_error).hide();
				$("div[id='upload_category']").removeClass( " has-error" );				
			}    
		}
		if ( video_file == '' ) {
			error   = true;
			$(file_error).fadeIn();
			$("div[id='upload_file']").addClass( " has-error" );			
		} else {
			if ( $(file_error).is(':visible') ) {
				$(file_error).hide();
			}
            var ext_error   = $("div[id='video_file_ext_error']");
            var extension   = video_file.slice(video_file.indexOf(".")).toLowerCase();
            if ( !extension.match(video_allowed_extensions) ) {
                error = true;
                $(ext_error).html(lang_ext_invalid);
                $(ext_error).fadeIn();
				$("div[id='upload_file']").addClass( " has-error" );
            } else {
                if ( $(ext_error).is(':visible') ) {
                    $(ext_error).hide();
                }
            }
		}
		if ($('#video_filesize_error_').val() == 1) {
			error = true;
		}
		if (!error) {
			$(this).ajaxSubmit({ 
				target: '#notifications',
				beforeSubmit: function() {
					$("#bar").width('0');
					$("#notifications").html('');					
				},
				uploadProgress: function (event, position, total, percentComplete){	
					$('#upload_status').show();
					$("#bar").width(percentComplete+'%');				   
				},
				success:function (){
					$('#upload_status').hide();
					$("#bar").width('0');		
					$("#upvname").text($("#nofile").text());
				},
				resetForm: true 
			});
		}
		return false; 
	});
    

    
    $('#add_photo').click(function(event) {
        event.preventDefault();
		more_p = pic + 1;
		
        var pCODE = '<div id="upload_photo_container_' + pic + '">';
        var pCODE = pCODE + '<div id="upload_file_' + pic + '" class="form-group">';
        var pCODE = pCODE + '<label for="photo_' + pic + '" class="col-lg-3 control-label">' + lang_file + '</label>';
        var pCODE = pCODE + '<div class="col-lg-9">';
        var pCODE = pCODE + '<div id="get_file_' + pic + '" class="btn btn btn-primary no-radius-r pull-left" onclick="getFile(\'photo_' + pic + '\')">' + lang_choose_file + '</div>';
        var pCODE = pCODE + '<div class="file-box">';
        var pCODE = pCODE + '<span id="uppname_' + pic + '">' + lang_no_file + '</span>';
        var pCODE = pCODE + '<div style="height: 0px; width: 0px;overflow:hidden;">';
        var pCODE = pCODE + '<input name="photo_' + pic + '" type="file" id="photo_' + pic + '" onChange="sub(this,\'uppname_' + pic + '\',\'nofile_' + pic + '\')">';
        var pCODE = pCODE + '</div>';
        var pCODE = pCODE + '<input type="hidden" id="nofile_' + pic + '" value="' + lang_no_file + '">';
        var pCODE = pCODE + '</div>';
        var pCODE = pCODE + '<div class="clearfix"></div>';
        var pCODE = pCODE + '<div id="photo_' + pic + '_error" class="text-danger m-t-5" style="display: none;"></div>';		
        var pCODE = pCODE + '</div>';
        var pCODE = pCODE + '</div>';
        var pCODE = pCODE + '<div class="form-group">';
        var pCODE = pCODE + '<label for="caption_' + pic + '" class="col-lg-3 control-label">' + lang_caption + '</label>';
        var pCODE = pCODE + '<div class="col-lg-9">';
        var pCODE = pCODE + '<input name="caption_' + pic + '" type="text" class="form-control" value="" maxlength="100" id="caption_' + pic + '" />';
		var pCODE = pCODE + '<div class="m-t-5"><a href="#remove_photo" id="remove_photo_' + pic + '">' + lang_remove + '</a></div>';		
        var pCODE = pCODE + '</div>';
        var pCODE = pCODE + '</div>';		
        var pCODE = pCODE + '</div>';
        var pCODE = pCODE + '<div id="add_photo_' + more_p + '" style="display: none;"></div>';
		

        $("#add_photo_" + pic).html(pCODE);
		$("#add_photo_" + pic).fadeIn();

        pic++;
    });

	$("body").on('click', "a[id*='remove_photo_']", function(event) {  	    
        event.preventDefault();
        var remove_id   = $(this).attr('id');
        var id_split    = remove_id.split('_');
        var photo_nr    = id_split[2];
		$('#photo_' + photo_nr).val('');
        $('#photo_' + photo_nr).html('');
        $('#upload_photo_container_' + photo_nr).hide();
    });
    
    $("#add_photos_submit").click(function() {
        var error       = false;
        var photo_first = $("input[id='photo_1']").val();

        if ( photo_first == '' ) {
            error       = true;
            $("div[id='album_photo_error']").fadeIn();
        } else {
            $("div[id='album_photo_error']").hide();
        }

        if ( !error ) {
            jQuery.each($("input[id*='photo_']"), function() {
                var photo_id    = $(this).attr('id');
                var filename    = $(this).val();
                var extension   = filename.slice(filename.indexOf(".")).toLowerCase();
                var div        = photo_id + '_error';  
                if ( extension != '.jpg' && extension != '.jpeg' && extension != '.png' && extension != '.gif' && extension != '.bmp' ) {
                    error       = true;
                    $("div[id='" + div + "']").html(lang_ext_invalid);
                    $("div[id='" + div + "']").fadeIn();
                } else {
                    var visible = $("div[id='" + div + "']").is(':visible');
                    if ( visible ) {
                        $("div[id='" + div + "']").hide();
                    }
                }
            });
        }
                
        if ( error ) {
            return false;
        }
        
        $("#upload_message_photos").fadeIn();
    });
    
    $("#upload_submit").click(function() {
        var error       = false;
        var album_name  = $("input[id='upload_album_name']").val();
        var album_cat   = $("select[id='upload_album_category']").val();
        var album_tags  = $("textarea[id='upload_album_tags']").val();
        var photo_first = $("input[id='photo_1']").val();
        
        if ( album_name == '' ) {
            error       = true;
            $("div[id='album_name_error']").fadeIn();
			$("div[id='upload_name']").addClass(" has-error");				
        } else {
            $("div[id='album_name_error']").hide();
			$("div[id='upload_name']").removeClass(" has-error");				
        }
        
        if ( album_cat == '0' ) {
            error       = true;
            $("div[id='album_category_error']").fadeIn();
			$("div[id='upload_category']").addClass(" has-error");				
        } else {
            $("div[id='album_category_error']").hide();
			$("div[id='upload_category']").removeClass(" has-error");			
        }
                       
        if ( album_tags == '' ) {
            error       = true;
            $("div[id='album_tags_error']").fadeIn();
			$("div[id='upload_tags']").addClass(" has-error");				
        } else {
            $("div[id='album_tags_error']").hide();
			$("div[id='upload_tags']").removeClass(" has-error");			
        }
        
        if ( photo_first == '' ) {
            error       = true;
            $("div[id='album_photo_error']").fadeIn();
			$("div[id='upload_file_1']").addClass(" has-error");
        } else {
            $("div[id='album_photo_error']").hide();
			$("div[id='upload_file_1']").removeClass(" has-error");
        }
                

            jQuery.each($("input[id*='photo_']"), function() {
                var photo_id    = $(this).attr('id');
                var filename    = $(this).val();
                var extension   = filename.slice(filename.indexOf(".")).toLowerCase();

				var id_split    = photo_id.split('_');
				var photo_nr    = id_split[1];		
				
                var div        = photo_id + '_error';  
                if ( ( extension != '.jpg' && extension != '.jpeg' && extension != '.png' && extension != '.gif' && extension != '.bmp' ) && ( filename != '' ) ){
                    error       = true;
                    $("div[id='" + div + "']").html(lang_ext_invalid);
                    $("div[id='" + div + "']").fadeIn();
					$("div[id='upload_file_" + photo_nr + "']").addClass(" has-error");
                } else {
                    var visible = $("div[id='" + div + "']").is(':visible');
                    if ( visible ) {
                        $("div[id='" + div + "']").hide();
						$("div[id='upload_file_" + photo_nr + "']").removeClass(" has-error");						
                    }
                }
            });

                
        if ( error ) {
            return false;
        } 
        
        $("input[id='upload_submit']").value = lang_submit;
        $("#upload_message_photos").fadeIn();
    });

	$("body").on('click', "div[id='get_video_file']", function(event) {  	    
		event.preventDefault();

	   $("div[id='upload_file']").removeClass( "has-error" );
	   if ( $("div[id='video_file_error']").is(':visible') ) {
			$("div[id='video_file_error']").hide();
		}
	   if ( $("div[id='video_file_ext_error']").is(':visible') ) {
			$("div[id='video_file_ext_error']").hide();
		}  
	});
	
	$("body").on('click', "div[id*='get_file_']", function(event) {  	    
		event.preventDefault();
		var this_id   = $(this).attr('id');
		var id_split    = this_id.split('_');
		var photo_nr    = id_split[2];

		$("div[id='upload_file_" + photo_nr + "']").removeClass( "has-error" );
		
		if ( photo_nr == 1 ) {
			if ( $("#album_photo_error").is(':visible') ) {
				$("#album_photo_error").hide();
			}
		}

		if ( $("div[id='photo_" + photo_nr + "_error']").is(':visible') ) {
			$("div[id='photo_" + photo_nr + "_error']").hide();
		}
	});

	$("body").on('click', "div[id='get_game_file']", function(event) {  	    
		event.preventDefault();

	   $("div[id='upload_file']").removeClass( "has-error" );
	   if ( $("div[id='game_file_error']").is(':visible') ) {
			$("div[id='game_file_error']").hide();
		}
	   if ( $("div[id='game_file_ext_error']").is(':visible') ) {
			$("div[id='game_file_ext_error']").hide();
		}  
	});
	
	$("body").on('click', "div[id='get_game_thumb_file']", function(event) {  	    
		event.preventDefault();

	   $("div[id='upload_thumb_file']").removeClass( "has-error" );
	   if ( $("div[id='game_thumb_file_error']").is(':visible') ) {
			$("div[id='game_thumb_file_error']").hide();
		}
	   if ( $("div[id='game_thumb_file_ext_error']").is(':visible') ) {
			$("div[id='game_thumb_file_ext_error']").hide();
		}  
	});	
	
});
