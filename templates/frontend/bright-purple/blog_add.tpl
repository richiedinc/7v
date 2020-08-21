<script type="text/javascript" src="{$relative_tpl}/js/jquery.browser.min.js"></script>
<script type="text/javascript" src="{$relative}/addons/markitup/jquery.markitup.js"></script>
<script type="text/javascript" src="{$relative}/addons/markitup/sets/bbcode/set.js"></script>
<link rel="stylesheet" type="text/css" href="{$relative}/addons/markitup/skins/jtageditor/style.css" />
<link rel="stylesheet" type="text/css" href="{$relative}/addons/markitup/sets/bbcode/style.css" />

<script type="text/javascript">
    {literal}		
        $(document).ready(function() {
            $("#blog_content").markItUp(myBbcodeSettings);
			$(".markItUpSeparator").addClass(" hidden-xs");
			$('.markItUpDropMenu .markItUpButton').on("click", function () {
				$(this).parent('ul').hide();
			});
        });
	{/literal}
</script>

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
					{t c='blog.add_title'}
				</div>
				<div class="panel-body">

					<form class="form-horizontal" name="addBlogForm" id="addBlogForm" method="post" action="{$relative}/blog/add">
					
						<div class="form-group{if $err.title} has-error{/if}">
							<label for="blog_title" class="col-lg-3 control-label">{t c='global.title'}</label>
							<div class="col-lg-9">
								<input name="blog_title" type="text" class="form-control" value="{$blog_title}" maxlength="99" id="blog_title" placeholder="{t c='global.title'}" />
							</div>
						</div>

						<div id="media_message" style="display: none;"></div>

						<div class="row">
							<div id="media_content" class="col-md-12 m-b-15" style="display: none;"></div>
						</div>

						<div class="form-group">
							<div class="col-md-12">
								<textarea name="blog_content" id="blog_content">{$blog_content}</textarea>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-lg-9 col-lg-offset-3">
								<input name="blog_add_submit" type="submit" value=" {t c='global.save'} " id="blog_submit" class="btn btn-primary" />
							</div>
						</div>

					</form>
 
				</div>				
			</div>	
		</div>
	</div>
</div>