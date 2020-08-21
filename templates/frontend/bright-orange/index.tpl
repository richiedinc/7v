<div class="container">

	<div class="well well-filters">
			<div class="pull-left">
				<h4>{translate c='index.videos_being_watched'}</h4>
			</div>
			<div class="pull-right">
				<a class="btn btn-primary" href="{$relative}/videos?o=bw"><span class="hidden-xs"><i class="fa fa-plus"></i> {translate c='index.videos_being_watched_more'}</span><span class="visible-xs"><i class="fa fa-plus"></i></span></a>
			</div>		
			<div class="clearfix"></div>
	</div>

	<div class="row">
		<div class="col-md-9 col-sm-8">
            {if $viewed_videos}
			<div class="row">
            {section name=i loop=$viewed_videos}
				<div class="col-sm-6 col-md-4 col-lg-4">
					<div class="well well-sm">
						<a href="{$relative}/video/{$viewed_videos[i].VID}/{$viewed_videos[i].title|clean}">
							<div class="thumb-overlay">
								<img src="{insert name=thumb_path vid=$viewed_videos[i].VID}/{$viewed_videos[i].thumb}.jpg" title="{$viewed_videos[i].title|escape:'html'}" alt="{$viewed_videos[i].title|escape:'html'}" id="rotate_{$viewed_videos[i].VID}_{$viewed_videos[i].thumbs}_{$viewed_videos[i].thumb}_viewed" class="img-responsive {if $viewed_videos[i].type == 'private'}img-private{/if}"/>
								{if $viewed_videos[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
								{if $viewed_videos[i].hd==1}<div class="hd-text-icon">HD</div>{/if}
								<div class="duration">
									{insert name=duration assign=duration duration=$viewed_videos[i].duration}
									{$duration}
								</div>
							</div>
							<span class="video-title title-truncate m-t-5">{$viewed_videos[i].title|escape:'html'}</span>
						</a>
						<div class="video-added">
							{insert name=time_range assign=addtime time=$viewed_videos[i].addtime}
							{$addtime}
						</div>
						<div class="video-views pull-left">
							{$viewed_videos[i].viewnumber} {if $viewed_videos[i].viewnumber == '1'}{t c='global.view'}{else}{t c='global.views'}{/if}
						</div>
						<div class="video-rating pull-right {if $viewed_videos[i].rate == 0 && $viewed_videos[i].dislikes == 0}no-rating{/if}">
							<i class="fa fa-heart video-rating-heart {if $viewed_videos[i].rate == 0 && $viewed_videos[i].dislikes == 0}no-rating{/if}"></i> <b>{if $viewed_videos[i].rate == 0 && $viewed_videos[i].dislikes == 0}-{else}{$viewed_videos[i].rate}%{/if}</b>
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
						

		</div>
		
		<div class="col-md-3 col-sm-4">
			<div class="well ad-body">
				<p class="ad-title">{t c='global.sponsors'}</p>
				{insert name=adv assign=adv group='index_right'}
				{if $adv}{$adv}{/if}
			</div>			
		</div>
	</div>
	
	<div class="well well-filters">
		<div class="pull-left">
			<h4>{translate c='index.most_recent_videos'}</h4>
		</div>
		<div class="pull-right">
			<a class="btn btn-primary" href="{$relative}/videos?o=mr"><span class="hidden-xs"><i class="fa fa-plus"></i> {translate c='index.most_recent_videos_more'}</span><span class="visible-xs"><i class="fa fa-plus"></i></span></a>
		</div>		
		<div class="clearfix"></div>
	</div>
	
	<div class="row">
		<div class="col-sm-12">
            {if $recent_videos}
			<div class="row">
            {section name=i loop=$recent_videos}
				<div class="col-sm-4 col-md-3 col-lg-3">
					<div class="well well-sm">
						<a href="{$relative}/video/{$recent_videos[i].VID}/{$recent_videos[i].title|clean}">
							<div class="thumb-overlay">
								<img src="{insert name=thumb_path vid=$recent_videos[i].VID}/{$recent_videos[i].thumb}.jpg" title="{$recent_videos[i].title|escape:'html'}" alt="{$recent_videos[i].title|escape:'html'}" id="rotate_{$recent_videos[i].VID}_{$recent_videos[i].thumbs}_{$recent_videos[i].thumb}_recent" class="img-responsive {if $recent_videos[i].type == 'private'}{/if}"/>
								{if $recent_videos[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
								{if $recent_videos[i].hd==1}<div class="hd-text-icon">HD</div>{/if}
								<div class="duration">
									{insert name=duration assign=duration duration=$recent_videos[i].duration}
									{$duration}
								</div>
							</div>
							<span class="video-title title-truncate m-t-5">{$recent_videos[i].title|escape:'html'}</span>
						</a>
						<div class="video-added">
							{insert name=time_range assign=addtime time=$recent_videos[i].addtime}
							{$addtime}
						</div>
						<div class="video-views pull-left">
							{$recent_videos[i].viewnumber} {if $recent_videos[i].viewnumber == '1'}{t c='global.view'}{else}{t c='global.views'}{/if}
						</div>
						<div class="video-rating pull-right {if $recent_videos[i].rate == 0 && $recent_videos[i].dislikes == 0}no-rating{/if}">
							<i class="fa fa-heart video-rating-heart {if $recent_videos[i].rate == 0 && $recent_videos[i].dislikes == 0}no-rating{/if}"></i> <b>{if $recent_videos[i].rate == 0 && $recent_videos[i].dislikes == 0}-{else}{$recent_videos[i].rate}%{/if}</b>
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
		</div>
	</div>
	
	<div class="well ad-body">
		<p class="ad-title">{t c='global.sponsors'}</p>
		{insert name=adv assign=adv group='index_bottom'}
		{if $adv}{$adv}{/if}
	</div>
	
</div>