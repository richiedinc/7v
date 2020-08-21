<script type="text/javascript">
var lang_comment_limit = "{t c='global.comment_limit'}";
</script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.notice-0.1.js"></script>

<div class="container">
	<div class="row">

		<div class="col-md-9 col-sm-8">

					<div class="panel panel-default">
						<div class="panel-heading">
							<div class="pull-left">
								<a href="{$relative}/user/{$notice.username}"><img class="small-avatar" src="{$relative}/media/users/{if $notice.photo == ''}nopic-{$notice.gender}.gif{else}{$notice.photo}{/if}" /><span>{$notice.username|escape:'html'}</span></a>
							</div>						
							<div class="pull-right">
								{insert name=time_range assign=addtime time=$notice.addtime}
								{$addtime}							
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="panel-body">
							<div class="blog_header">
								<a href="{$relative}/notice/{$notice.NID}/{$notice.title|clean}">{$notice.title|escape:'html'}</a>
							</div>
							
							<div class="blog_content">
								{$notice.content}
							</div>


						{if isset($smarty.session.uid)}
							<div class="separator m-t-15"></div>
							<div id="post_comment">
								<form class="form-horizontal" name="postNoticeComment" id="postNoticeComment" method="post" action="">

									<div class="form-group">
										<div class="col-xs-12 col-sm-10 col-sm-offset-1">
											<textarea name="notice_comment" id="notice_comment" rows="5" class="form-control" placeholder="{t c='global.add_comment'}"></textarea>
											<div id="post_message" class="text-danger m-t-5" style="display: none;">{t c='global.comment_empty'}!</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-12 col-sm-10 col-sm-offset-1">
											<div class="pull-left">
												<input name="submit_comment" type="button" value=" {t c='global.post'} " id="post_notice_comment_{$notice.NID}" class="btn btn-primary" />
											</div>
											<div class="pull-right">
												<span id="chars_left">1000</span> {t c='global.chars_left'}
											</div>
											<div class="clearfix"></div>
										</div>
									</div>
								</form>
							</div>			
						{else}
							{if $comments}
								<div class="separator m-t-15"></div>
							{/if}
						{/if}

							<div id="notice_comments_{$notice.NID}">
								{if $comments}
									{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span id="end_num" class="text-white">{$end_num}</span> {t c='global.of'} <span id="total_comments" class="text-white">{$comments_total}</span> {t c='global.comments'}.
								{/if}
								<div id="notice_response" style="display: none;"></div>
								<div id="comments_delimiter" style="display: none;"></div>
								
								{if $comments}
									{section name=i loop=$comments}
										
										<div id="notice_comment_{$notice.NID}_{$comments[i].CID}" class="col-xs-12 m-t-15">
											<div class="row">
												<div class="pull-left">
													<a href="{$relative}/user/{$comments[i].username}">
														<img src="{$relative}/media/users/{if $comments[i].photo != ''}{$comments[i].photo}{else}nopic-{$comments[i].gender}.gif{/if}" title="{$comments[i].username}'s avatar" alt="{$comments[i].username}'s avatar" class="img-responsive comment-avatar" />
													</a>											
												</div>
												<div class="comment">
													<div class="comment-info">
														{insert name=time_range assign=addtime time=$comments[i].addtime}
														<a href="{$relative}/user/{$comments[i].username}">{$comments[i].username}</a>&nbsp;-&nbsp;<span class="">{$addtime}</span>
													</div>
													<div class="comment-body overflow-hidden">{$comments[i].comment|nl2br}</div>
													{if isset($smarty.session.uid)}
														<div class="comment-actions">
															{if $smarty.session.uid == $comments[i].UID}
																<a href="#delete_comment" id="delete_comment_notice_{$comments[i].CID}_{$notice.NID}">{t c='global.delete'}</a> <span id="delete_response_{$comments[i].CID}" style="display: none;"></span>
															{else}
																<span id="reported_spam_{$comments[i].CID}_{$notice.NID}"><a href="#report_spam" id="report_spam_notice_{$comments[i].CID}_{$notice.NID}">{t c='global.report_spam'}</a></span>
															{/if}
														</div>
													{/if}
												</div>
												<div class="clearfix"></div>
											</div>
											
										</div>
										
									{/section}

									{if $page_link}
										<div class="visible-xs center m-b--15">
											<ul class="pagination pagination-lg">{$page_link}</ul>
										</div>
										<div class="hidden-xs center m-b--15">
											<ul class="pagination">{$page_link}</ul>
										</div>
									{/if}
						
								{/if}
							</div>						
						
						</div>						

					</div>
		</div>
		<div class="col-md-3 col-sm-4">
			<div class="list-group">
				<a href="{url base='notices' strip='c' value=""}" {if $category == "0" || !$category}class="list-group-item active"{else}class="list-group-item"{/if}>
					{t c='global.all'}
				</a>
				{section name=i loop=$categories}
				<a href="{url base='notices' strip='c' value=$categories[i].category_id}" {if $category == $categories[i].category_id}class="list-group-item active"{else}class="list-group-item"{/if}>
					{$categories[i].name|escape:'html'}
				</a>
				{/section}
			</div>
			<div class="list-group">
				<a href="{url base='notices' strip='t' value=""}" {if !$timestamp}class="list-group-item active"{else}class="list-group-item"{/if}>
					{t c='global.all'}
				</a>
				{section name=i loop=$arhive}
				<a href="{url base='notices' strip='t' value=$arhive[i]}" {if $timestamp == $arhive[i]}class="list-group-item active"{else}class="list-group-item"{/if}>
					{$arhive[i]|date_format:"%B %Y"}
				</a>
				{/section}
			</div>
		</div>		
	</div>
</div>

