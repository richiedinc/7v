	<div class="well well-filters">
		<div class="btn-group">
			<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">{if isset($smarty.session.username) && $smarty.session.username == $username}{t c='my.quick_jumps'}{else}{$username|truncate:16:'...':true}{if $smarty.session.language == 'en_US'}&#39;s{/if} {t c='user.quick_jumps'}{/if} <span class="caret"></span></button>
			<ul class="dropdown-menu">
				<li><a href="{$relative}/user/{$username}">{t c='user.profile'}</a></li>		
				{if $blog_module == '1'}<li><a href="{$relative}/user/{$username}/blog">{t c='global.blog'}</a></li>{/if}
				<li><a href="{$relative}/user/{$username}/playlist">{t c='user.playlist'}</a></li>				
				{if $video_module == '1'}<li><a href="{$relative}/user/{$username}/videos">{t c='global.videos'}</a></li>{/if}
				{if $photo_module == '1'}<li><a href="{$relative}/user/{$username}/albums">{t c='user.photo_albums'}</a></li>{/if}
				{if $game_module == '1'}<li><a href="{$relative}/user/{$username}/games">{t c='global.games'}</a></li>{/if}
				{if $video_module == '1'}<li><a href="{$relative}/user/{$username}/favorite/videos">{t c='global.favorite'} {t c='global.videos'}</a></li>{/if}
				{if $photo_module == '1'}<li><a href="{$relative}/user/{$username}/favorite/photos">{t c='global.favorite'} {t c='global.photos'}</a></li>{/if}
				{if $game_module == '1'}<li><a href="{$relative}/user/{$username}/favorite/games">{t c='global.favorite'} {t c='global.games'}</a></li>{/if}
				<li><a href="{$relative}/user/{$username}/wall">{t c='user.wall'}</a></li>                
				<li><a href="{$relative}/user/{$username}/friends">{t c='user.friends'}</a></li>
				<li><a href="{$relative}/user/{$username}/subscribers">{t c='user.subscribers'}</a></li>
				<li><a href="{$relative}/user/{$username}/subscriptions">{t c='user.subscriptions'}</a></li>
				{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}<li><a href="{$relative}/mail">{t c='global.inbox'}</a></li>{/if}		
			</ul>
		</div>
	</div>