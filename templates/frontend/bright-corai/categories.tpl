<div class="container">
	<div class="well well-filters">
			<div class="pull-left">
				<h4>{t c='menu.categories'}</h4>
			</div>
			<div class="pull-left m-l-20">
				{if $video_module+$photo_module+$game_module > "1"}
				<div class="btn-group">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">{if $section == 'v'}{t c='global.videos'}{elseif $section == 'a'}{t c='global.albums'}{else}{t c='global.games'}{/if} <span class="caret"></span></button>
					<ul class="dropdown-menu">
						{if $video_module == '1'}<li {if $section == 'v'}class="active"{/if}><a href="{url base='categories' strip='s' value=''}">{t c='global.videos'}</a></li>{/if}
						{if $photo_module == '1'}<li {if $section == 'a'}class="active"{/if}><a href="{url base='categories' strip='s' value='a'}">{t c='global.albums'}</a></li>{/if}
						{if $game_module == '1'}<li {if $section == 'g'}class="active"{/if}><a href="{url base='categories' strip='s' value='g'}">{t c='global.games'}</a></li>{/if}
					</ul>
				</div>
				{/if}
			</div>
			<div class="clearfix"></div>
	</div>
	
	<div class="row">
		<div class="col-md-9 col-sm-8">
		{if $section == "a" &&  $photo_module == '1'}
            {if $categories}
			<div class="row">
            {section name=i loop=$categories}
				<div class="col-sm-6 col-md-4 col-lg-4 m-b-20">
					<a href="{$relative}/albums/{$categories[i].slug}">
						<div class="thumb-overlay">
							<img src="{$relative}/media/categories/album/{$categories[i].CID}.jpg" title="{$categories[i].name|escape:'html'}" alt="{$categories[i].name|escape:'html'}" class="img-responsive"/>
							<div class="category-title m-t-5">
								<div class="pull-left title-truncate">
									{$categories[i].name|escape:'html'}
								</div>
								<div class="pull-right">
									<span class="badge">{$albums[i].num_rows}</span>
								</div>
							</div>							
						</div>
					</a>
				</div>			
            {/section}
			</div>
            {/if}
		{/if}

		{if $section == "v" &&  $video_module == '1'}
            {if $categories}
			<div class="row">
            {section name=i loop=$categories}
				<div class="col-sm-6 col-md-4 col-lg-4 m-b-20">
					<a href="{$relative}/videos/{$categories[i].slug}">
						<div class="thumb-overlay">
							<img src="{$relative}/media/categories/video/{$categories[i].CHID}.jpg" title="{$categories[i].name|escape:'html'}" alt="{$categories[i].name|escape:'html'}" class="img-responsive"/>
							<div class="category-title m-t-5">
								<div class="pull-left title-truncate">
									{$categories[i].name|escape:'html'}
								</div>
								<div class="pull-right">
									<span class="badge">{$videos[i].num_rows}</span>
								</div>
							</div>							
						</div>
					</a>
				</div>			
            {/section}
			</div>
            {/if}
		{/if}

		{if $section == "g" &&  $game_module == '1'}
            {if $categories}
			<div class="row">
            {section name=i loop=$categories}
				<div class="col-sm-6 col-md-4 col-lg-4 m-b-20">
					<a href="{$relative}/games/{$categories[i].slug}">
						<div class="thumb-overlay">
							<img src="{$relative}/media/categories/game/{$categories[i].category_id}.jpg" title="{$categories[i].category_name|escape:'html'}" alt="{$categories[i].category_name|escape:'html'}" class="img-responsive"/>
							<div class="category-title m-t-5">
								<div class="pull-left title-truncate">
									{$categories[i].category_name|escape:'html'}
								</div>
								<div class="pull-right">
									<span class="badge">{$games[i].num_rows}</span>
								</div>
							</div>							
						</div>
					</a>
				</div>				
            {/section}
			</div>
            {/if}
		{/if}		
		
		</div>
		<div class="col-md-3 col-sm-4">
			<div class="well ad-body">
				<p class="ad-title">{t c='global.sponsors'}</p>
				{insert name=adv assign=adv group='categories_right'}
				{if $adv}{$adv}{/if}
			</div>			
		</div>
	</div>
	<div class="well ad-body">
		<p class="ad-title">{t c='global.sponsors'}</p>
		{insert name=adv assign=adv group='categories_bottom'}
		{if $adv}{$adv}{/if}
	</div>	
</div>