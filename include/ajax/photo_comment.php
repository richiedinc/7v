<?php
defined('_VALID') or die('Restricted Access!');

if ( $config['photo_module'] == '0' ) {
    die();
}

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/compat/json.php';
require $config['BASE_DIR']. '/include/dbconn.php';

$data   = array('msg' => '', 'code' => '', 'pid' => 0, 'cid' => 0);
if ( isset($_POST['photo_id']) && isset($_POST['album_id']) && isset($_POST['comment']) ) {
    if ( $config['photo_comments'] == '0' ) {
        $data['msg'] = show_err($lang['ajax.photo_comment_disabled']);
    } elseif ( isset($_SESSION['uid']) ) {
        $spam   = false;
        if ( isset($_SESSION['p_comment_added']) ) {
            $delay  = intval($_SESSION['p_comment_added'])+30;
            if ( time() < $delay ) {
                $spam                       = true;
                $_SESSION['p_comment_added']  = time();
            }
        }

        if ( $spam ) {
            $data['msg'] = show_err($lang['ajax.dont_spam']);
        } else {
            $filter         = new VFilter();
            $uid            = intval($_SESSION['uid']);
            $pid            = $filter->get('photo_id', 'INTEGER');
            $aid            = $filter->get('album_id', 'INTEGER');
            $comment        = $filter->get('comment');
            $sql            = "INSERT INTO photo_comments ( PID, UID, comment, addtime )
                               VALUES (" .$pid. ", " .$uid. ", " .$conn->qStr($comment). ", '" .time(). "')";
            $conn->execute($sql);
            $cid            = $conn->insert_Id();
            $sql            = "UPDATE photos SET total_comments = total_comments+1 WHERE PID = " .$pid. " LIMIT 1";
            $conn->execute($sql);
            $sql            = "UPDATE albums SET total_comments = total_comments+1 WHERE AID = " .$aid. " LIMIT 1";
            $conn->execute($sql);
        
            $username       = $_SESSION['username'];
            $photo          = ( $_SESSION['photo'] == '' ) ? 'nopic-' .$_SESSION['gender']. '.gif' : $_SESSION['photo'];
			
            $code           = '<div id="photo_comment_' .$pid. '_' .$cid. '" class="col-xs-12 m-t-15">';
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
			$code          .= '<a href="#delete_comment" id="delete_comment_photo_' .$cid. '_' .$pid. '">'.$lang['global.delete'].'</a> <span id="delete_response_' .$cid. '" style="display: none;"></span>';
			$code          .= '</div>';
			$code          .= '</div>';			
            $code          .= '<div class="clearfix"></div>';
			$code          .= '</div>';
			$code          .= '</div>';       
            $data['code']   = $code;
            $data['cid']    = $cid;
            $data['pid']    = $pid;
			$data['status'] = 1;
			$data['msg'] 	= show_msg($lang['global.comment_success']);			
            $_SESSION['p_comment_added'] = time();
            
            $sql    = "SELECT a.UID, s.email, u.photo_comment 
                       FROM albums AS a, users_prefs AS u, signup AS s
                       WHERE a.AID = " .$aid. "
                       AND a.UID = u.UID
                       AND a.UID = s.UID
                       LIMIT 1";
            $rs     = $conn->execute($sql);
            if ( $conn->Affected_Rows() === 1 ) {
                $prefs_p_comment = $rs->fields['photo_comment'];
                if ( $prefs_p_comment == '1' ) {
                    $email          = $rs->fields['email'];
                    require $config['BASE_DIR']. '/classes/file.class.php';
                    require $config['BASE_DIR']. '/classes/email.class.php';
                    $photo_link     = $config['BASE_URL']. '/photo/' .$pid;
                    $search         = array('{$username}', '{$site_title}', '{$site_name}', '{$baseurl}', '{$photo_link}');
                    $replace        = array($_SESSION['username'], $config['site_title'], $config['site_name'], $config['BASE_URL'], $photo_link);
                    $mail           = new VMail();
                    $mail->sendPredefined($email, 'photo_comment', $search, $replace);
                }
            }
        }
    } else {
        $data['msg'] = show_err($lang['ajax.photo_comment_login']);
    }
}

echo json_encode($data);
die();
?>
