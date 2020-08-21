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
						{$user.username}{if $smarty.session.language == 'en_US'}&#39;s{/if} {t c='global.games'}
					</div>
					{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
						<div class="pull-right">
							<a href="{$relative}/upload/game">{t c='game.upload_game'}</a>
						</div>
					{/if}					
					<div class="clearfix"></div>
				</div>
			
            {if $games}
				<div class="panel-body">
					<div id="delete_game_message" style="display:none"></div>
					{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$games_total}</span> {t c='game.games'}.
					<div class="row">
						{section name=i loop=$games}
							<div id="game_{$games[i].GID}" class="col-sm-4 m-t-15">
								<div class="thumb-overlay">
									<a href="{$relative}/game/{$games[i].GID}/{$games[i].title|clean}">
										<div class="thumb-overlay">
											<img src="{$relative}/media/games/tmb/{$games[i].GID}.jpg" alt="{$games[i].title|escape:'html'}" class="img-responsive {if $games[i].type == 'private'}img-private{/if}" />
											{if $games[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
										</div>
										<div class="video-title title-truncate">{$games[i].title|escape:'html'}</div>
									</a>
									{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
										<div class="actions">
											<a href="{$relative}/game/edit/{$games[i].GID}" class="btn btn-primary btn-xs edit-btn hidden-xs">{t c='global.edit'}</a>
											<a href="{$relative}/game/edit/{$games[i].GID}" class="btn btn-primary edit-btn visible-xs"><i class="glyphicon glyphicon-edit"></i> {t c='global.edit'}</a>
											
											<a href="#delete_game" id="delete_game_{$games[i].GID}" class="btn btn-danger btn-xs delete-btn hidden-xs">{t c='global.delete'}</a>
											<a href="#delete_game" id="delete_game_{$games[i].GID}" class="btn btn-danger delete-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.delete'}</a>
										</div>
									{/if}
								</div>
								<div class="video-added">
									{insert name=time_range assign=addtime time=$games[i].addtime}
									{$addtime}								
								</div>
								<div class="video-views pull-left">
									{$games[i].total_plays} {if $games[i].total_plays == '1'}{t c='global.play'}{else}{t c='global.plays'}{/if}
								</div>
								<div class="video-rating pull-right {if $games[i].rate == 0 && $games[i].dislikes == 0}no-rating{/if}">
									<i class="fa fa-heart video-rating-heart {if $games[i].rate == 0 && $games[i].dislikes == 0}no-rating{/if}"></i> <b>{if $games[i].rate == 0 && $games[i].dislikes == 0}-{else}{$games[i].rate}%{/if}</b>
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