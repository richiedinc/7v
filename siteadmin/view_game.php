<?php
define('_VALID', true);
define('_ADMIN', true);
require '../include/config.php';
require '../include/function_global.php';
require '../include/function_admin.php';
require '../include/function_smarty.php';
require '../classes/auth.class.php';

if (isset($_GET['GID']) && $_GET['GID'] != '') {
	$gid = intval($_GET['GID']);
} else {
	die();
}

$sql = "SELECT * from game WHERE GID = " .$conn->qStr($gid). " LIMIT 1";
$rs = $conn->execute($sql);

if ( $conn->Affected_Rows() == 1 ) {
	$game = $rs->getrows();
	$game = $game[0];
} else {
	die();
}

$smarty->assign('game', $game);
$smarty->display('view_game.tpl');
?>
