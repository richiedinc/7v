<script type="text/javascript">
var game_allowed_extensions = /{$upload_allowed_extensions}$/i;
var image_allowed_extensions = /{$image_allowed_extensions}$/i;
var lang_game_submit = "{t c='upload.game_submit'}";
var lang_game_ext = "{t c='upload.game_ext_invalid'}";
var lang_game_thumb_ext = "{t c='upload.game_thumb_ext_invalid'}";
</script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.upload-0.1.js"></script>
<script type="text/javascript" src="http://malsup.github.io/min/jquery.form.min.js"></script>

<div class="container">
	<div id="notifications"></div>
</div>		
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
					{t c='upload.game_title'}
				</div>
				<div class="panel-body">
				
					<div class="text-warning m-b-20">{t c='upload.terms' s=$site_name}</div>				

					<form class="form-horizontal" name="uploadGame" id="uploadGame" method="post" enctype="multipart/form-data" target="_self" action="{$relative}/upload/game">
					
						<input type="hidden" name="game_upload_started" value='1'/>	
						
						<div  id="upload_title" class="form-group">
							<label for="upload_game_title" class="col-lg-3 control-label">{t c='global.title'}</label>
							<div class="col-lg-9">
								<input name="game_title" type="text" class="form-control" value="{$game.title}" id="upload_game_title" placeholder="{t c='global.title'}" />
								<div id="game_title_error" class="text-danger m-t-5" style="display: none;">{t c='upload.game_title_empty'}</div>
							</div>
						</div>

						<div id="upload_tags" class="form-group">
							<label for="upload_game_keywords" class="col-lg-3 control-label">{t c='global.tags'}</label>
							<div class="col-lg-9">
								<textarea name="game_keywords" id="upload_game_keywords" rows="2" class="form-control" placeholder="{t c='upload.tags_expl'}">{$game.keywords}</textarea>
								<div id="game_tags_error" class="text-danger m-t-5" style="display: none;">{t c='upload.game_tags_empty'}</div>
							</div>
						</div>
						
						<div id="upload_category" class="form-group">
							<label for="upload_game_category" class="col-lg-3 control-label">{t c='global.category'}</label>
							<div class="col-lg-9">
								<select name="game_category" id="upload_game_category" class="form-control">
									<option value="0"{if $game.category == '0'} selected="selected"{/if}>-----</option>
									{section name=i loop=$categories}
									<option value="{$categories[i].category_id}"{if $game.category == $categories[i].category_id} selected="selected"{/if}>{$categories[i].category_name|escape:'html'}</option>
									{/section}
								</select>
								<div id="game_category_error" class="text-danger m-t-5" style="display: none;">{t c='global.category_empty'}</div>
							</div>
						</div>

						<div id="upload_file" class="form-group">
							<label for="upload_game_file" class="col-lg-3 control-label">{t c='global.file'}</label>
							<div class="col-lg-9">
							
							<div id="get_game_file" class="btn btn btn-primary no-radius-r pull-left" onclick="getFile('upload_game_file')">{t c='file.choose_file'}</div>
							<div class="file-box">
								<span id="upgname">{t c='file.no_file'}</span>
								<div style="height: 0px; width: 0px;overflow:hidden;">
									<input name="game_file" type="file" id="upload_game_file" onChange="sub(this,'upgname','nofile_g')" accept=".swf"/>
								</div>
								<input type="hidden" id="nofile_g" value="{t c='file.no_file'}">
							</div>
							<div class="clearfix"></div>
							<div id="game_file_error" class="text-danger m-t-5" style="display: none;">{t c='upload.game_file_error'}</div>
							<div id="game_file_ext_error" class="text-danger m-t-5" style="display: none;"></div>
							</div>
						</div>						

						<div id="upload_thumb_file" class="form-group">
							<label for="upload_game_thumb_file" class="col-lg-3 control-label">{t c='upload.game_thumb'}</label>
							<div class="col-lg-9">
							
							<div id="get_game_thumb_file" class="btn btn btn-primary no-radius-r pull-left" onclick="getFile('upload_game_thumb_file')">{t c='file.choose_file'}</div>
							<div class="file-box">
								<span id="uptname">{t c='file.no_file'}</span>
								<div style="height: 0px; width: 0px;overflow:hidden;">
									<input name="game_thumb_file" type="file" id="upload_game_thumb_file" onChange="sub(this,'uptname','nofile_t')" accept="image/*"/>								
								</div>
								<input type="hidden" id="nofile_t" value="{t c='file.no_file'}">
							</div>
							<div class="clearfix"></div>
							<div id="game_thumb_file_error" class="text-danger m-t-5" style="display: none;">{t c='upload.game_thumb_select'}</div>
							<div id="game_thumb_file_ext_error" class="text-danger m-t-5" style="display: none;"></div>
							</div>
						</div>						
						
						<div class="form-group">
							<label class="col-lg-3 control-label">{t c='upload.anonymous'}</label>
							<div class="col-lg-9">
								<div class="radio">
									<label>
										<input name="game_anonymous" type="radio" value="no" id="upload_game_anonymous_no" {if $game.anonymous == 'no'} checked="checked"{/if} />
										{t c='upload.anonymous_yes'}
									</label>
								</div>
								<div class="radio">
									<label>
										<input name="game_anonymous" type="radio" value="yes" id="upload_game_anonymous_yes" {if $game.anonymous == 'yes'} checked="checked"{/if} />
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
										<input name="game_privacy" type="radio" value="public" id="upload_game_privacy_public" {if $game.privacy == 'public'} checked="checked"{/if} />
										{t c='upload.privacy_public_game'}
									</label>
								</div>
								<div class="radio">
									<label>
										<input name="game_privacy" type="radio" value="private" id="upload_game_privacy_private" {if $game.privacy == 'private'} checked="checked"{/if} />
										{t c='upload.privacy_private_game'}
									</label>
								</div>
							</div>
						</div>

						<div id="upload_status" class="form-group" style="display:none;">
							<div id="upload_progress" class="col-lg-9 col-lg-offset-3">
								<div class="progress progress-striped active">
									<div id="bar" class="progress-bar progress-bar-warning" style="width: 100%;">&nbsp;</div>
								</div>								
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-lg-9 col-lg-offset-3">
								<input name="submit_upload_game" type="submit" id="upload_game_submit" value="{t c='upload.game_button'}" class="btn btn-primary" />
							</div>
						</div>
						{t c='upload.contr' s=$site_name}
					</form>
				</div>
			</div>	
		</div>
	</div>
</div>