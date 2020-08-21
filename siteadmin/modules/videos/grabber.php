<?php
defined('_VALID') or die('Restricted Access!');

Auth::checkAdmin();

require $config['BASE_DIR']. '/classes/filter.class.php';

$sql        = "SELECT * FROM grab_cron ORDER BY grab_id DESC";
$rs         = $conn->execute($sql);
$grabbers   = $rs->getrows();

$updated    = false;
$intervals  = array();
if ( isset($_POST['update_grabbers']) ) {
    $filter     = new VFilter();    
    foreach ( $grabbers as $grabber ) {
        $grab_id                = $grabber['grab_id'];
        $interval               = $filter->get('interval_' .$grab_id);
        $items                  = $filter->get('items_' .$grab_id);
        if ( $interval == 'hourly' or $interval == 'daily' ) {
            $sql    = "UPDATE grab_cron SET status = '1', grab_interval = " .$conn->qStr($intervals[$grab_id]). ", grab_number = " .$items. "
                       WHERE grab_id = " .$conn->qStr($grab_id). " LIMIT 1";
            $conn->execute($sql);
        } else {
            $sql    = "UPDATE grab_cron SET status = '0', grab_number = " .$items. "
                       WHERE grab_id = " .$conn->qStr($grab_id). " LIMIT 1";
            $conn->execute($sql);
        }
    }
    
    $updated    = true;
    $messages[] = 'Successfully updated grabbers configuration!';
}

if ( $updated ) {
    $sql        = "SELECT * FROM grab_cron ORDER BY grab_id DESC";
    $rs         = $conn->execute($sql);
    $grabbers   = $rs->getrows();
}

$smarty->assign('grabbers', $grabbers);
?>
