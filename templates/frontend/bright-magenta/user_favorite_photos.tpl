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
						{$user.username}{if $smarty.session.language == 'en_US'}&#39;s{/if} {t c='user.FAVORITE_PHOTOS'}
					</div>
					{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
						<div class="pull-right">
							<a href="{$relative}/user/{$username}/favorite/photos?clear=yes" title="{t c='favorite_photos.clear'}" onclick="javascript:return confirm('{t c='user.fav_photos_all'}');">{t c='global.clear_all'}</a>
						</div>
					{/if}					
					<div class="clearfix"></div>
				</div>
			
            {if $favorites}
				<div class="panel-body">
					<div id="remove_favorite_photo_message" class="m-t-15" style="display: none;"></div>
					{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$favorites_total}</span> {t c='photo.photos'}.
					<div class="row">
								{section name=i loop=$favorites}
									{if ($smarty.section.i.index mod 3 == 0) && ($smarty.section.i.index <> 0)}
										</div><div class="row">
									{/if}	
									<div id="favorite_photo_{$favorites[i].PID}" class="col-sm-4 m-t-15">
										<div class="thumb-overlay">
											<a href="{$relative}/photo/{$favorites[i].PID}/">
												<div class="thumb-overlay">
													<img src="{$relative}/media/photos/tmb/{$favorites[i].PID}.jpg" alt="{$favorites[i].caption|escape:html}" id="album_photo_{$favorites[i].PID}" class="img-responsive {if $favorites[i].type == 'private'}img-private{/if}" />
													{if $favorites[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
												</div>
											</a>
											{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
												<div class="actions">
													<a href="#remove_photo" id="remove_photo_from_favorite_{$favorites[i].PID}" class="btn btn-danger btn-xs remove-btn hidden-xs">{t c='global.remove'}</a>
													<a href="#remove_photo" id="remove_photo_from_favorite_{$favorites[i].PID}" class="btn btn-danger remove-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.remove'}</a>
												</div>
											{/if}
										</div>
									</div>  
								{/section}
					</div>
					{if $page_link}
						<div style="text-align: center;" class="visible-xs">
							<ul class="pagination pagination-lg">{$page_link}</ul>
						</div>
						<div style="text-align: center;" class="hidden-xs">
							<ul class="pagination">{$page_link}</ul>
						</div>
					{/if}
				</div>
			{else}
				<div class="panel-body">
					<span class="text-danger">{t c='user.fav_photos_none'}.</span>
				</div>
			{/if}	
			</div>	
		</div>
	</div>
</div>

