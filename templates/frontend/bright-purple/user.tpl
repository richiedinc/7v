<div class="container">
	<div class="row">
		<div class="col-md-4">
			{include file='user_info.tpl'}
			
			{if $friends}
				<div class="panel panel-default">           
					<div class="panel-heading">
						<div class="pull-left title-truncate m-w-60">
							{$username}{if $smarty.session.language == 'en_US'}&#39;s{/if}  {t c='user.friends'}
						</div>
						<div class="pull-right">
							<a href="{$relative}/user/{$user.username}/friends">{t c='global.view_all'}</a>	
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="panel-body">
						<div class="m-b--15">
							<div class="row">
								{section name=i loop=$friends}
									<div class="col-xs-6 col-sm-3 col-md-6 m-b-15">
										<a href="{$relative}/user/{$friends[i].username}">
											<img src="{$relative}/media/users/{if $friends[i].photo == ''}nopic-{$friends[i].gender}.gif{else}{$friends[i].photo}{/if}" alt="{$friends[i].username}'s avatar" class="img-responsive"/>
											<div class="video-title title-truncate">{$friends[i].username|escape:'html'}</div>
										</a>
									</div>                                                    
								{/section}
							</div>
						</div>
					</div>
				</div>
			{/if}

        {if $subscribers}
			<div class="panel panel-default">           
				<div class="panel-heading">
					<div class="pull-left title-truncate m-w-60">
						{$username}{if $smarty.session.language == 'en_US'}&#39;s{/if}  {t c='user.subscribers'}
					</div>
					<div class="pull-right">
						<a href="{$relative}/user/{$user.username}/subscribers">{t c='global.view_all'}</a>	
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="panel-body">
					<div class="m-b--15">
						<div class="row">
							{section name=i loop=$subscribers}
								<div class="col-xs-6 col-sm-3 col-md-6 m-b-15">
									<a href="{$relative}/user/{$subscribers[i].username}">
										<img src="{$relative}/media/users/{if $subscribers[i].photo == ''}nopic-{$subscribers[i].gender}.gif{else}{$subscribers[i].photo}{/if}" alt="{$subscribers[i].username}'s avatar" class="img-responsive"/>
										<div class="video-title title-truncate">{$subscribers[i].username|escape:'html'}</div>
									</a>
								</div>                                                    
							{/section}
						</div>
					</div>
				</div>
			</div>
        {/if}
		
        {if $subscriptions}

			<div class="panel panel-default">           
				<div class="panel-heading">
					<div class="pull-left title-truncate m-w-60">
						{$username}{if $smarty.session.language == 'en_US'}&#39;s{/if}  {t c='user.subscriptions'}
					</div>
					<div class="pull-right">
						<a href="{$relative}/user/{$user.username}/subscriptions">{t c='global.view_all'}</a>	
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="panel-body">
					<div class="m-b--15">
						<div class="row">
							{section name=i loop=$subscriptions}
								<div class="col-xs-6 col-sm-3 col-md-6 m-b-15">
									<a href="{$relative}/user/{$subscriptions[i].username}">
										<img src="{$relative}/media/users/{if $subscriptions[i].photo == ''}nopic-{$subscriptions[i].gender}.gif{else}{$subscriptions[i].photo}{/if}" alt="{$subscriptions[i].username}'s avatar" class="img-responsive"/>
										<div class="video-title title-truncate">{$subscriptions[i].username|escape:'html'}</div>
									</a>
								</div>                                                    
							{/section}
						</div>
					</div>
				</div>
			</div>		
		
        {/if}  
			
		</div>
		<div class="col-md-8">
		
			{if $blog && $blog_module == '1'}
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="pull-left">
							<i class="fa fa-pencil"></i>&nbsp;
							{insert name=time_range assign=addtime time=$blog.addtime}
							{$blog.total_views} {t c='global.views'} <strong>&middot;</strong> {$addtime}	
						</div>
						<div class="pull-right">					
							<a href="{$relative}/user/{$username}/blog">{t c='global.view_all'}</a>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="panel-body">
						<div class="blog_header">
							<a href="{$relative}/blog/{$blog.BID}/{$blog.title|clean}">{$blog.title|escape:'html'}</a>
						</div>
						
						<div class="blog_content">
							{$blog.content|nl2br}
						</div>
					</div>
					<div class="panel-footer">
						<div class="pull-left">
							<i class="fa fa-comment"></i> <a href="{$relative}/blog/{$blog.BID}/{$blog.title|clean}">{$blog.total_comments}</a> <strong>&middot;</strong>
							<a href="{$relative}/blog/{$blog.BID}/{$blog.title|clean}">{t c='blog.post_comment'}</a>                               
						</div>
						{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
							<div class="pull-right">
								<a href="{$relative}/blog/edit/{$blog.BID}/{$blog.title|clean}">{t c='global.edit'}</a> <strong>&middot;</strong>
								<a href="{$relative}/blog/delete/{$blog.BID}">{t c='global.delete'}</a>
							</div>
						{/if}
						<div class="clearfix"></div>
					</div>
				</div>		
			{/if}

			{if $playlist}
				<div class="panel panel-default">           
					<div class="panel-heading">
						<div class="pull-left">
							{t c='user.PLAYLIST'}
						</div>
						<div class="pull-right">
							<a href="{$relative}/user/{$user.username}/playlist">{t c='global.view_all'}</a>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="panel-body">
						<div id="remove_playlist_message" style="display:none"></div>
						<div class="m-b--15">
							<div class="row">
								 {section name=i loop=$playlist}
									<div id="playlist_video_{$playlist[i].VID}" class="col-sm-4 m-b-15">
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
						</div>
					</div>
				</div>			
			{/if}

			{if $videos}
				<div class="panel panel-default">           
					<div class="panel-heading">
						<div class="pull-left">
							{t c='global.videos'}
						</div>
						<div class="pull-right">
							<a href="{$relative}/user/{$user.username}/videos">{t c='global.view_all'}</a>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="panel-body">
						<div id="delete_video_message" style="display:none"></div>
						<div class="m-b--15">
							<div class="row">
								  {section name=i loop=$videos}
									<div id="video_{$videos[i].VID}" class="col-sm-4 m-b-15">
										<div class="thumb-overlay">
											<a href="{$relative}/video/{$videos[i].VID}/{$videos[i].title|clean}">
												<div class="thumb-overlay">
													<img src="{insert name=thumb_path vid=$videos[i].VID}/{$videos[i].thumb}.jpg" alt="{$videos[i].title|escape:'html'}" id="rotate_{$videos[i].VID}_{$videos[i].thumbs}_{$videos[i].thumb}" class="img-responsive {if $videos[i].type == 'private'}img-private{/if}" />
													{if $videos[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
													{if $videos[i].hd==1}<div class="hd-text-icon">HD</div>{/if}
													<div class="duration">
														{insert name=duration assign=duration duration=$videos[i].duration}
														{$duration}
													</div>												
												</div>
											</a>
											<div class="actions">
												{if $edit_videos == '1' && isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
													<a href="{$relative}/edit/{$videos[i].VID}" class="btn btn-primary btn-xs edit-btn hidden-xs">{t c='global.edit'}</a>
													<a href="{$relative}/edit/{$videos[i].VID}" class="btn btn-primary edit-btn visible-xs"><i class="glyphicon glyphicon-edit"></i> {t c='global.edit'}</a>
												{/if}	
												{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}												
													<a href="#delete_video" id="delete_video_{$videos[i].VID}" class="btn btn-danger btn-xs delete-btn hidden-xs">{t c='global.delete'}</a>
													<a href="#delete_video" id="delete_video_{$videos[i].VID}" class="btn btn-danger delete-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.delete'}</a>
												{/if}
											</div>
										</div>
										<a href="{$relative}/video/{$videos[i].VID}/{$videos[i].title|clean}">
											<div class="video-title title-truncate">{$videos[i].title|escape:'html'}</div>
										</a>
										<div class="video-added">
											{insert name=time_range assign=addtime time=$videos[i].addtime}
											{$addtime}								
										</div>
										<div class="video-views pull-left">
											{$videos[i].viewnumber} {if $videos[i].viewnumber == '1'}{t c='global.view'}{else}{t c='global.views'}{/if}
										</div>
										<div class="video-rating pull-right {if $videos[i].rate == 0 && $videos[i].dislikes == 0}no-rating{/if}">
											<i class="fa fa-heart video-rating-heart {if $videos[i].rate == 0 && $videos[i].dislikes == 0}no-rating{/if}"></i> <b>{if $videos[i].rate == 0 && $videos[i].dislikes == 0}-{else}{$videos[i].rate}%{/if}</b>
										</div>
										<div class="clearfix"></div>										
									</div>                                                    
								{/section}
							</div>
						</div>
					</div>
				</div>			
			{/if}			
			
			{if $albums && $photo_module == '1'}
				<div class="panel panel-default">           
					<div class="panel-heading">
						<div class="pull-left">
							{t c='user.PHOTO_ALBUMS'}
						</div>
						<div class="pull-right">
							<a href="{$relative}/user/{$user.username}/albums">{t c='global.view_all'}</a>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="panel-body">
						<div class="m-b--15">
							<div class="row">
								{section name=i loop=$albums}
									<div class="col-sm-4 m-b-15">
										<div class="thumb-overlay">
											<a href="{$relative}/album/{$albums[i].AID}/{$albums[i].name|clean}">
												<div class="thumb-overlay">
													<img src="{$relative}/media/albums/{$albums[i].AID}.jpg" title="{$albums[i].name|escape:'html'}" alt="{$albums[i].name|escape:'html'}" class="img-responsive {if $albums[i].type == 'private'}img-private{/if}" />
													{if $albums[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
												</div>											
											</a>
										{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
											<div class="actions">
												<a href="{$relative}/album/delete/{$albums[i].AID}" class="btn btn-danger btn-xs delete-btn hidden-xs">{t c='global.delete'}</a>
												<a href="{$relative}/album/delete/{$albums[i].AID}" class="btn btn-danger delete-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.delete'}</a>
											</div>
										{/if}											
										</div>
										<a href="{$relative}/album/{$albums[i].AID}/{$albums[i].name|clean}">
											<div class="video-title title-truncate">{$albums[i].name|escape:'html'}</div>
										</a>
										<div class="video-added">
											{insert name=time_range assign=addtime time=$albums[i].addtime}
											{$addtime}										
										</div>
										<div class="video-views pull-left">
											{$albums[i].total_photos} {if $albums[i].total_photos > 1}{t c='album.photos'}{else}{t c='album.photo'}{/if}
										</div>
										<div class="video-rating pull-right {if $albums[i].rate == 0 && $albums[i].dislikes == 0}no-rating{/if}">
											<i class="fa fa-heart video-rating-heart {if $albums[i].rate == 0 && $albums[i].dislikes == 0}no-rating{/if}"></i> <b>{if $albums[i].rate == 0 && $albums[i].dislikes == 0}-{else}{$albums[i].rate}%{/if}</b>
										</div>
										<div class="clearfix"></div>										
									</div>                                                    
								{/section}
							</div>
						</div>
					</div>
				</div>			
			{/if}

			{if $games && $game_module == '1'}
				<div class="panel panel-default">           
					<div class="panel-heading">
						<div class="pull-left">
							{t c='global.games'}
						</div>
						<div class="pull-right">
							<a href="{$relative}/user/{$user.username}/games">{t c='global.view_all'}</a>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="panel-body">
						<div id="delete_game_message" style="display:none"></div>
						<div class="m-b--15">
							<div class="row">
								  {section name=i loop=$games}
									<div id="game_{$games[i].GID}" class="col-sm-4 m-b-15">
										<div class="thumb-overlay">
											<a href="{$relative}/game/{$games[i].GID}/{$games[i].title|clean}">
												<div class="thumb-overlay">
													<img src="{$relative}/media/games/tmb/{$games[i].GID}.jpg" alt="{$games[i].title|escape:'html'}" class="img-responsive {if $games[i].type == 'private'}img-private{/if}" />
													{if $games[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
												</div>
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
										<a href="{$relative}/game/{$games[i].GID}/{$games[i].title|clean}">
											<div class="video-title title-truncate">{$games[i].title|escape:'html'}</div>
										</a>										
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
						</div>
					</div>
				</div>			
			{/if}
			
			{if $favorites}
				<div class="panel panel-default">           
					<div class="panel-heading">
						<div class="pull-left">
							{t c='user.FAVORITE_VIDEOS'}
						</div>
						<div class="pull-right">
							<a href="{$relative}/user/{$user.username}/favorite/videos">{t c='global.view_all'}</a>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="panel-body">
						<div id="remove_favorite_message" style="display:none"></div>
						<div class="m-b--15">
							<div class="row">
								  {section name=i loop=$favorites}
									<div id="favorite_video_{$favorites[i].VID}" class="col-sm-4 m-b-15">
										<div class="thumb-overlay">
											<a href="{$relative}/video/{$favorites[i].VID}/{$favorites[i].title|clean}">
												<div class="thumb-overlay">
													<img src="{insert name=thumb_path vid=$favorites[i].VID}/{$favorites[i].thumb}.jpg" alt="{$favorites[i].title|escape:'html'}" id="favoriterotate_{$favorites[i].VID}_{$favorites[i].thumbs}_{$favorites[i].thumb}" class="img-responsive {if $favorites[i].type == 'private'}img-private{/if}" />
													{if $favorites[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
													{if $favorites[i].hd==1}<div class="hd-text-icon">HD</div>{/if}
													<div class="duration">
														{insert name=duration assign=duration duration=$favorites[i].duration}
														{$duration}
													</div>												
												</div>
												<div class="video-title title-truncate">{$favorites[i].title|escape:'html'}</div>
											</a>
											{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
												<div class="actions">
													<a href="#remove_video" id="remove_video_from_favorite_{$favorites[i].VID}" class="btn btn-danger btn-xs remove-btn hidden-xs">{t c='global.remove'}</a>
													<a href="#remove_video" id="remove_video_from_favorite_{$favorites[i].VID}" class="btn btn-danger remove-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.remove'}</a>
												</div>
											{/if}
										</div>
										<div class="video-added">
											{insert name=time_range assign=addtime time=$favorites[i].addtime}
											{$addtime}								
										</div>
										<div class="video-views pull-left">
											{$favorites[i].viewnumber} {if $favorites[i].viewnumber == '1'}{t c='global.view'}{else}{t c='global.views'}{/if}
										</div>
										<div class="video-rating pull-right {if $favorites[i].rate == 0 && $favorites[i].dislikes == 0}no-rating{/if}">
											<i class="fa fa-heart video-rating-heart {if $favorites[i].rate == 0 && $favorites[i].dislikes == 0}no-rating{/if}"></i> <b>{if $favorites[i].rate == 0 && $favorites[i].dislikes == 0}-{else}{$favorites[i].rate}%{/if}</b>
										</div>
										<div class="clearfix"></div>										
									</div>                                                    
								{/section}
							</div>
						</div>
					</div>
				</div>			
			{/if}
			
			{if $photos && $photo_module == '1'}
				<div class="panel panel-default">           
					<div class="panel-heading">
						<div class="pull-left">
							{t c='user.FAVORITE_PHOTOS'}
						</div>
						<div class="pull-right">
							<a href="{$relative}/user/{$user.username}/favorite/photos">{t c='global.view_all'}</a>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="panel-body">
						<div id="remove_favorite_photo_message" style="display: none;"></div>
						<div class="m-b--15">
							<div class="row">
								{section name=i loop=$photos}
									<div id="favorite_photo_{$photos[i].PID}" class="col-sm-4 m-b-15">
										<div class="thumb-overlay">
											<a href="{$relative}/photo/{$photos[i].PID}/">
												<div class="thumb-overlay">
													<img src="{$relative}/media/photos/tmb/{$photos[i].PID}.jpg" alt="{$photos[i].caption|escape:html}" id="album_photo_{$photos[i].PID}" class="img-responsive {if $photos[i].type == 'private'}img-private{/if}" />
													{if $photos[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
												</div>
											</a>
											{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
												<div class="actions">
													<a href="#remove_photo" id="remove_photo_from_favorite_{$photos[i].PID}" class="btn btn-danger btn-xs remove-btn hidden-xs">{t c='global.remove'}</a>
													<a href="#remove_photo" id="remove_photo_from_favorite_{$photos[i].PID}" class="btn btn-danger remove-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.remove'}</a>
												</div>
											{/if}
										</div>
									</div>                                                    
								{/section}
							</div>
						</div>
					</div>
				</div>			
			{/if}
			
			{if $favorite_games && $game_module == '1'}
				<div class="panel panel-default">           
					<div class="panel-heading">
						<div class="pull-left">
							{t c='user.FAVORITE_GAMES'}
						</div>
						<div class="pull-right">
							<a href="{$relative}/user/{$user.username}/favorite/games">{t c='global.view_all'}</a>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="panel-body">
						<div id="remove_favorite_game_message" style="display:none"></div>
						<div class="m-b--15">
							<div class="row">
								  {section name=i loop=$favorite_games}
									<div id="favorite_game_{$favorite_games[i].GID}" class="col-sm-4 m-b-15">
										<div class="thumb-overlay">
											<a href="{$relative}/game/{$favorite_games[i].GID}/{$favorite_games[i].title|clean}">
												<div class="thumb-overlay">
													<img src="{$relative}/media/games/tmb/{$favorite_games[i].GID}.jpg" alt="{$favorite_games[i].title|escape:'html'}" class="img-responsive {if $favorite_games[i].type == 'private'}img-private{/if}" />
													{if $favorite_games[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
												</div>
												<div class="video-title title-truncate">{$favorite_games[i].title|escape:'html'}</div>
											</a>
											{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
												<div class="actions">
													<a href="#remove_game" id="remove_game_from_favorite_{$favorite_games[i].GID}" class="btn btn-danger btn-xs remove-btn hidden-xs">{t c='global.remove'}</a>
													<a href="#remove_game" id="remove_game_from_favorite_{$favorite_games[i].GID}" class="btn btn-danger remove-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.remove'}</a>
												</div>
											{/if}
										</div>
										<div class="video-added">
											{insert name=time_range assign=addtime time=$favorite_games[i].addtime}
											{$addtime}								
										</div>
										<div class="video-views pull-left">
											{$favorite_games[i].total_plays} {if $favorite_games[i].total_plays == '1'}{t c='global.play'}{else}{t c='global.plays'}{/if}
										</div>
										<div class="video-rating pull-right {if $favorite_games[i].rate == 0 && $favorite_games[i].dislikes == 0}no-rating{/if}">
											<i class="fa fa-heart video-rating-heart {if $favorite_games[i].rate == 0 && $favorite_games[i].dislikes == 0}no-rating{/if}"></i> <b>{if $favorite_games[i].rate == 0 && $favorite_games[i].dislikes == 0}-{else}{$favorite_games[i].rate}%{/if}</b>
										</div>
										<div class="clearfix"></div>										
									</div>                                                    
								{/section}
							</div>
						</div>
					</div>
				</div>			
			{/if}

			{if $show_wall}
				{if $walls || ( isset($smarty.session.uid) && $wall_comments == '1' )}
					<div class="panel panel-default">           
						<div class="panel-heading">
							{t c='user.WALL'}
						</div>
						<div class="panel-body">
						
							{if isset($smarty.session.uid) && $user.UID && $wall_comments == '1'}
							<div id="wall">
								<form class="form-horizontal" name="wall_form" id="wall_form" method="post" action="#post_comment">
									<div id="media_message" style="display: none;"></div>
									<div id="media_content" class="m-b-15" style="display: none;"></div>
									<div class="form-group">
										<div class="col-xs-12 col-sm-10 col-sm-offset-1">
											<textarea name="wall_comment" id="wall_comment" cols="75" rows="5" class="form-control" placeholder="{t c='global.add_comment'}"></textarea>
											<div id="post_message" class="text-danger m-t-5" style="display: none;">{t c='global.comment_empty'}</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-12 col-sm-10 col-sm-offset-1">
											<div class="pull-left">
												<input name="submit_wall" type="submit" value=" {t c='global.post'} " id="post_wall_comment_{$user.UID}" class="btn btn-primary">
												<a href="#attach_photo" id="attach_photo" class="btn btn-secondary m-l-5"><span class="visible-xs"><i class="fa fa-camera"></i></span><span class="hidden-xs">{t c='global.attach_photo'}</span></a>
												<a href="#attach_video" id="attach_video" class="btn btn-secondary m-l-5"><span class="visible-xs"><i class="fa fa-film"></i></span><span class="hidden-xs">{t c='global.attach_video'}</span></a>
											</div>
											<div class="pull-right">
												<span id="chars_left">1000</span> {t c='global.chars_left'}
											</div>
											<div class="clearfix"></div>
										</div>
									</div>
								</form>
							</div>
							{/if}
							
							<div id="wall_comments_{$user.UID}">
								{if $walls}
									{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span id="end_num" class="text-white">{$end_num}</span> {t c='global.of'} <span id="total_comments" class="text-white">{$walls_total}</span> {t c='global.comments'}.
								{/if}
								<div id="wall_response" style="display: none;">{t c='global.posting'}</div>
								<div id="comments_delimiter" style="display:none;"></div>
								{if $walls}
									{section name=i loop=$walls}
										
										<div id="wall_comment_{$walls[i].wall_id}" class="col-xs-12 m-t-15">
											<div class="row">
												<div class="pull-left">
													<a href="{$relative}/user/{$walls[i].username}">
														<img src="{$relative}/media/users/{if $walls[i].photo != ''}{$walls[i].photo}{else}nopic-{$walls[i].gender}.gif{/if}" title="{$walls[i].username}'s avatar" alt="{$walls[i].username}'s avatar" class="img-responsive comment-avatar" />
													</a>											
												</div>
												<div class="comment">
													<div class="comment-info">
														{insert name=time_range assign=addtime time=$walls[i].addtime}
														<a href="{$relative}/user/{$walls[i].username}">{$walls[i].username}</a>&nbsp;-&nbsp;<span class="">{$addtime}</span>
													</div>
													<div class="comment-body overflow-hidden">{$walls[i].message|nl2br}</div>
													{if isset($smarty.session.uid)}
														<div class="comment-actions">
															{if $smarty.session.uid == $walls[i].UID}
																<a href="#delete_comment" id="delete_comment_wall_{$walls[i].wall_id}_{$user.UID}">{t c='global.delete'}</a> <span id="delete_response_{$walls[i].wall_id}" style="display: none;"></span>
															{/if}
															{if $smarty.session.uid != $walls[i].UID}
																<span id="reported_spam_{$walls[i].wall_id}_{$user.UID}"><a href="#report_spam" id="report_spam_wall_{$walls[i].wall_id}_{$user.UID}">{t c='global.report_spam'}</a></span>
															{/if}
														</div>
													{/if}
												</div>
												<div class="clearfix"></div>
											</div>
											
										</div>
										
									{/section}

									{if $page_link}
										<div class="visible-xs center m-b--15">
											<ul class="pagination pagination-lg">{$page_link}</ul>
										</div>
										<div class="hidden-xs center m-b--15">
											<ul class="pagination">{$page_link}</ul>
										</div>
									{/if}
						
								{/if}
							</div>
						</div>
					</div>
				
				{/if}
			{/if}
			
			
		</div>
	</div>
</div>

