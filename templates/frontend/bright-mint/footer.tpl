<div class="footer-container">
	<div class="footer-links">
		<div class="container">
			<div class="row">
				<div class="col-sm-4">
						<h4>{t c='footer.information'}</h4>
						<ul class="list-unstyled">
							<li><a href="{$relative}/static/terms" rel="nofollow">{translate c='footer.terms'}</a></li>
							<li><a href="{$relative}/static/privacy" rel="nofollow">{translate c='footer.privacy'}</a></li>
							<li><a href="{$relative}/static/dmca" rel="nofollow">{translate c='footer.dmca'}</a></li>
							<li><a href="{$relative}/static/_2257" rel="nofollow">{translate c='footer.2257'}</a></li>
						</ul>
				</div>
				<div class="col-sm-4">
						<h4>{t c='footer.work_with_us'}</h4>
						<ul class="list-unstyled">
							<li><a href="{$relative}/static/advertise" rel="nofollow">{translate c='footer.advertise'}</a></li>
							<li><a href="{$relative}/static/webmasters" rel="nofollow">{translate c='footer.webmasters'}</a></li>
							<li><a href="{$relative}/invite" rel="nofollow">{translate c='global.invite_friends'}</a></li>						
						</ul>
				</div>
				<div class="col-sm-4">
						<h4>{t c='footer.support_and_help'}</h4>
						<ul class="list-unstyled">
							<li><a href="{$relative}/notices">{translate c='global.notice'}</a></li>					
							<li><a href="{$relative}/static/faq" rel="nofollow">{translate c='footer.faq'}</a></li>
							<li><a href="{$relative}/feedback" rel="nofollow">{translate c='global.support_feedback'}</a></li>					
						</ul>
				</div>				
			</div>
		</div>
	</div>
	<div class="footer">
		<div class="container">
			<div class="hidden-xs">
				<div class="pull-left">
					<span>{t c='footer.copyright'} &#169; 2008-2018</span> {$site_name}
				</div>
				<div class="pull-right">
					Powered by <a target="_blank" href="http://www.adultvideoscript.com">AVS</a>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="visible-xs"><span>{t c='footer.copyright'} &#169; 2008-2018</span> {$site_name}<br />Powered by <a target="_blank" href="http://www.adultvideoscript.com">AVS</a></div>
		</div>
	</div>
</div>
</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="{$relative_tpl}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="{$relative_tpl}/js/jquery.rotator-0.2.js"></script>
    <script type="text/javascript" src="{$relative_tpl}/js/jquery.avs-0.2.js"></script>	
	{if $view && !$video.embed_code}
		<script src="{$baseurl}/media/player/videojs/video-js-events.js"></script>			
	{/if}
	{if $g_signin == '1' || $fb_signin == '1'}
		<script type="text/javascript" src="{$relative_tpl}/js/jquery.load-apis.js"></script>	
	{/if}	
	<script>
	{literal}
			if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
		  var msViewportStyle = document.createElement('style')
		  msViewportStyle.appendChild(
			document.createTextNode(
			  '@-ms-viewport{width:auto!important}'
			)
		  )
		  document.querySelector('head').appendChild(msViewportStyle)
		}
	{/literal}
	</script>	
	{include file='../../../templates/backend/default/analytics/analytics.tpl'}	
</body>
</html>