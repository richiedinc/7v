<!DOCTYPE html>
<html lang="en">
{if $view}
	<head prefix="og: http://ogp.me/ns#">
{else}
	<head>
{/if}
	{if $view}
		{assign var='vtags' value=$video.keyword}
	
		<meta property="og:site_name" content="{$site_name}">
		<meta property="og:title" content="{$video.title|escape:'html'}">
		<meta property="og:url" content="{$baseurl}/video/{$video.VID}/{$video.title|clean}">
		<meta property="og:type" content="video">
		<meta property="og:image" content="{insert name=thumb_path vid=$video.VID}/{if $video.embed_code != ''}1{else}default{/if}.jpg">
		<meta property="og:description" content="{if $video.description}{$video.description|escape:'html'}{else}{$video.title|escape:'html'}{/if}">
	{section name=i loop=$vtags}
	<meta property="video:tag" content="{$vtags[i]}">
	{/section}			
		{if !$video.embed_code}	
			{include file='player_settings.tpl'}	
		{/if}
	{/if}

    <title>{if isset($self_title) && $self_title != ''}{$self_title|escape:'html'}{else}{$site_name}{/if}</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="robots" content="index, follow" />
    <meta name="revisit-after" content="1 days" />
    <meta name="keywords" content="{if isset($self_keywords) && $self_keywords != ''}{$self_keywords|escape:'html'}{else}{$meta_keywords}{/if}" />
    <meta name="description" content="{if isset($self_description) && $self_description != ''}{$self_description|escape:'html'}{else}{$meta_description}{/if}" />

	<link rel="Shortcut Icon" type="image/ico" href="/favicon.ico" />
	<link rel="apple-touch-icon" href="{$relative_tpl}/img/webapp-icon.png">

    <script type="text/javascript">
    var base_url = "{$baseurl}";
	var max_thumb_folders = "{$max_thumb_folders}";
    var tpl_url = "{$relative_tpl}";
	{if isset($video.VID)}var video_id = "{$video.VID}";{/if}
	var lang_deleting = "{t c='global.deleting'}";
	var lang_flaging = "{t c='global.flaging'}";
	var lang_loading = "{t c='global.loading'}";
	var lang_sending = "{t c='global.sending'}";
	var lang_share_name_empty = "{t c='share.name_empty'}";
	var lang_share_rec_empty = "{t c='share.recipient'}";
	var fb_signin = "{$fb_signin}";
	var fb_appid = "{$fb_appid}";
	var g_signin = "{$g_signin}";
	var g_cid = "{$g_cid}";
	var signup_section = false;
	var relative = "{$relative}";
	</script>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	
	<link href="{$relative_tpl}/css/bootstrap.css" rel="stylesheet">
	<link href="{$relative_tpl}/css/style.css" rel="stylesheet">
	<link href="{$relative_tpl}/css/responsive.css" rel="stylesheet">
	<link href="{$relative_tpl}/css/font-awesome.min.css" rel="stylesheet">		
	<link href="{$relative_tpl}/css/colors.css" rel="stylesheet">
	
	<!-- Video Player -->
	{if $view && !$video.embed_code}
		<link href="{$baseurl}/media/player/videojs/video-js.css" rel="stylesheet">	
		<link href="{$baseurl}/media/player/videojs/plugins/videojs-resolution-switcher-master/lib/videojs-resolution-switcher.css" rel="stylesheet">		
		<link href="{$baseurl}/media/player/videojs/plugins/videojs-logobrand-master/src/videojs.logobrand.css" rel="stylesheet">
		<link href="{$baseurl}/media/player/videojs/plugins/videojs-thumbnails-master/videojs.thumbnails.css" rel="stylesheet">
		<link href="{$baseurl}/media/player/videojs/video-js-custom.css" rel="stylesheet">					
		
		<script src="{$baseurl}/media/player/videojs/ie8/videojs-ie8.min.js"></script>
		<script src="{$baseurl}/media/player/videojs/video.js"></script>
		<script src="{$baseurl}/media/player/videojs/plugins/videojs-resolution-switcher-master/lib/videojs-resolution-switcher.js"></script>
		<script src="{$baseurl}/media/player/videojs/plugins/videojs-logobrand-master/src/videojs.logobrand.js"></script>
		<script src="{$baseurl}/media/player/videojs/plugins/videojs-thumbnails-master/videojs.thumbnails.js"></script>
	{/if}	
	<!-- End Video Player -->
	
</head>
<body>

