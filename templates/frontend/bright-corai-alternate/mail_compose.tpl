<div class="container">
	<div class="row">
		<div class="col-md-4">
			{include file='mail_menu.tpl'}		
			<div class="hidden-sm hidden-xs">
				{include file='user_info.tpl'}
			</div>
		</div>
		<div class="col-md-8">
			<div class="panel panel-default">
				<div class="panel-heading">
					{t c='mail.compose_title'}
				</div>
				<div class="panel-body">
					<form class="form-horizontal" name="compose_message_form" id="compose_message_form" method="post" action="{$relative}/mail/compose">
						
						<div class="form-group {if $err.receiver}has-error{/if}">
							<label for="receiver" class="col-lg-3 control-label">{t c='global.To'}</label>
							<div class="col-lg-9 input-select">
								<input name="receiver" type="text" class="form-control pull-left" value="{$compose.receiver}" maxlength="30" id="receiver" placeholder="{t c='mail.select_expl' s=$site_name}" />
								<select  class="form-control pull-left" name="receiver_friend">
									<option value="">{t c='mail.select_friend'}</option>
									{section name=i loop=$friends}
									<option value="{$friends[i].username}"{if $friends[i].username == $compose.friend} selected="yes"{/if}>{$friends[i].username|escape:'html'}</option>
									{/section}
								</select>								
							</div>
						</div>
						
						<div class="form-group {if $err.subject}has-error{/if}">
							<label for="subject" class="col-lg-3 control-label">{t c='global.subject'}</label>
							<div class="col-lg-9">
								<input name="subject" type="text" class="form-control" value="{$compose.subject}" id="subject" maxlength="99" placeholder="{t c='global.subject'}" />
							</div>
						</div>

						<div class="form-group {if $err.body}has-error{/if}">
							<label for="body" class="col-lg-3 control-label">{t c='global.message'}</label>
							<div class="col-lg-9">
								<textarea name="body" id="body" class="form-control" rows="8" placeholder="{t c='global.message'}">{$compose.body}</textarea>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-lg-9 col-lg-offset-3">
								<div class="checkbox">
									<label>
										<input name="save_outbox" type="checkbox" id="save_outbox"{if $compose.save_outbox == '1'} checked="checked"{/if} /> {t c='mail.save_outbox'}
									</label>
								</div>								
							</div>
							<div class="col-lg-9 col-lg-offset-3">
								<div class="checkbox">
									<label>
										<input name="send_self" type="checkbox" id="send_self"{if $compose.send_self == '1'} checked="checked"{/if} /> {t c='mail.send_myself'}
									</label>
								</div>								
							</div>						
						</div>						

						<div class="form-group">
							<div class="col-lg-9 col-lg-offset-3">
								<input name="send_mail" type="submit" value=" {t c='mail.send'} " id="send" class="btn btn-primary" />
							</div>
						</div>						

					</form>		
				</div>				
			</div>	
		</div>
	</div>
</div>

