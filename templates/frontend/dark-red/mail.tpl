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
					{$folder|ucfirst}
				</div>
				<div class="panel-body">
					{if $mails}
						<div class="m-b-15">
							{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$total_mails}</span> {t c='global.messages'}.
						</div>
						<table class="table table-striped table-hover m-b-0">
							<thead>
								<tr>
									<th class="hidden-xs">{t c='global.status'}</th>
									<th>{t c='global.sender'}</th>                                        
									<th>{t c='global.subject'}</th>
									<th class="hidden-xs">{t c='global.date'}</th>
									<th>{t c='global.delete'}</th>
								</tr>
							</thead>
							<tbody>
							{section name=i loop=$mails}
							<tr>
								<td class="hidden-xs v-middle {if $mails[i].readed == '1'}mail-read{else}mail-unread{/if}"><i class="fa {if $mails[i].readed == '1'}fa-envelope-o{else}fa-envelope{/if}"></i></td>
								<td class="user v-middle">
									<a href="{$relative}/user/{$mails[i].sender}">
										<span class="hidden-xs">
											<img src="{$relative}/media/users/{if $mails[i].photo == ''}nopic-{$mails[i].gender}.gif{else}{$mails[i].photo}{/if}" alt="{$mails[i].sender}" class="small-avatar" />
										</span>
										<span class="hidden-xs">{$mails[i].sender|truncate:15:'...':true|escape:'html'}</span>
										<span class="visible-xs">{$mails[i].sender|truncate:10:'...':true|escape:'html'}</span>
									</a>
								</td>
								<td class="{if $mails[i].readed == '1'}subject-read{else}subject-unread{/if} v-middle">
									<a href="{$relative}/mail/read?id={$mails[i].mail_id}&f={$folder}"><span class="hidden-xs">{$mails[i].subject|truncate:25:'...':true|escape:'html'}</span><span class="visible-xs">{$mails[i].subject|truncate:10:'...':true|escape:'html'}</span></a>
								</td>
								<td class="hidden-xs v-middle">{$mails[i].send_date|date_format:"%B %e, %Y"}</td>
								<td class="mail-delete delete v-middle">
									<a href="{$relative}/mail/{$folder}?delete={$mails[i].mail_id}"><i class="fa fa-trash-o"></i></a>
								</td>
							</tr>
							{/section}
							</tbody>
						</table>
					{else}
						<span class="text-danger">{t c='mail.none'}.</span>
					{/if}
				</div>				
			</div>	
		</div>
	</div>
</div>