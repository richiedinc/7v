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
						{$user.username}{if $smarty.session.language == 'en_US'}&#39;s{/if} {t c='user.PHOTO_ALBUMS'}
					</div>
					{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
						<div class="pull-right">
							<a  href="{$relative}/upload/photo">{t c='album.upload'}</a>
						</div>
					{/if}					
					<div class="clearfix"></div>
				</div>
			
            {if $albums}
				<div class="panel-body">

					{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$albums_total}</span> {t c='album.albums'}.

					<div class="row">
					{section name=i loop=$albums}
						<div class="col-sm-6 col-md-4 col-lg-4 m-t-15">
							<div class="thumb-overlay">
								<a href="{$relative}/album/{$albums[i].AID}/{$albums[i].name|clean}">
									<div class="thumb-overlay">
										<img src="{$relative}/media/albums/{$albums[i].AID}.jpg" title="{$albums[i].name|escape:'html'}" alt="{$albums[i].name|escape:'html'}" class="img-responsive {if $albums[i].type == 'private'}img-private{/if}" />
										{if $albums[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
									</div>											
								</a>
							{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
								<div class="actions">
									<a href="{$relative}/album/delete/{$albums[i].AID}" class="btn btn-danger btn-xs delete-btn hidden-xs">{t c='global.delete'}</a>
									<a href="{$relative}/album/delete/{$albums[i].AID}" class="btn btn-danger delete-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.delete'}</a>
								</div>
							{/if}											
							</div>
							<a href="{$relative}/album/{$albums[i].AID}/{$albums[i].name|clean}">
								<div class="video-title title-truncate">{$albums[i].name|escape:'html'}</div>
							</a>
							<div class="video-added">
								{insert name=time_range assign=addtime time=$albums[i].addtime}
								{$addtime}
							</div>
							<div class="video-views pull-left">
								{$albums[i].total_photos} {if $albums[i].total_photos == '1'}{t c='photo.photo'}{else}{t c='photo.photos'}{/if}
							</div>
							<div class="video-rating pull-right {if $albums[i].rate == 0 && $albums[i].dislikes == 0}no-rating{/if}">
								<i class="fa fa-heart video-rating-heart {if $albums[i].rate == 0 && $albums[i].dislikes == 0}no-rating{/if}"></i> <b>{if $albums[i].rate == 0 && $albums[i].dislikes == 0}-{else}{$albums[i].rate}%{/if}</b>
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
					<span class="text-danger">{t c='albums.none_found'}.</span>
				</div>
			{/if}	
			</div>	
		</div>
	</div>
</div>

