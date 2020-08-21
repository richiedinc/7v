<?php

defined('_VALID') or die('Restricted Access!');

if ( $config['game_module'] == '0' ) {
    die();
}

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/compat/json.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/dbconn.php';
require $config['BASE_DIR']. '/include/function_user.php';


$response = array('status' => 0, 'msg' => '', 'debug' => '');
if ( isset($_POST['game_id']) ) {
    if ( isset($_SESSION['uid']) ) {
        $filter     = new VFilter();
        $gid        = $filter->get('game_id', 'INTEGER');

        $uid        = intval($_SESSION['uid']);
        $sql        = "SELECT UID FROM game WHERE GID = " .$gid. " LIMIT 1";
        $rs         = $conn->execute($sql);
	   
       if ( $conn->Affected_Rows() === 1 ) { 
           $game  = $rs->getrows();
			if ($uid == $game[0][0]) {
				deleteGame( $gid );
				$response['status'] = 1;
				$response['msg'] = show_msg_mb($lang['ajax.delete_game_success']);
           } else {
                $response['msg'] = show_err_mb($lang['ajax.delete_game_failed']);
           }
		} else {
			$response['msg'] = show_err_mb($lang['ajax.delete_game_failed']);
        } 
       
    } else {
		$response['msg']   = show_err_mb($lang['ajax.delete_game_login']);
    }
}

echo json_encode($response);
die();
?>
