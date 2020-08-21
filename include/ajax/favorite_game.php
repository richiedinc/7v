<?php
defined('_VALID') or die('Restricted Access!');

if ( $config['game_module'] == '0' ) {
    die();
}

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/compat/json.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/dbconn.php';

$data   = array('status' => 0, 'msg' => '');
if ( isset($_POST['game_id']) ) {
    $filter         = new VFilter();
    $game_id       = $filter->get('game_id', 'INTEGER');
    if ( isset($_SESSION['uid']) ) {
        $uid = intval($_SESSION['uid']);
        $sql = "SELECT GID FROM game_favorites WHERE GID = " .$game_id. " AND UID = " .$uid. " LIMIT 1";
        $conn->execute($sql);
        if ( $conn->Affected_Rows() == 1 ) {
            $data['msg']    = show_err($lang['ajax.favorite_game_exists']);
        } else {
            $sql        = "SELECT GID, type FROM game WHERE GID = " .$game_id. " AND UID = " .$uid. " LIMIT 1";
            $conn->execute($sql);
            if ( $conn->Affected_Rows() == 1 ) {
                $data['msg']    = show_err($lang['ajax.favorite_game_self']);
            } else {
                $sql    = "INSERT INTO game_favorites SET GID = " .$game_id. ", UID = " .$uid;
                $conn->execute($sql);
                $sql    = "UPDATE game SET total_favorites = total_favorites+1 WHERE GID = " .$game_id. " LIMIT 1";
                $conn->execute($sql);
                $data['msg']    = show_msg($lang['ajax.favorite_game_success']);
                $data['status'] = 1;
            }
        }
    } else {
        $data['msg']    = show_err($lang['ajax.favorite_game_login']);
    }
}

echo json_encode($data);
die();
?>
