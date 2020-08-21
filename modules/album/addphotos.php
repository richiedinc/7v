<?php
defined('_VALID') or die('Restricted Access!');

require $config['BASE_DIR']. '/classes/auth.class.php';
require $config['BASE_DIR']. '/classes/image.class.php';
require $config['BASE_DIR']. '/classes/filter.class.php';

$auth   = new Auth();
$auth->check();

if ( isset($_SESSION['uid']) && $uid != $_SESSION['uid'] ) {
    session_write_close();
    header('Location: ' .$config['BASE_URL']. '/notfound/album_permission');
    die();
}

if ( isset($_POST['add_photos_submit']) ) {
    $photos     = 0;
    $filter     = new VFilter();
    $image      = new VImageConv();
    foreach ( $_FILES as $key => $values ) {
        if ( $values['tmp_name'] != '' ) {
            if ( is_uploaded_file($values['tmp_name']) && $check = getimagesize($values['tmp_name'])) {
				$ext = strtolower(substr($values['name'], strrpos($values['name'], '.')+1));
				if (!check_image($values['tmp_name'], $ext)) {
					continue;
				}
				
                $photo_expl     = explode('_', $key);
                $photo_nr       = $photo_expl['1'];
                $caption        = $filter->get('caption_' .$photo_nr);
                $sql_add        = NULL;
                if ( $caption != '' ) {
                    $sql_add    = ", caption = " .$conn->qStr($caption). "";
                }
                $sql            = "INSERT INTO photos SET AID = " .$aid . $sql_add;
                $conn->execute($sql);
                $photo_id       = $conn->insert_Id();
                $src            = $values['tmp_name'];
                $dst            = $config['BASE_DIR']. '/media/photos/tmb/' .$photo_id. '.jpg';
				
				list ($width, $height) = getimagesize($src);
				$crop_w = min ($width, $height);
				$crop_h = $crop_w;
				if ($width > $height) {
					$crop_x = floor (($width - $crop_w)/2);
					$crop_y = 0;
				}
				else {
					$crop_x = 0;
					$crop_y = floor (($height - $crop_h)/2);
				}			
				
				$image->process($src, $dst, 'EXACT', $crop_w, $crop_h);
				$image->crop($crop_x, $crop_y, $crop_w, $crop_h, true);
				$image->process($dst, $dst, 'MAX_WIDTH', 400, 0);
				$image->resize(true, true);
				
                $dst        = $config['BASE_DIR']. '/media/photos/' .$photo_id. '.jpg';
                $image->process($src, $dst, 'MAX_WIDTH', 960, 0);
                $image->resize(true, true);
 
				++$photos;
            }
        }
    }
    
    $sql        = "UPDATE albums SET total_photos = total_photos+" .intval($photos). " WHERE AID = " .$aid. " LIMIT 1";
    $conn->execute($sql);
    $_SESSION['message'] = $lang['album.add_photos_msg'].'!';
    header('Location: ' .$config['BASE_URL']. '/album/' .$aid);
    die();
}            
?>
