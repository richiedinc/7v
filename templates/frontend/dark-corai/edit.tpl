<script type="text/javascript" src="{$relative_tpl}/js/jquery.video_edit-0.1.js"></script>

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
					{t c='global.edit'}: {$video.title|escape:'html'}
				</div>
				<div class="panel-body">
					<form class="form-horizontal" name="editVideo" id="editVideo" method="post" enctype="multipart/form-data" target="_self" action="{$relative}/edit/{$video.VID}">
						
						<div class="form-group {if $err.title}has-error{/if}">
							<label for="upload_video_title" class="col-lg-3 control-label">{t c='global.title'}</label>
							<div class="col-lg-9">
								<input name="title" type="text" class="form-control" value="{$video.title}" id="upload_video_title" placeholder="{t c='global.title'}" />
								<div id="video_title_error" class="text-danger m-t-5" {if !$err.title}style="display: none;"{/if}>{t c='upload.video_title_empty'}</div>
							</div>
						</div>

						<div class="form-group {if $err.tags}has-error{/if}">
							<label for="upload_video_keywords" class="col-lg-3 control-label">{t c='global.tags'}</label>
							<div class="col-lg-9">
								<textarea name="keyword" id="upload_video_keywords" rows="2" class="form-control" placeholder="{t c='upload.tags_expl'}">{$video.keyword}</textarea>
								<div id="video_tags_error" class="text-danger m-t-5" {if !$err.tags}style="display: none;"{/if}>{t c='upload.video_tags_empty'}</div>
							</div>
						</div>
						
						<div class="form-group {if $err.category}has-error{/if}">
							<label for="upload_video_category" class="col-lg-3 control-label">{t c='global.category'}</label>
							<div class="col-lg-9">
								<select name="channel" id="upload_video_category" class="form-control">
									<option value="0"{if $video.channel == '0'} selected="selected"{/if}>-----</option>
									{section name=i loop=$categories}
									<option value="{$categories[i].CHID}"{if $video.channel == $categories[i].CHID} selected="selected"{/if}>{$categories[i].name|escape:'html'}</option>
									{/section}
								</select>
								<div id="video_category_error" class="text-danger m-t-5" {if !$err.category}style="display: none;"{/if}>{t c='global.category_empty'}</div>
							</div>
						</div>

						<div class="form-group">
							<label class="col-lg-3 control-label">{t c='upload.privacy'}</label>
							<div class="col-lg-9">
								<div class="radio">
									<label>
										<input name="type" type="radio" value="public" id="upload_video_privacy_public" {if $video.type == 'public'} checked="checked"{/if} />
										{t c='upload.video_public'}
									</label>
								</div>
								<div class="radio">
									<label>
										<input name="type" type="radio" value="private" id="upload_video_privacy_private" {if $video.type == 'private'} checked="checked"{/if} />
										{t c='upload.video_private'}
									</label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="thumb" class="col-lg-3 control-label">{t c='edit.thumb'}</label>
							<div class="col-lg-9">
								<input name="thumb" id="thumb" type="hidden" value="{$video.thumb}" />
								{insert name=thumb assign=thumb vid=$video.VID thumb=$video.thumb thumbs=$video.thumbs}
								{$thumb}
							</div>						
						</div>
						
						<div class="form-group">
							<div class="col-lg-9 col-lg-offset-3">
								 <input name="edit_submit" type="submit" id="edit_submit" value="{t c='global.save'}" class="btn btn-primary" />
							</div>
						</div>						
						
					</form>
				</div>
	
			</div>	
		</div>
	</div>
</div>

