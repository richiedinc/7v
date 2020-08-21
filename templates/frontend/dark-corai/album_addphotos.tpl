<script type="text/javascript">
var lang_file = "{t c='global.file'}";
var lang_caption = "{t c='album.caption'}";
var lang_remove = "{t c='global.remove'}";
var lang_ext_invalid = "{t c='upload.album_ext_invalid' s=$image_extensions}";
var lang_submit = "{t c='upload.album_submit'}";
var lang_choose_file = "{t c='file.choose_file'}";
var lang_no_file = "{t c='file.no_file'}";
</script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.upload-0.1.js"></script>

<div class="container">
	<div class="row">
		<div class="col-md-4">
			<div class="visible-sm visible-xs">
				{include file='quick_jumps.tpl'}
			</div>		
			<div class="hidden-sm hidden-xs">
				{include file='user_info.tpl'}
			</div>
		</div>
		<div class="col-md-8">
			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="pull-left">
						{t c='album.add_photos_to'}: {$album.name|escape:'html'}
					</div>
					<div class="pull-right">
                      <a href="{$relative}/album/{$album.AID}/">{t c='global.back_to'} '{$album.name|escape:'html'}'</a>
                      {if isset($smarty.session.uid) && $smarty.session.uid == $album.UID}
						  <strong>&middot;</strong>
						  <a href="{$relative}/album/edit/{$album.AID}">{t c='global.edit'}</a> <strong>&middot;</strong>
						  <a href="{$relative}/album/delete/{$album.AID}">{t c='global.delete'}</a>
                      {/if}			
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="panel-body">
					<div id="upload_photo_form">
						<form class="form-horizontal" name="addMorePhotos" id="addMorePhotos" method="post" enctype="multipart/form-data" target="_self" action="{$relative}/album/addphotos/{$album.AID}/">
						<div id="upload_photo_container_1" class="m-b-40">
							<div id="upload_file_1" class="form-group">
								<label for="photo_1" class="col-lg-3 control-label">{t c='global.file'}</label>
								<div class="col-lg-9">
									<div id="get_file_1" class="btn btn btn-primary no-radius-r pull-left" onclick="getFile('photo_1')">{t c='file.choose_file'}</div>
									<div class="file-box">
										<span id="uppname_1">{t c='file.no_file'}</span>
										<div style="height: 0px; width: 0px;overflow:hidden;">
											<input name="photo_1" type="file" id="photo_1" onChange="sub(this,'uppname_1','nofile_1')">
										</div>
										<input type="hidden" id="nofile_1" value="{t c='file.no_file'}">
									</div>
									<div class="clearfix"></div>					
									<div id="album_photo_error" class="text-danger m-t-5" style="display: none;">{t c='album.select_one'}</div>
									<div id="photo_1_error" class="text-danger m-t-5" style="display: none;"></div>
								</div>
							</div>
							<div class="form-group">
								<label for="caption_1" class="col-lg-3 control-label">{t c='album.caption'}</label>
								<div class="col-lg-9">
									<input name="caption_1" type="text" class="form-control" value="" maxlength="100" id="caption_1" />
								</div>
							</div>
						</div>
						
						<div id="add_photo_2" style="display: none;"></div>
						
						<div class="form-group">
							<div class="col-lg-9 col-lg-offset-3">			
								<a href="#add_more" id="add_photo" class="btn btn-secondary">{t c='global.add_more'}</a>
							</div>
						</div>
						
						<div id="upload_message_photos" class="form-group" style="display: none;">
							<div id="upload_progress" class="col-lg-9 col-lg-offset-3">
								<div class="progress progress-striped active">
									<div class="progress-bar progress-bar-warning" style="width: 100%"></div>
								</div>
							</div>
							<div class="col-lg-9 col-lg-offset-3 hidden-xs">
								{t c='album.uploading'}
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-lg-9 col-lg-offset-3">
								<input name="add_photos_submit" type="submit" value=" {t c='global.upload'} " id="upload_submit" class="btn btn-primary">
							</div>
						</div>
					
						</form>
					</div>
				</div>
				
			</div>	
		</div>
	</div>
</div>

