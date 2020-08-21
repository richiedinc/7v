	{include file="category_edit.tpl"}
	{include file="category_thumbnail.tpl"}
	<!-- BEGIN PAGE CONTAINER-->
	<div class="page-content"> 
		<div class="content">
			<!-- BEGIN PAGE TITLE -->
			<div class="page-title">
				<i class="icon-custom-left"></i>
				<h3>Categories - <span class="semi-bold">Game Categories</span></h3>
			</div>
			{include file="errmsg.tpl"}
			<!-- END PAGE TITLE -->
			<!-- BEGIN PlACE PAGE CONTENT HERE -->															
			<div class="col-md-12">
				<div class="grid simple">
					<div class="grid-title no-border">
						<h4>Game <span class="semi-bold">Categories</span></h4>
					</div>
					<div class="grid-body no-border">
						<div class="row">
							<div class="col-xs-12">
								<form class="form-no-horizontal-spacing form-grey" name="add_channel" method="POST" enctype="multipart/form-data" action="channels.php?m=listgame">
									<div class="row">
										<div class="col-xs-12 col-sm-6 col-md-3">
											<div class="form-group">
												 <input type="text" name="name" value="{$channel.name}" class="form-control {if $err.name}error{/if}" placeholder="Name">												
											</div>
										</div>
										<div class="col-xs-12 col-sm-6 col-md-3">
											<div class="form-group">
												 <input type="text" name="slug" value="{$channel.slug}" class="form-control {if $err.slug}error{/if}" placeholder="Slug (Optional)">
											</div>
										</div>
										<div class="col-xs-12 col-sm-6 col-md-3">
											<div class="form-group">
												<div id="get_file" class="btn btn btn-success btn-file" onclick="getFile('picture')">Choose File</div>
												<div class="file-box">
													<span id="uppicture">Thumb - No file chosen</span>
													<input name="picture" type="file" id="picture" onChange="sub(this,'uppicture','nofile')" accept=".gif,.jpg,.jpeg,.png" />		
													<input type="hidden" id="nofile" value="No File">
												</div>
											</div>
										</div>										
										<div class="col-xs-12 col-sm-6 col-md-3">
											<div class="form-group">
												<input type="submit" name="add_channel" value="Add Category" class="btn btn-success btn-cons btn-icon m-0 pull-right">
												<div class="clearfix"></div>
											</div>
										</div>
									</div>			
								</form>						
								<form class="form-no-horizontal-spacing search-filters" name="search_channels" method="POST" action="channels.php?m={$module}">
									<input id="sort" name="sort" type="hidden" value={$option.sort}>
									<input id="order" name="order" type="hidden" value={$option.order}>
									<div class="pull-left">
										<div class="btn-group"> <a class="btn dropdown-toggle btn-demo-space" data-toggle="dropdown" href="#">Order by <span id="sort_items">{if $option.sort == 'category_name'}Name{elseif $option.sort == 'total_games'}Total Games{else}ID{/if}</span> <span class="caret"></span> </a>
											<ul class="dropdown-menu">
												<li><a href="#" onClick="document.getElementById('sort_items').innerText = 'ID'; document.getElementById('sort').value = 'category_id'" >ID</a></li>
												<li><a href="#" onClick="document.getElementById('sort_items').innerText = 'Name'; document.getElementById('sort').value = 'category_name'" >Name</a></li>
												<li><a href="#" onClick="document.getElementById('sort_items').innerText = 'Total Games'; document.getElementById('sort').value = 'total_games'" >Total Games</a></li>										
											</ul>
										</div>									
										<div class="btn-group"> <a class="btn dropdown-toggle btn-demo-space" data-toggle="dropdown" href="#"><span id="order_items">{if $option.order == 'ASC'}Ascending{else}Descending{/if}</span> <span class="caret"></span> </a>
											<ul class="dropdown-menu">
												<li><a href="#" onClick="document.getElementById('order_items').innerText = 'Ascending'; document.getElementById('order').value = 'ASC'" >Ascending</a></li>
												<li><a href="#" onClick="document.getElementById('order_items').innerText = 'Descending'; document.getElementById('order').value = 'DESC'" >Descending</a></li>
											</ul>
										</div>
									</div>
									<div class="pull-right">
										<button type="button" id="reset_search" name="reset_search" class="btn btn-white btn-cons btn-icon"><i class="fa fa-times"></i></button>									
										<button type="submit" name="search_channels" class="btn btn-success btn-cons btn-icon m-r-0"><i class="fa fa-search"></i></button>									
									</div>
									<div class="clearfix"></div>
								</form>
							</div>
						</div>
						<!-- END SEARCH FILTERS -->						
						<div class="row">
							<div class="col-xs-12">
								<div>
									{if $channels}
										<form class="form-no-horizontal-spacing" name="category_select" method="post" id="category_select" action="">
										{section name=i loop=$channels}
											<div id="item-{$channels[i].category_id}" class="item-main-container category">
												<div class="item-col-left">
													<div class="item-main">
														<div class="item-thumb">
															<div class="thumb-overlay">	
																<a href="games.php?m=all&CID={$channels[i].category_id}">
																	<img id="thumb-{$channels[i].category_id}" src="{$baseurl}/media/categories/game/{$channels[i].category_id}.jpg" class="img-responsive">
																</a>
																<div class="item-id">
																	<b>ID</b> {$channels[i].category_id}
																</div>
																<div id="photos-loading-{$channels[i].category_id}" class="thumbnails-loading" style="display: none"><i class="loader"></i></div>
															</div>												
														</div>
													</div>
												</div>
												<div class="item-col-right">
													<div class="item-details">
														<div class="item-title">
															<a href="games.php?m=all&CID={$channels[i].category_id}">
																<span class="text-info" id="title-{$channels[i].category_id}">{$channels[i].category_name|escape:'html'}</span>
															</a>
														</div>
														<div class="row">						
															<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
																<div class="d-label">Slug</div>
																<span id="slug-{$channels[i].category_id}">{$channels[i].slug}</span>
															</div>
															<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
																<div class="d-label">Games</div>
																<a id="total-items-{$channels[i].category_id}" href="games.php?m=all&CID={$channels[i].category_id}">{$channels[i].total_games}</a>
															</div>
														</div>
													</div>
												</div>
												<div class="clearfix"></div>
												<div class="item-actions">																									
													<div class="btn-group">
														<div class="btn-group">
															<a id="delete__category_{$channels[i].category_id}" class="btn btn-success" data-toggle="dropdown" href="#" alt="Delete" title="Delete"><i class="fa fa-trash-o"></i></a>
															<ul class="dropdown-menu">
																<li><a id="delete_category_Game_{$channels[i].category_id}" href="#">Delete</a></li>
															</ul>
														</div>
														<a id="edit_category_Game_{$channels[i].category_id}" class="btn btn-success" href="#" alt="Edit" title="Edit"><i class="fa fa-pencil"></i></a>
														<a id="thumb_category_Game_{$channels[i].category_id}" class="btn btn-success" href="#" alt="Thumbnail" title="Thumbnail"><i class="fa fa-picture-o"></i></a>																
													</div>
												
												</div>												
											</div>
										{/section}									
										</form>
									{else}
									<div class="row">
										<div class="col-xs-12">
											<div class="alert alert-info">
												<button class="close" data-dismiss="alert"></button>
												No Categories Found
											</div>
										</div>
									</div>
									{/if}	
								</div>
							
							</div>
						</div>
					</div>
				</div>
			</div>			
			<!-- END PLACE PAGE CONTENT HERE -->
		</div>
	</div>
	<!-- END PAGE CONTAINER -->	