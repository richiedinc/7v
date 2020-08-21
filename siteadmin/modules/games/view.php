<?php
defined('_VALID') or die('Restricted Access!');

Auth::checkAdmin();

$game  = array();
$GID    = ( isset($_GET['GID']) && is_numeric($_GET['GID']) ) ? intval(trim($_GET['GID'])) : NULL;
settype($GID, 'integer');
if ( !$GID ) {
    $errors[] = 'Invalid game ID. This game does not exist!';
}

if ( !$errors ) {
    if ( isset($_GET['a']) && $_GET['a'] == 'approve' ) {
        $sql = "UPDATE game SET status = '1' WHERE GID = '" .$GID. "' LIMIT 1";
        $conn->execute($sql);
        $msg = 'Game approved successfuly!';
    }

    $sql    = "SELECT * FROM game WHERE GID = '" .$GID. "' LIMIT 1";
    $rs     = $conn->execute($sql);
    if ( $conn->Affected_Rows() == 1 )
        $game = $rs->getrows();
    else
        $err = 'Invalid game ID. This game does not exist!';
}

$sql = "SELECT * FROM game_categories";
$rs  = $conn->execute($sql);

$smarty->assign('game', $game);
$smarty->assign('categories', $rs->getrows());
?>
