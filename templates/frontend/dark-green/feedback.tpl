<script type="text/javascript">
    {literal}
        $(document).ready(function(){
            $("#captcha_reload").click(function(event){
                event.preventDefault();
                $("#captcha_image").attr('src', "{/literal}{$relative}{literal}/captcha" + '/' + Math.random());
            });
        });
    {/literal}  
</script>
{if $captcha == '1'}
	<script src='https://www.google.com/recaptcha/api.js?hl={$captcha_language}'></script>		
{/if}
<div class="container">
	
	<div class="row">
		<div class="col-md-6">
		<div class="well bs-component">
			<form class="form-horizontal" name="contactUsForm" id="contactUsForm" method="post" action="{$relative}/feedback">
			  <fieldset>
				<legend>{t c='feedback.title'}</legend>
				
					<div class="form-group {if $err.department}has-error{/if}">
						<label for="contact_option" class="col-lg-4 control-label">{t c='feedback.department'}</label>
						<div class="col-lg-8">
							<select name="department" id="contact_option" class="form-control">
								<option value="General"{if $feedback.department == 'General'} selected="selected"{/if}>{t c='feedback.general'}</option>
								<option value="Violations"{if $feedback.department == 'Violations'} selected="selected"{/if}>{t c='feedback.violations'}</option>
								<option value="Advertising"{if $feedback.department == 'Advertising'} selected="selected"{/if}>{t c='feedback.advertising'}</option>
							</select>
						</div>
					</div>

					<div class="form-group {if $err.email}has-error{/if}">
						<label for="contact_email" class="col-lg-4 control-label">{t c='global.email'}</label>
						<div class="col-lg-8">
							<input name="email" type="text" class="form-control" value="{$feedback.email}" maxlength="100" id="contact_email" placeholder="{t c='global.email'}" />
						</div>
					</div>

					<div class="form-group {if $err.name}has-error{/if}">
						<label for="contact_name" class="col-lg-4 control-label">{t c='global.name'}</label>
						<div class="col-lg-8">
							<input name="name" type="text" class="form-control" value="{$feedback.name}" maxlength="100" id="contact_name" placeholder="{t c='global.name'}" />
						</div>
					</div>

					<div class="form-group {if $err.message}has-error{/if}">
						<label for="contact_message" class="col-lg-4 control-label">{t c='global.message'}</label>
						<div class="col-lg-8">
							<textarea class="form-control" name="message" id="contact_message" rows="5" placeholder="{t c='global.message'}" >{$feedback.message}</textarea>
						</div>
					</div>			

                    {if $captcha == '1'}
						<div class="form-group">
							<label class="col-lg-4 control-label"></label>
							<div class="col-lg-8">
								<div class="g-recaptcha" data-sitekey="{$recaptcha_site_key}"></div>
							</div>
						</div>
                    {/if}

					<div class="form-group">
						<div class="col-lg-8 col-lg-offset-4">
							<button name="submit_feedback" type="submit" class="btn btn-primary">{t c='global.send'}</button>
						</div>
					</div>					
					
			  </fieldset>
			</form>		
		</div>
		</div>
		<div class="col-md-6">
			<div class="well bs-component">
				<legend>{t c='faq.check'}</legend>
				{t c='faq.expl' s=$relative}
			</div>
			<div class="well bs-component">
				<legend>{t c='global.what_is' s=$site_name}</legend>
				{include file='static/whatis.tpl'}
			</div>
		</div>
	</div>
</div>