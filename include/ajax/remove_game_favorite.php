<?php
defined('_VALID') or die('Restricted Access!');

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/dbconn.php';
require $config['BASE_DIR']. '/include/compat/json.php';

$data = array('status' => 0, 'msg' => '');
if ( isset($_POST['game_id']) ) {
    if ( isset($_SESSION['uid']) ) {
        $filter     = new VFilter();
        $gid        = $filter->get('game_id', 'INTEGER');
        $uid        = intval($_SESSION['uid']);
        $sql        = "DELETE FROM game_favorites WHERE UID = " .$uid. " AND GID = " .$gid. " LIMIT 1";
        $conn->execute($sql);
		$data['status'] = 1;
		$data['msg'] =  show_msg_mb($lang['ajax.remove_fav_game_success']);
    } else {
        $data['msg']   =  show_err_mb($lang['ajax.remove_fav_game_login']);
    }
}

echo json_encode($data);
die();
?>
