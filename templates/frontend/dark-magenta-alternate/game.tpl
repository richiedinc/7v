<script type="text/javascript">
var lang_favoriting = "{t c='global.favoriting'}";
var lang_posting = "{t c='global.posting'}";
var aspect = "{$aspect}";

{literal}
$( document ).ready(function() {

    var gdiv = $('.game-container');
	var width = gdiv.width();
	height =  Math.round(width / aspect);
	gdiv.css("height" , height);

	
	$(window).resize(function() {
	var vwidth = $('.game-container').width();
	vheight =  Math.round(vwidth / aspect);
	$('.game-container').css("height" , vheight);
	});
	
	$(window).load(function() {

		var checker = setInterval(function(){
			if ( $('.at15t_compact').length > 0) {
				clearInterval(checker);
			}
            jQuery.each($("span[class*='at15t_']"), function() {

                var this_class    = $(this).attr('class');
				var class_split    = this_class.split('_');
				var item_name    = class_split[1];
				$(this).removeClass();
				$(this).addClass("at4-icon aticon-" + item_name);
				
			});	  
		}, 100);
	});
	
});
{/literal}

</script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.game-0.2.js"></script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.voting-game-0.1.js"></script>

<div class="container">
	<div class="row">
		{if !$is_friend}
			<div class="col-xs-12">	
				<div class="well well-sm">
					<div class="text-danger">{t c='game.private' r=$relative u=$game.username un=$game.username}</div>
				</div>
			</div>
		{else}
			<div class="col-md-8">
					<h3 class="hidden-xs big-title-truncate m-t-0">{$game.title|escape:'html'}</h3>
					<h4 class="visible-xs big-title-truncate m-t-0">{$game.title|escape:'html'}</h4>
			</div>
		{/if}
	</div>
	{if $is_friend}
		<div class="row">
			<div class="col-md-8">
				<div>
					<div id="flash-game" class="game-container">
						<center>
							<div class="text-danger">{t c='flash.not_available'}</div>
						</center>					
					</div>
					<script type='text/javascript' src="{$relative_tpl}/js/swfobject.js"></script>
					<script type='text/javascript'>
					var s1 = new SWFObject('{$relative}/media/games/swf/{$game.GID}.swf','flash-game','100%','100%','9');
					s1.addParam('allowfullscreen','true');
					s1.addParam('allowscriptaccess','always');
					s1.addParam('wmode','opaque');
					s1.write('flash-game');
					</script>
				</div>
				<div class="vote-box col-xs-7 col-sm-2 col-md-2">
					<div class="dislikes {if $game.likes == 0 and $game.dislikes == 0}not-voted{/if}">
						<div id="game_rate" class="likes" style="width: {$game.rate}%;"></div>
					</div>
					<div id="vote_msg" class="vote-msg">
						<div class="pull-left">
							<i class="glyphicon glyphicon-thumbs-up"></i> <span id="game_likes" class="text-white">{$game.likes}</span>
						</div>
						<div class="pull-right">
							<i class="glyphicon glyphicon-thumbs-down"></i> <span id="game_dislikes" class="text-white">{$game.dislikes}</span>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<div class="pull-right visible-xs">
					<div class="pull-left m-t-15">
						<a href="#" class="btn btn-primary" id="vote_like_{$game.GID}" ><i class="glyphicon glyphicon-thumbs-up"></i></a>
						<a href="#" class="btn btn-primary" id="vote_dislike_{$game.GID}"><i class="glyphicon glyphicon-thumbs-down"></i></a>
					</div>				
				</div>
				<div class="clearfix visible-xs"></div>
				<div class="pull-left m-l-5 hidden-xs">
					<div class="pull-left m-t-15">
						<a href="#" class="btn btn-primary" id="vote_like_{$game.GID}" ><i class="glyphicon glyphicon-thumbs-up"></i></a>
						<a href="#" class="btn btn-primary" id="vote_dislike_{$game.GID}"><i class="glyphicon glyphicon-thumbs-down"></i></a>
					</div>				
				</div>
				<div class="pull-right m-t-15">
					<div id="share_game" class="pull-right"><a href="#share_game" class="btn btn-default"><i class="glyphicon glyphicon-share-alt"></i> <span class="hidden-xs">{t c='global.share'}</span></a></div>							
					{if isset($smarty.session.uid)}
						<div id="flag_game" class="pull-right m-r-5"><a href="#flag_game" class="btn btn-default"><i class="glyphicon glyphicon-flag"></i> <span class="hidden-xs">{t c='global.flag'}</span></a></div>
						<div id="favorite_game" class="pull-right m-r-5"><a href="#favorite_game" class="btn btn-default" id="favorite_game_{$game.GID}"><i class="glyphicon glyphicon-heart"></i> <span class="hidden-xs">{t c='global.favorite'}</span></a></div>
					{/if}
					<div class="clearfix"></div>
				</div>
						
				<div class="clearfix"></div>
				<div id="response_message" style="display: none;"></div>
				{if isset($smarty.session.uid)}
					<div id="flag_game_box" class="m-t-15" style="display: none;">
						<a href="#close_flag" id="close_flag" class="close">&times;</a>
						<div class="separator">{t c='game.flag'}</div>
						<div id="flag_game_response" style="display: none;"></div>
						<div class="form-horizontal">
							<div class="form-group">
								<label class="col-lg-3 control-label">{t c='game.flag'}</label>
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
									<input name="submit_flag" type="button" value=" {t c='game.flag'} " id="submit_flag_game_{$game.GID}" class="btn btn-primary" />
								</div>
							</div>
						</div>								
					</div>
				{/if}				
				<div id="share_game_box" class="m-t-15" style="display: none;">	
					<a href="#close_share" id="close_share" class="close">&times;</a>
					<div class="separator">{t c='game.share'}</div>
					<div id="share_game_response" style="display: none;"></div>
					<div id="share_game_form">
						<form class="form-horizontal" name="share_game_form" method="post" action="#share_game">
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
									 <input name="submit_share" type="button" value=" {t c='game.share'} " id="send_share_game_{$game.GID}" class="btn btn-primary" />
								</div>
							</div>									
						</form>
					</div>
				</div>				
				<div class="separator m-t-15 p-0"></div>
				<div class="pull-left user-container">
					<a href="{$relative}/user/{$game.username}"><img class="medium-avatar" src="{$relative}/media/users/{if $game.photo == ''}nopic-{$game.gender}.gif{else}{$game.photo}{/if}" /><span>{$game.username}</span></a>
				</div>
				{insert name=time_range assign=addtime time=$game.addtime}
				<div class="pull-right big-views hidden-xs">
					<span class="text-white">{$addtime}</span>,
					<span class="text-white">{$game.total_plays}</span> {if $game.total_plays == '1'}{t c='global.play'}{else}{t c='global.plays'}{/if}
				</div>
				<div class="pull-right big-views-xs visible-xs">
					<span class="text-white">{$addtime}</span>,
					<span class="text-white">{$game.total_plays}</span> {if $game.total_plays == '1'}{t c='global.play'}{else}{t c='global.plays'}{/if}
				</div>					
				<div class="clearfix"></div>
				<div class="m-t-10 overflow-hidden">
					{assign var='keywords' value=$game.tags}
					{t c='global.tags'}:
					{section name=i loop=$keywords}
						<a class="tag" href="{$relative}/search?search_type=games&search_query={$keywords[i]}">{$keywords[i]}</a>{if !$smarty.section.i.last},{/if}
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
					{insert name=adv assign=adv group='game_right'}
					{if $adv}{$adv}{/if}
				</div>
				<div class="well ad-body">
					<p class="ad-title">{t c='global.sponsors'}</p>
					{insert name=adv assign=adv group='game_right_second'}
					{if $adv}{$adv}{/if}
				</div>			
			</div>
		</div>
		<ul class="nav nav-tabs">
			<li class="active"><a href="#related_games" data-toggle="tab">{t c='game.related'}{if $games_total > 0} <div class="badge">{$games_total}</div>{/if}</a></li>
			<li class=""><a href="#comments" data-toggle="tab">{t c='global.COMMENTS'}{if $comments_total > 0} <div class="badge" id="total_game_comments">{$comments_total}</div>{/if}</a></li>
		</ul>
		<div class="tab-content m-b-20">
			<div class="tab-pane fade active in" id="related_games">
			 {if $games}
		        <input name="current_page_related_games" type="hidden" value="1" id="current_page_related_games" />
				<div class="row">
				{section name=i loop=$games}
					<div class="col-sm-6 col-md-3 col-lg-3">
						<div class="well well-sm m-b-0 m-t-20">
							<a href="{$relative}/game/{$games[i].GID}/{$games[i].title|clean}">
								<div class="thumb-overlay">
									<img src="{$relative}/media/games/tmb/{$games[i].GID}.jpg" title="{$games[i].title|escape:'html'}" alt="{$games[i].title|escape:'html'}" class="img-responsive {if $games[i].type == 'private'}img-private{/if}"/>
									{if $games[i].type == 'private'}<div class="label-private">{t c='global.PRIVATE'}</div>{/if}
								</div>
								<span class="game-title title-truncate m-t-5">{$games[i].title|escape:'html'}</span>
							</a>
							<div class="game-added">
								{insert name=time_range assign=addtime time=$games[i].addtime}
								{$addtime}
							</div>
							<div class="game-views pull-left">
								{$games[i].total_plays} {if $games[i].total_plays == '1'}{t c='global.play'}{else}{t c='global.plays'}{/if}
							</div>
							<div class="game-rating pull-right {if $games[i].rate == 0 && $games[i].dislikes == 0}no-rating{/if}">
								<i class="fa fa-heart video-rating-heart {if $games[i].rate == 0 && $games[i].dislikes == 0}no-rating{/if}"></i> <b>{if $games[i].rate == 0 && $games[i].dislikes == 0}-{else}{$games[i].rate}%{/if}</b>
							</div>	
							<div class="clearfix"></div>
							
						</div>				
					</div>			
				{/section}
				</div>
				<div id="related_games_container_1"></div>

				{if $games_total > 8}
					<center>
						<div class="center_related" style="display: none;  margin: -6px 0 -26px 0;"><img src="{$relative_tpl}/img/loading-bubbles.svg"></div>
						<ul class="pager">
						  <li><a href="#prev_related_games" id="prev_related_games_{$game.GID}" style="display: none;">{t c='global.hide'}</a></li>
						  <li><a href="#next_related_games" id="next_related_games_{$game.GID}" >{t c='global.show_more'}</a></li>
						</ul>					
					</center>
				{/if}				
				
			{else}
			<div class="well well-sm m-t-20">
				<span class="text-danger">{t c='game.related_none'}.</span>
			</div>
			{/if}				

			</div>
			<div class="tab-pane fade" id="comments">
				<div class="m-b-20"></div>
				{if isset($smarty.session.uid) && $game_comments == '1'}
					<div id="post_comment">
						<form class="form-horizontal"name="postVideoComment" id="postVideoComment" method="post" action="#">
							<div class="form-group">
								<div class="col-xs-12 col-sm-10 col-sm-offset-1">
									<textarea name="game_comment" id="game_comment" rows="5" class="form-control" placeholder="{t c='global.add_comment'}"></textarea>
									<div id="post_message" class="text-danger m-t-5" style="display: none;">{t c='global.comment_empty'}!</div>											
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-12 col-sm-10 col-sm-offset-1">
									<div class="pull-left">
										<input name="submit_comment" type="button" value=" {t c='global.post'} " id="post_game_comment_{$game.GID}" class="btn btn-primary" />
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

				<div id="game_comments_{$game.GID}">
					{if $comments}
						{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span id="end_num" class="text-white">{$end_num}</span> {t c='global.of'} <span id="total_comments" class="text-white">{$comments_total}</span> {t c='global.comments'}.
					{/if}
					<div id="game_response" style="display: none;"></div>
					<div id="comments_delimiter" style="display: none;"></div>
					
					{if $comments}
						{section name=i loop=$comments}
							
							<div id="game_comment_{$game.GID}_{$comments[i].CID}" class="col-xs-12 m-t-15">
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
													<a href="#delete_comment" id="delete_comment_game_{$comments[i].CID}_{$game.GID}">{t c='global.delete'}</a> <span id="delete_response_{$comments[i].CID}" style="display: none;"></span>
												{else}
													<span id="reported_spam_{$comments[i].CID}_{$game.GID}"><a href="#report_spam" id="report_spam_game_{$comments[i].CID}_{$game.GID}">{t c='global.report_spam'}</a></span>
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
		{insert name=adv assign=adv group='game_bottom'}
		{if $adv}{$adv}{/if}
	</div>		
</div>