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
					{t c='requests.title'}
				</div>
				<div class="panel-body">
					{if $requests}
						<div class="m-b-15">
							{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$requests_total}</span> {t c='requests.friend'}.
						</div>
						<div class="m-b--15">
						{section name=i loop=$requests}
						<div id="request_message_{$requests[i].FID}" style="display: none;"></div>
						<div id="request_{$requests[i].FID}" class="m-b-30">
							<div class="pull-left">
								<a href="{$relative}/user/{$requests[i].username}">
									<img src="{$relative}/media/users/{if $requests[i].photo != ''}{$requests[i].photo}{else}nopic-{$requests[i].gender}.gif{/if}" alt="{$requests[i].username}'s avatar" class="comment-avatar"  />
								</a>
							</div>
							<div class="comment">
								<div class="comment-info">
									<a href="{$relative}/user/{$requests[i].username}">{$requests[i].username}</a>
								</div>
								<div class="comment-body">
									{if $requests[i].message}{$requests[i].message|escape:'html'|nl2br}{else}{t c='requests.no_message'}{/if}
								</div>
							</div>				
							<div class="clearfix m-b-15"></div>
							<div class="m-l-80">
								<a href="#accept_friend" id="accept_friend_{$requests[i].FID}" class="btn btn-primary">{t c='global.accept'}</a>
								<a href="#reject_friend" id="reject_friend_{$requests[i].FID}" class="btn btn-secondary m-l-5">{t c='global.reject'}</a>
							</div>
						</div>
						{/section}
						</div>
					{else}
						<span class="text-danger">{t c='requests.none'}.</span>
					{/if}
				</div>				
			</div>	
		</div>
	</div>
</div>

