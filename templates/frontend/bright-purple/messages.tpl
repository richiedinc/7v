{if isset($messages) && $messages}
<div class="container">
	<div class="alert alert-dismissable alert-success">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		{section name=i loop=$messages}
		{$messages[i]}<br />
		{/section}
	</div>
</div>
{/if}