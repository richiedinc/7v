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
					{t c='upload.album_title'}
				</div>
				<div class="panel-body">
				
					<div class="text-warning m-b-20">{t c='upload.terms' s=$site_name}</div>

					<div class="separator">
						{t c='upload.album_details'}
					</div>					

					<form class="form-horizontal" name="uploadPhoto" id="uploadPhoto" method="post" enctype="multipart/form-data" target="_self" action="{$relative}/upload/photo"> 
					
						<div  id="upload_name" class="form-group">
							<label for="upload_album_name" class="col-lg-3 control-label">{t c='global.name'}</label>
							<div class="col-lg-9">
								<input name="album_name" type="text" class="form-control" value="{$album.name}" id="upload_album_name" placeholder="{t c='global.name'}" />
								<div id="album_name_error" class="text-danger m-t-5" style="display: none;">{t c='upload.album_name_empty'}</div>
							</div>
						</div>						

						<div  id="upload_tags" class="form-group">
							<label for="upload_album_tags" class="col-lg-3 control-label">{t c='global.tags'}</label>
							<div class="col-lg-9">
								<textarea name="album_tags" id="upload_album_tags" rows="2" class="form-control" placeholder="{t c='global.tags'}">{$album.tags}</textarea>
								<div id="album_tags_error" class="text-danger m-t-5" style="display: none;">{t c='upload.album_tags_empty'}</div>
							</div>
						</div>						

						<div id="upload_category" class="form-group">
							<label for="upload_album_category" class="col-lg-3 control-label">{t c='global.category'}</label>
							<div class="col-lg-9">
								<select name="album_category" id="upload_album_category" class="form-control">
									<option value="0"{if $album.category == ''} selected="selected"{/if}>-----</option>
									{section name=i loop=$categories}
									<option value="{$categories[i].CID}"{if $album.category == $categories[i].CID} selected="selected"{/if}>{$categories[i].name}</option>
									{/section}
								</select>
								<div id="album_category_error" class="text-danger m-t-5" style="display: none;">{t c='global.category_empty'}</div>
							</div>
						</div>						

						<div class="form-group">
							<label class="col-lg-3 control-label">{t c='upload.anonymous'}</label>
							<div class="col-lg-9">
								<div class="radio">
									<label>
										<input name="album_anonymous" type="radio" value="no" id="upload_album_anonymous_no"{if $album.anonymous == 'no'} checked="checked"{/if} />
										{t c='upload.anonymous_yes'}
									</label>
								</div>
								<div class="radio">
									<label>
										<input name="album_anonymous" type="radio" value="yes" id="upload_album_anonymous_yes"{if $album.anonymous == 'yes'} checked="checked"{/if} />
										{t c='upload.anonymous_no'}
									</label>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="col-lg-3 control-label">{t c='upload.privacy'}</label>
							<div class="col-lg-9">
								<div class="radio">
									<label>
										<input name="album_type" type="radio" value="public" id="upload_album_type_public"{if $album.type == 'public'} checked="checked"{/if} />
										{t c='upload.album_public'}
									</label>
								</div>
								<div class="radio">
									<label>
										<input name="album_type" type="radio" value="private" id="upload_album_type_private"{if $album.type == 'private'} checked="checked"{/if} />
										{t c='upload.album_private'}
									</label>
								</div>
							</div>
						</div>
						
						<div class="separator">
							{t c='upload.album_add_title'}
						</div>
						
						<div id="upload_photo_container_1" class="m-b-40">
							<div id="upload_file_1" class="form-group">
								<label for="photo_1" class="col-lg-3 control-label">{t c='global.file'}</label>
								<div class="col-lg-9">
									<div id="get_file_1" class="btn btn btn-primary no-radius-r pull-left" onclick="getFile('photo_1')">{t c='file.choose_file'}</div>
									<div class="file-box">
										<span id="uppname_1">{t c='file.no_file'}</span>
										<div style="height: 0px; width: 0px; overflow:hidden;">
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
								<input name="upload_photo_submit" type="submit" value="{t c='upload.album_button'}" id="upload_submit" class="btn btn-primary">
							</div>
						</div>
						{t c='upload.contr' s=$site_name}
					</form>
				</div>
			</div>	
		</div>
	</div>
</div>