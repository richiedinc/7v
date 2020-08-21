<div class="hidden-md hidden-lg">
	{include file='quick_jumps.tpl'}
</div>

<div class="panel panel-default">
	<div class="panel-heading">
		{t c='mail.messages'}
	</div>
	<div class="panel-body">
		<div class="row">
			<div class="col-xs-4">
				<center>
					<a href="{$relative}/mail/compose">
						<div class="text-white"><i class="fa fa-envelope fa-2x"></i></div>
						<div>{t c='mail.compose'}</div>
					</a>
				</center>
			</div>
			<div class="col-xs-4">
				<center>
					<a href="{$relative}/mail/inbox">
						<div class="text-white"><i class="fa fa-inbox fa-2x"></i></div>
						<div>{t c='mail.inbox'}</div>
					</a>
				</center>
			</div>
			<div class="col-xs-4">
				<center>
					<a href="{$relative}/mail/outbox">
						<div class="text-white"><i class="fa fa-send fa-2x"></i></div>
						<div>{t c='mail.outbox'}</div>
					</a>
				</center>
			</div>			
		</div>

	</div>

</div>