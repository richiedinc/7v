<div class="container">

		<div class="well bs-component">
			<form class="form-horizontal" name="user_prefs_form" id="user_prefs_form" method="post" action="{$relative}/user/prefs">
				<div class="col-md-6">
					<fieldset class="m-b-15">
						<legend>{t c='user.PREFS_TITLE'}</legend>
						<div class="form-group">
							<div class="col-sm-9 col-sm-offset-3">
								<div class="col-xs-4">
									<center>
										{t c='global.public'}
									</center>
								</div>
								<div class="col-xs-4">
									<center>
										{t c='user.only_friends'}
									</center>
								</div>
								<div class="col-xs-4">
									<center>
										{t c='user.only_me'}
									</center>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-wrap">{t c='user.playlist'}</label>
							<div class="col-sm-9">
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_playlist" type="radio" value="2" {if $prefs.show_playlist == '2'} checked="checked"{/if} />
										</label>
									</center>
								</div>
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_playlist" type="radio" value="1" {if $prefs.show_playlist == '1'} checked="checked"{/if} />
										</label>
									</center>
								</div>
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_playlist" type="radio" value="0" {if $prefs.show_playlist == '0'} checked="checked"{/if} />
										</label>
									</center>
								</div>								
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-wrap">{t c='user.favorites'}</label>
							<div class="col-sm-9">
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_favorites" type="radio" value="2" {if $prefs.show_favorites == '2'} checked="checked"{/if} />
										</label>
									</center>
								</div>
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_favorites" type="radio" value="1" {if $prefs.show_favorites == '1'} checked="checked"{/if} />
										</label>
									</center>
								</div>
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_favorites" type="radio" value="0" {if $prefs.show_favorites == '0'} checked="checked"{/if} />
										</label>
									</center>
								</div>								
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-wrap">{t c='user.friend'} {t c='global.list'}</label>
							<div class="col-sm-9">
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_friends" type="radio" value="2" {if $prefs.show_friends == '2'} checked="checked"{/if} />
										</label>
									</center>
								</div>
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_friends" type="radio" value="1" {if $prefs.show_friends == '1'} checked="checked"{/if} />
										</label>
									</center>
								</div>
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_friends" type="radio" value="0" {if $prefs.show_friends == '0'} checked="checked"{/if} />
										</label>
									</center>
								</div>								
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-wrap">{t c='user.subscriptions'}</label>
							<div class="col-sm-9">
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_subscriptions" type="radio" value="2" {if $prefs.show_subscriptions == '2'} checked="checked"{/if} />
										</label>
									</center>
								</div>
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_subscriptions" type="radio" value="1" {if $prefs.show_subscriptions == '1'} checked="checked"{/if} />
										</label>
									</center>
								</div>
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_subscriptions" type="radio" value="0" {if $prefs.show_subscriptions == '0'} checked="checked"{/if} />
										</label>
									</center>
								</div>								
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-wrap">{t c='user.subscribers'}</label>
							<div class="col-sm-9">
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_subscribers" type="radio" value="2" {if $prefs.show_subscribers == '2'} checked="checked"{/if} />
										</label>
									</center>
								</div>
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_subscribers" type="radio" value="1" {if $prefs.show_subscribers == '1'} checked="checked"{/if} />
										</label>
									</center>
								</div>
								<div class="col-xs-4">
									<center>
										<label class="control-label">
											<input name="show_subscribers" type="radio" value="0" {if $prefs.show_subscribers == '0'} checked="checked"{/if} />
										</label>
									</center>
								</div>								
							</div>
						</div>
						
					</fieldset>
					
					

					<fieldset class="m-b-15">
						<legend>{t c='user.ACCOUNT_PREF'}</legend>
						
						<div class="form-group">
							<div class="col-xs-12">
								<div class="checkbox">
									<label>
										<input name="friends_requests" type="checkbox" id="profile_friend_requests" {if $prefs.friends_requests == '1'} checked="checked"{/if} /> {t c='user.friends_auto'}
									</label>
								</div>								
							</div>
						</div>
						<div class="form-group">						
							<div class="col-xs-12">
								<div class="checkbox">
									<label>
										<input name="wall_public" type="checkbox" id="profile_wall_public" {if $prefs.wall_public == '1'} checked="checked"{/if} /> {t c='user.wall_public'}
									</label>
								</div>								
							</div>						
						</div>				
						
					</fieldset>	
					
				</div>

				<div class="col-md-6">
				
					<fieldset>
						<legend>{t c='user.EMAIL_NOTIF'}</legend>
						<div class="form-group">
							<div class="col-xs-12">
								<div class="checkbox">
									<label>
										<input name="video_approve" type="checkbox" id="profile_vapprove" {if $prefs.video_approve == '1'} checked="checked"{/if} /> {t c='user.notif_video_approve'}
									</label>
								</div>								
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-12">
								<div class="checkbox">
									<label>
										<input name="album_approve" type="checkbox" id="profile_aapprove" {if $prefs.album_approve == '1'} checked="checked"{/if} /> {t c='user.notif_album_approve'}
									</label>
								</div>								
							</div>
						</div>
						<div class="form-group">							
							<div class="col-xs-12">
								<div class="checkbox">
									<label>
										<input name="video_subscribe" type="checkbox" id="profile_vsubscribe" {if $prefs.video_subscribe == '1'} checked="checked"{/if} /> {t c='user.notif_subscribe'}
									</label>
								</div>								
							</div>
						</div>
						<div class="form-group">							
							<div class="col-xs-12">
								<div class="checkbox">
									<label>
										<input name="friend_request" type="checkbox" id="profile_frequest" {if $prefs.friend_request == '1'} checked="checked"{/if} /> {t c='user.notif_friend'}
									</label>
								</div>								
							</div>
						</div>
						<div class="form-group">							
							<div class="col-xs-12">
								<div class="checkbox">
									<label>
										<input name="wall_write" type="checkbox" id="profile_wwrite" {if $prefs.wall_write == '1'} checked="checked"{/if} /> {t c='user.notif_wall'}
									</label>
								</div>								
							</div>
						</div>
						<div class="form-group">							
							<div class="col-xs-12">
								<div class="checkbox">
									<label>
										<input name="video_comment" type="checkbox" id="profile_vcomment" {if $prefs.video_comment == '1'} checked="checked"{/if} /> {t c='user.notif_video_comment'}
									</label>
								</div>								
							</div>
						</div>
						<div class="form-group">							
							<div class="col-xs-12">
								<div class="checkbox">
									<label>
										<input name="photo_comment" type="checkbox" id="profile_pcomment" {if $prefs.photo_comment == '1'} checked="checked"{/if} /> {t c='user.notif_photo_comment'}
									</label>
								</div>								
							</div>
						</div>
						<div class="form-group">							
							<div class="col-xs-12">
								<div class="checkbox">
									<label>
										<input name="blog_comment" type="checkbox" id="profile_bcomment" {if $prefs.blog_comment == '1'} checked="checked"{/if} /> {t c='user.notif_blog_comment'}
									</label>
								</div>								
							</div>
						</div>
						<div class="form-group">							
							<div class="col-xs-12">
								<div class="checkbox">
									<label>
										<input name="game_comment" type="checkbox" id="profile_gcomment" {if $prefs.game_comment == '1'} checked="checked"{/if} /> {t c='user.notif_game_comment'}
									</label>
								</div>								
							</div>
						</div>
						<div class="form-group">							
							<div class="col-xs-12">
								<div class="checkbox">
									<label>
										<input name="send_message" type="checkbox" id="profile_message" {if $prefs.send_message == '1'} checked="checked"{/if} /> {t c='user.notif_send_msg'}
									</label>
								</div>								
							</div>						
						</div>
					
					</fieldset>
				</div>

				<div class="clearfix"></div>

				<div class="form-group m-t-15">
					<center>
						<input name="prefs_submit" type="submit" value=" {t c='user.save'} " id="profile_submit" class="btn btn-primary">
					</center>
				</div>
				
			</form>
		
		</div>

</div>