<div class="modal fade in" id="login-modal">
	<div class="modal-dialog login-modal">
      <div class="modal-content">
        <form name="login_form" method="post" action="{$relative}/login">
		<div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title">{t c='signup.login'}</h4>
        </div>
        <div class="modal-body">
			<center>
				<div class="m-b-5"></div>
				{if $fb_signin == '1'}
					<div>
						<button id="facebook-signin" class="btn btn-facebook" disabled><div></div><i class="fa fa-facebook"></i> <span>{t c='socialsignup.login_with'} Facebook</span></button>
					</div>
					<div class="hr">
						<div class="inner inner-login">{t c='socialsignup.or'}</div>
					</div>
				{/if}
				{if $g_signin == '1'}						
					<div>
						<button id="google-signin" class="btn btn-google" disabled><div></div><i class="fa fa-google-plus"></i> <span>{t c='socialsignup.login_with'} Google</span></button>
					</div>
					<div class="hr">
						<div class="inner inner-login">{t c='socialsignup.or'}</div>
					</div>
				{/if}
			</center>	
			<div class="form-group">
				<label for="login_username" class="control-label">{t c='global.username'}:</label>
				<input name="username" type="text" value="" id="login_username" class="form-control" />
			</div>
			<div class="form-group">
				<label for="login_password" class="control-label">{t c='global.password'}:</label>
				<input name="password" type="password" value="" id="login_password" class="form-control" />
			</div>
			<a href="{$relative}/lost" id="lost_password">{t c='global.forgot'}</a><br />
			<a href="{$relative}/confirm" id="confirmation_email">{t c='global.confirm'}</a>		
        </div>
        <div class="modal-footer">
          <button name="submit_login" id="login_submit" type="submit" class="btn btn-primary">{t c='global.login'}</button>
          <a href="{$relative}/signup" class="btn btn-secondary">{translate c='global.sign_up'}</a>
        </div>
		</form>			
      </div>
    </div>
</div>

{if $fb_signin == '1'}
	{include file='fb_signup_modal.tpl'}
{/if}
{if $g_signin == '1'}
	{include file='g_signup_modal.tpl'}
{/if}

<div class="modal fade in" id="language-modal">
	<div class="modal-dialog language-modal">
      <div class="modal-content">
        
		<div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title">{t c='global.select_language'}</h4>
        </div>
        <div class="modal-body">
			<div class="row">
				{foreach from=$languages key=key item=language }
					<div class="col-xs-6 col-sm-4">
						{if $smarty.session.language != $key}
							<a href="#" id="{$key}" class="change-language">{$language.name}</a>
						{else}
							<span class="change-language language-active">{$language.name}</span>
						{/if}
					</div>
				{/foreach}
			</div>
			<form name="languageSelect" id="languageSelect" method="post" action="">
			<input name="language" id="language" type="hidden" value="" />
			</form>
        </div>

		
      </div>
    </div>
</div>
<div class="top-nav">
	<div class="container">
		<ul class="top-menu">
			{if $multi_language}
				<div class="pull-left">
					{insert name=language assign=flag}
					<li><a data-toggle="modal" href="#language-modal">{$flag} <span class="caret"></span></a></li>					
				</div>
			{/if}
			<div class="pull-right">
			{if isset($smarty.session.uid)}
				<li class="dropdown">
					<a class="dropdown-toggle"  data-toggle="dropdown" href="#">
						<span class="visible-xs">
							{if $requests_count > 0 || $mails_count > 0}<div class="badge">{$requests_count+$mails_count}</div>{/if} {$smarty.session.username|truncate:15:"..."} <span class="caret"></span>
						</span>
						<span class="hidden-xs">
							{if $requests_count > 0 || $mails_count > 0}<div class="badge">{$requests_count+$mails_count}</div>{/if} {$smarty.session.username|truncate:35:"..."} <span class="caret"></span>
						</span>
					</a>
					<ul class="dropdown-menu pull-right m-t-0">
						<li><a href="{$relative}/user">{t c='topnav.my_profile'}</a></li>
						{if $video_module == '1'}<li><a href="{$relative}/user/{$smarty.session.username}/videos">{t c='topnav.my_videos'}</a></li>{/if}
						{if $photo_module == '1'}<li><a href="{$relative}/user/{$smarty.session.username}/albums">{t c='topnav.my_photos'}</a></li>{/if}
						{if $game_module == '1'}<li><a href="{$relative}/user/{$smarty.session.username}/games">{t c='topnav.my_games'}</a></li>{/if}
						<li><a href="{$relative}/user/{$smarty.session.username}/blog">{t c='topnav.my_blog'}</a></li>
						<li><a href="{$relative}/feeds">{translate c='global.my_feeds'}</a></li>
						<li><a href="{$relative}/requests"><span class="pull-left">{translate c='global.requests'}</span>{if $requests_count > 0}<div class="badge pull-right">{$requests_count}</div>{/if}<div class="clearfix"></div></a></li>
						<li><a href="{$relative}/mail/inbox"><span class="pull-left">{translate c='global.inbox'}</span>{if $mails_count > 0}<div class="badge pull-right">{$mails_count}</div>{/if}<div class="clearfix"></div></a></li>
					</ul>
				</li>			
				<li><a href="{$relative}/logout">{translate c='global.sign_out'}</a></li>
			{else}
				<li><a href="{$relative}/signup" rel="nofollow">{translate c='global.sign_up'}</a></li>
				<li><a data-toggle="modal" href="#login-modal">{translate c='global.login'}</a></li>	
			{/if}
			</div>
			<div class="clearfix"></div>
		</ul> 
	</div>
