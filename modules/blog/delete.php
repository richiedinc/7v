<?php
defined('_VALID') or die('Restricted Access!');
require $config['BASE_DIR']. '/classes/auth.class.php';
require $config['BASE_DIR']. '/classes/filter.class.php';

Auth::check_();

$uid = intval($_SESSION['uid']);
if ( isset($_POST['delete_yes']) && $_POST['delete_yes'] == 'Yes' ) {
    $sql    = "DELETE FROM blog WHERE UID = " .$uid. " AND BID = " .$bid. " LIMIT 1";
    $conn->execute($sql);
    if ( $conn->Affected_Rows() == 1 ) {
        $_SESSION['message']    = $lang['blog.delete_msg'];
        VRedirect::go($config['BASE_URL']. '/user/' .$username. '/blog');
    } else {
        $errors[]   = $lang['blog.delete_err'];
    }
}

if ( isset($_POST['delete_no']) && $_POST['delete_no'] == 'No' ) {
    VRedirect::go($config['BASE_URL']. '/user/' .$username. '/blog');
}

$smarty->assign('blog', $blog);
?>
