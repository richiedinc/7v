<div class="container">

	<div class="well well-filters">
			<div class="pull-left">
				<h4>{t c='global.videos'}</h4>
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
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">{if $order == 'bw'}{t c='global.being_watched'}{elseif $order == 'mr'}{t c='global.most_recent'}{elseif $order == 'mv'}{t c='global.most_viewed'}{elseif $order == 'tr'}{t c='global.top_rated'}{elseif $order == 'md'}{t c='global.most_commented'}{elseif $order == 'tf'}{t c='global.top_favorites'}{else}{t c='global.longest'}{/if} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li {if $order == 'bw'}class="active"{/if}><a href="{url base=$base strip='o' value='bw'}">{t c='global.being_watched'}</a></li>						
							<li {if $order == 'mr'}class="active"{/if}><a href="{url base=$base strip='o' value='mr'}">{t c='global.most_recent'}</a></li>
							<li {if $order == 'mv'}class="active"{/if}><a href="{url base=$base strip='o' value='mv'}">{t c='global.most_viewed'}</a></li>
							<li {if $order == 'md'}class="active"{/if}><a href="{url base=$base strip='o' value='md'}">{t c='global.most_commented'}</a></li>
							<li {if $order == 'tr'}class="active"{/if}><a href="{url base=$base strip='o' value='tr'}">{t c='global.top_rated'}</a></li>							
							<li {if $order == 'tf'}class="active"{/if}><a href="{url base=$base strip='o' value='tf'}">{t c='global.top_favorites'}</a></li>
							<li {if $order == 'lg'}class="active"{/if}><a href="{url base=$base strip='o' value='lg'}">{t c='global.longest'}</a></li>
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
							<li {if $order == 'bw'}class="active"{/if}><a href="{url base=$base strip='o' value='bw'}">{t c='global.being_watched'}</a></li>						
							<li {if $order == 'mr'}class="active"{/if}><a href="{url base=$base strip='o' value='mr'}">{t c='global.most_recent'}</a></li>
							<li {if $order == 'mv'}class="active"{/if}><a href="{url base=$base strip='o' value='mv'}">{t c='global.most_viewed'}</a></li>
							<li {if $order == 'md'}class="active"{/if}><a href="{url base=$base strip='o' value='md'}">{t c='global.most_commented'}</a></li>
							<li {if $order == 'tr'}class="active"{/if}><a href="{url base=$base strip='o' value='tr'}">{t c='global.top_rated'}</a></li>							
							<li {if $order == 'tf'}class="active"{/if}><a href="{url base=$base strip='o' value='tf'}">{t c='global.top_favorites'}</a></li>
							<li {if $order == 'lg'}class="active"{/if}><a href="{url base=$base strip='o' value='lg'}">{t c='global.longest'}</a></li>
						</ul>
					</div>				
				</div>
			</div>
			<div class="pull-right">
				<a class="btn btn-primary" href="{$relative}/upload/video"><span class="hidden-xs"><i class="fa fa-upload"></i> {t c='videos.upload'}</span><span class="visible-xs"><i class="fa fa-upload"></i></span></a>
			</div>		
			<div class="clearfix"></div>
	</div>
	
	<div class="row">
		<div class="col-md-9 col-sm-8">
            {if $videos}
			<div class="well well-sm">
				{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$videos_total}</span> {t c='videos.videos'}.
			</div>			
			<div class="row">
            {section name=i loop=$videos}
				<div class="col-sm-6 col-md-4 col-lg-4">
					<div class="well well-sm">
						<a href="{$relative}/video/{$videos[i].VID}/{$videos[i].title|clean}">
							<div class="thumb-overlay">
								<img src="{insert name=thumb_path vid=$videos[i].VID}/{$videos[i].thumb}.jpg" title="{$videos[i].title|escape:'html'}" alt="{$videos[i].title|escape:'html'}" id="rotate_{$videos[i].VID}_{$videos[i].thumbs}_{$videos[i].thumb}" class="img-responsive {if $videos[i].type == 'private'}img-private{/if}"/>
								{if $videos[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
								{if $videos[i].hd==1}<div class="hd-text-icon">HD</div>{/if}
								<div class="duration">
									{insert name=duration assign=duration duration=$videos[i].duration}
									{$duration}
								</div>
							</div>
							<span class="video-title title-truncate m-t-5">{$videos[i].title|escape:'html'}</span>
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
				</div>			
            {/section}
			
			</div>
            {else}
			<div class="well well-sm">
				<span class="text-danger">{t c='videos.no_videos_found'}.</span>
			</div>
            {/if}	

			{if $videos}
				{if $page_link}			
					<div style="text-align: center;" class="visible-xs">
						<ul class="pagination pagination-lg">{$page_link}</ul>
					</div>
				{/if}
			{/if}

		</div>
		
		<div class="col-md-3 col-sm-4">
			<div class="list-group">
				<a href="{url base='videos' strip='c' value=''}" {if $category == "0"}class="list-group-item active"{else}class="list-group-item"{/if}>
					{t c='global.all'}
				</a>
				{section name=i loop=$categories}
				<a href="{url base='videos/'|cat:$categories[i].slug strip='c' value=''}" {if $category == $categories[i].CHID}class="list-group-item active"{else}class="list-group-item"{/if}>
					{$categories[i].name}
				</a>
				{/section}
			</div>
			<div class="well ad-body">
				<p class="ad-title">{t c='global.sponsors'}</p>
				{insert name=adv assign=adv group='videos_right'}
				{if $adv}{$adv}{/if}
			</div>			
		</div>
	</div>
	{if $videos}
		{if $page_link}	
			<div style="text-align: center;" class="hidden-xs">
				<ul class="pagination">{$page_link}</ul>
			</div>
		{/if}
	{/if}
	
	<div class="well ad-body">
		<p class="ad-title">{t c='global.sponsors'}</p>
		{insert name=adv assign=adv group='videos_bottom'}
		{if $adv}{$adv}{/if}
	</div>	
</div>