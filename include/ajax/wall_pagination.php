<?php
defined('_VALID') or die('Restricted Access!');

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/compat/json.php';
require $config['BASE_DIR']. '/classes/pagination.class.php';
require $config['BASE_DIR']. '/include/dbconn.php';

$code           = array();
if ( isset($_POST['user_id']) && isset($_POST['page']) ) {
    $filter         = new VFilter();
    $oid            = $filter->get('user_id', 'INTEGER');
    $page           = $filter->get('page', 'INTEGER');
    $uid            = ( isset($_SESSION['uid']) ) ? intval($_SESSION['uid']) : NULL;
    
    $sql            = "SELECT username FROM signup WHERE UID = " .$oid. " LIMIT 1";
    $rs             = $conn->execute($sql);
    $username       = $rs->fields['username'];
    
    $sql            = "SELECT COUNT(wall_id) AS total_walls FROM wall WHERE OID = " .$oid;
    $rsc            = $conn->execute($sql);
    $total          = $rsc->fields['total_walls'];
    $pagination     = new Pagination(10, $page);
    $limit          = $pagination->getLimit($total);
    $sql            = "SELECT w.wall_id, w.UID, w.message, w.addtime, u.username, u.photo, u.gender
                       FROM wall AS w, signup AS u WHERE w.OID = " .$oid. " AND w.status = '1' AND w.UID = u.UID 
                       ORDER BY w.addtime DESC LIMIT " .$limit;
    $rs             = $conn->execute($sql);
    $comments       = $rs->getrows();
    $page_link      = $pagination->getPagination('user/' .$username. '/wall', 'p_wall_comments_' .$oid. '_');
    $page_link_b    = $pagination->getPagination('user/' .$username. '/wall', 'pp_wall_comments_' .$oid. '_');
    $start_num      = $pagination->getStartItem();
    $end_num        = $pagination->getEndItem();
    

    $code[]         = $lang['global.showing']. ' <span class="text-white">' .$start_num. '</span> '.$lang['global.to'].' <span id="end_num" class="text-white">' .$end_num. '</span> '.$lang['global.of'].' <span id="total_comments" class="text-white">' .$total. '</span> '.$lang['global.comments'].'.';
	$code[]         = '<div id="wall_response" class="wall_posting" style="display: none;">'. $lang['global.posting'] .'</div>';
	
    if ( $comments ) {

        $code[]     = '<div id="comments_delimiter" style="display:none;"></div>';
        foreach ( $comments as $comment ) {
            $photo      = ( $comment['photo'] == '' ) ? 'nopic-' .$comment['gender']. '.gif' : $comment['photo'];
            $username   = $comment['username'];
            $code[]     = '<div id="wall_comment_' .$comment['wall_id']. '" class="col-xs-12 m-t-15">';
			$code[]		= '<div class="row">';
			$code[]		= '<div class="pull-left">';
			$code[]     = '<a href="' .$config['BASE_URL']. '/user/' .$username. '">';
			$code[]		= '<img src="' .$config['BASE_URL']. '/media/users/' .$photo. '" title="' .$username. '" alt="' .$username. '" class="img-responsive comment-avatar" />';
			$code[]		= '</a>';
			$code[]		= '</div>';
			$code[]     = '<div class="comment">';
			$code[]     = '<div class="comment-info">';
			$code[]		= '<a href="' .$config['BASE_URL']. '/user/' .$username. '">' .$username. '</a>&nbsp;-&nbsp;<span class="font-10">' .time_range($comment['addtime']). '</span>';
			$code[]		= '</div>';
			$code[]		= '<div class="comment-body overflow-hidden">' .nl2br($comment['message']). '</div>';
            if ( $uid ) {
                $code[]   = '<div class="comment-actions">';
                if ( $comment['UID'] == $uid ) {
                    $code[] = '<a href="#delete_comment" id="delete_comment_wall_' .$comment['wall_id']. '_' .$oid. '">'.$lang['global.delete'].'</a> <span id="delete_response_' .$comment['wall_id']. '" style="display: none;"></span>';
                }
				if ( $comment['UID'] != $uid ) {
					$code[]  = '<span id="reported_spam_' .$comment['wall_id']. '_' .$oid. '"><a href="#report_spam" id="report_spam_wall_' .$comment['wall_id']. '_' .$oid. '">'.$lang['global.report_spam'].'</a></span>';
				}
                $code[]  = '</div>';
            }
			$code[]     = '</div>';			
            $code[]     = '<div class="clearfix"></div>';
			$code[]     = '</div>';
			$code[]     = '</div>';
        }
		if ( $page_link ) {
			$code[]     = '<div class="visible-xs center m-b--15">';
			$code[]     = '<ul class="pagination pagination-lg">'. $page_link .'</ul>';
			$code[]     = '</div>';
			$code[]     = '<div class="hidden-xs center m-b--15">';
			$code[]     = '<ul class="pagination">'. $page_link .'</ul>';
			$code[]     = '</div>';
		}

    } else {
        $code[] = '<div class="m-t-15"><span class="text-danger">' .$lang['comments.page_no_comments']. '</span></div>';
    }        
} 

echo implode("\n", $code);
die();
?>
