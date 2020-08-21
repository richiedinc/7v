<?php
defined('_VALID') or die('Restricted Access!');

if ( $config['game_module'] == '0' ) {
    die();
}

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/compat/json.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/dbconn.php';

$data   = array('status' => 0, 'msg' => '', 'debug' => '');
if ( isset($_POST['item_id']) && isset($_POST['flag_id']) && isset($_POST['message']) ) {
    $filter         = new VFilter();
    $game_id        = $filter->get('item_id', 'INTEGER');
    $flag_id        = $filter->get('flag_id');
    $flag_message   = $filter->get('message');
    if ( isset($_SESSION['uid']) ) {
        $uid    = intval($_SESSION['uid']);
        if ( $flag_id == '' OR strlen($flag_id) > 14 ) {
            $data['msg'] = show_err_mb($lang['ajax.flag_invalid']);
        } else {
            $sql         = "SELECT GID FROM game_flags WHERE GID = " .$game_id. " AND UID = " .$uid. " LIMIT 1";
            $conn->execute($sql);
            if ( $conn->Affected_Rows() == 1 ) {
                $data['msg'] = show_err_mb($lang['ajax.flag_game_exists']);
            } else {
                $sql     = "INSERT INTO game_flags (GID, UID, reason, message, add_date)
                            VALUES (" .$game_id. ", " .$uid. ", " .$conn->qStr($flag_id). ",
                                    " .$conn->qStr($flag_message). ", '" .date('Y-m-d'). "')";
                $conn->execute($sql);
                $data['status'] = 1;
                $data['msg']    = show_msg_mb($lang['ajax.flag_game_success']);
            }
        }
    } else {
        $data['msg'] = show_err_mb($lang['ajax.flag_game_login']);
    }
}

echo json_encode($data);
die();
?>
