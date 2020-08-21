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
						{$user.username}{if $smarty.session.language == 'en_US'}&#39;s{/if} {t c='user.FAVORITE_GAMES'}
					</div>
					{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
						<div class="pull-right">
							<a href="{$relative}/user/{$username}/favorite/games?clear=yes" title="{t c='favorite_games.clear'}" onclick="javascript:return confirm('{t c='user.fav_games_all'}');">{t c='global.clear_all'}</a>
						</div>
					{/if}					
					<div class="clearfix"></div>
				</div>
			
            {if $favorites}
				<div class="panel-body">
					<div id="remove_favorite_game_message" class="posting" style="display:none"></div>
					{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$favorites_total}</span> {t c='game.games'}.
					<div class="row">
								  {section name=i loop=$favorites}
									<div id="favorite_game_{$favorites[i].GID}" class="col-sm-4 m-b-15">
										<div class="thumb-overlay">
											<a href="{$relative}/game/{$favorites[i].GID}/{$favorites[i].title|clean}">
												<div class="thumb-overlay">
													<img src="{$relative}/media/games/tmb/{$favorites[i].GID}.jpg" alt="{$favorites[i].title|escape:'html'}" class="img-responsive {if $favorites[i].type == 'private'}img-private{/if}" />
													{if $favorites[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
												</div>
												<div class="video-title title-truncate">{$favorites[i].title|escape:'html'}</div>
											</a>
											{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
												<div class="actions">
													<a href="#remove_game" id="remove_game_from_favorite_{$favorites[i].GID}" class="btn btn-danger btn-xs remove-btn hidden-xs">{t c='global.remove'}</a>
													<a href="#remove_game" id="remove_game_from_favorite_{$favorites[i].GID}" class="btn btn-danger remove-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.remove'}</a>
												</div>
											{/if}
										</div>
										<div class="video-added">
											{insert name=time_range assign=addtime time=$favorites[i].addtime}
											{$addtime}								
										</div>
										<div class="video-views pull-left">
											{$favorites[i].total_plays} {if $favorites[i].total_plays == '1'}{t c='global.play'}{else}{t c='global.plays'}{/if}
										</div>
										<div class="video-rating pull-right {if $favorites[i].rate == 0 && $favorites[i].dislikes == 0}no-rating{/if}">
											<i class="fa fa-heart video-rating-heart {if $favorites[i].rate == 0 && $favorites[i].dislikes == 0}no-rating{/if}"></i> <b>{if $favorites[i].rate == 0 && $favorites[i].dislikes == 0}-{else}{$favorites[i].rate}%{/if}</b>
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
					<span class="text-danger">{t c='games.none'}.</span>
				</div>
			{/if}	
			</div>	
		</div>
	</div>
</div>

