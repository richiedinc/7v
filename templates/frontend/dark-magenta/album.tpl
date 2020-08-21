<script>
	var lang_delete_photo_ask = "{t c='photo.delete_confirm'}";
</script>
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
						{$album.name}
					</div>
					{if $photos_total > 1}
						<div class="pull-right">
							<a href="{$relative}/album/slideshow/{$album.AID}">{t c='global.slideshow'}</a>
						</div>
					{/if}
					<div class="clearfix"></div>
				</div>
				<div class="panel-body">
					{if !$is_friend}
					<div class="text-danger">{t c='album.private' url=$relative u=$username un=$username}</div>
					{else}				
						{if $photos}
							{if $delete_photos == '1' && $smarty.session.uid == $album.UID}
								<div id="delete_photo_message" style="display:none"></div>
							{/if}	
								{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$photos_total}</span> {t c='album.photos'}.

								<div class="row">
									{section name=i loop=$photos}
										<div id="album_photo_{$photos[i].PID}" class="col-sm-4 m-t-15">
											<div class="thumb-overlay">
												<a href="{$relative}/photo/{$photos[i].PID}/">
													<div class="thumb-overlay">
														<img src="{$relative}/media/photos/tmb/{$photos[i].PID}.jpg" alt="{$photos[i].caption|escape:html}" id="album_photo_{$photos[i].PID}" class="img-responsive" />
													</div>
												</a>
												{if $delete_photos == '1' && $smarty.session.uid == $album.UID}
													<div class="actions">
														<a href="#delete_photo" id="delete_photo_{$photos[i].PID}" class="btn btn-danger btn-xs delete-btn hidden-xs">{t c='global.delete'}</a>
														<a href="#delete_photo" id="delete_photo_{$photos[i].PID}" class="btn btn-danger delete-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.delete'}</a>
													</div>
												{/if}
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
							<span class="text-danger">{t c='global.no_photos_found'}.</span>
						{/if}
					{/if}
				</div>
				{if isset($smarty.session.uid) && $smarty.session.uid == $album.UID}
					<div class="panel-footer">
						<a href="{$relative}/album/edit/{$album.AID}">{t c='global.edit'}</a> <strong>&middot;</strong>
						<a href="{$relative}/album/addphotos/{$album.AID}">{t c='album.add_more_photos'}</a> <strong>&middot;</strong>
						<a href="{$relative}/album/delete/{$album.AID}">{t c='global.delete'}</a>
                    </div>
				{/if}				
			</div>	
		</div>
	</div>
</div>

