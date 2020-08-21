<?php
defined('_VALID') or die('Restricted Access!');

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/compat/json.php';
require $config['BASE_DIR']. '/include/dbconn.php';

$data   = array('msg' => '', 'code' => '', 'vid' => 0, 'cid' => 0);
if ( isset($_POST['video_id']) && isset($_POST['comment']) ) {
    if ( $config['video_comments'] == '0' ) {
        $data['msg'] = show_err($lang['ajax.video_comment_disabled']);
    } elseif ( isset($_SESSION['uid']) ) {
        $spam   = false;
        if ( isset($_SESSION['v_comment_added']) ) {
            $delay  = intval($_SESSION['v_comment_added'])+30;
            if ( time() < $delay ) {
                $spam = true;
                $_SESSION['v_comment_added'] = time();
            }
        }

        if ( $spam ) {
            $data['msg'] = show_err($lang['ajax.dont_spam']);
        } else {
            $filter         = new VFilter();
            $uid            = intval($_SESSION['uid']);
            $vid            = $filter->get('video_id', 'INTEGER');
            $comment        = $filter->get('comment');
            $sql            = "INSERT INTO video_comments ( VID, UID, comment, addtime )
                               VALUES (" .$vid. ", " .$uid. ", " .$conn->qStr($comment). ", '" .time(). "')";
            $conn->execute($sql);
            $cid            = $conn->insert_Id();
            $sql            = "UPDATE video SET com_num = com_num+1 WHERE VID = " .$vid. " LIMIT 1";
            $conn->execute($sql);
        
            $username       = $_SESSION['username'];
            $photo          = ( $_SESSION['photo'] == '' ) ? 'nopic-' .$_SESSION['gender']. '.gif' : $_SESSION['photo'];
			
            $code           = '<div id="video_comment_' .$vid. '_' .$cid. '" class="col-xs-12 m-t-15">';
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
			$code          .= '<a href="#delete_comment" id="delete_comment_video_' .$cid. '_' .$vid. '">'.$lang['global.delete'].'</a> <span id="delete_response_' .$cid. '" style="display: none;"></span>';
			$code          .= '</div>';
			$code          .= '</div>';			
            $code          .= '<div class="clearfix"></div>';
			$code          .= '</div>';
			$code          .= '</div>';         
            $data['code']   = $code;
            $data['cid']    = $cid;
            $data['vid']    = $vid;
			$data['status'] = 1;
			$data['msg'] 	= show_msg($lang['global.comment_success']);
            $_SESSION['v_comment_added'] = time();
            
            $sql    = "SELECT v.UID, v.title, s.email, u.video_comment
                       FROM video AS v, users_prefs AS u, signup As s
                       WHERE v.VID = " .$vid. "
                       AND v.UID = u.UID
                       AND v.UID = s.UID
                       LIMIT 1";
            $rs     = $conn->execute($sql);
            if ( $conn->Affected_Rows() === 1 ) {
                $prefs_v_comment = $rs->fields['video_comment'];
                if ( $prefs_v_comment == '1' ) {
                    $email          = $rs->fields['email'];
                    $title          = $rs->fields['title'];
                    require $config['BASE_DIR']. '/classes/file.class.php';
                    require $config['BASE_DIR']. '/classes/email.class.php';
                    $video_link     = $config['BASE_URL']. '/video/' .$vid. '/' .prepare_string($title);
                    $search         = array('{$username}', '{$site_title}', '{$site_name}', '{$baseurl}', '{$video_link}');
                    $replace        = array($_SESSION['username'], $config['site_title'], $config['site_name'], $config['BASE_URL'], $video_link);
                    $mail           = new VMail();
                    $mail->sendPredefined($email, 'video_comment', $search, $replace);
                }
            }
        }
    } else {
        $data['msg'] = show_err($lang['ajax.video_comment_login']);
    }
}

echo json_encode($data);
die();
?>
