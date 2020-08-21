<?php
defined('_VALID') or die('Restricted Access!');
require $config['BASE_DIR']. '/classes/filter.class.php';

if ( $config['photo_module'] == '0' ) {
	VRedirect::go($config['BASE_URL']. '/notfound/page_invalid');
}

$album          = array('name' => '', 'category' => 0, 'tags' => '',
                        'anonymous' => 'no', 'type' => 'public');
if ( isset($_POST['upload_photo_submit']) ) {
    $step       = 'photo';
    $filter     = new VFilter();
    $name       = $filter->get('album_name');
    $category   = $filter->get('album_category', 'INTEGER');
    $tags       = $filter->get('album_tags');
    $type       = $filter->get('album_type');
    $anonymous  = $filter->get('album_anonymous');
	
    if ( $name == '' ) {
        $errors[]       = $lang['album.name_empty'];
    } else {
        $album['name']  = $name;
    }
    
    if ( $category == '0' ) {
        $errors[]       = $lang['album.category_empty'];
    } else {
        $album['category'] = $category;
    }
    
    if ( $tags == '' ) {
        $errors[]       = $lang['album.tags_empty'];
    } else {
        $tags           = prepare_string($tags, false);
        $album['tags']  = $tags;
    }
    
    if ( $_FILES['photo_1']['tmp_name'] == '' ) {
        $errors[]           = $lang['album.select_one'];
    } elseif ( !is_uploaded_file($_FILES['photo_1']['tmp_name']) ) {
        $errors[]           = $lang['upload.album_invalid'];
    } else {
        $filename           = substr($_FILES['photo_1']['name'], strrpos($_FILES['photo_1']['name'], DIRECTORY_SEPARATOR)+1);
        $extension          = strtolower(substr($_FILES['photo_1']['name'], strrpos($_FILES['photo_1']['name'], '.')+1));
        $extensions_allowed = explode(',', trim($config['image_allowed_extensions']));
        if ( !in_array($extension, $extensions_allowed) ) {
			$errors[] 		= translate('upload.album_ext_invalid', $config['image_allowed_extensions']);
        }
    }
    
    $album['type']      = ( $type == 'private' ) ? 'private' : 'public';
    $album['anonymous'] = ( $anonymous == 'yes' ) ? 'yes' : 'no';
    $uid                = ( $anonymous == 'yes' ) ? getAnonymousUID() : intval($_SESSION['uid']);
    
    if ( !$errors ) {
        require $config['BASE_DIR']. '/classes/image.class.php';
        $type       = ( $type == 'public' ) ? 'public' : 'private';
        $status     = ( $config['approve_photos'] == '1' ) ? 0 : 1;
        $sql        = "INSERT INTO albums (UID, name, category, tags, type, addtime, adddate, status)
                       VALUES (" .$uid. ", " .$conn->qStr($name). ", " .$category. ",
                           " .$conn->qStr($tags). ", '" .$type. "', " .time(). ", '" .date('Y-m-d'). "', '" .$status. "')";
        $conn->execute($sql);
        $album_id   = $conn->insert_Id();
        
        $photos    = 0;
        $image      = new VImageConv();
        foreach ( $_FILES as $key => $values ) {
            if ( $values['tmp_name'] != '' ) {
                if ( is_uploaded_file($values['tmp_name']) && getimagesize($values['tmp_name'])) {
              		$ext = strtolower(substr($values['name'], strrpos($values['name'], '.')+1));
              		if (!check_image($values['tmp_name'], $ext)) {
                  		continue;
              		}
					
                    ++$photos;
                    $photo_expl     = explode('_', $key);
                    $photo_nr       = $photo_expl['1'];
                    $caption        = $filter->get('caption_' .$photo_nr);
                    $sql_add        = NULL;
                    if ( $caption != '' ) {
                        $sql_add    = ", caption = " .$conn->qStr($caption). "";
                    }
                    
                    $sql            = "INSERT INTO photos SET AID = " .$album_id . $sql_add;
                    $conn->execute($sql);
                    $photo_id       = $conn->insert_Id();
                    if ( $photos === 1 ) {
                        $album_cover_id = $photo_id;
                    }
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
                }
            }
        }
        
        $src        = $config['BASE_DIR']. '/media/photos/tmb/' .$album_cover_id. '.jpg';
        $dst        = $config['BASE_DIR']. '/media/albums/' .$album_id. '.jpg';
        $image->process($src, $dst, 'MAX_WIDTH', 400, 0);
        $image->resize(true, true);
		
        $sql        = "UPDATE albums SET total_photos = " .intval($photos). " WHERE AID = " .$album_id. " LIMIT 1";
        $conn->execute($sql);
        $sql        = "UPDATE album_categories SET total_albums = total_albums+1 WHERE CID = " .$category. " LIMIT 1";
        $conn->execute($sql);
        $sql        = "UPDATE signup SET total_albums = total_albums+1, points = points+5 WHERE UID = " .$uid. " LIMIT 1";
        $conn->execute($sql);
		
		$album_url  = $config['BASE_URL']. '/album/' .$album_id. '/' .prepare_string($name);
        $album_link = '<a href="' .$album_url. '">' .$album_url. '</a>';
        $search     = array('{$site_title}', '{$site_name}', '{$username}', '{$album_link}', '{$baseurl}');
        $replace    = array($config['site_title'], $config['site_name'], $_SESSION['username'], $album_link, $config['BASE_URL']);
        $mail       = new VMail();
        if ( $config['approve'] == '0' ) {
            $mail->sendPredefined($_SESSION['email'], 'photo_approve', $search, $replace);
        } else {
            $mail->sendPredefined($_SESSION['email'], 'photo_upload', $search, $replace);
        }

        $album['name']      = '';
        $album['category']  = 0;
        $album['tags']      = '';
        $album['anonymous'] = 'no';
        $album['type']      = 'public';
        
        if ( $config['approve_photos'] == '1' ) {
			$messages[] = translate('upload.album_approve', $config['site_name']);
        } else {
			$messages[] = translate('upload.album_success', $config['site_name'], $album_url, htmlspecialchars($name, ENT_QUOTES, 'UTF-8'));
        }
    }
}

$image_extensions  = '(' .str_replace(',', ' | ', $config['image_allowed_extensions']). ')';
$smarty->assign('image_extensions', $image_extensions);	

$smarty->assign('album', $album);
$smarty->assign('upload_photo', true);
$smarty->assign('categories', get_albums_categories());
?>
