<div class="container">
	<div class="well">
		<div class="col-md-12">
			<fieldset class="m-b-15">
				<legend>{t c='user.DELETE_TITLE'}</legend>
                <form class="form-horizontal" name="deleteAccount" id="deleteAccount" method="post" action="{$relative}/user/delete">
					<div class="clearfix"></div>
					<div class="alert alert-danger">{t c='user.delete_expl'}</div>
					<div class="form-group">
						<label for="delete" class="col-lg-4 control-label">{t c='user.delete_ask'}</label>
						<div class="col-lg-8">
							<input name="delete_yes" type="submit" value="{t c='global.yes'}" class="btn btn-primary" id="delete" />
							<input name="delete_no" type="submit" value="{t c='global.back_to_profile'}" class="btn btn-secondary" id="delete_no" />						
						</div>
					</div>
					<label for="delete" class="delete"></label>
					<div class="form-group">
						<div class="col-lg-8 col-lg-offset-4">
							<div class="checkbox">
								<label>
									<input name="confirm_delete" type="checkbox" id="confirm_delete" /> {t c='user.delete_confirm'}
								</label>
							</div>								
						</div>
					</div>
				</form>
			</fieldset>
		</div>
		<div class="clearfix"></div>
	</div>
</div>