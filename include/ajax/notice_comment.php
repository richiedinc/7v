<?php
defined('_VALID') or die('Restricted Access!');

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/compat/json.php';
require $config['BASE_DIR']. '/include/dbconn.php';

$data   = array('status' => 0, 'msg' => '', 'code' => '', 'pid' => 0, 'cid' => 0);
if ( isset($_POST['notice_id']) && isset($_POST['comment']) ) {
    if ( $config['notice_comments'] == '0' ) {
        $data['msg'] = show_err($lang['ajax.notice_comment_disabled']);
    } elseif ( isset($_SESSION['uid']) ) {
        $spam   = false;
        if ( isset($_SESSION['n_comment_added']) ) {
            $delay  = intval($_SESSION['n_comment_added'])+30;
            if ( time() < $delay ) {
                $spam                       = true;
                $_SESSION['n_comment_added']  = time();
            }
        }

        if ( $spam ) {
            $data['msg'] = show_err($lang['ajax.dont_spam']);
        } else {
            $filter         = new VFilter();
            $uid            = intval($_SESSION['uid']);
            $nid            = $filter->get('notice_id', 'INTEGER');
            $comment        = $filter->get('comment');
            $sql            = "INSERT INTO notice_comments ( NID, UID, comment, addtime )
                               VALUES (" .$nid. ", " .$uid. ", " .$conn->qStr($comment). ", '" .time(). "')";
            $conn->execute($sql);
            $cid            = $conn->insert_Id();
            $sql            = "UPDATE notice SET total_comments = total_comments+1 WHERE NID = " .$nid. " LIMIT 1";
            $conn->execute($sql);
        
            $username       = $_SESSION['username'];
            $photo          = ( $_SESSION['photo'] == '' ) ? 'nopic-' .$_SESSION['gender']. '.gif' : $_SESSION['photo'];   
			
            $code           = '<div id="notice_comment_' .$nid. '_' .$cid. '" class="col-xs-12 m-t-15">';
			$code          .= '<div class="row">';
			$code          .= '<div class="pull-left">';
			$code          .= '<a href="' .$config['BASE_URL']. '/user/' .$username. '">';
			$code          .= '<img src="' .$config['BASE_URL']. '/media/users/' .$photo. '" title="' .$username. '\'s avatar" alt="' .$username. '\'s avatar" class="img-responsive comment-avatar" />';
			$code          .= '</a>';
			$code          .= '</div>';
			$code          .= '<div class="comment new-comment">';
			$code          .= '<div class="comment-info">';
			$code          .= '<a href="' .$config['BASE_URL']. '/user/' .$username. '">' .$username. '</a>&nbsp;-&nbsp;<span class="">'.$lang['global.right_now'].'</span>';
			$code          .= '</div>';
			$code          .= '<div class="comment-body overflow-hidden">' .nl2br($comment). '</div>';
			$code          .= '<div class="comment-actions">';
			$code          .= '<a href="#delete_comment" id="delete_comment_notice_' .$cid. '_' .$nid. '">'.$lang['global.delete'].'</a> <span id="delete_response_' .$cid. '" style="display: none;"></span>';
			$code          .= '</div>';
			$code          .= '</div>';			
            $code          .= '<div class="clearfix"></div>';
			$code          .= '</div>';
			$code          .= '</div>';        
            $data['code']   = $code;
            $data['cid']    = $cid;
			$data['nid']	= $nid;
			$data['status'] = 1;			
			$data['msg'] 	= show_msg($lang['global.comment_success']);			
            $_SESSION['n_comment_added'] = time();
        }
    } else {
        $data['msg'] = show_err($lang['ajax.notice_comment_login']);
    }
}

echo json_encode($data);
die();
?>
