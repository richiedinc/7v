<script type="text/javascript" src="{$relative_tpl}/js/jquery.browser.min.js"></script>
<link rel="stylesheet" type="text/css" href="{$relative_tpl}/css/imgareaselect/imgareaselect-default.css" />
<script type="text/javascript" src="{$relative_tpl}/js/jquery.imgareaselect.js"></script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.album-0.1.js"></script>

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
						{t c='global.edit'}: {$album.name|escape:'html'}
					</div>
					<div class="pull-right">
                      <a href="{$relative}/album/{$album.AID}/">{t c='global.back_to'} '{$album.name|escape:'html'}'</a> <strong>&middot;</strong>
                      <a href="{$relative}/album/addphotos/{$album.AID}">{t c='album.add_more_photos'}</a>					
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="panel-body">
					<form class="form-horizontal" name="uploadPhoto" id="uploadPhoto" method="post" action="{$relative}/album/edit/{$album.AID}">
						
						<div class="separator">
							{t c='upload.album_details'}
						</div>
						
						<div class="form-group {if $err.name}has-error{/if}">
							<label for="upload_album_name" class="col-lg-3 control-label">{t c='global.name'}</label>
							<div class="col-lg-9">
								<input name="album_name" type="text" class="form-control" value="{$album.name}" id="upload_album_name" placeholder="{t c='global.name'}" />
								<div id="album_name_error" class="text-danger m-t-5" style="display: none;">{t c='upload.album_name_empty'}</div>
							</div>
						</div>
						
						<div class="form-group {if $err.tags}has-error{/if}">
							<label for="upload_album_tags" class="col-lg-3 control-label">{t c='global.tags'}</label>
							<div class="col-lg-9">
								<textarea name="album_tags" id="upload_album_tags" rows="3" style="resize: none;" class="form-control" placeholder="{t c='global.tags'}">{$album.tags}</textarea>
								<div id="album_tags_error" class="text-danger m-t-5" style="display: none;">{t c='upload.album_tags_empty'}</div>
							</div>
						</div>						

						<div class="form-group {if $err.category}has-error{/if}">
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

						<div class="form-group {if $err.type}has-error{/if}">
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
						
						{if $photos}
							<div class="separator">
								{t c='album.step_one'}
							</div>
							<div class="row">
								{section name=i loop=$photos}
									{if ($smarty.section.i.index mod 3 == 0) && ($smarty.section.i.index <> 0)}
										</div><div class="row">
									{/if}	
									<div class="col-sm-4 m-b-15">
											<a href="{$relative}/photo/{$photos[i].PID}/">
												<img src="{$relative}/media/photos/tmb/{$photos[i].PID}.jpg" alt="{$photos[i].caption|escape:html}" id="album_photo_{$photos[i].PID}" class="img-responsive" />
											</a>
									</div>
								{/section}
							</div>
							<div class="separator">
								<span class="hidden-xs">{t c='album.step_two'}</span><span class="visible-xs">{t c='album.step_two_xs'}</span>
							</div>								
							<input name="x1" type="hidden" value="0" id="x1" />
							<input name="y1" type="hidden" value="0" id="y1" />
							<input name="x2" type="hidden" value="400" id="x2" />
							<input name="y2" type="hidden" value="400" id="y2" />
							<input name="width" type="hidden" value="400" id="width" />
							<input name="height" type="hidden" value="400" id="height" />

							<input name="x1-i" type="hidden" value="0" id="x1-i" />
							<input name="y1-i" type="hidden" value="0" id="y1-i" />
							<input name="x2-i" type="hidden" value="400" id="x2-i" />
							<input name="y2-i" type="hidden" value="400" id="y2-i" />
							<input name="width-i" type="hidden" value="400" id="width-i" />
							<input name="height-i" type="hidden" value="400" id="height-i" />							
							
							<input name="photo" type="hidden" value="1" id="photo" />
							<input name="random" type="hidden" value="" id="random" />
							<input name="init-s" type="hidden" value="0" id="init-s" />
							<center>
							<div id="current_cover" class="m-b-15">
								<label class="control-label">{t c='album.current_cover'}</label>
							</div>
							<div class="m-b-15">
								<img src="{$relative}/media/albums/{$album.AID}.jpg?{0|rand:100}" id="album_cover" class="img-responsive-mw"/>
							</div>
							<div class="form-group">
								<div class="col-xs-12">
									<input name="submit_album_edit" type="submit" value=" {t c='global.save'} " class="btn btn-primary" />
								</div>
							</div>
							</center>							
						{else}
							<div class="text-danger">
								{t c='album.edit_no_photos' r=$relative a=$album.AID}!
							</div>
						{/if}
						
					</form>
				</div>
	
			</div>	
		</div>
	</div>
</div>

