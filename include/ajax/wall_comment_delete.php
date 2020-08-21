<?php
defined('_VALID') or die('Restricted Access!');

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/compat/json.php';
require $config['BASE_DIR']. '/include/dbconn.php';

$data   = array('msg' => '', 'status' => 0, 'debug' => '');
if ( isset($_POST['parent_id']) && isset($_POST['comment_id']) ) {
    if ( isset($_SESSION['uid']) ) {
        $filter     = new VFilter();
        $uid        = intval($_SESSION['uid']);
        $wid        = $filter->get('comment_id', 'INTEGER');
        $oid        = $filter->get('parent_id', 'INTEGER');
        $sql        = "DELETE FROM wall WHERE UID = " .$uid. " AND OID = " .$oid. " AND wall_id = " .$wid. " LIMIT 1";
        $data['debug'] = $sql;
        $conn->execute($sql);
        if ( $conn->Affected_Rows() == 1 ) {
            $data['status'] = 1;
			$data['msg'] = $lang['ajax.comment_success'];
        } else { 
            $data['msg'] = $lang['ajax.comment_delete'];
        }
    } else {
        $data['msg'] = $lang['ajax.comment_login'];
    }
} else {
    $data['msg'] = 'Invalid request!?';
}

echo json_encode($data);
die();
?>
