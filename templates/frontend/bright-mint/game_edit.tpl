
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
					{t c='global.edit'}: {$game.title|escape:'html'}
				</div>
				<div class="panel-body">
					<form class="form-horizontal" name="editGame" id="editGame" method="post" enctype="multipart/form-data" target="_self" action="{$relative}/game/edit/{$game.GID}">
						
						<div  id="upload_title" class="form-group {if $err.title}has-error{/if}">
							<label for="upload_game_title" class="col-lg-3 control-label">{t c='global.title'}</label>
							<div class="col-lg-9">
								<input name="game_title" type="text" class="form-control" value="{$game.title}" id="upload_game_title" placeholder="{t c='global.title'}" />

							</div>
						</div>

						<div id="upload_tags" class="form-group {if $err.tags}has-error{/if}">
							<label for="upload_game_keywords" class="col-lg-3 control-label">{t c='global.tags'}</label>
							<div class="col-lg-9">
								<textarea name="game_keywords" id="upload_game_keywords" rows="2" class="form-control" placeholder="{t c='upload.tags_expl'}">{$game.tags}</textarea>

							</div>
						</div>
						
						<div id="upload_category" class="form-group {if $err.category}has-error{/if}">
							<label for="upload_game_category" class="col-lg-3 control-label">{t c='global.category'}</label>
							<div class="col-lg-9">
								<select name="game_category" id="upload_game_category" class="form-control">
									<option value="0"{if $game.category == '0'} selected="selected"{/if}>-----</option>
									{section name=i loop=$categories}
									<option value="{$categories[i].category_id}"{if $game.category == $categories[i].category_id} selected="selected"{/if}>{$categories[i].category_name|escape:'html'}</option>
									{/section}
								</select>

							</div>
						</div>
						
						<div class="form-group">
							<label class="col-lg-3 control-label">{t c='upload.privacy'}</label>
							<div class="col-lg-9">
								<div class="radio">
									<label>
										<input name="game_privacy" type="radio" value="public" id="upload_game_privacy_public" {if $game.type == 'public'} checked="checked"{/if} />
										{t c='upload.privacy_public_game'}
									</label>
								</div>
								<div class="radio">
									<label>
										<input name="game_privacy" type="radio" value="private" id="upload_game_privacy_private" {if $game.type == 'private'} checked="checked"{/if} />
										{t c='upload.privacy_private_game'}
									</label>
								</div>
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

