<script type="text/javascript">
var lang_photo = "{t c='photo.Photo'}";
var lang_of = "{t c='global.of'}";
</script>
<script type="text/javascript" src="{$relative_tpl}/js/lightbox.js"></script>
<link href="{$relative_tpl}/css/lightbox.css" rel="stylesheet" />
<script>
{literal}
$( document ).ready(function() {
    $('#0-lb').trigger('click');
});
{/literal}
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
						{t c='album.SLIDESHOW'}: {$album.name}
					</div>
					<div class="pull-right">
                      <a href="{$relative}/album/{$album.AID}/">{t c='global.back_to'} '{$album.name|escape:'html'}'</a>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="panel-body">
					{if !$is_friend}
						<div class="text-danger">{t c='album.private' url=$relative u=$username un=$username}</div>
					{else}				
						{if $photos}
								<div class="m-b--15">
									<div class="row">
										{section name=i loop=$photos}
											<div class="col-sm-4 m-b-15">
												<a id="{$smarty.section.i.index}-lb" href="{$relative}/media/photos/{$photos[i].PID}.jpg" data-lightbox="slideshow-{$album.AID}" data-title="{$photos[i].caption|escape:html}">
													<img src="{$relative}/media/photos/tmb/{$photos[i].PID}.jpg" alt="{$photos[i].caption|escape:html}" class="img-responsive" />
												</a>
											</div>  
										{/section}
									</div>
								</div>
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

