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
					{t c='blog.delete'}
				</div>
				<div class="panel-body">
                <form class="form-horizontal" name="deleteBlogForm" id="deleteBlogForm" method="post" action="{$relative}/blog/delete/{$blog.BID}/{$blog.title|clean}">
				
                <div class="form-group {if $errors}has-error{/if}">
					<label for="delete" class="col-lg-12"><center>{t c='blog.delete_confirm'}</center></label>
						<div class="col-lg-12 m-t-5">
							<center>
								<input name="delete_yes" type="submit" value="{t c='global.yes'}" class="btn btn-primary" id="delete" />
								<input name="delete_no" type="submit" value="{t c='global.no'}" class="btn btn-secondary" id="delete_no" />
							</center>
						</div>
				</div>

                    
                </form>				

				</div>
		</div>
	</div>
</div>
