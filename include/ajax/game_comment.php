<?php
defined('_VALID') or die('Restricted Access!');

if ( $config['game_module'] == '0' ) {
    die();
}

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/compat/json.php';
require $config['BASE_DIR']. '/include/dbconn.php';

$data   = array('msg' => '', 'status' => 0, 'code' => '', 'vid' => 0, 'cid' => 0);
if ( isset($_POST['game_id']) && isset($_POST['comment']) ) {
    if ( $config['game_comments'] == '0' ) {
        $data['msg'] = show_err($lang['ajax.game_comment_disabled']);
    } elseif ( isset($_SESSION['uid']) ) {
        $spam   = false;
        if ( isset($_SESSION['g_comment_added']) ) {
            $delay  = intval($_SESSION['g_comment_added'])+30;
            if ( time() < $delay ) {
                $spam = true;
                $_SESSION['g_comment_added'] = time();
            }
        }
		
        if ( $spam ) {
            $data['msg'] = show_err($lang['ajax.dont_spam']);
        } else {
            $filter         = new VFilter();
            $uid            = intval($_SESSION['uid']);
            $gid            = $filter->get('game_id', 'INTEGER');
            $comment        = $filter->get('comment');
            $sql            = "INSERT INTO game_comments ( GID, UID, comment, addtime )
                               VALUES (" .$gid. ", " .$uid. ", " .$conn->qStr($comment). ", '" .time(). "')";
            $conn->execute($sql);
            $cid            = $conn->insert_Id();
            $sql            = "UPDATE game SET total_comments = total_comments+1 WHERE GID = " .$gid. " LIMIT 1";
            $conn->execute($sql);
        
            $username       = $_SESSION['username'];
            $photo          = ( $_SESSION['photo'] == '' ) ? 'nopic-'.$_SESSION['gender'].'.gif' : $_SESSION['photo'];
			
            $code           = '<div id="game_comment_' .$gid. '_' .$cid. '" class="col-xs-12 m-t-15">';
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
			$code          .= '<a href="#delete_comment" id="delete_comment_game_' .$cid. '_' .$gid. '">'.$lang['global.delete'].'</a> <span id="delete_response_' .$cid. '" style="display: none;"></span>';
			$code          .= '</div>';
			$code          .= '</div>';			
            $code          .= '<div class="clearfix"></div>';
			$code          .= '</div>';
			$code          .= '</div>';    
			$data['status'] = 1;   
            $data['code']   = $code;
            $data['cid']    = $cid;
            $data['gid']    = $gid;
			$data['msg']    = show_msg($lang['global.comment_success']);
            $_SESSION['g_comment_added'] = time();
            
            $sql    = "SELECT g.title, s.username, s.email, u.game_comment
                       FROM game AS g, signup AS s, users_prefs AS u 
                       WHERE g.GID = " .$gid. "
                       AND g.UID = s.UID
                       AND s.UID = u.UID 
                       LIMIT 1";
            $data['debug'] = $sql;
            $rs     = $conn->execute($sql);
            if ( $conn->Affected_Rows() === 1 ) {
                $prefs_g_comment = $rs->fields['game_comment'];
                if ( $prefs_g_comment == '1' ) {
                    $email          = $rs->fields['email'];
                    $username       = $rs->fields['username'];
                    $title          = $rs->fields['title'];
                    require $config['BASE_DIR']. '/classes/file.class.php';
                    require $config['BASE_DIR']. '/classes/email.class.php';
                    $game_link      = $config['BASE_URL']. '/game/' .$gid. '/' .prepare_string($title);
                    $search         = array('{$username}', '{$site_title}', '{$site_name}', '{$baseurl}', '{$game_link}');
                    $replace        = array($_SESSION['username'], $config['site_title'], $config['site_name'], $config['BASE_URL'], $game_link);
                    $mail           = new VMail();
                    $mail->sendPredefined($email, 'game_comment', $search, $replace);
                }
            }

        }
    } else {
        $data['msg'] = show_err($lang['ajax.game_comment_login']);
    }
}

echo json_encode($data);
die();
?>
