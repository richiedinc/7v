			<li class="{if $active_menu == 'games'}open{/if}">
				<a href="javascript:;">
					<i class="fa fa-gamepad"></i>
					<span class="title">Games</span>
					<span class="arrow {if $active_menu == 'games'}open{/if}"></span>					
				</a>
				<ul class="sub-menu" {if $active_menu == 'games'}style="overflow: hidden; display: block;"{/if}>
					<li class="{if $sub_menu == 'manage-games'}open active{/if}">
						<a href="games.php?m=all&all=1">Manage Games</a>
					</li>
					<li class="{if $sub_menu == 'game-requests'}open active{/if}">
						<a href="javascript:;"><span class="title">Requests</span><span class="arrow {if $sub_menu == 'game-requests'}open{/if}"></span></a>
						<ul class="sub-menu" {if $sub_menu == 'game-requests'}style="overflow: hidden; display: block;"{/if}>
							<li class="{if $module == 'flagged' && $sub_menu == 'game-requests'}active{/if}"><a href="games.php?m=flagged&all=1">Flagged</a></li>
							<li class="{if $module == 'spam' && $sub_menu == 'game-requests'}active{/if}"><a href="games.php?m=spam">Spam</a></li>
						</ul>						
					</li>
					<li class="{if $sub_menu == 'add-games'}open active{/if}">
						<a href="javascript:;"><span class="title">Add Games</span><span class="arrow {if $sub_menu == 'add-games'}open{/if}"></span></a>
						<ul class="sub-menu" {if $sub_menu == 'add-games'}style="overflow: hidden; display: block;"{/if}>
							<li class="{if $sub_menu == 'add-games' && $module == 'add'}active{/if}"><a href="games.php?m=add">Add Game</a></li>
						</ul>						
					</li>					
				</ul>
			</li>