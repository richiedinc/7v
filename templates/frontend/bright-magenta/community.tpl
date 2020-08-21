<div class="container">

	<div class="row">
		<div class="col-md-9 col-sm-8">

		{if $popular_users}
			<div class="well well-filters">
					<div class="pull-left">
						<h4>{t c='community.most_popular'}</h4>
					</div>
					<div class="pull-right">
						<a class="btn btn-primary" href="{$relative}/users?o=mp"><span class="hidden-xs"><i class="fa fa-plus"></i> {t c='global.view_more'}</span><span class="visible-xs"><i class="fa fa-plus"></i></span></a>
					</div>		
					<div class="clearfix"></div>
			</div>
			<div class="row">
           {section name=i loop=$popular_users max=8}
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-3 {if $smarty.section.i.index>5}hidden-xs hidden-sm{/if}">
					<div class="well well-sm">
						<a href="{$relative}/user/{$popular_users[i].username}">
							<img src="{$relative}/media/users/{if $popular_users[i].photo == ''}nopic-{$popular_users[i].gender}.gif{else}{$popular_users[i].photo}{/if}" alt="{$popular_users[i].username}'s avatar" class="img-responsive"/>
							<span class="video-title title-truncate m-t-5">{$popular_users[i].username|escape:'html'}</span>
						</a>
					</div>				
				</div>			
            {/section}
			</div>
        {/if}

		{if $female_users}
			<div class="well well-filters">
					<div class="pull-left">
						<h4>{t c='community.new_female'}</h4>
					</div>
					<div class="pull-right">
						<a class="btn btn-primary" href="{$relative}/users?o=mr&amp;g=Female"><span class="hidden-xs"><i class="fa fa-plus"></i> {t c='global.view_more'}</span><span class="visible-xs"><i class="fa fa-plus"></i></span></a>
					</div>		
					<div class="clearfix"></div>
			</div>
			<div class="row">
           {section name=i loop=$female_users max=8}
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-3 {if $smarty.section.i.index>5}hidden-xs hidden-sm{/if}">
					<div class="well well-sm">
						<a href="{$relative}/user/{$female_users[i].username}">
							<img src="{$relative}/media/users/{if $female_users[i].photo == ''}nopic-Female.gif{else}{$female_users[i].photo}{/if}" alt="{$female_users[i].username}'s avatar" class="img-responsive"/>
							<span class="video-title title-truncate m-t-5">{$female_users[i].username|escape:'html'}</span>
						</a>
					</div>				
				</div>			
            {/section}
			</div>
        {/if}
		 <div class="clearfix"></div>

		{if $male_users}
			<div class="well well-filters">
					<div class="pull-left">
						<h4>{t c='community.new_male'}</h4>
					</div>
					<div class="pull-right">
						<a class="btn btn-primary" href="{$relative}/users?o=mr&amp;g=Male"><span class="hidden-xs"><i class="fa fa-plus"></i> {t c='global.view_more'}</span><span class="visible-xs"><i class="fa fa-plus"></i></span></a>
					</div>		
					<div class="clearfix"></div>
			</div>
			<div class="row">
           {section name=i loop=$male_users max=8}
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-3 {if $smarty.section.i.index>5}hidden-xs hidden-sm{/if}">
					<div class="well well-sm">
						<a href="{$relative}/user/{$male_users[i].username}">
							<img src="{$relative}/media/users/{if $male_users[i].photo == ''}nopic-Male.gif{else}{$male_users[i].photo}{/if}" alt="{$male_users[i].username}'s avatar" class="img-responsive"/>
							<span class="video-title title-truncate m-t-5">{$male_users[i].username|escape:'html'}</span>
						</a>
					</div>				
				</div>			
            {/section}
			</div>
        {/if}
		 <div class="clearfix"></div>		 
		 
		</div>
		
		<div class="col-md-3 col-sm-4">
			<div class="well ad-body">
				<p class="ad-title">{t c='global.sponsors'}</p>
				{insert name=adv assign=adv group='community_right'}
				{if $adv}{$adv}{/if}
			</div>			
		</div>
	</div>

	
	<div class="well ad-body">
		<p class="ad-title">{t c='global.sponsors'}</p>
		{insert name=adv assign=adv group='community_bottom'}
		{if $adv}{$adv}{/if}
	</div>	
</div>