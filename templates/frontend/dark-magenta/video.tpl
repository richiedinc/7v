<script type="text/javascript">
var lang_favoriting = "{t c='global.favoriting'}";
var lang_posting = "{t c='global.posting'}";
var video_width = "{$video_width}";
var video_height = "{$video_height}";
var evideo_vkey = "{$video.vkey}";
{literal}
$( document ).ready(function() {

    var evdiv = $('.video-embedded');
	var ewidth = evdiv.width();
	eheight =  Math.round(ewidth / 1.777);
	evdiv.css("height" , eheight);

	$(window).resize(function() {
	var evwidth = $('.video-embedded').width();
	evheight =  Math.round(evwidth / 1.777);
	$('.video-embedded').css("height" , evheight);	
	});	
});
{/literal}

</script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.video-0.2.js"></script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.voting-video-0.1.js"></script>

<div class="container">
	<div class="row">
		{if $guest_limit}
			<div class="col-xs-12">
				<div class="text-danger">{t c='video.limit'}</div>
			</div>
		{elseif !$is_friend}
			<div class="col-xs-12">	
				<div class="well well-sm">
					<div class="text-danger">{t c='video.private' r=$relative s=$video.username sn=$video.username}</div>
				</div>
			</div>
		{else}
			<div class="col-md-8">
					<h3 class="hidden-xs big-title-truncate m-t-0">{$video.title|escape:'html'}</h3>
					<h4 class="visible-xs big-title-truncate m-t-0">{$video.title|escape:'html'}</h4>
			</div>
		{/if}
	</div>
	{if $is_friend && !$guest_limit}
		<div class="row">
			<div class="col-md-8">
				<div>
					{include file='video_vplayer.tpl'}
				</div>
				<div class="vote-box col-xs-7 col-sm-2 col-md-2">
					<div class="dislikes {if $video.likes == 0 and $video.dislikes == 0}not-voted{/if}">
						<div id="video_rate" class="likes" style="width: {$video.rate}%;"></div>
					</div>
					<div id="vote_msg" class="vote-msg">
						<div class="pull-left">
							<i class="glyphicon glyphicon-thumbs-up"></i> <span id="video_likes" class="text-white">{$video.likes}</span>
						</div>
						<div class="pull-right">
							<i class="glyphicon glyphicon-thumbs-down"></i> <span id="video_dislikes" class="text-white">{$video.dislikes}</span>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<div class="pull-right visible-xs">
					<div class="pull-left m-t-15">
						<a href="#" class="btn btn-primary" id="vote_like_{$video.VID}" ><i class="glyphicon glyphicon-thumbs-up"></i></a>
						<a href="#" class="btn btn-primary" id="vote_dislike_{$video.VID}"><i class="glyphicon glyphicon-thumbs-down"></i></a>
					</div>				
				</div>
				<div class="clearfix visible-xs"></div>
				<div class="pull-left m-l-5 hidden-xs">
					<div class="pull-left m-t-15">
						<a href="#" class="btn btn-primary" id="vote_like_{$video.VID}" ><i class="glyphicon glyphicon-thumbs-up"></i></a>
						<a href="#" class="btn btn-primary" id="vote_dislike_{$video.VID}"><i class="glyphicon glyphicon-thumbs-down"></i></a>
					</div>				
				</div>
				<div class="pull-right m-t-15">
					<div id="share_video" class="pull-right"><a href="#share_video" class="btn btn-default"><i class="glyphicon glyphicon-share-alt"></i> <span class="hidden-xs">{t c='global.share'}</span></a></div>							
					{if isset($smarty.session.uid)}
						<div id="flag_video" class="pull-right m-r-5"><a href="#flag_video" class="btn btn-default"><i class="glyphicon glyphicon-flag"></i> <span class="hidden-xs">{t c='global.flag'}</span></a></div>
						<div id="favorite_video" class="pull-right m-r-5"><a href="#favorite_video" class="btn btn-default" id="favorite_video_{$video.VID}"><i class="glyphicon glyphicon-heart"></i> <span class="hidden-xs">{t c='global.favorite'}</span></a></div>
					{/if}
						{if $video_embed == '1' && $video.embed_code == '' && $is_friend}
						<div id="embed_video" class="pull-right m-r-5"><a href="#embed_video" class="btn btn-default"><i class="glyphicon glyphicon-link"></i> <span class="hidden-xs">{t c='global.embed'}</span></a></div>
						{/if}					
					<div class="clearfix"></div>
				</div>
				{if $downloads == '1' && $video.embed_code == '' && $is_friend}
					<div class="pull-right m-t-15 m-r-5">
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-download-alt"></i><span class="hidden-xs hidden-sm hidden-sm hidden-md hidden-lg"> {t c='global.download'}</span> <span class="caret"></span></button>
							<ul class="dropdown-menu">
								{if $video.formats}
									{section name=i loop=$video.files}
										<li><a href="{$baseurl}/download.php?id={$video.VID}&label={$video.files[i].label}">{if $video.files[i].height >= 480}HD - {$video.files[i].label} (MP4){else}SD - {$video.files[i].label} (MP4){/if}</a></li>										
									{/section}								
								{else}
									{if $video.hd == '1'}<li><a href="{$baseurl}/download_hd.php?id={$video.VID}">HD (MP4)</a></li>{/if}
									{if $video.iphone == '1'}<li><a href="{$baseurl}/download_mobile.php?id={$video.VID}">Mobile (MP4)</a></li>{/if}
								{/if}
							</ul>
						</div>				
					</div>
				{/if}						
				<div class="clearfix"></div>
				<div id="response_message" style="display: none;"></div>
				{if $video_embed == '1' && $video.embed_code == '' && $is_friend}
				<div id="embed_video_box" class="m-t-15" style="display: none;">
					<a href="#close_embed" id="close_embed" class="close">&times;</a>					
					<div class="separator">{t c='video.EMBED'}</div>
					<div class="form-horizontal">
						<div class="form-group">
							<label for="video_embed_code" class="col-lg-3 control-label">{t c='video.embed_code'}</label>
							<div class="col-lg-9">
								{include file='video_embed_vplayer.tpl'}
							</div>
						</div>
						<div id="custom_size" class="form-group">
							<label for="custom_width" class="col-lg-3 control-label">{t c='video.embed_custom_size'}</label>
							<div class="col-lg-9">
								<div class="pull-left">
									<input id="custom_width" type="text" class="form-control" value="" placeholder="{t c='video.width'}" style="width: 100px!important;"/>									
								</div>
								<div class="pull-left m-l-5 m-r-5" style="line-height: 38px;">
									&times;
								</div>
								<div class="pull-left m-r-15">
									<input id="custom_height" type="text" class="form-control" value="" placeholder="{t c='video.height'}" style="width: 100px!important;"/>
								</div>
								<div class="pull-left" style="line-height: 38px;">
									{t c='video.embed_custom_size_min'}
								</div>								
							</div>
						</div>						
					</div>
				</div>
				{/if}				
				{if isset($smarty.session.uid)}
					<div id="flag_video_box" class="m-t-15" style="display: none;">
						<a href="#close_flag" id="close_flag" class="close">&times;</a>
						<div class="separator">{t c='video.flag'}</div>
						<div id="flag_video_response" style="display: none;"></div>
						<div class="form-horizontal">
							<div class="form-group">
								<label class="col-lg-3 control-label">{t c='video.flag'}</label>
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
											<input name="flag_reason" type="radio" value="not_playing" />
											{t c='flag.not_playing'}
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
									<input name="submit_flag" type="button" value=" {t c='video.flag'} " id="submit_flag_video_{$video.VID}" class="btn btn-primary" />
								</div>
							</div>
						</div>								
					</div>
				{/if}				
				<div id="share_video_box" class="m-t-15" style="display: none;">	
					<a href="#close_share" id="close_share" class="close">&times;</a>
					<div class="separator">{t c='video.SHARE'}</div>
					<div id="share_video_response" style="display: none;"></div>
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
									 <input name="submit_share" type="button" value=" {t c='video.share'} " id="send_share_video_{$video.VID}" class="btn btn-primary" />
								</div>
							</div>									
						</form>
					</div>
				</div>				
				<div class="separator m-t-15 p-0"></div>
				<div class="pull-left user-container">
					<a href="{$relative}/user/{$video.username}"><img class="medium-avatar" src="{$relative}/media/users/{if $video.photo == ''}nopic-{$video.gender}.gif{else}{$video.photo}{/if}" /><span>{$video.username}</span></a>
				</div>
				{insert name=time_range assign=addtime time=$video.addtime}
				<div class="pull-right big-views hidden-xs">
					<span class="text-white">{$addtime}</span>,
					<span class="text-white">{$video.viewnumber}</span> {if $video.viewnumber == '1'}{t c='global.view'}{else}{t c='global.views'}{/if}
				</div>
				<div class="pull-right big-views-xs visible-xs">
					<span class="text-white">{$addtime}</span>,
					<span class="text-white">{$video.viewnumber}</span> {if $video.viewnumber == '1'}{t c='global.view'}{else}{t c='global.views'}{/if}					
				</div>					
				<div class="clearfix"></div>
				{if $video.description}
					<div class="m-t-10 overflow-hidden">
						{$video.description}
					</div>
				{/if}
				<div class="m-t-10 overflow-hidden">
					{assign var='keywords' value=$video.keyword}
					{t c='global.tags'}:
					{section name=i loop=$keywords}
						<a class="tag" href="{$relative}/search/videos?search_query={$keywords[i]}">{$keywords[i]}</a>{if !$smarty.section.i.last},{/if}
					{/section}						
				</div>
				<div class="m-t-10 m-b-15">
					<!-- Go to www.addthis.com/dashboard to customize your tools -->
					<div class="addthis_sharing_toolbox"></div>
					<!-- Go to www.addthis.com/dashboard to customize your tools -->
					<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=avsbookmark"></script>
				</div>
			</div>
			<div class="col-md-4">
				<div class="well ad-body">
					<p class="ad-title">{t c='global.sponsors'}</p>
					{insert name=adv assign=adv group='video_right'}
					{if $adv}{$adv}{/if}
				</div>
				<div class="well ad-body">
					<p class="ad-title">{t c='global.sponsors'}</p>
					{insert name=adv assign=adv group='video_right_second'}
					{if $adv}{$adv}{/if}
				</div>			
			</div>
		</div>
		<ul class="nav nav-tabs">
			<li class="active"><a href="#related_videos" data-toggle="tab">{t c='video.RELATED'}{if $videos_total > 0} <div class="badge">{$videos_total}</div>{/if}</a></li>
			<li class=""><a href="#comments" data-toggle="tab">{t c='global.COMMENTS'}{if $comments_total > 0} <div class="badge" id="total_video_comments">{$comments_total}</div>{/if}</a></li>
		</ul>
		<div class="tab-content m-b-20">
			<div class="tab-pane fade active in" id="related_videos">
			 {if $videos}
		        <input name="current_page_related_videos" type="hidden" value="1" id="current_page_related_videos" />
				<div class="row">
				{section name=i loop=$videos}
					<div class="col-sm-6 col-md-3 col-lg-3">
						<div class="well well-sm m-b-0 m-t-20">
							<a href="{$relative}/video/{$videos[i].VID}/{$videos[i].title|clean}">
								<div class="thumb-overlay">
									<img src="{insert name=thumb_path vid=$videos[i].VID}/{$videos[i].thumb}.jpg" title="{$videos[i].title|escape:'html'}" alt="{$videos[i].title|escape:'html'}" id="rotate_{$videos[i].VID}_{$videos[i].thumbs}_{$videos[i].thumb}" class="img-responsive {if $videos[i].type == 'private'}img-private{/if}"/>
									{if $videos[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
									{if $videos[i].hd==1}<div class="hd-text-icon">HD</div>{/if}
									<div class="duration">
										{insert name=duration assign=duration duration=$videos[i].duration}
										{$duration}
									</div>
								</div>
								<span class="video-title title-truncate m-t-5">{$videos[i].title|escape:'html'}</span>
							</a>
							<div class="video-added">
								{insert name=time_range assign=addtime time=$videos[i].addtime}
								{$addtime}
							</div>
							<div class="video-views pull-left">
								{$videos[i].viewnumber} {if $videos[i].viewnumber == '1'}{t c='global.view'}{else}{t c='global.views'}{/if}
							</div>
							<div class="video-rating pull-right {if $videos[i].rate == 0 && $videos[i].dislikes == 0}no-rating{/if}">
								<i class="fa fa-heart video-rating-heart {if $videos[i].rate == 0 && $videos[i].dislikes == 0}no-rating{/if}"></i> <b>{if $videos[i].rate == 0 && $videos[i].dislikes == 0}-{else}{$videos[i].rate}%{/if}</b>
							</div>	
							<div class="clearfix"></div>
							
						</div>				
					</div>			
				{/section}
				</div>
				<div id="related_videos_container_1"></div>

				{if $videos_total > 8}
					<center>
						<div class="center_related" style="display: none;  margin: -6px 0 -26px 0;"><img src="{$relative_tpl}/img/loading-bubbles.svg"></div>
						<ul class="pager">
						  <li><a href="#prev_related_videos" id="prev_related_videos_{$video.VID}" style="display: none;">{t c='global.hide'}</a></li>
						  <li><a href="#next_related_videos" id="next_related_videos_{$video.VID}" >{t c='global.show_more'}</a></li>
						</ul>					
					</center>
				{/if}				
				
			{else}
			<div class="well well-sm m-t-20">
				<span class="text-danger">{t c='videos.no_videos_found'}.</span>
			</div>
			{/if}				

			</div>
			<div class="tab-pane fade" id="comments">
				<div class="m-b-20"></div>
				{if isset($smarty.session.uid) && $video_comments == '1'}
					<div id="post_comment">
						<form class="form-horizontal"name="postVideoComment" id="postVideoComment" method="post" action="#">
							<div class="form-group">
								<div class="col-xs-12 col-sm-10 col-sm-offset-1">
									<textarea name="video_comment" id="video_comment" rows="5" class="form-control" placeholder="{t c='global.add_comment'}"></textarea>
									<div id="post_message" class="text-danger m-t-5" style="display: none;">{t c='global.comment_empty'}!</div>											
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-12 col-sm-10 col-sm-offset-1">
									<div class="pull-left">
										<input name="submit_comment" type="button" value=" {t c='global.post'} " id="post_video_comment_{$video.VID}" class="btn btn-primary" />
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

				<div id="video_comments_{$video.VID}">
					{if $comments}
						{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span id="end_num" class="text-white">{$end_num}</span> {t c='global.of'} <span id="total_comments" class="text-white">{$comments_total}</span> {t c='global.comments'}.
					{/if}
					<div id="video_response" style="display: none;"></div>
					<div id="comments_delimiter" style="display: none;"></div>
					
					{if $comments}
						{section name=i loop=$comments}
							
							<div id="video_comment_{$video.VID}_{$comments[i].CID}" class="col-xs-12 m-t-15">
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
													<a href="#delete_comment" id="delete_comment_video_{$comments[i].CID}_{$video.VID}">{t c='global.delete'}</a> <span id="delete_response_{$comments[i].CID}" style="display: none;"></span>
												{else}
													<span id="reported_spam_{$comments[i].CID}_{$video.VID}"><a href="#report_spam" id="report_spam_video_{$comments[i].CID}_{$video.VID}">{t c='global.report_spam'}</a></span>
												{/if}
											</div>
										{/if}
									</div>
									<div class="clearfix"></div>
								</div>
								
							</div>
							
						{/section}

						{if $page_link_comments}
							<div class="visible-xs center m-b--15">
								<ul class="pagination pagination-lg">{$page_link_comments}</ul>
							</div>
							<div class="hidden-xs center m-b--15">
								<ul class="pagination">{$page_link_comments}</ul>
							</div>
						{/if}
					{elseif !isset($smarty.session.uid)}
						<div class="well well-sm m-t-20 m-b-0">
							<span class="text-danger">{t c='global.comments.none'}.</span>
						</div>						
					{/if}
				</div>				
				<div class="clearfix"></div>
			</div>
		</div>
	{/if}
	<div class="well ad-body">
		<p class="ad-title">{t c='global.sponsors'}</p>
		{insert name=adv assign=adv group='video_bottom'}
		{if $adv}{$adv}{/if}
	</div>		
</div>