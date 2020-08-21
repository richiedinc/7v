<div class="container">
	<div class="row">
		<div class="col-md-4">
			<div class="visible-sm visible-xs">
				{include file='quick_jumps.tpl'}
			</div>		
			<div class="hidden-sm hidden-xs">
				{include file='user_info.tpl'}
			</div>
		</div>
		<div class="col-md-8">
			<div class="well well-filters">
					<div class="pull-left">
						<h4>{$user.username}{if $smarty.session.language == 'en_US'}&#39;s{/if} {t c='global.blog'}</h4>
					</div>
					{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
						<div class="pull-right">
							<a class="btn btn-primary" href="{$relative}/blog/add"><span class="hidden-xs"><i class="fa fa-pencil"></i> {t c='blog.create_new'}</span><span class="visible-xs"><i class="fa fa-pencil"></i></span></a>
						</div>
					{/if}					
					<div class="clearfix"></div>
			</div>
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
								<i class="fa fa-pencil"></i>&nbsp;
								{insert name=time_range assign=addtime time=$blogs[i].addtime}
								{$blogs[i].total_views} {t c='global.views'} <strong>&middot;</strong> {$addtime}								
							</div>
							<div class="pull-right">					
							
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

							<div class="pull-left">
								<i class="fa fa-comment"></i> <a href="{$relative}/blog/{$blogs[i].BID}/{$blogs[i].title|clean}">{$blogs[i].total_comments}</a> <strong>&middot;</strong>
								<a href="{$relative}/blog/{$blogs[i].BID}/{$blogs[i].title|clean}">{t c='blog.post_comment'}</a>
							</div>
							{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
								<div class="pull-right">
									<a href="{$relative}/blog/edit/{$blogs[i].BID}/{$blogs[i].title|clean}">{t c='global.edit'}</a> <strong>&middot;</strong>
									<a href="{$relative}/blog/delete/{$blogs[i].BID}/{$blogs[i].title|clean}">{t c='global.delete'}</a>
								</div>
							{/if}
							<div class="clearfix"></div>
						</div>
					</div>				
				</div>			
            {/section}
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
			<div class="well well-sm">
				<span class="text-danger">{t c='blog.none'}.</span>
			</div>
            {/if}	
		</div>
	</div>
</div>

