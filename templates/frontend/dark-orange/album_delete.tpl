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
						{t c='album.add_photos_to'}: {$album.name|escape:'html'}
					</div>
					<div class="pull-right">
                      <a href="{$relative}/album/{$album.AID}/">{t c='global.back_to'} '{$album.name|escape:'html'}'</a>
                      {if isset($smarty.session.uid) && $smarty.session.uid == $album.UID}
						  <strong>&middot;</strong>
						  <a href="{$relative}/album/edit/{$album.AID}">{t c='global.edit'}</a> <strong>&middot;</strong>
						  <a href="{$relative}/album/addphotos/{$album.AID}">{t c='album.add_more_photos'}</a>
                      {/if}			
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="panel-body">
					<div id="simple_form">
						<form class="form-horizontal" name="deleteAccount" id="deleteAccount" method="post" action="{$relative}/album/delete/{$album.AID}">
							<div class="alert alert-danger">{t c='album.delete_expl'}</div>
							<div class="form-group">
								<label for="delete" class="col-lg-6 control-label">{t c='album.delete_ask'}</label>
								<div class="col-lg-6">
									<input name="delete_yes" type="submit" value="{t c='global.yes'}" class="btn btn-primary" id="delete" />
									<input name="delete_no" type="submit" value="{t c='global.no'}" class="btn btn-secondary" id="delete_no" />						
								</div>
							</div>
							<label for="delete" class="delete"></label>
							<div class="form-group">
								<div class="col-lg-6 col-lg-offset-6">
									<div class="checkbox">
										<label>
											<input name="confirm_delete" type="checkbox" id="confirm_delete" /> {t c='user.delete_confirm'}
										</label>
									</div>								
								</div>
							</div>
						</form>
					</div>
				</div>
				
			</div>	
		</div>
	</div>
</div>

