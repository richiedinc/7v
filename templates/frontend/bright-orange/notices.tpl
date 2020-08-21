<div class="container">

	<div class="well well-md">
				<h4>{$site_name|escape:'html'} {t c='global.notices'}</h4>
	</div>
	
	<div class="row">
		<div class="col-md-9 col-sm-8">
            {if $notices}
			<div class="well well-sm">
				{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$notices_total}</span> {t c='notice.notices'}.
			</div>			
			<div class="row">
            {section name=i loop=$notices}
				<div class="col-md-12">
					<div class="panel panel-default">
         
						<div class="panel-heading">
							<div class="pull-left">
								<a href="{$relative}/user/{$notices[i].username}"><img class="small-avatar" src="{$relative}/media/users/{if $notices[i].photo == ''}nopic-{$notices[i].gender}.gif{else}{$notices[i].photo}{/if}" /><span>{$notices[i].username}</span></a>
							</div>
							<div class="pull-right">
								{insert name=time_range assign=addtime time=$notices[i].addtime}
								{$addtime}							
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="panel-body">
							<div class="blog_header">
								<a href="{$relative}/notice/{$notices[i].NID}/{$notices[i].title|clean}">{$notices[i].title|escape:'html'}</a>
							</div>
							
							<div class="blog_content">
								{$notices[i].content|nl2br}
							</div>
						</div>
						
						<div class="panel-footer">
							<i class="fa fa-comment"></i> <a href="{$relative}/notice/{$notices[i].NID}/{$notices[i].title|clean}">{$notices[i].total_comments}</a> <strong>&middot;</strong>
							<a href="{$relative}/notice/{$notices[i].NID}/{$notices[i].title|clean}">{t c='blog.post_comment'}</a>                                
						</div>

						
					</div>				
				</div>			
            {/section}
			
			</div>
            {else}
			<div class="well well-sm">
				<span class="text-danger">{t c='notice.none'}.</span>
			</div>
            {/if}	

			{if $notices && $page_link}		
				<div style="text-align: center;" class="visible-xs">
					<ul class="pagination pagination-lg">{$page_link}</ul>
				</div>
			{/if}

		</div>
		
		<div class="col-md-3 col-sm-4">
			<div class="list-group">
				<a href="{url base='notices' strip='c' value=""}" {if $category == "0" || !$category}class="list-group-item active"{else}class="list-group-item"{/if}>
					{t c='global.all'}
				</a>
				{section name=i loop=$categories}
				<a href="{url base='notices' strip='c' value=$categories[i].category_id}" {if $category == $categories[i].category_id}class="list-group-item active"{else}class="list-group-item"{/if}>
					{$categories[i].name|escape:'html'}
				</a>
				{/section}
			</div>
			<div class="list-group">
				<a href="{url base='notices' strip='t' value=""}" {if !$timestamp}class="list-group-item active"{else}class="list-group-item"{/if}>
					{t c='global.all'}
				</a>
				{section name=i loop=$arhive}
				<a href="{url base='notices' strip='t' value=$arhive[i]}" {if $timestamp == $arhive[i]}class="list-group-item active"{else}class="list-group-item"{/if}>
					{$arhive[i]|date_format:"%B %Y"}
				</a>
				{/section}
			</div>			
		</div>
	</div>
	{if $notices && $page_link}
		<div style="text-align: center;" class="hidden-xs">
			<ul class="pagination">{$page_link}</ul>
		</div>
	{/if}
</div>