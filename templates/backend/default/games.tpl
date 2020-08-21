	{include file="game_edit.tpl"}
	{include file="game_thumbnail.tpl"}
	{include file="comments.tpl"}	
	{include file="game_view.tpl"}
	<!-- BEGIN PAGE CONTAINER-->
	<div class="page-content"> 
		<div class="content">
			<!-- BEGIN PAGE TITLE -->
			<div class="page-title">
				<i class="icon-custom-left"></i>
				<h3>Games - <span class="semi-bold">Manage Games</span></h3>
			</div>
			{include file="errmsg.tpl"}
			<!-- END PAGE TITLE -->
			<!-- BEGIN PlACE PAGE CONTENT HERE -->															
			<div class="col-md-12">
				<div class="grid simple">
					<div class="grid-title no-border">
						<h4>Search <span class="semi-bold">Filters</span></h4>
					</div>
					<div class="grid-body no-border">
						<div class="row">
							<div class="col-xs-12">
								<form class="form-no-horizontal-spacing search-filters" name="search_games" method="POST" action="games.php?m={$module}">
									<div class="filters">
										<div class="row">
											<div class="filter col-xs-12 col-sm-6 col-md-4">
												<div class="form-group">
													<input type="text" id="filter_username" name="username" value="{$option.username}" class="form-control {if $option.username}filter-active{/if}" placeholder="Username">
													<i id="filter_remove_username" class="fa fa-times remove-filter" {if !$option.username}style="display:none"{/if}></i>
												</div>
											</div>
											<div class="filter col-xs-12 col-sm-6 col-md-4">
												<div class="form-group">
													<input type="text"  id="filter_title" name="title" value="{$option.title}" class="form-control {if $option.title}filter-active{/if}" placeholder="Title">
													<i id="filter_remove_title" class="fa fa-times remove-filter" {if !$option.title}style="display:none"{/if}></i>
												</div>										
											</div>
											<div class="filter col-xs-12 col-sm-6 col-md-4">
												<div class="form-group">
													<input type="text"  id="filter_keyword" name="keyword" value="{$option.keyword}" class="form-control {if $option.keyword}filter-active{/if}" placeholder="Tag">
													<i id="filter_remove_keyword" class="fa fa-times remove-filter" {if !$option.keyword}style="display:none"{/if}></i>
												</div>										
											</div>
											<div class="filter col-xs-12 col-sm-6 col-md-4">
												<div class="form-group">
													<select id="filter_category" name="category" style="width:100%">
														<option value="">Category</option>
														{section name=i loop=$categories}
														<option value="{$categories[i].category_id}"{if $categories[i].category_id == $option.category } selected="selected"{/if}>{$categories[i].category_name}</option>
														{/section}
													</select>  												
												</div>
											</div>
											<div class="filter col-xs-12 col-sm-6 col-md-4">
												<div class="form-group">
													<select id="filter_status" name="status" style="width:100%">
														<option value="">Status</option>
														<option value="1"{if $option.status == '1'} selected="selected"{/if}>Active</option>
														<option value="0"{if $option.status == '0'} selected="selected"{/if}>Inactive</option>
													</select>												
												</div>
											</div>
											<div class="filter col-xs-12 col-sm-6 col-md-4">
												<div class="form-group">
													<select id="filter_type" name="type" style="width:100%">
														<option value="">Type</option>
														<option value="public"{if $option.type == 'public'} selected="selected"{/if}>Public</option>
														<option value="private"{if $option.type == 'private'} selected="selected"{/if}>Private</option>
													</select>												
												</div>
											</div>										
										</div>
									</div>
									<input id="sort" name="sort" type="hidden" value={$option.sort}>
									<input id="order" name="order" type="hidden" value={$option.order}>
									<input id="display" name="display" type="hidden" value={$option.display}>

									<div class="pull-left">
										<div class="btn-group"> <a class="btn dropdown-toggle btn-demo-space" data-toggle="dropdown" href="#">Order by <span id="sort_items">{if $option.sort == 'g.title'}Title{elseif $option.sort == 'g.type'}Type{elseif $option.sort == 'g.adddate'}Date{elseif $option.sort == 'g.total_plays'}Plays{elseif $option.sort == 'g.total_favorites'}Favorites{elseif $option.sort == 'g.total_comments'}Comments{else}ID{/if}</span> <span class="caret"></span> </a>
											<ul class="dropdown-menu">
												<li><a href="#" onClick="document.getElementById('sort_items').innerText = 'ID'; document.getElementById('sort').value = 'g.GID'" >ID</a></li>
												<li><a href="#" onClick="document.getElementById('sort_items').innerText = 'Title'; document.getElementById('sort').value = 'g.title'" >Title</a></li>
												<li><a href="#" onClick="document.getElementById('sort_items').innerText = 'Type'; document.getElementById('sort').value = 'g.type'" >Type</a></li>
												<li><a href="#" onClick="document.getElementById('sort_items').innerText = 'Date'; document.getElementById('sort').value = 'g.adddate'" >Date</a></li>
												<li><a href="#" onClick="document.getElementById('sort_items').innerText = 'Plays'; document.getElementById('sort').value = 'g.total_plays'" >Plays</a></li>
												<li><a href="#" onClick="document.getElementById('sort_items').innerText = 'Favorites'; document.getElementById('sort').value = 'g.total_favorites'" >Favorites</a></li>
												<li><a href="#" onClick="document.getElementById('sort_items').innerText = 'Comments'; document.getElementById('sort').value = 'g.total_comments'" >Comments</a></li>											
											</ul>
										</div>									
										<div class="btn-group"> <a class="btn dropdown-toggle btn-demo-space" data-toggle="dropdown" href="#"><span id="order_items">{if $option.order == 'ASC'}Ascending{else}Descending{/if}</span> <span class="caret"></span> </a>
											<ul class="dropdown-menu">
												<li><a href="#" onClick="document.getElementById('order_items').innerText = 'Ascending'; document.getElementById('order').value = 'ASC'" >Ascending</a></li>
												<li><a href="#" onClick="document.getElementById('order_items').innerText = 'Descending'; document.getElementById('order').value = 'DESC'" >Descending</a></li>
											</ul>
										</div>									
										<div class="btn-group"> <a class="btn dropdown-toggle btn-demo-space" data-toggle="dropdown" href="#"><span id="display_items">{$option.display}</span> <span class="caret"></span> </a>
											<ul class="dropdown-menu">
												<li><a href="#" onClick="document.getElementById('display_items').innerText = '10'; document.getElementById('display').value = '10'" >10</a></li>
												<li><a href="#" onClick="document.getElementById('display_items').innerText = '20'; document.getElementById('display').value = '20'" >20</a></li>
												<li><a href="#" onClick="document.getElementById('display_items').innerText = '30'; document.getElementById('display').value = '30'" >30</a></li>
												<li><a href="#" onClick="document.getElementById('display_items').innerText = '40'; document.getElementById('display').value = '40'" >40</a></li>
												<li><a href="#" onClick="document.getElementById('display_items').innerText = '50'; document.getElementById('display').value = '50'" >50</a></li>
												<li><a href="#" onClick="document.getElementById('display_items').innerText = '100'; document.getElementById('display').value = '100'" >100</a></li>
												<li><a href="#" onClick="document.getElementById('display_items').innerText = '200'; document.getElementById('display').value = '200'" >200</a></li>
											</ul>
										</div>
									</div>
									<div class="pull-right">
										<button type="button" id="reset_search" name="reset_search" class="btn btn-white btn-cons btn-icon"><i class="fa fa-times"></i></button>									
										<button type="submit" name="search_games" class="btn btn-success btn-cons btn-icon m-r-0"><i class="fa fa-search"></i></button>									
									</div>
									<div class="clearfix"></div>
								</form>
							</div>
						</div>
						<!-- END SEARCH FILTERS -->						
						<div class="row">
							<div class="col-xs-12">
								<div>
									 {if $total_games >= 1}
										<form class="form-no-horizontal-spacing" name="game_select" method="post" id="game_select" action="">
										<div>
											<input type="submit" name="delete_selected_games" value="Delete" class="btn btn-danger btn-cons" onClick="javascript:return confirm('Are you sure you want to delete all selected games?');">
											<input type="submit" name="suspend_selected_games" value="Suspend" class="btn btn-white btn-cons" onClick="javascript:return confirm('Are you sure you want to suspend all selected games?');">
											<input type="submit" name="approve_selected_games" value="Approve" class="btn btn-white btn-cons" onClick="javascript:return confirm('Are you sure you want to approve all selected games?');">
										</div>
										<div class="s-pagination">{$paging}</div>
										<div class="checkbox check-default">
											<input id="check_all_games" name="check_all_games" type="checkbox" id="game_check_all">
											<label for="check_all_games" style="margin: 0 0 15px 10px !important;">Select All</label>
											<code class="text-info hidden-xs hidden-sm pull-right">Use CHECK -> SHIFT + CHECK to select multiple games.</code>
										</div>
										{section name=i loop=$games}
											<div id="item-{$games[i].GID}" class="item-main-container">
												<div class="item-col-left">
													<div class="item-main">
														<div class="item-select" unselectable="on" onselectstart="return false;" onmousedown="return false;">
															<div class="checkbox check-default">
																<input name="game_id_checkbox_{$games[i].GID}" id="game_checkbox_{$games[i].GID}" type="checkbox" class="select-multiple">
																<label for="game_checkbox_{$games[i].GID}" style="margin: 0 0 15px 0 !important;"></label>
															</div>												
														</div>
														<div class="item-thumb">
															<div class="thumb-overlay">														
																<a id="view_game_{$games[i].GID}" href="#">
																	<img id="thumb-{$games[i].GID}" src="{$baseurl}/media/games/tmb/{$games[i].GID}.jpg" class="img-responsive">
																</a>
																<div class="item-id">
																	<b>ID</b> {$games[i].GID}
																</div>
																<div id="private-{$games[i].GID}">
																	{if $games[i].type == 'private'}<div class="item-private">PRIVATE</div>{/if}
																</div>
																<div id="photos-loading-{$games[i].GID}" class="thumbnails-loading" style="display: none"><i class="loader"></i></div>
															</div>												
														</div>
													</div>
												</div>
												<div class="item-col-right">
													<div class="item-details">
														<div class="item-title">
															<a id="view_game_{$games[i].GID}_" href="#"><span id="title-{$games[i].GID}">{$games[i].title|escape:'html'}</span></a>
														</div>
														<div class="row">						
															<div class="col-xs-6 col-sm-4 col-md-3 col-lg-3">
																<div class="d-label">User</div>
																<a href="users.php?m=all&all=1&UID={$games[i].UID}" class="text-info">{$games[i].username}</a>															
															</div>
															<div class="col-xs-6 col-sm-4 col-md-3 col-lg-3">
																<div class="d-label">Status</div>
																<span id="status-{$games[i].GID}">
																	{if $games[i].status == 1}
																		<span class="text-green" alt="Active" title="Active">Active</span>
																	{else}
																		<span class="text-red" alt="Inactive" title="Inactive">Inactive</span>
																	{/if}
																</span>
															</div>
															<div class="col-xs-12 col-sm-4 col-md-3 col-lg-3">
																<div class="d-label">Date</div>
																{$games[i].adddate|date_format}													
															</div>
															<div class="col-xs-4 col-sm-4 col-md-1 col-lg-1">
																<div class="d-label"><i class="fa fa-comments"></i></div>
																{if $games[i].total_comments > 0}
																	<a id="comments_Game_{$games[i].GID}" href="#" class="text-info">{$games[i].total_comments}</a>
																{else}
																	<span class="text-muted">{$games[i].total_comments}</span>
																{/if}																
															</div>
															<div class="col-xs-4 col-sm-4 col-md-1 col-lg-1">
																<div class="d-label"><i class="fa fa-eye"></i></div>
																<span id="views-{$games[i].GID}">{$games[i].total_plays}</span>
															</div>
															<div class="col-xs-4 col-sm-4 col-md-1 col-lg-1">
																<div class="d-label"><i class="fa fa-star"></i></div>
																{$games[i].total_favorites}
															</div>
														</div>
													</div>
												</div>
												<div class="clearfix"></div>
												<div class="item-actions">																									
													<div class="btn-group">
														<div class="btn-group">
															<a id="delete__game_{$games[i].GID}" class="btn btn-success" data-toggle="dropdown" href="#" alt="Delete" title="Delete"><i class="fa fa-trash-o"></i></a>
															<ul class="dropdown-menu">
																<li><a id="delete_game_{$games[i].GID}" href="#">Delete</a></li>
															</ul>
														</div>
														<a id="edit_game_{$games[i].GID}" class="btn btn-success" href="#" alt="Edit" title="Edit"><i class="fa fa-pencil"></i></a>
														<a id="thumb_game_{$games[i].GID}" class="btn btn-success" href="#" alt="Thumbnail" title="Thumbnail"><i class="fa fa-picture-o"></i></a>
														{if $games[i].status == '1'}
															<a id="status_game_{$games[i].GID}" class="btn btn-success" href="#" alt="Suspend" title="Suspend" data-processing="0" data-status="1"><i class="fa fa-times"></i></a>
														{else}
															<a id="status_game_{$games[i].GID}" class="btn btn-success" href="#" alt="Activate" title="Activate" data-processing="0" data-status="0"><i class="fa fa-check"></i></a>
														{/if}																	
													</div>
												
												</div>												
											</div>
										{/section}
											

										<div class="s-pagination">{$paging}</div>										
										</form>
									{else}
									<div class="row">
										<div class="col-xs-12">
											<div class="alert alert-info">
												<button class="close" data-dismiss="alert"></button>
												No Games Found
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