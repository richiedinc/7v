<?php
defined('_VALID') or die('Restricted Access!');

Auth::checkAdmin();

$chimg  = $config['BASE_DIR']. '/media/categories/game';
if ( !file_exists($chimg) or !is_dir($chimg) or !is_writable($chimg) ) {
    $errors[] = 'Category image directory \'' .$chimg. '\' is not writable!';
}

$channel    = array();
$CID        = ( isset($_GET['CID']) && is_numeric($_GET['CID']) ) ? trim($_GET['CID']) : NULL;
$CID        = ( $CID && channelExists($CID, 'game') ) ? $CID : NULL;
if ( !$CID ) {
    $errors[] = 'Category does not exist! Invalid channel id!?';
}

if ( isset($_POST['edit_channel']) && !$errors ) {
    $name   = trim($_POST['name']);
    $slug   = toAscii(trim($_POST['slug']));	
    
    if ( $name == '' ) {
        $errors[]   = 'Category name field cannot be blank!';
    } else {
        $sql        = "SELECT category_id FROM game_categories
                       WHERE category_name = " .$conn->qStr($name). " AND category_id != ".$CID." LIMIT 1";
        $conn->execute($sql);
        if ( $conn->Affected_Rows() > 0 ) {
            $errors[]   = 'Category name \'' .htmlspecialchars($name, ENT_QUOTES, 'UTF-8'). ' is already used. Please choose another name!';
        }	
	} 
    
    if ( $slug == '' ) {
        $errors[]   = 'Category slug field cannot be blank!';
    } 
    
	if (channelSlugExists($slug, $CID, 'game')) {
		$errors[]   = 'This slug already exists, please choose a different one!';
	}
	
    if ( !$errors ) {
        $sql = "UPDATE game_categories SET category_name = " .$conn->qStr($name). ", slug = " .$conn->qStr($slug). " WHERE category_id = " .$conn->qStr($CID). " LIMIT 1";
        $conn->execute($sql);
		if ($_FILES['picture']['tmp_name'] != '') {
			require $config['BASE_DIR']. '/classes/image.class.php';
      		$image = new VImageConv();
      		$image->process($_FILES['picture']['tmp_name'], $chimg. '/' .$CID. '.jpg', 'MAX_WIDTH', 384, 216);
      		$image->canvas(384, 216, '000000', true);
		}
    }
    
    if ( !$errors ) {
        $messages[] = 'Category updated successfuly!';
    }
}

$sql        = "SELECT * FROM game_categories WHERE category_id = " .$conn->qStr($CID). " LIMIT 1";
$rs         = $conn->execute($sql);
$channel    = $rs->getrows();

$smarty->assign('channel', $channel);
?>
