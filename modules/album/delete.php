<?php
defined('_VALID') or die('Restricted Access!');
require $config['BASE_DIR']. '/classes/auth.class.php';
$auth   = new Auth();
$auth->check();

// we dont cache anything here...needed for the album avatar update!
header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
header('Cache-Control: no-store, no-cache, must-revalidate');
header('Cache-Control: post-check=0, pre-check=0', false);
header('Pragma: no-cache');

if ( isset($_SESSION['uid']) && $uid != $_SESSION['uid'] ) {
    VRedirect::go($config['BASE_URL']. '/notfound/album_permission');
}

if ( isset($_POST['delete_yes']) && isset($_POST['confirm_delete']) ) {
	if ($config['delete_album']) {
		$sql = "DELETE FROM albums WHERE AID = ".$aid." AND UID = ".$uid." LIMIT 1";
		$conn->execute($sql);

		//delete album cover
		$file = $config['BASE_DIR'].'/media/albums/'.$aid.'.jpg';
		if ( file_exists($file) ) {
			@chmod($file, 0777);
			@unlink($file);
		}		

		$sql = "SELECT PID FROM photos WHERE AID = ".$aid;
		$rs = $conn->execute($sql);

		//delete photos + thumbs
		foreach ($rs as $value) {
			$file = $config['BASE_DIR'].'/media/photos/'.$value['PID'].'.jpg';
			if ( file_exists($file) ) {
				@chmod($file, 0777);
				@unlink($file);
			}
			$file = $config['BASE_DIR'].'/media/photos/tmb/'.$value['PID'].'.jpg';
			if ( file_exists($file) ) {
				@chmod($file, 0777);
				@unlink($file);
			}
		}		
		
		$sql = "DELETE FROM photos WHERE AID = ".$aid;
		$conn->execute($sql);
	} else {

		$sql  = "SELECT UID FROM signup WHERE username = 'anonymous' LIMIT 1";
		$rs   = $conn->execute($sql);
		$anon = intval($rs->fields['UID']);
		$sql  = "UPDATE albums SET UID = ".$anon." WHERE AID = ".$aid." LIMIT 1";
		$conn->execute($sql);
		$sql  = "UPDATE signup SET total_albums = total_albums+1 WHERE UID = ".$anon." LIMIT 1";
		$conn->execute($sql);
	}

	$sql = "UPDATE signup SET total_albums = total_albums-1 WHERE UID = ".$uid." LIMIT 1";
	$conn->execute($sql);
	
	$_SESSION['message'] = $lang['album.delete_msg'].'!';
    header('Location: ' .$config['BASE_URL']. '/albums');
    die();
}

if ( isset($_POST['delete_no']) ) {
    VRedirect::go($config['BASE_URL']. '/albums');
}

?>
