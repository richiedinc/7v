<div class="container">
	<div class="row">
		<div class="col-md-4">
			<div class="panel panel-default">
				<div class="panel-heading">
					{t c='global.SUBSCRIPTIONS'}
				</div>	
				<div class="panel-body">
					<ul class="list-unstyled m-b-0">
						<li>
							{if $username == 'all'}
								<span class="text-white">{t c='global.all'}</span>
							{else}
								<a href="{$relative}/feeds">{t c='global.all'}</a>
							{/if}
						</li>
						{section name=i loop=$subscriptions}
							<li class="overflow-hidden">
								{if $username == $subscriptions[i].username}
									<span class="text-white">{$subscriptions[i].username|escape:'html'}</span>
								{else}
									<a href="{url base='feeds' strip='u' value=$subscriptions[i].username}">{$subscriptions[i].username|escape:'html'}</a>
								{/if}
							</li>
						{/section}
					</ul>				
				</div>				
			</div>		

		</div>
		<div class="col-md-8">
			<div class="panel panel-default">
				<div class="panel-heading">
					{t c='feeds.activity'}
				</div>
					<div class="btn-group m-t-15 m-l-15">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">{if $table == 'all'}{t c='global.all'}{elseif $table == 'albums'}{t c='global.albums'}{elseif $table == 'blogs'}{t c='menu.blogs'}{elseif $table == 'games'}{t c='global.games'}{else}{t c='global.videos'}{/if} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							 <li {if $table == 'all'}class="active"{/if}><a href="{url base='feeds' strip='t' value='all'}">{t c='global.all'}</a></li>
							 <li {if $table == 'albums'}class="active"{/if}><a href="{url base='feeds' strip='t' value='albums'}">{t c='global.albums'}</a></li>
							 <li {if $table == 'blogs'}class="active"{/if}><a href="{url base='feeds' strip='t' value='blogs'}">{t c='menu.blogs'}</a></li>
							 <li {if $table == 'games'}class="active"{/if}><a href="{url base='feeds' strip='t' value='games'}">{t c='global.games'}</a></li>
							 <li {if $table == 'videos'}class="active"{/if}><a href="{url base='feeds' strip='t' value='videos'}">{t c='global.videos'}</a></li>
						</ul>
					</div>				
				<div class="panel-body">
					<div class="clearfix"></div>
					{if $feeds}
						<div class="m-b--5">					
							<div class="row">
							{section name=i loop=$feeds}
								<div class="col-xs-12 m-b-5 overflow-hidden">
									{if $feeds[i].type == 'video'}
										<span class="text-white"><i class="fa fa-film"></i></span>
									{elseif $feeds[i].type == 'album'}
										<span class="text-white"><i class="fa fa-camera"></i></span>
									{elseif $feeds[i].type == 'photo'}
										<span class="text-white"><i class="fa fa-photo"></i></span>
									{elseif $feeds[i].type == 'game'}
										<span class="text-white"><i class="fa fa-gamepad"></i></span>
									{elseif $feeds[i].type == 'blog'}
										<span class="text-white"><i class="fa fa-pencil"></i></span>
									{/if}
									&nbsp;
									<span class="text-white">{$feeds[i].time|date_format:"%m/%d/%y"}</span> &nbsp;<a href="{$relative}/user/{$feeds[i].data.username}">{$feeds[i].data.username}</a>&nbsp;
									{if $feeds[i].type == 'video'}
									{t c='feeds.has_uploaded'} &nbsp;<a href="{$relative}/video/{$feeds[i].data.VID}/{$feeds[i].data.title|clean}">{t c='feeds.new_video'}</a>.
									{elseif $feeds[i].type == 'album'}
									{t c='feeds.has_created'} &nbsp;<a href="{$relative}/album/{$feeds[i].data.AID}/{$feeds[i].data.name|clean}">{t c='feeds.new_album'}</a>.
									{elseif $feeds[i].type == 'game'}
									{t c='feeds.has_uploaded'} &nbsp;<a href="{$relative}/game/{$feeds[i].data.GID}/{$feeds[i].data.title|clean}">{t c='feeds.new_game'}</a>.
									{elseif $feeds[i].type == 'blog'}
									{t c='feeds.has_created'} &nbsp;<a href="{$relative}/blog/{$feeds[i].data.BID}/{$feeds[i].data.title|clean}">{t c='feeds.new_blog'}</a>.
									{/if}
								</div>				
							{/section}
							</div>
						</div>
						{if $page_link}
							<div style="text-align: center;" class="visible-xs">
								<ul class="pagination pagination-lg">{$page_link}</ul>
							</div>
							<div style="text-align: center;" class="hidden-xs">
								<ul class="pagination">{$page_link}</ul>
							</div>
						{/if}
					{else}
						<span class="text-danger">{t c='feeds.none'}.</span>
					{/if}
				</div>				
			</div>	
		</div>
	</div>
</div>

