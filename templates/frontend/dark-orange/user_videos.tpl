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
			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="pull-left">
						{$user.username}{if $smarty.session.language == 'en_US'}&#39;s{/if} {t c='global.videos'}
					</div>
					{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
						<div class="pull-right">
							<a href="{$relative}/upload/video">{t c='videos.upload'}</a>
						</div>
					{/if}					
					<div class="clearfix"></div>
				</div>
			
            {if $videos}
				<div class="panel-body">
					<div id="delete_video_message" class="m-t-15" style="display:none"></div>
					{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$videos_total}</span> {t c='videos.videos'}.
					<div class="row">
					  {section name=i loop=$videos}
						<div id="video_{$videos[i].VID}" class="col-sm-4 m-t-15">
							<div class="thumb-overlay">
								<a href="{$relative}/video/{$videos[i].VID}/{$videos[i].title|clean}">
									<div class="thumb-overlay">
										<img src="{insert name=thumb_path vid=$videos[i].VID}/{$videos[i].thumb}.jpg" alt="{$videos[i].title|escape:'html'}" id="rotate_{$videos[i].VID}_{$videos[i].thumbs}_{$videos[i].thumb}" class="img-responsive {if $videos[i].type == 'private'}img-private{/if}" />
										{if $videos[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
										{if $videos[i].hd==1}<div class="hd-text-icon">HD</div>{/if}
										<div class="duration">
											{insert name=duration assign=duration duration=$videos[i].duration}
											{$duration}
										</div>												
									</div>
								</a>
								<div class="actions">
									{if $edit_videos == '1' && isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
										<a href="{$relative}/edit/{$videos[i].VID}" class="btn btn-primary btn-xs edit-btn hidden-xs">{t c='global.edit'}</a>
										<a href="{$relative}/edit/{$videos[i].VID}" class="btn btn-primary edit-btn visible-xs"><i class="glyphicon glyphicon-edit"></i> {t c='global.edit'}</a>
									{/if}	
									{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
										<a href="#delete_video" id="delete_video_{$videos[i].VID}" class="btn btn-danger btn-xs delete-btn hidden-xs">{t c='global.delete'}</a>
										<a href="#delete_video" id="delete_video_{$videos[i].VID}" class="btn btn-danger delete-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.delete'}</a>
									{/if}
								</div>
							</div>
							<a href="{$relative}/video/{$videos[i].VID}/{$videos[i].title|clean}">
								<div class="video-title title-truncate">{$videos[i].title|escape:'html'}</div>
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
				</div>
			{else}
				<div class="panel-body">
					<span class="text-danger">{t c='videos.no_videos_found'}.</span>
				</div>
			{/if}	
			</div>	
		</div>
	</div>
</div>

