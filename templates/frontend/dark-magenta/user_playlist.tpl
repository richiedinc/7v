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
						{$user.username}{if $smarty.session.language == 'en_US'}&#39;s{/if} {t c='user.PLAYLIST'}
					</div>
					{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
						<div class="pull-right">
							<a href="{$relative}/user/{$username}/playlist?clear=yes" title="Clear Playlist" onclick="javascript:return confirm('{t c='user.playlist_clear'}');">{t c='global.clear_all'}</a>
						</div>
					{/if}					
					<div class="clearfix"></div>
				</div>
			
            {if $playlist}
				<div class="panel-body">
					<div id="remove_playlist_message" class="m-t-15" style="display:none"></div>
					{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$playlist_total}</span> {t c='videos.videos'}.
					
					<div class="row">
								 {section name=i loop=$playlist}
									<div id="playlist_video_{$playlist[i].VID}" class="col-sm-4 m-t-15">
										<div class="thumb-overlay">
											<a href="{$relative}/video/{$playlist[i].VID}/{$playlist[i].title|clean}">
												<div class="thumb-overlay">
													<img src="{insert name=thumb_path vid=$playlist[i].VID}/{$playlist[i].thumb}.jpg" alt="{$playlist[i].title|escape:'html'}" id="playlistrotate_{$playlist[i].VID}_{$playlist[i].thumbs}_{$playlist[i].thumb}" class="img-responsive {if $playlist[i].type == 'private'}img-private{/if}" />
													{if $playlist[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
													{if $playlist[i].hd==1}<div class="hd-text-icon">HD</div>{/if}
													<div class="duration">
														{insert name=duration assign=duration duration=$playlist[i].duration}
														{$duration}
													</div>												
												</div>
												<div class="video-title title-truncate">{$playlist[i].title|escape:'html'}</div>
											</a>
											{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
												<div class="actions">
													<a href="#remove_video" id="remove_video_from_playlist_{$playlist[i].VID}" class="btn btn-danger btn-xs remove-btn hidden-xs">{t c='global.remove'}</a>
													<a href="#remove_video" id="remove_video_from_playlist_{$playlist[i].VID}" class="btn btn-danger remove-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.remove'}</a>
												</div>
											{/if}
										</div>
										<div class="video-added">
											{insert name=time_range assign=addtime time=$playlist[i].addtime}
											{$addtime}										
										</div>
										<div class="video-views pull-left">
											{$playlist[i].viewnumber} {if $playlist[i].viewnumber == '1'}{t c='global.view'}{else}{t c='global.views'}{/if}
										</div>
										<div class="video-rating pull-right {if $playlist[i].rate == 0 && $playlist[i].dislikes == 0}no-rating{/if}">
											<i class="fa fa-heart video-rating-heart {if $playlist[i].rate == 0 && $playlist[i].dislikes == 0}no-rating{/if}"></i> <b>{if $playlist[i].rate == 0 && $playlist[i].dislikes == 0}-{else}{$playlist[i].rate}%{/if}</b>
										</div>
										<div class="clearfix"></div>										
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
					<span class="text-danger">{t c='user.playlist_none'}.</span>
				</div>
			{/if}	
			</div>	
		</div>
	</div>
</div>

