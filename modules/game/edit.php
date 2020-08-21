<?php
defined('_VALID') or die('Restricted Access!');

require $config['BASE_DIR']. '/classes/auth.class.php';
require $config['BASE_DIR']. '/classes/filter.class.php';

if ( $config['game_module'] == '0' ) {
    VRedirect::go($config['BASE_URL']. '/notfound/page_invalid');
}

$auth       = new Auth();
$auth->check();

$uid            = intval($_SESSION['uid']);
$username       = $_SESSION['username'];

$gid = get_request_arg('edit');
if ( !$gid ) {
    VRedirect::go($config['BASE_URL']. '/notfound/game_missing');
}

$uid = (int) $_SESSION['uid'];
$sql = "SELECT GID FROM game WHERE GID = ".$gid." AND UID = ".$uid." AND status = '1' LIMIT 1";
$conn->execute($sql);
if ($conn->Affected_Rows()) {
	$categories = get_games_categories();
		if (isset($_POST['edit_submit'])) {
		$filter     = new VFilter();
		$title      = $filter->get('game_title');
		$category   = $filter->get('game_category', 'INTEGER');
		$keywords   = $filter->get('game_keywords');
		$privacy    = $filter->get('game_privacy');


		if ( $title == '' ) {
			$errors[]           = $lang['upload.game_title_empty'];
			$err['title']       = 1;
		}

		if ( $keywords == '' ) {
			$errors[]           = $lang['upload.game_tags_empty'];
			$err['tags']        = 1;
		}

		if ( $category == '0' ) {
			$errors[]           = $lang['upload.game_category_empty'];
			$err['category']    = 1;
		}

		if (!$errors) {
			$type  = ( $privacy == 'private' ) ? 'private' : 'public';

			$sql   = "UPDATE game
			          SET title = " .$conn->qStr($title).",
					     tags = " .$conn->qStr($keywords).",
						 type = '".$type."',
						 category = " .$category."
					  WHERE GID = ".$gid."
					  AND UID = ".$uid."
					  AND status = '1'
					  LIMIT 1";
					  
			$conn->execute($sql);
			$messages[] = $lang['edit.game.success'];
		}	
	}
	
	$sql   		= "SELECT * FROM game WHERE GID = ".$gid." AND UID = ".$uid." AND status = '1' LIMIT 1";
	$rs    		= $conn->execute($sql);
	$game 		= $rs->getrows();
	$game 		= $game['0'];
} else {
    VRedirect::go($config['BASE_URL']. '/notfound/game_missing');
}

$sql        = "SELECT * FROM signup WHERE UID = '" .$uid. "' LIMIT 1";
$rs         = $conn->execute($sql);
if ( $conn->Affected_Rows() != 1 ) {
    VRedirect::go($config['BASE_URL']. '/notfound/user_missing');
}
$user       = $rs->getrows();
$user       = $user['0'];
$username   = $user['username'];

$smarty->assign('errors',$errors);
$smarty->assign('err',$err);
$smarty->assign('messages',$messages);
$smarty->assign('menu', 'games');
$smarty->assign('submenu', '');
$smarty->assign('user', $user);
$smarty->assign('username', $username);
$smarty->assign('game', $game);
$smarty->assign('categories', $categories);
$smarty->loadFilter('output', 'trimwhitespace');
$smarty->display('header.tpl');
$smarty->display('errors.tpl');
$smarty->display('messages.tpl');
$smarty->display('game_edit.tpl');
$smarty->display('footer.tpl');
?>
