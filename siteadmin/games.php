<?php
define('_VALID', true);
define('_ADMIN', true);
require '../include/config.php';
require '../include/function_global.php';
require '../include/function_admin.php';
require '../classes/auth.class.php';

Auth::checkAdmin();

if ( isset($_GET['err']) ) {
    $errors[]   = trim($_GET['err']);
}

if ( isset($_GET['msg']) ) {
    $messages[] = trim($_GET['msg']);
}

$module             = ( isset($_GET['m']) && $_GET['m'] != '' ) ? trim($_GET['m']) : 'all';
$module_keep        = NULL;
$module_template    = 'games.tpl';
$modules_allowed    = array('all', 'public', 'private', 'flagged', 'view', 'edit', 'comments',
                            'commentedit', 'add', 'spam');
if ( !in_array($module, $modules_allowed) ) {
    $module = 'all';
    $err    = 'Invalid Games Module!';
}

switch ( $module ) {
    case 'flagged':
    case 'spam':
    case 'edit':
    case 'view':
    case 'comments':
    case 'commentedit':
    case 'add':
        $module_template = 'games_' .$module. '.tpl';
        break;
    case 'all':
    case 'public':
    case 'private':
    default:
        $module_keep        = $module;
        $module             = 'all';
        break;
}

if ( in_array($module, array('all', 'public', 'private', 'view', 'edit')) ) {
	$sub_menu = 'manage-games';
} elseif ( in_array($module, array('flagged', 'comments', 'commentedit', 'spam')) ) {
	$sub_menu = 'game-requests';
} elseif ( in_array($module, array('add')) ) {
	$sub_menu = 'add-games';
}

require 'modules/games/' .$module. '.php';

$smarty->assign('errors', $errors);
$smarty->assign('err', $err);
$smarty->assign('messages', $messages);
if ($module_keep) {
	$smarty->assign('module', $module_keep);
} else {
	$smarty->assign('module', $module);
}
$smarty->assign('active_menu', 'games');
$smarty->assign('sub_menu', $sub_menu);
$smarty->display('header.tpl');
$smarty->display('leftmenu/menu.tpl');
$smarty->display($module_template);
$smarty->display('footer.tpl');
?>
