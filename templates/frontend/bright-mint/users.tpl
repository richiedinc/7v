<div class="container">

	<div class="well well-filters">
			<div class="pull-left">
				<h4>{t c='global.users'}</h4>
			</div>
			<div class="pull-left m-l-20">
				<div class="hidden-xs">
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">{if $interest == ''}{t c='global.interested'}{elseif $interest == 'Guys'}{t c='global.guys'}{elseif $interest == 'Girls'}{t c='global.girls'}{else}{t c='global.guys_girls'}{/if} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li {if $interest == ''}class="active"{/if}><a href="{url base='users' strip='i' value=''}">{t c='global.any'}</a></li>
							<li {if $interest == 'Guys'}class="active"{/if}><a href="{url base='users' strip='i' value='Guys'}">{t c='global.guys'}</a></li>
							<li {if $interest == 'Girls'}class="active"{/if}><a href="{url base='users' strip='i' value='Girls'}">{t c='global.girls'}</a></li>
							<li {if $interest == 'Guys + Girls'}class="active"{/if}><a href="{url base='users' strip='i' value='Guys%2BGirls'}">{t c='global.guys_girls'}</a></li>
						</ul>
					</div>

					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">{if $avatar == ''}{t c='global.avatar'}{elseif $avatar == 'yes'}{t c='avatar.yes'}{else}{t c='avatar.no'}{/if} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li {if $avatar == ''}class="active"{/if}><a href="{url base='users' strip='a' value=''}">{t c='global.any'}</a></li>							
							<li {if $avatar == 'yes'}class="active"{/if}><a href="{url base='users' strip='a' value='yes'}">{t c='avatar.yes'}</a></li>
							<li {if $avatar == 'no'}class="active"{/if}><a href="{url base='users' strip='a' value='no'}">{t c='avatar.no'}</a></li>
						</ul>
					</div>					

					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">{if $order == 'mr'}{t c='global.most_recent'}{elseif $order == 'mv'}{t c='global.most_viewed'}{elseif $order == 'ma'}{t c='global.most_active'}{elseif $order == 'tr'}{t c='global.top_rated'}{elseif $order == 'mp'}{t c='global.most_popular'}{else}{t c='global.online_now'}{/if} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li {if $order == 'mr'}class="active"{/if}><a href="{url base='users' strip='o' value='mr'}">{t c='global.most_recent'}</a></li>
							<li {if $order == 'mv'}class="active"{/if}><a href="{url base='users' strip='o' value='mv'}">{t c='global.most_viewed'}</a></li>
							<li {if $order == 'ma'}class="active"{/if}><a href="{url base='users' strip='o' value='ma'}">{t c='global.most_active'}</a></li>
							<li {if $order == 'mp'}class="active"{/if}><a href="{url base='users' strip='o' value='mp'}">{t c='global.most_popular'}</a></li>
							<li {if $order == 'tr'}class="active"{/if}><a href="{url base='users' strip='o' value='tr'}">{t c='global.top_rated'}</a></li>
							<li {if $order == 'on'}class="active"{/if}><a href="{url base='users' strip='o' value='on'}">{t c='global.online_now'}</a></li>
						</ul>
							
					</div>		
				</div>	
				<div class="visible-xs">
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">Filters <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li {if $interest == ''}class="active"{/if}><a href="{url base='users' strip='i' value=''}">{t c='global.any'}</a></li>
							<li {if $interest == 'Guys'}class="active"{/if}><a href="{url base='users' strip='i' value='Guys'}">{t c='global.guys'}</a></li>
							<li {if $interest == 'Girls'}class="active"{/if}><a href="{url base='users' strip='i' value='Girls'}">{t c='global.girls'}</a></li>
							<li {if $interest == 'Guys + Girls'}class="active"{/if}><a href="{url base='users' strip='i' value='Guys%2BGirls'}">{t c='global.guys_girls'}</a></li>
							<li class="divider"></li>
							<li {if $avatar == ''}class="active"{/if}><a href="{url base='users' strip='a' value=''}">{t c='global.any'}</a></li>							
							<li {if $avatar == 'yes'}class="active"{/if}><a href="{url base='users' strip='a' value='yes'}">{t c='avatar.yes'}</a></li>
							<li {if $avatar == 'no'}class="active"{/if}><a href="{url base='users' strip='a' value='no'}">{t c='avatar.no'}</a></li>
							<li class="divider"></li>				
							<li {if $order == 'mr'}class="active"{/if}><a href="{url base='users' strip='o' value='mr'}">{t c='global.most_recent'}</a></li>
							<li {if $order == 'mv'}class="active"{/if}><a href="{url base='users' strip='o' value='mv'}">{t c='global.most_viewed'}</a></li>
							<li {if $order == 'ma'}class="active"{/if}><a href="{url base='users' strip='o' value='ma'}">{t c='global.most_active'}</a></li>
							<li {if $order == 'mp'}class="active"{/if}><a href="{url base='users' strip='o' value='mp'}">{t c='global.most_popular'}</a></li>
							<li {if $order == 'tr'}class="active"{/if}><a href="{url base='users' strip='o' value='tr'}">{t c='global.top_rated'}</a></li>
							<li {if $order == 'on'}class="active"{/if}><a href="{url base='users' strip='o' value='on'}">{t c='global.online_now'}</a></li>
						</ul>
					</div>				
				</div>
			</div>
			<div class="pull-right">
				<a class="btn btn-primary" href="{$relative}/signup"><span class="hidden-xs"><i class="glyphicon glyphicon-plus"></i> {t c='user.new'}</span><span class="visible-xs"><i class="glyphicon glyphicon-plus"></i></span></a>
			</div>		
			<div class="clearfix"></div>
	</div>
	
	<div class="row">
		<div class="col-md-9 col-sm-8">
            {if $users}
			<div class="well well-sm">
				{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$users_total}</span> {t c='user.users'}.
			</div>			
			<div class="row">
			   {section name=i loop=$users}
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-3">
						<div class="well well-sm">
							<a href="{$relative}/user/{$users[i].username}">
								<img src="{$relative}/media/users/{if $users[i].photo == ''}nopic-{$users[i].gender}.gif{else}{$users[i].photo}{/if}" alt="{$users[i].username}'s avatar" class="img-responsive"/>
								<span class="video-title title-truncate m-t-5">{$users[i].username|escape:'html'}</span>
							</a>
						</div>				
					</div>			
				{/section}
				</div>
            {else}
			<div class="well well-sm">
				<span class="text-danger">{t c='users.none'}.</span>
			</div>
            {/if}	

			{if $users}
				{if $page_link}			
					<div style="text-align: center;" class="visible-xs">
						<ul class="pagination pagination-lg">{$page_link}</ul>
					</div>
				{/if}
			{/if}

		</div>
		
		<div class="col-md-3 col-sm-4">
			<div class="list-group">
				<a href="{url base='users' strip='g' value=''}" {if $gender == ''} class="list-group-item active"{else}class="list-group-item"{/if}>{t c='global.any'}</a></li>							
				<a href="{url base='users' strip='g' value='Male'}"  {if $gender == 'Male'}class="list-group-item active"{else}class="list-group-item"{/if}>{t c='global.male'}</a></li>
				<a href="{url base='users' strip='g' value='Female'}"  {if $gender == 'Female'}class="list-group-item active"{else}class="list-group-item"{/if}>{t c='global.female'}</a></li>	
			</div>
			<div class="well ad-body">
				<p class="ad-title">{t c='global.sponsors'}</p>
				{insert name=adv assign=adv group='users_right'}
				{if $adv}{$adv}{/if}
			</div>			
		</div>
	</div>
	{if $users}
		{if $page_link}	
			<div style="text-align: center;" class="hidden-xs">
				<ul class="pagination">{$page_link}</ul>
			</div>
		{/if}
	{/if}
	
	<div class="well ad-body">
		<p class="ad-title">{t c='global.sponsors'}</p>
		{insert name=adv assign=adv group='users_bottom'}
		{if $adv}{$adv}{/if}
	</div>	
</div>