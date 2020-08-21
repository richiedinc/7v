	<!-- BEGIN PAGE CONTAINER-->
	<div class="page-content"> 
		<div class="content">  
			<!-- BEGIN PAGE TITLE -->
			<div class="page-title">
				<i class="icon-custom-left"></i>
				<h3>Games - <span class="semi-bold">Add Game</span></h3>
			</div>
			{include file="errmsg.tpl"}
			<!-- END PAGE TITLE -->
			<!-- BEGIN PlACE PAGE CONTENT HERE -->
			<div class="col-md-12">
				<div class="grid simple">
					<div class="grid-title no-border">
						<h4>Game <span class="semi-bold">Information</span></h4>
					</div>
					<div class="grid-body no-border">
						<form class="form-no-horizontal-spacing" name="add_game" method="POST" enctype="multipart/form-data" action="games.php?m=add">
				
							<div class="row">
								<div class="col-lg-6 col-lg-offset-3 col-md-12">
									<div class="row">		
										<div class="form-group">
											<label class="col-lg-4 control-label">Username</label>
											<div class="col-lg-8">
												<input class="form-control {if $err.username}error{/if}" name="username" type="text" value="{$game.username}">
											</div>
											<div class="clearfix"></div>
										</div>
										<div class="form-group">
											<label class="col-lg-4 control-label">Title</label>
											<div class="col-lg-8">
												<input class="form-control {if $err.title}error{/if}" name="title" type="text" value="{$game.title}">
											</div>
											<div class="clearfix"></div>
										</div>
										<div class="form-group">
											<label class="col-lg-4 control-label">Category</label>
											<div class="col-lg-8">
												<select id="category" name="category" style="width:100%">
													{section name=i loop=$categories}
													<option value="{$categories[i].category_id}"{if $game.category == $categories[i].category_id} selected="selected"{/if}>{$categories[i].category_name|escape:'html'}</option>
													{/section}
												</select>
											</div>
											<div class="clearfix"></div>
										</div>
										<div class="form-group">
											<label class="col-lg-4 control-label">Tags</label>
											<div class="col-lg-8">
												 <textarea class="form-control {if $err.tags}error{/if}" name="tags" rows="3" style="resize: vertical">{$game.tags}</textarea>
												 <span class="help">Space separated</span>
											</div>
											<div class="clearfix"></div>
										</div>
										<div class="form-group">
											<label class="col-lg-4 control-label">Type</label>
											<div class="col-lg-8">
												<div class="radio p-t-9">
													<input id="type_pb" type="radio" name="type" value="public" {if $game.type != 'private'}checked="checked"{/if} class="radio-enabled">
													<label for="type_pb">Public</label>
													<input id="type_pv" type="radio" name="type" value="private" {if $game.type == 'private'}checked="checked"{/if} class="radio-disabled">
													<label for="type_pv">Private</label>												
												</div>
											</div>
											<div class="clearfix"></div>
										</div>
										<div class="form-group">
											<label class="col-lg-4 control-label">Game</label>
											<div class="col-lg-8">
												<div id="get_file" class="btn btn btn-success btn-file" onclick="getFile('game_file')">Choose File</div>
												<div class="file-box">
													<span id="addgame">No file chosen</span>
													<input name="game_file" type="file" id="game_file" onChange="sub(this,'addgame','nofile_1')" accept=".swf" />		
													<input type="hidden" id="nofile_1" value="No File">
												</div>
											</div>
											<div class="clearfix"></div>
										</div>
										<div class="form-group">
											<label class="col-lg-4 control-label">Thumbnail</label>
											<div class="col-lg-8">
												<div id="get_file" class="btn btn btn-success btn-file" onclick="getFile('game_thumb')">Choose File</div>
												<div class="file-box">
													<span id="addthumb">No file chosen</span>
													<input name="game_thumb" type="file" id="game_thumb" onChange="sub(this,'addthumb','nofile_2')" accept=".gif,.jpg,.jpeg,.png" />		
													<input type="hidden" id="nofile_2" value="No File">
												</div>
											</div>
											<div class="clearfix"></div>
										</div>
									</div>
								</div>
							</div>
							<div class="form-actions">
								<div class="pull-right">
									<input name="add_game" type="submit" value="Add Game" id="add_game" class="btn btn-success btn-cons" onClick="document.getElementById('add_game').value='Uploading...'">
									<a href="index.php" class="btn btn-white btn-cons">Cancel</a>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>			
			<!-- END PLACE PAGE CONTENT HERE -->
		</div>
	</div>
	<!-- END PAGE CONTAINER -->	