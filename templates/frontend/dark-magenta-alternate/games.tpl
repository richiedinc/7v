<div class="container">

	<div class="well well-filters">
			<div class="pull-left">
				<h4>{t c='global.games'}</h4>
			</div>
			<div class="pull-left m-l-20">
				<div class="hidden-xs">
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">{if $type == ''}{t c='global.type'}{elseif $type == 'public'}{t c='global.public'}{else}{t c='global.private'}{/if} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li {if $type == ''}class="active"{/if}><a href="{url base=$base strip='type' value=''}">{t c='global.all'}</a></li>
							<li {if $type == 'public'}class="active"{/if}><a href="{url base=$base strip='type' value='public'}">{t c='global.public'}</a></li>
							<li {if $type == 'private'}class="active"{/if}><a href="{url base=$base strip='type' value='private'}">{t c='global.private'}</a></li>
						</ul>
					</div>
					
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">{if $timeframe == 'a'}{t c='global.timeline'}{elseif $timeframe == 't'}{t c='global.added'} {t c='global.today'}{elseif $timeframe == 'w'}{t c='global.added'} {t c='global.this_week'}{else}{t c='global.added'} {t c='global.this_month'}{/if} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li {if $timeframe == 'a'}class="active"{/if}><a href="{url base=$base strip='t' value='a'}">{t c='global.all'}</a></li>							
							<li {if $timeframe == 't'}class="active"{/if}><a href="{url base=$base strip='t' value='t'}">{t c='global.added'} {t c='global.today'}</a></li>
							<li {if $timeframe == 'w'}class="active"{/if}><a href="{url base=$base strip='t' value='w'}">{t c='global.added'} {t c='global.this_week'}</a></li>
							<li {if $timeframe == 'm'}class="active"{/if}><a href="{url base=$base strip='t' value='m'}">{t c='global.added'} {t c='global.this_month'}</a></li>
						</ul>
					</div>					

					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">{if $order == 'bp'}{t c='global.being_played'}{elseif $order == 'mr'}{t c='global.most_recent'}{elseif $order == 'mp'}{t c='global.most_played'}{elseif $order == 'tr'}{t c='global.top_rated'}{elseif $order == 'md'}{t c='global.most_commented'}{else}{t c='global.top_favorites'}{/if} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li {if $order == 'bp'}class="active"{/if}><a href="{url base=$base strip='o' value='bp'}">{t c='global.being_played'}</a></li>						
							<li {if $order == 'mr'}class="active"{/if}><a href="{url base=$base strip='o' value='mr'}">{t c='global.most_recent'}</a></li>
							<li {if $order == 'mp'}class="active"{/if}><a href="{url base=$base strip='o' value='mp'}">{t c='global.most_played'}</a></li>
							<li {if $order == 'tr'}class="active"{/if}><a href="{url base=$base strip='o' value='tr'}">{t c='global.top_rated'}</a></li>
							<li {if $order == 'md'}class="active"{/if}><a href="{url base=$base strip='o' value='md'}">{t c='global.most_commented'}</a></li>
							<li {if $order == 'tf'}class="active"{/if}><a href="{url base=$base strip='o' value='tf'}">{t c='global.top_favorites'}</a></li>
						</ul>
					</div>					
				</div>	
				<div class="visible-xs">
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">Filters <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li {if $type == ''}class="active"{/if}><a href="{url base=$base strip='type' value=''}">{t c='global.all'}</a></li>
							<li {if $type == 'public'}class="active"{/if}><a href="{url base=$base strip='type' value='public'}">{t c='global.public'}</a></li>
							<li {if $type == 'private'}class="active"{/if}><a href="{url base=$base strip='type' value='private'}">{t c='global.private'}</a></li>						
							<li class="divider"></li>
							<li {if $timeframe == 'a'}class="active"{/if}><a href="{url base=$base strip='t' value='a'}">{t c='global.all'}</a></li>							
							<li {if $timeframe == 't'}class="active"{/if}><a href="{url base=$base strip='t' value='t'}">{t c='global.added'} {t c='global.today'}</a></li>
							<li {if $timeframe == 'w'}class="active"{/if}><a href="{url base=$base strip='t' value='w'}">{t c='global.added'} {t c='global.this_week'}</a></li>
							<li {if $timeframe == 'm'}class="active"{/if}><a href="{url base=$base strip='t' value='m'}">{t c='global.added'} {t c='global.this_month'}</a></li>
							<li class="divider"></li>				
							<li {if $order == 'bp'}class="active"{/if}><a href="{url base=$base strip='o' value='bp'}">{t c='global.being_played'}</a></li>						
							<li {if $order == 'mr'}class="active"{/if}><a href="{url base=$base strip='o' value='mr'}">{t c='global.most_recent'}</a></li>
							<li {if $order == 'mp'}class="active"{/if}><a href="{url base=$base strip='o' value='mp'}">{t c='global.most_played'}</a></li>
							<li {if $order == 'tr'}class="active"{/if}><a href="{url base=$base strip='o' value='tr'}">{t c='global.top_rated'}</a></li>
							<li {if $order == 'md'}class="active"{/if}><a href="{url base=$base strip='o' value='md'}">{t c='global.most_commented'}</a></li>
							<li {if $order == 'tf'}class="active"{/if}><a href="{url base=$base strip='o' value='tf'}">{t c='global.top_favorites'}</a></li>
						</ul>
					</div>				
				</div>
			</div>
			<div class="pull-right">
				<a class="btn btn-primary" href="{$relative}/upload/game"><span class="hidden-xs"><i class="fa fa-upload"></i> {t c='game.upload_game'}</span><span class="visible-xs"><i class="fa fa-upload"></i></span></a>
			</div>		
			<div class="clearfix"></div>
	</div>
	
	<div class="row">
		<div class="col-md-9 col-sm-8">
            {if $games}
			<div class="well well-sm">
				{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$games_total}</span> {t c='game.games'}.
			</div>			
			<div class="row">
            {section name=i loop=$games}
				<div class="col-sm-6 col-md-4 col-lg-4">
					<div class="well well-sm">
						<a href="{$relative}/game/{$games[i].GID}/{$games[i].title|clean}">
							<div class="thumb-overlay">
								<img src="{$relative}/media/games/tmb/{$games[i].GID}.jpg" title="{$games[i].title|escape:'html'}" alt="{$games[i].title|escape:'html'}"  class="img-responsive {if $games[i].type == 'private'}img-private{/if}"/>
								{if $games[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
							</div>
							<span class="video-title title-truncate m-t-5">{$games[i].title|escape:'html'}</span>
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
				</div>			
            {/section}
			
			</div>
            {else}
			<div class="well well-sm">
				<span class="text-danger">{t c='games.none'}.</span>
			</div>
            {/if}	

			{if $games}
				{if $page_link}
					<div style="text-align: center;" class="visible-xs">
						<ul class="pagination pagination-lg">{$page_link}</ul>
					</div>
				{/if}
			{/if}

		</div>
		
		<div class="col-md-3 col-sm-4">
			<div class="list-group">
				<a href="{url base='games' strip='c' value=''}" {if $category == "0"}class="list-group-item active"{else}class="list-group-item"{/if}>
					{t c='global.all'}
				</a>
				{section name=i loop=$categories}
				<a href="{url base='games/'|cat:$categories[i].slug strip='c' value=''}" {if $category == $categories[i].category_id}class="list-group-item active"{else}class="list-group-item"{/if}>
					{$categories[i].category_name}
				</a>
				{/section}
			</div>			
			<div class="well ad-body">
				<p class="ad-title">{t c='global.sponsors'}</p>
				{insert name=adv assign=adv group='games_right'}
				{if $adv}{$adv}{/if}
			</div>			
		</div>
	</div>
	{if $games}
		{if $page_link}	
			<div style="text-align: center;" class="hidden-xs">
				<ul class="pagination">{$page_link}</ul>
			</div>
		{/if}
	{/if}
	
	<div class="well ad-body">
		<p class="ad-title">{t c='global.sponsors'}</p>
		{insert name=adv assign=adv group='games_bottom'}
		{if $adv}{$adv}{/if}
	</div>	
</div>