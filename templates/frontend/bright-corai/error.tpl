<div class="container">
	
	<div class="row">
		<div class="col-md-9 col-sm-8">
		<div class="well">

			  <fieldset>
				<legend>{t c='global.ERROR'}</legend>
				<div class="m-b-20 text-danger">
					{$message}
				</div>
			  </fieldset>

		</div>
		</div>
		<div class="col-md-3 col-sm-4">
			<div class="well ad-body">
				<p class="ad-title">{t c='global.sponsors'}</p>
				{insert name=adv assign=adv group='index_right'}
				{if $adv}{$adv}{/if}
			</div>			
		</div>
	</div>
	<div class="well ad-body">
		<p class="ad-title">{t c='global.sponsors'}</p>
		{insert name=adv assign=adv group='index_bottom'}
		{if $adv}{$adv}{/if}
	</div>	
</div>