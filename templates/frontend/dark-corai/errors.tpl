{if isset($errors) && $errors}
<div class="container">
	<div class="alert alert-dismissable alert-danger">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		{section name=i loop=$errors}
		{$errors[i]}<br />
		{/section}
	</div>
</div>
{/if}