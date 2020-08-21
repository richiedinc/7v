<script type="text/javascript">
var lang_posting = "{t c='global.posting'}";
var lang_comment_limit = "{t c='global.comment_limit'}";
var lang_comment_success = "{t c='global.comment_success'}";
</script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.blog-0.1.js"></script>

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
							<div class="pull-left">
								<a href="{$relative}/user/{$user.username}"><img class="small-avatar" src="{$relative}/media/users/{if $user.photo == ''}nopic-{$user.gender}.gif{else}{$user.photo}{/if}" /><span>{$username|truncate:25:"..."}</span></a>
							</div>						
							<div class="pull-right">
								{insert name=time_range assign=addtime time=$blog.addtime}
								{$blog.total_views} {t c='global.views'} <strong>&middot;</strong> {$addtime}								
							</div>

							<div class="clearfix"></div>
						</div>
						<div class="panel-body">
							<div class="blog_header">
								<a href="{$relative}/blog/{$blog.BID}/{$blog.title|clean}">{$blog.title|escape:'html'}</a>							
							</div>
							
							<div class="blog_content">
								{$blog.content|nl2br}
							</div>


						{if isset($smarty.session.uid) && $blog_comments == '1'}
							<div class="separator m-t-15"></div>
							<div id="post_comment_blog">
								<form class="form-horizontal" name="postBlogComment" id="postBlogComment" method="post" action="{$relative}/blog/{$blog.BID}">
									<div id="media_message" style="display: none;"></div>
									<div id="media_content" class="m-b-15" style="display: none;"></div>
									<div class="form-group">
										<div class="col-xs-12 col-sm-10 col-sm-offset-1">
											<textarea name="blog_comment" id="blog_comment" rows="5" class="form-control" placeholder="{t c='global.add_comment'}"></textarea>
											<div id="post_message" class="text-danger m-t-5" style="display: none;">{t c='global.comment_empty'}!</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-12 col-sm-10 col-sm-offset-1">
											<div class="pull-left">
												<input name="submit_comment" type="button" value=" {t c='global.post'} " id="post_blog_comment_{$blog.BID}" class="btn btn-primary" />
												<a href="#attach_photo" id="attach_photo" class="btn btn-secondary m-l-5"><span class="visible-xs"><i class="fa fa-camera"></i></span><span class="hidden-xs">{t c='global.attach_photo'}</span></a>
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

							<div id="blog_comments_{$blog.BID}">
								{if $comments}
									{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span id="end_num" class="text-white">{$end_num}</span> {t c='global.of'} <span id="total_comments" class="text-white">{$comments_total}</span> {t c='global.comments'}.
								{/if}
								<div id="blog_response" style="display: none;"></div>
								<div id="comments_delimiter" style="display: none;"></div>
								
								{if $comments}
									{section name=i loop=$comments}
										
										<div id="blog_comment_{$blog.BID}_{$comments[i].CID}" class="col-xs-12 m-t-15">
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
																<a href="#delete_comment" id="delete_comment_blog_{$comments[i].CID}_{$blog.BID}">{t c='global.delete'}</a> <span id="delete_response_{$comments[i].CID}" style="display: none;"></span>
															{else}
																<span id="reported_spam_{$comments[i].CID}_{$blog.BID}"><a href="#report_spam" id="report_spam_blog_{$comments[i].CID}_{$blog.BID}">{t c='global.report_spam'}</a></span>
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
						{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
							<div class="panel-footer">
								<div class="pull-left">
									<a href="{$relative}/blog/edit/{$blog.BID}/{$blog.title|clean}">{t c='global.edit'}</a> <strong>&middot;</strong>
									<a href="{$relative}/blog/delete/{$blog.BID}/{$blog.title|clean}">{t c='global.delete'}</a>
								</div>
								<div class="clearfix"></div>
							</div>								
						{/if}							
					</div>
		</div>
	</div>
</div>