</div>
<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-inverse-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="{$relative}/"><img src="{$relative}/images/logo/logo.png"></a> 
		</div>
		<div class="navbar-collapse collapse navbar-inverse-collapse">
			<ul class="nav navbar-nav navbar-right">
				{if $video_module == '1'}<li{if $menu == 'videos'} class="active"{/if}><a href="{$relative}/videos">{translate c='menu.videos'}</a></li>{/if}
				{if $photo_module == '1'}<li{if $menu == 'albums'} class="active"{/if}><a href="{$relative}/albums">{translate c='menu.photos'}</a></li>{/if}
				{if $game_module == '1'}<li{if $menu == 'games'} class="active"{/if}><a href="{$relative}/games">{translate c='menu.games'}</a></li>{/if}
				
				<li class="dropdown visible-sm hidden-xs hidden-md hidden-lg">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">{translate c='menu.more'} <b class="caret"></b></a>
						<ul class="dropdown-menu">
							{if $blog_module == '1'}<li{if $menu == 'blogs'} class="active"{/if}><a href="{$relative}/blogs">{translate c='menu.blogs'}</a></li>{/if}
							<li{if $menu == 'categories'} class="active"{/if}>{if $video_module == '1'}<a href="{$relative}/categories">{elseif $photo_module == '1'}<a href="{$relative}/categories?s=a">{else}<a href="{$relative}/categories?s=g">{/if}{translate c='menu.categories'}</a></li>
							<li{if $menu == 'community'} class="active"{/if}><a href="{$relative}/community">{translate c='menu.community'}</a></li>
						</ul>
				</li>
				
				{if $blog_module == '1'}<li{if $menu == 'blogs'} class="active hidden-sm"{else} class="hidden-sm"{/if}><a href="{$relative}/blogs">{translate c='menu.blogs'}</a></li>{/if}
				<li{if $menu == 'categories'} class="active hidden-sm"{else} class="hidden-sm"{/if}>{if $video_module == '1'}<a href="{$relative}/categories">{elseif $photo_module == '1'}<a href="{$relative}/categories?s=a">{else}<a href="{$relative}/categories?s=g">{/if}{translate c='menu.categories'}</a></li>
				<li{if $menu == 'community'} class="active hidden-sm"{else} class="hidden-sm"{/if}><a href="{$relative}/community">{translate c='menu.community'}</a></li>
				<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-search"></i></a>
				<ul class="dropdown-menu search-dropdown-menu">
					<form class="form-inline" name="search" id="search_form" method="get" action="{$relative}/search/{if !isset($search_type)}videos{else}{$search_type}{/if}">
						<div class="input-group">
						<input type="text" class="form-control" placeholder="{t c='ajax.search'}" name="search_query" id="search_query" value="{if isset($search_query)}{$search_query}{/if}">
						<span class="search-select input-group-addon">
							<select class="form-control" id="search_type">
								<option value="videos"{if isset($search_type) && $search_type == 'videos'} selected="yes"{/if}>{translate c='global.videos'}</option>
								{if $photo_module == '1'}<option value="photos"{if isset($search_type) && $search_type == 'photos'} selected="yes"{/if}>{translate c='global.photos'}</option>{/if}
								{if $game_module == '1'}<option value="games"{if isset($search_type) && $search_type == 'games'} selected="yes"{/if}>{translate c='global.games'}</option>{/if}
								<option value="users"{if isset($search_type) && $search_type == 'users'} selected="yes"{/if}>{translate c='global.users'}</option>
							</select>		
						</span>
						<span class="input-group-btn">
							<button type="submit" class="btn btn-primary"><i class="fa fa-search"></i></button>
						</span>
						</div>
					</form>
				</ul>
				</li>
				<li><button type="button" class="btn btn-primary navbar-btn m-l-15 m-r-15" onclick="location.href='{$relative}/upload'">{translate c='menu.upload'}</button></li>						
			</ul>
			
		</div><!--/.nav-collapse -->
    </div>
</div>
<div id="wrapper">

