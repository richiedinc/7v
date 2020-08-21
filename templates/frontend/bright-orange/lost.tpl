<div class="container">
	
	<div class="row">
		<div class="col-md-6">
		<div class="well">
			<form class="form-horizontal" name="lost_password_form" id="lost_password_form" method="post" action="{$relative}/lost">
			  <fieldset>
				<legend>{t c='lost.title'}</legend>
				<div class="m-b-20">
					<h4>{t c='confirm.expl'}</h4>
				</div>
				<div class="form-group {if $errors}has-error{/if}">
					<label for="lost_email" class="col-lg-3 control-label">{t c='global.email'}</label>
					<div class="col-lg-9">
						 <input name="email" type="text" class="form-control" value="" id="lost_email" placeholder="{t c='global.email'}" />
					</div>
				</div>
				<div class="form-group">
					<div class="col-lg-9 col-lg-offset-3">
						<input name="submit_lost" type="submit" value=" {t c='lost.send'} " id="lost_submit" class="btn btn-primary">
					</div>
				</div>					
			  </fieldset>
			</form>		
		</div>
		</div>
		<div class="col-md-6">
			<div class="well bs-component">
				<legend>{t c='global.what_is' s=$site_name}</legend>
				{include file='static/whatis.tpl'}
			</div>
		</div>
	</div>
</div>