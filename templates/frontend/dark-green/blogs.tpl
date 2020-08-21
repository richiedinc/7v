<div class="container">

	<div class="well well-filters">
			<div class="pull-left">
				<h4>{t c='menu.blogs'}</h4>
			</div>
			<div class="pull-left m-l-20">
				<div class="hidden-xs">
					
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">{if $timeframe == 'a'}{t c='global.timeline'}{elseif $timeframe == 't'}{t c='global.added'} {t c='global.today'}{elseif $timeframe == 'w'}{t c='global.added'} {t c='global.this_week'}{else}{t c='global.added'} {t c='global.this_month'}{/if} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li {if $timeframe == 'a'}class="active"{/if}><a href="{url base='blogs' strip='t' value='a'}">{t c='global.all'}</a></li>							
							<li {if $timeframe == 't'}class="active"{/if}><a href="{url base='blogs' strip='t' value='t'}">{t c='global.added'} {t c='global.today'}</a></li>
							<li {if $timeframe == 'w'}class="active"{/if}><a href="{url base='blogs' strip='t' value='w'}">{t c='global.added'} {t c='global.this_week'}</a></li>
							<li {if $timeframe == 'm'}class="active"{/if}><a href="{url base='blogs' strip='t' value='m'}">{t c='global.added'} {t c='global.this_month'}</a></li>
						</ul>
					</div>					

					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">{if $order == 'bw'}{t c='global.being_watched'}{elseif $order == 'mr'}{t c='global.most_recent'}{elseif $order == 'mv'}{t c='global.most_viewed'}{elseif $order == 'tr'}{t c='global.top_rated'}{elseif $order == 'md'}{t c='global.most_commented'}{else}{t c='global.top_favorites'}{/if} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li {if $order == 'mr'}class="active"{/if}><a href="{url base='blogs' strip='o' value='mr'}">{t c='global.most_recent'}</a></li>
							<li {if $order == 'mv'}class="active"{/if}><a href="{url base='blogs' strip='o' value='mv'}">{t c='global.most_viewed'}</a></li>
							<li {if $order == 'md'}class="active"{/if}><a href="{url base='blogs' strip='o' value='md'}">{t c='global.most_commented'}</a></li>
						</ul>
					</div>					
				</div>	
				<div class="visible-xs">
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">Filters <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li {if $timeframe == 'a'}class="active"{/if}><a href="{url base='blogs' strip='t' value='a'}">{t c='global.all'}</a></li>							
							<li {if $timeframe == 't'}class="active"{/if}><a href="{url base='blogs' strip='t' value='t'}">{t c='global.added'} {t c='global.today'}</a></li>
							<li {if $timeframe == 'w'}class="active"{/if}><a href="{url base='blogs' strip='t' value='w'}">{t c='global.added'} {t c='global.this_week'}</a></li>
							<li {if $timeframe == 'm'}class="active"{/if}><a href="{url base='blogs' strip='t' value='m'}">{t c='global.added'} {t c='global.this_month'}</a></li>
							<li class="divider"></li>				
					
							<li {if $order == 'mr'}class="active"{/if}><a href="{url base='blogs' strip='o' value='mr'}">{t c='global.most_recent'}</a></li>
							<li {if $order == 'mv'}class="active"{/if}><a href="{url base='blogs' strip='o' value='mv'}">{t c='global.most_viewed'}</a></li>
							<li {if $order == 'md'}class="active"{/if}><a href="{url base='blogs' strip='o' value='md'}">{t c='global.most_commented'}</a></li>

						</ul>
					</div>				
				</div>
			</div>
			<div class="pull-right">
				<a class="btn btn-primary" href="{$relative}/blog/add"><span class="hidden-xs"><i class="fa fa-pencil"></i> {t c='blog.create_new'}</span><span class="visible-xs"><i class="fa fa-pencil"></i></span></a>
			</div>		
			<div class="clearfix"></div>
	</div>
	
	<div class="row">
		<div class="col-md-9 col-sm-8">
            {if $blogs}
			<div class="well well-sm">
				{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$blogs_total}</span> {t c='blog.blog_art'}.
			</div>			
			<div class="row">
            {section name=i loop=$blogs}
				<div class="col-md-12">
					<div class="panel panel-default">
         
						<div class="panel-heading">
							<div class="pull-left">
								<a href="{$relative}/user/{$blogs[i].username}"><img class="small-avatar" src="{$relative}/media/users/{if $blogs[i].photo == ''}nopic-{$blogs[i].gender}.gif{else}{$blogs[i].photo}{/if}" /><span>{$blogs[i].username|truncate:25:"..."}</span></a>
							</div>
							<div class="pull-right">					
								{insert name=time_range assign=addtime time=$blogs[i].addtime}
								{$blogs[i].total_views} {t c='global.views'} <strong>&middot;</strong> {$addtime}								
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="panel-body">
							<div class="blog_header">
								<a href="{$relative}/blog/{$blogs[i].BID}/{$blogs[i].title|clean}">{$blogs[i].title|escape:'html'}</a>							
							</div>
							
							<div class="blog_content">
								{$blogs[i].content|nl2br}
							</div>
						</div>
						
						<div class="panel-footer">
							<i class="fa fa-comment"></i> <a href="{$relative}/blog/{$blogs[i].BID}/{$blogs[i].title|clean}">{$blogs[i].total_comments}</a> <strong>&middot;</strong>
							<a href="{$relative}/blog/{$blogs[i].BID}/{$blogs[i].title|clean}">{t c='blog.post_comment'}</a>                                
						</div>

						
					</div>				
				</div>			
            {/section}
			
			</div>
            {else}
			<div class="well well-sm">
				<span class="text-danger">{t c='blog.none'}.</span>
			</div>
            {/if}	

			{if $blogs}		
				<div style="text-align: center;" class="visible-xs">
					<ul class="pagination pagination-lg">{$page_link}</ul>
				</div>
			{/if}

		</div>
		
		<div class="col-md-3 col-sm-4">
			<div class="well ad-body">
				<p class="ad-title">{t c='global.sponsors'}</p>
				{insert name=adv assign=adv group='blogs_right'}
				{if $adv}{$adv}{/if}
			</div>			
		</div>
	</div>
	{if $blogs}
		{if $page_link}
			<div style="text-align: center;" class="hidden-xs">
				<ul class="pagination">{$page_link}</ul>
			</div>
		{/if}
	{/if}
	
	<div class="well ad-body">
		<p class="ad-title">{t c='global.sponsors'}</p>
		{insert name=adv assign=adv group='blogs_bottom'}
		{if $adv}{$adv}{/if}
	</div>	
</div>