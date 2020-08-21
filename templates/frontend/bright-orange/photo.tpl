<script type="text/javascript">
var lang_favoriting = "{t c='global.favoriting'}";
var lang_thanks = "{t c='rate.thanks'}";
var lang_lame = "{t c='rate.lame'}";
var lang_bleh = "{t c='rate.bleh'}";
var lang_alright = "{t c='rate.alright'}";
var lang_good = "{t c='rate.good'}";
var lang_awesome = "{t c='rate.awesome'}";
</script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.photo-0.2.js"></script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.voting-photo-0.1.js"></script>

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
						{t c='photo.title'}: {$album.name|escape:'html'}
					</div>
					{if $album.total_photos > 1}
					<div class="pull-right">
						<a href="{$relative}/album/slideshow/{$photo.AID}">{t c='global.slideshow'}</a>
					</div>
					{/if}
					<div class="clearfix"></div>
				</div>
				<div class="panel-body">
					{if !$is_friend}
						<div class="text-danger">{t c='album.private' url=$relative u=$username un=$username}</div>
					{else}
						<div class="thumb-overlay">
							{if isset($next)}<a href="{$relative}/photo/{$next}">{/if}<center><img src="{$relative}/media/photos/{$photo.PID}.jpg" alt="{$photo.caption}" class="img-responsive-mw"/></center>{if isset($next)}</a>{/if}
						</div>
							<div class="vote-box col-xs-12 col-sm-3 col-md-3">
								<div class="dislikes {if $photo.likes == 0 and $photo.dislikes == 0}not-voted{/if}">
									<div id="photo_rate" class="likes" style="width: {$photo.rate}%;"></div>
								</div>
								<div id="vote_msg" class="vote-msg">
									<div class="pull-left">
										<i class="glyphicon glyphicon-thumbs-up"></i> <span id="photo_likes" class="text-white">{$photo.likes}</span>
									</div>
									<div class="pull-right">
										<i class="glyphicon glyphicon-thumbs-down"></i> <span id="photo_dislikes" class="text-white">{$photo.dislikes}</span>
									</div>
									<div class="clearfix"></div>
								</div>
							</div>	
						<div class="pull-left hidden-xs" style="width:4px; height:1px;"></div>
						<div class="pull-left m-t-15">
							<a href="#" class="btn btn-primary" id="vote_like_{$photo.PID}" ><i class="glyphicon glyphicon-thumbs-up"></i></a>
							<a href="#" class="btn btn-primary" id="vote_dislike_{$photo.PID}"><i class="glyphicon glyphicon-thumbs-down"></i></a>
						</div>
						
						<div class="pull-right m-t-15">
							<div id="share_photo" class="pull-right"><a href="#share_photo" class="btn btn-default"><i class="glyphicon glyphicon-share-alt"></i> <span class="hidden-xs">{t c='global.share'}</span></a></div>							
							{if isset($smarty.session.uid)}
								<div id="flag_photo" class="pull-right m-r-5"><a href="#flag_photo" class="btn btn-default"><i class="glyphicon glyphicon-flag"></i> <span class="hidden-xs">{t c='global.flag'}</span></a></div>
								<div id="favorite_photo" class="pull-right m-r-5"><a href="#favorite_photo" class="btn btn-default" id="favorite_photo_{$photo.PID}_{$photo.AID}"><i class="glyphicon glyphicon-heart"></i> <span class="hidden-xs">{t c='global.favorite'}</span></a></div>
							{/if}
							<div class="clearfix"></div>
						</div>
						<div class="clearfix"></div>
						<div class="pull-left m-t-15">
							<a href="{$relative}/album/{$photo.AID}/{$album.name|clean}">{t c='global.back_to'} '{$album.name|escape:'html'}'</a>
						</div>
						<div class="pull-right m-t-15">
							{if isset($prev)}
								<a href="{$relative}/photo/{$prev}">{t c='global.prev'}</a>
							{/if}
							{if isset($prev) && isset($next)} &middot; {/if}
							{if isset($next)}
								<a href="{$relative}/photo/{$next}">{t c='global.next'}</a>
							{/if}
						</div>
						<div class="clearfix"></div>
						<div id="response_message" style="display: none;"></div>
						{if isset($smarty.session.uid)}
							<div id="flag_photo_box" class="m-t-15" style="display: none;">
								<a href="#close_flag" id="close_flag" class="close">&times;</a>
								<div class="separator">{t c='photo.flag'}</div>
								<div id="flag_photo_response" style="display: none;"></div>
								<div class="form-horizontal">
									<div class="form-group">
										<label class="col-lg-3 control-label">{t c='photo.flag'}</label>
										<div class="col-lg-9">
											<div class="radio">
												<label>
													<input name="flag_reason" type="radio" value="inappropriate" checked="yes" />
													{t c='flag.inappr'}
												</label>
											</div>
											<div class="radio">
												<label>
													<input name="flag_reason" type="radio" value="underage" />
													{t c='flag.underage'}
												</label>
											</div>
											<div class="radio">
												<label>
													<input name="flag_reason" type="radio" value="copyrighted" />
													{t c='flag.copyright'}
												</label>
											</div>
											<div class="radio">
												<label>
													<input name="flag_reason" type="radio" value="other" />
													{t c='flag.other'}
												</label>
											</div>
											<div id="flag_reason_error" class="text-danger m-t-5" style="display: none;"></div>
										</div>
									</div>
									<div class="form-group">
										<label for="flag_message" class="col-lg-3 control-label">{t c='flag.reason'}</label>
										<div class="col-lg-9">
											<textarea name="flag_message" class="form-control" rows="3" id="flag_message"></textarea>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-9 col-lg-offset-3">
											<input name="submit_flag" type="button" value=" {t c='photo.flag_send'} " id="submit_flag_photo_{$photo.PID}" class="btn btn-primary" />
										</div>
									</div>
								</div>								
							</div>
						{/if}
						<div id="share_photo_box" class="m-t-15" style="display: none;">	
							<a href="#close_share" id="close_share" class="close">&times;</a>
							<div class="separator">{t c='global.share'}</div>
							<div id="share_photo_response" style="display: none;"></div>
							<div id="share_video_form">
								<form class="form-horizontal" name="share_video_form" method="post" action="#share_video">
									<div class="form-group">
										<label for="share_from" class="col-lg-3 control-label">{t c='global.from'}</label>
										<div class="col-lg-9">
											<input name="from" type="text" class="form-control" value="{if isset($smarty.session.uid)}{if $smarty.session.fname != ''}{$smarty.session.fname}{else}{$smarty.session.username}{/if}{/if}" id="share_from" placeholder="{t c='global.from'}" />
											<div id="share_from_error" class="text-danger m-t-5" style="display: none;"></div>
										</div>
									</div>								
									<div class="form-group">
										<label for="share_to" class="col-lg-3 control-label">{t c='global.To'}</label>
										<div class="col-lg-9">
											<textarea name="to" class="form-control" rows="3" id="share_to" placeholder="{t c='global.share_expl' s=$site_name}"></textarea>
											<div id="share_to_error" class="text-danger m-t-5" style="color: red; display: none;"></div>
										</div>
									</div>
									<div class="form-group">
										<label for="share_message" class="col-lg-3 control-label">{t c='global.message_opt'}</label>
										<div class="col-lg-9">
											<textarea name="message" class="form-control" rows="3" id="share_message" placeholder="{t c='global.message_opt'}" ></textarea>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-9 col-lg-offset-3">
											<input name="submit_share" type="button" value=" {t c='photo.share_send'} " id="send_share_photo_{$photo.PID}" class="btn btn-primary" />
										</div>
									</div>									
								</form>
							</div>
						</div>
						{if isset($smarty.session.uid) && $photo_comments == '1'}
							<div class="separator m-t-15"></div>
							<div id="post_comment">
								<form class="form-horizontal" name="postPhotoComment" id="postPhotoComment" method="post" action="">
									<div class="form-group">
										<div class="col-xs-12 col-sm-10 col-sm-offset-1">
											<textarea name="photo_comment" id="photo_comment" rows="5" class="form-control" placeholder="{t c='global.add_comment'}"></textarea>
											<div id="post_message" class="text-danger m-t-5" style="display: none;">{t c='global.comment_empty'}!</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-12 col-sm-10 col-sm-offset-1">
											<div class="pull-left">
												<input name="submit_comment" type="button" value=" {t c='global.post'} " id="post_photo_comment_{$photo.AID}_{$photo.PID}" class="btn btn-primary" />
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
						
							<div id="photo_comments_{$photo.PID}">
								{if $comments}
									{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span id="end_num" class="text-white">{$end_num}</span> {t c='global.of'} <span id="total_comments" class="text-white">{$comments_total}</span> {t c='global.comments'}.
								{/if}
								<div id="photo_response" class="response" style="display: none;"></div>
								<div id="comments_delimiter" style="display: none;"></div>
								
								{if $comments}
									{section name=i loop=$comments}
										
										<div id="photo_comment_{$photo.PID}_{$comments[i].CID}" class="col-xs-12 m-t-15">
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
																<a href="#delete_comment" id="delete_comment_photo_{$comments[i].CID}_{$photo.PID}">{t c='global.delete'}</a> <span id="delete_response_{$comments[i].CID}" style="display: none;"></span>
															{else}
																<span id="reported_spam_{$comments[i].CID}_{$photo.PID}"><a href="#report_spam" id="report_spam_photo_{$comments[i].CID}_{$photo.PID}">{t c='global.report_spam'}</a></span>
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
						
					{/if}
				</div>
				
			</div>	
		</div>
	</div>
</div>

