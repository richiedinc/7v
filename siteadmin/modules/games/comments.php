<?php
defined('_VALID') or die('Restricted Access!');

Auth::checkAdmin();

require $config['BASE_DIR']. '/classes/pagination.class.php';

$remove         = NULL;
$GID            = ( isset($_GET['GID']) && is_numeric($_GET['GID']) ) ? intval($_GET['GID']) : NULL;
if ( isset($_GET['a']) && $_GET['a'] == 'delete' ) {
    $COMID = ( isset($_GET['COMID']) && is_numeric($_GET['COMID']) ) ? intval($_GET['COMID']) : NULL;
    if ( $COMID ) {
        $sql = "DELETE FROM game_comments WHERE CID = " .$COMID. " LIMIT 1";
        $conn->execute($sql);
        if ( $conn->Affected_Rows() == 1 ) {
            $msg = 'Comment deleted successfully!';
        } else {
            $err = 'Failed to delete comment! Invalid comment id!?';
        }
    } else {
        $err = 'Invalid comment id or not set!';
    }
    $remove = '&a=delete&COMID=' .$COMID;
}

$sql            ="SELECT COUNT(CID) AS total_comments FROM game_comments WHERE GID = " .$GID;
$rs             = $conn->execute($sql);
$total_comments = $rs->fields['total_comments'];
$pagination     = new Pagination(20);
$limit          = $pagination->getLimit($total_comments);
$paging         = $pagination->getAdminPagination($remove);
$sql            = "SELECT c.*, u.username FROM game_comments AS c, signup AS u
                   WHERE c.GID = " .$GID. " AND c.UID = u.UID LIMIT " .$limit;
$rs             = $conn->execute($sql);
$comments       = $rs->getrows();

$smarty->assign('GID', $GID);
$smarty->assign('comments', $comments);
$smarty->assign('total_comments', $total_comments);
$smarty->assign('paging', $paging);
?>
