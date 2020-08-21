<!DOCTYPE html>
<html>
<head>
	{include file='player_settings.tpl'}	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	
	<link href="{$base_url}/media/player/videojs/video-js.css" rel="stylesheet">	
	<link href="{$base_url}/media/player/videojs/plugins/videojs-resolution-switcher-master/lib/videojs-resolution-switcher.css" rel="stylesheet">		
	<link href="{$base_url}/media/player/videojs/plugins/videojs-logobrand-master/src/videojs.logobrand.css" rel="stylesheet">
	<link href="{$base_url}/media/player/videojs/plugins/videojs-thumbnails-master/videojs.thumbnails.css" rel="stylesheet">
	<link href="{$base_url}/media/player/videojs/video-js-custom.css" rel="stylesheet">					

	<script src="{$base_url}/media/player/videojs/ie8/videojs-ie8.min.js"></script>
	<script src="{$base_url}/media/player/videojs/video.js"></script>
	<script src="{$base_url}/media/player/videojs/plugins/videojs-resolution-switcher-master/lib/videojs-resolution-switcher.js"></script>
	<script src="{$base_url}/media/player/videojs/plugins/videojs-logobrand-master/src/videojs.logobrand.js"></script>
	<script src="{$base_url}/media/player/videojs/plugins/videojs-thumbnails-master/videojs.thumbnails.js"></script>
	<style>
	{literal}
	body {
		margin:0!important;
		padding:0!important;
		overflow:hidden;
		background-color: #000;
	}
	.text-error {  
		font-family: "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 14px;
		line-height: 1.42857143;
		color: red;
		padding: 10px;	
	}
	.text-message {  
		font-family: "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 16px;
		line-height: 1.42857143;
		color: #fff;
		padding: 10px;
	}
	.text-message a {
		color: #ccc;
	}
	.text-message a:visited {  
		color: #ccc;
	}
	.video-embedded {
		width: 100%;
		overflow: hidden;
	}
	.video-embedded iframe {
		width: 100%!important;
		height: 100%!important;
	}
	{/literal}
	</style>
</head>
<body>
{if $video.VID}
	{if $video.embed_code != ''}
		<div class="video-embedded">
			{$video.embed_code}
		</div>
	{else}
	<div class="video-container">
			<video id="video" class="video-js vjs-16-9 vjs-big-play-centered vjs-sublime-skin" preload="auto" controls poster="{insert name=thumb_path vid=$video.VID}/default.jpg" {if $player.autoplay}{literal}data-setup='{"autoplay": true}'{/literal}{else}{literal}data-setup='{}'{/literal}{/if}>
			{if $video.iphone == 1}
				<source src="{$video_root}/iphone/{$video.VID}.mp4" type='video/mp4' label='SD' res='720'/>
				{if $video.hd == 1}
					<source src="{$video_root}/hd/{$video.VID}.mp4" type='video/mp4' label='HD' res ='1080'/>
				{/if}
			{else}
				{section name=i loop=$video.files}
					<source src="{$video_root}/h264/{$video.files[i].file}" type='video/{$video.files[i].format}' label='{$video.files[i].label}' res='{$video.files[i].height}'/>
				{/section}
			{/if}
			<p class="vjs-no-js">To view this video please enable JavaScript, and consider upgrading to a web browser that <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a></p>
		</video>		
	</div>
	{/if}
{/if}
<script src="{$base_url}/media/player/videojs/video-js-events.js"></script>
</body>
</html>
