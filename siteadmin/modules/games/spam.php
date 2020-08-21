<?php
defined('_VALID') or die('Restricted Access!');
require $config['BASE_DIR']. '/classes/pagination.class.php';

Auth::checkAdmin();

if (isset($_POST['delete_selected_comments'])) {
    $index = 0;
    foreach ( $_POST as $key => $value ) {
        if ( $key != 'check_all_comments' && substr($key, 0, 20) == 'comment_id_checkbox_') {
            if ( $value == 'on' ) {
                $comment_id = intval(str_replace('comment_id_checkbox_', '',$key));
                $sql = "DELETE FROM game_comments WHERE CID = " .$comment_id. " LIMIT 1";
                $conn->execute($sql);
                $sql = "DELETE FROM spam WHERE type = 'game' AND comment_id = " .$comment_id; 
                $conn->execute($sql);
                ++$index;
            }
        }
    }

    if ( $index === 0 ) {
        $errors[]   = 'Please select comments to be deleted!';
    } else {
        $messages[] = 'Successfully deleted ' .$index. ' (selected) comments!';
    }
}

if (isset($_POST['unspam_selected_comments'])) {
    $index = 0;
    foreach ( $_POST as $key => $value ) {
        if ( $key != 'check_all_comments' && substr($key, 0, 20) == 'comment_id_checkbox_') {
            if ( $value == 'on' ) {
                $comment_id = intval(str_replace('comment_id_checkbox_', '',$key));
                $sql = "DELETE FROM spam WHERE type = 'game' AND comment_id = " .$comment_id; 
                $conn->execute($sql);                
                ++$index;
            }
        }
    }

    if ( $index === 0 ) {
        $errors[]   = 'Please select comments to be unspammed!';
    } else {
        $messages[] = 'Successfully unspammed ' .$index. ' (selected) comments!';
    }
}

$remove         = NULL;
$page   = (isset($_GET['page'])) ? intval($_GET['page']) : 1;

if ( isset($_GET['a']) && $_GET['a'] != '' ) {
    $action     = trim($_GET['a']);
    $CID        = ( isset($_GET['CID']) && is_numeric($_GET['CID']) ) ? intval(trim($_GET['CID'])) : NULL;
    $SID        = ( isset($_GET['SID']) && is_numeric($_GET['SID']) ) ? intval(trim($_GET['SID'])) : NULL;
    switch ( $action ) {
        case 'delete':
            $sql    = "DELETE FROM game_comments WHERE CID = " .$CID. " LIMIT 1";
            $conn->execute($sql);
            if ( $conn->Affected_Rows() == 1 ) {
                $sql    = "DELETE FROM spam WHERE type = 'game' AND comment_id = " .$CID;
                $conn->execute($sql);
                $messages[] = 'Successfully deleted comment!';
            } else {
                $errors[]   = 'Failed to delete comment! Are you sure this comment exists?!';
            }
			$remove = '&a=delete&CID=' .$CID;
            break;
        case 'unspam':
            $sql    = "DELETE FROM spam WHERE type = 'game' AND spam_id = " .$SID;
            $conn->execute($sql);
            if ( $conn->Affected_Rows() > 0 ) {
                $messages[] = 'Successfully unspamed this comment!';
            } else {
                $errors[]   = 'Failed to unspam comment! Are you sure this spam flag exists?!';
            }
			$remove = '&a=unspam&SID=' .$SID;
            break;
    }
}

$sql            = "SELECT COUNT(spam_id) AS total_spam FROM spam WHERE type = 'game'";
$rs             = $conn->execute($sql);
$total_spam     = $rs->fields['total_spam'];
$pagination     = new Pagination(20);
$limit          = $pagination->getLimit($total_spam);
$paging         = $pagination->getAdminPagination($remove);
$sql            = "SELECT s.spam_id, s.UID AS RID, s.addtime AS add_time, c.*, u.username
                   FROM spam AS s, game_comments AS c, signup AS u
                   WHERE s.comment_id = c.CID AND s.parent_id = c.GID AND c.UID = u.UID
                   LIMIT " .$limit;
$rs             = $conn->execute($sql);
$comments       = $rs->getrows();

$smarty->assign('comments', $comments);
$smarty->assign('total_spam', $total_spam);
$smarty->assign('paging', $paging);
$smarty->assign('page', $page);
?>
