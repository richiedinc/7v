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
					{t c='upload.title'}
				</div>
				<div class="panel-body">
					<div class="row hidden-xs">
					{if $video_module == '1'}
						<div class="col-xs-4">
							<center>
								<a href="{$relative}/upload/video">
									<div class="text-white"><i class="fa fa-film fa-5x"></i></div>
									<div class="text-lg m-t-10">{t c='global.videos'}</div>
								</a>
							</center>
						</div>
					{/if}
					{if $photo_module == '1'}					
						<div class="col-xs-4">
							<center>
								<a href="{$relative}/upload/photo">
									<div class="text-white"><i class="fa fa-camera fa-5x"></i></div>
									<div class="text-lg m-t-10">{t c='global.photos'}</div>
								</a>
							</center>
						</div>
					{/if}
					{if $game_module == '1'}
						<div class="col-xs-4">
							<center>
								<a href="{$relative}/upload/game">
									<div class="text-white"><i class="fa fa-gamepad fa-5x"></i></div>
									<div class="text-lg m-t-10">{t c='global.games'}</div>
								</a>
							</center>
						</div>
					{/if}
					</div>
					<div class="row visible-xs">
					{if $video_module == '1'}
						<div class="col-xs-4">
							<center>
								<a href="{$relative}/upload/video">
									<div class="text-white"><i class="fa fa-film fa-3x"></i></div>
									<div class="text-md m-t-10">{t c='global.videos'}</div>
								</a>
							</center>
						</div>
					{/if}
					{if $photo_module == '1'}					
						<div class="col-xs-4">
							<center>
								<a href="{$relative}/upload/photo">
									<div class="text-white"><i class="fa fa-camera fa-3x"></i></div>
									<div class="text-md m-t-10">{t c='global.photos'}</div>
								</a>
							</center>
						</div>
					{/if}
					{if $game_module == '1'}
						<div class="col-xs-4">
							<center>
								<a href="{$relative}/upload/game">
									<div class="text-white"><i class="fa fa-gamepad fa-3x"></i></div>
									<div class="text-md m-t-10">{t c='global.games'}</div>
								</a>
							</center>
						</div>
					{/if}
					</div>					
				</div>
			</div>	
		</div>
	</div>
</div>