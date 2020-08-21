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
            {if $walls || ( isset($smarty.session.uid) && $wall_comments == '1' )}
					<div class="panel panel-default">           
						<div class="panel-heading">
							{$user.username}{if $smarty.session.language == 'en_US'}&#39;s{/if} {t c='user.WALL'}
						</div>
						<div class="panel-body">
						
							{if isset($smarty.session.uid) && $user.UID && $wall_comments == '1'}
							<div id="wall">
								<form class="form-horizontal" name="wall_form" id="wall_form" method="post" action="#post_comment">
									<div id="media_message" style="display: none;"></div>
									<div id="media_content" class="m-b-15" style="display: none;"></div>
									<div class="form-group">
										<div class="col-xs-12 col-sm-10 col-sm-offset-1">
											<textarea name="wall_comment" id="wall_comment" cols="75" rows="5" class="form-control" placeholder="{t c='global.add_comment'}">{$comment}</textarea>
											<div id="post_message" class="text-danger m-t-5" style="display: none;">{t c='global.comment_empty'}</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-12 col-sm-10 col-sm-offset-1">
											<div class="pull-left">
												<input name="submit_wall" type="submit" value=" {t c='global.post'} " id="post_wall_comment_{$user.UID}" class="btn btn-primary">
												<a href="#attach_photo" id="attach_photo" class="btn btn-secondary m-l-5"><span class="visible-xs"><i class="fa fa-camera"></i></span><span class="hidden-xs">{t c='global.attach_photo'}</span></a>
												<a href="#attach_video" id="attach_video" class="btn btn-secondary m-l-5"><span class="visible-xs"><i class="fa fa-film"></i></span><span class="hidden-xs">{t c='global.attach_video'}</span></a>
											</div>
											<div class="pull-right">
												<span id="chars_left">1000</span> {t c='global.chars_left'}
											</div>
											<div class="clearfix"></div>
										</div>
									</div>
								</form>
							</div>
							{/if}
							
							<div id="wall_comments_{$user.UID}">
								{if $walls}
									{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span id="end_num" class="text-white">{$end_num}</span> {t c='global.of'} <span id="total_comments" class="text-white">{$walls_total}</span> {t c='global.comments'}.
								{/if}
								<div id="wall_response" style="display: none;">{t c='global.posting'}</div>
								<div id="comments_delimiter" style="display:none;"></div>
								{if $walls}
									{section name=i loop=$walls}
										
										<div id="wall_comment_{$walls[i].wall_id}" class="col-xs-12 m-t-15">
											<div class="row">
												<div class="pull-left">
													<a href="{$relative}/user/{$walls[i].username}">
														<img src="{$relative}/media/users/{if $walls[i].photo != ''}{$walls[i].photo}{else}nopic-{$walls[i].gender}.gif{/if}" title="{$walls[i].username}'s avatar" alt="{$walls[i].username}'s avatar" class="img-responsive comment-avatar" />
													</a>											
												</div>
												<div class="comment">
													<div class="comment-info">
														{insert name=time_range assign=addtime time=$walls[i].addtime}
														<a href="{$relative}/user/{$walls[i].username}">{$walls[i].username}</a>&nbsp;-&nbsp;<span class="">{$addtime}</span>
													</div>
													<div class="comment-body overflow-hidden">{$walls[i].message|nl2br}</div>
													{if isset($smarty.session.uid)}
														<div class="comment-actions">
															{if $smarty.session.uid == $walls[i].UID}
																<a href="#delete_comment" id="delete_comment_wall_{$walls[i].wall_id}_{$user.UID}">{t c='global.delete'}</a> <span id="delete_response_{$walls[i].wall_id}" style="display: none;"></span>
															{/if}
															{if $smarty.session.uid != $walls[i].UID}
																<span id="reported_spam_{$walls[i].wall_id}_{$user.UID}"><a href="#report_spam" id="report_spam_wall_{$walls[i].wall_id}_{$user.UID}">{t c='global.report_spam'}</a></span>
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
			{/if}	

		</div>
	</div>
</div>

