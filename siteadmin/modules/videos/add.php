<?php
defined('_VALID') or die('Restricted Access!');

Auth::checkAdmin();

if ( !function_exists('curl_init') ) {
	$errors[] = 'You need php-curl installed to use this module. See: <a href="http://www.php.net/curl">http://www.php.net/curl</a>!';
}

require $config['BASE_DIR']. '/include/config.grabber.php';
require $config['BASE_DIR']. '/classes/curl.class.php';
require $config['BASE_DIR']. '/include/function_video.php';

$categories = get_categories();
$embed		= 0;
$video      = array('site' => '', 'title' => '', 'category' => '', 'tags' => '',
                    'username' => 'anonymous', 'url' => '', 'id' => '', 'size' => '', 'type' => 'public');
if ( isset($_POST['grab_video']) ) {
    $url        = trim($_POST['url']);
    $site       = trim($_POST['site']);
	$embed		= (isset($_POST['embed']) && $_POST['embed'] == '1') ? 1 : 0;
    
    if ( $url == '' ) {
        $errors[] = 'Please enter video url!';
    }
    
	if (!$errors ) {
        require $config['BASE_DIR']. '/classes/grabers/' .$site. '.class.php';
        $class              = 'VGrab_' .$site;
        $graber             = new $class;
		if ($embed) {
			if (!$graber->hasEmbed()) {
				$errors[] = 'We are sorry but this grabber does not support embedding!';
			}
		}
	}
	
    if ( !$errors ) {
        $graber->getPage($url);
        $video['site']      = $site;
        $video['title']     = $graber->getVideoTitle();
        $video['tags']      = $graber->getVideoTags();
        $video['category']  = $graber->getVideoCategory();
        foreach ( $categories as $category ) {
            if ( $category['name']. 's' == $video['category'] || $category['name'] == $video['category'] ) {
                $video['category'] = $category['name'];
                break;
            }
        }
		
		if ($embed) {
			if ($graber->hasEmbed()) {
				$video['embed']		 = TRUE;
				$video['embed_code'] = $graber->getVideoEmbedCode();
				$video['thumbs']	 = $graber->getVideoThumbs();
				$video['duration']	 = $graber->getVideoDuration();
			} else {
				$errors[] = 'We are sorry but this grabber does not have embed functions!';
			}
		} else {
      		$video['id']        = $graber->getVideoId();
      		$video['url']       = $graber->getVideoUrl();
      		if ( $video['url'] ) {
          		$curl           = new VCurl();
          		$video['size']  = $curl->getRemoteSize($video['url']);
      		}
		}
        
		if ($embed) {
			if ($video['embed_code'] == '') {
				$errors[] = 'Failed to get video embed code! Are you sure the url is correct?';
			}
			
			if (!$video['thumbs']) {
				$errors[] = 'Failed to get thumbs. Are you sure the url is correct?';
			}
		} else {
      		if ( !$video['url'] ) {
          		$errors[] = 'Failed to get video url! Are you sure the url is correct?';
      		}
		}
    }
}

if ( isset($_POST['save_video']) ) {
    $v_site_id  = trim($_POST['video_id']);
    $title      = trim($_POST['title']);
    $category   = intval(trim($_POST['category']));
    $tags       = trim($_POST['tags']);
    $url        = (isset($_POST['url'])) ? trim($_POST['url']) : '';
    $username   = trim($_POST['username']);
    $type       = ( isset($_POST['type']) && $_POST['type'] == 'private' ) ? 'private' : 'public';
	$embed		= (isset($_POST['embed'])) ? $_POST['embed'] : 0;
	if ($embed) {
		$embed_code = trim($_POST['embed_code']);
		$thumbs		= $_POST['thumbs'];
		$duration	= trim($_POST['duration']);
	}
    
    if ( $username == '' ) {
        $errors[]                = 'Please enter a username!';
    } else {
        $sql        = "SELECT UID FROM signup WHERE username = " .$conn->qStr($username). " LIMIT 1";
        $rs         = $conn->execute($sql);
        if ( $conn->Affected_Rows() == 1 ) {
            $uid                = intval($rs->fields['UID']);
            $video['username']  = $username;
        } else {
            $errors[]    = 'Username: ' .htmlspecialchars($username, ENT_QUOTES, 'UTF-8'). 'does not exist!';
        }
    }
    
    if ( $title == '' ) {
        $errors[]                = 'Please enter a video title!';
    } else {
        $video['title']     = $title;
    }
    
    if ( $category === 0 ) {
        $errors[]                = 'Please select a video category!';
    } else {
        $video['category']  = $category;
    }
    
    if ( $tags == '' ) {
        $errors[]                = 'Please enter video tags!';
    } else {
        $video['tags']      = $tags;
    }
    
	if ($embed) {
		if ($embed_code == '') {
			$errors[] = 'Please enter video embed code!';
		} else {
			$video['embed_code'] = $embed_code;
		}
		
		if (!$thumbs) {
			$errors[] = 'Failed to get the video thumbs. Are you sure the url is correct!?';
		} else {
			$video['thumbs'] = $thumbs;
		}
	
		if ($duration == '') {
			$errors[] = 'Please enter video duration';
		} else {
			$duration_seconds = duration_to_seconds($duration);
			if (!$duration_seconds) {
				$errors[] = 'Invalid video duration! Please use minutes:seconds (eg: 12:03, 00:17, 08:51...)!';
			} else {
				$video['duration'] = $duration;
			}
		}
	} else {
  		if ( $url == '' ) {
      		$errors[]                = 'Please enter a url for the flash video to be downloaded!';
  		} else {
      		$video['url']       = $url;
  		}
    
  		$video['size']          = trim($_POST['size']);
	}
	
    $video['site']          = trim($_POST['site']);
    $video['type']          = $type;
    
    if ( !$errors ) {
        $sql        = "INSERT INTO video (UID, title, channel, vkey, keyword, type, addtime, adddate)
                       VALUES (" .$uid. ", " .$conn->qStr($title). ", '" .$category. "',
                               '" .mt_rand(). "', " .$conn->qStr($tags). ",
                               '" .$type. "', '" .time(). "', '" .date('Y-m-d'). "')";
        $conn->execute($sql);
        $vid            = $conn->insert_Id();
		
		
      	$curl           = new VCurl();
		$sql_add		= '';
		if ($embed) {
			$tmb_err	= FALSE;
			$tmb_dir	= $config['BASE_DIR'].'/media/videos/tmb/'.$vid;
			@mkdir($tmb_dir);
			$i 			= 0;
			foreach ($thumbs as $thumb) {
				if ($i === 0) {
					$tmb_file = $tmb_dir.'/default.jpg';
				} else {
					$tmb_file = $tmb_dir.'/'.$i.'.jpg';
				}
				
				if (!$curl->saveToFile($thumb, $tmb_file)) {
					$tmb_err = TRUE;
				} else {
					++$i;
				}
			}
			
			if ($tmb_err === TRUE) {
          		$sql        = "DELETE FROM video WHERE VID = " .$vid. " LIMIT 1";
          		$conn->execute($sql);
				$errors[] = 'Failed to download video thumbs! Are you sure thumbs are displayed on the page!?';
			}
		
			$duration	= $duration_seconds;
			$size 		= 0;
          	$vdoname    = '';
          	$flvdoname  = '';
			$thumb_nr	= count($thumbs)-1;
			$sql_add	= ", embed_code = " .$conn->qStr($embed_code). ", duration = ".$duration.", thumbs = ".$thumb_nr;
			$add 		= '';
		} else {
		
		
			$vdo_path   = $config['VDO_DIR']. '/' .$vid.'.flv';
      
      		if ( !$curl->saveToFile($url, $vdo_path) ) {
          		$sql        = "DELETE FROM video WHERE VID = " .$vid. " LIMIT 1";
          		$conn->execute($sql);
          		$errors[]        = 'Failed to download video file!';
      		} else {
      			// ---------------------------------------------------------------------------
				// ---------------------------------------------------------------------------
				function run_in_background($Command, $Priority = 0){
					if($Priority) $PID = shell_exec("nohup nice -n $Priority $Command 2> /dev/null & echo $!");
					else $PID = shell_exec("nohup $Command 2> /dev/null & echo $!");
					return($PID);
				}
				
				exec($config['mplayer']. ' -vo null -ao null -frames 0 -identify "' .$vdo_path. '"', $p);
				while(list($k,$v)=each($p)){
					if (preg_match("/^ID_.+\=.+/", $v)){
						$lx = explode("=", $v);
						$vidinfo[$lx[0]] = $lx[1];
					}
				}
				$vdoname = $vid.'.flv';
				$flvdoname = $vid.'.flv';
				$video_id = $vid;
				$duration = $vidinfo['ID_LENGTH'];
				$height = $vidinfo['ID_VIDEO_HEIGHT'];
				$width = $vidinfo['ID_VIDEO_WIDTH'];
				$fps = $vidinfo['ID_VIDEO_FPS'];
				$id_video_format = $vidinfo['ID_VIDEO_FORMAT'];
				$cgi = ( strpos(php_sapi_name(), 'cgi') ) ? 'env -i ' : NULL;
			
				// Proc
		        $cmd = $cgi.$config['phppath']
					." ".$config['BASE_DIR']."/scripts/convert_videos.php"
					." ".$vdoname
					." ".$video_id
					." ".$vdo_path
				."";
		        log_conversion($config['LOG_DIR']. '/' .$video_id. '.log', $cmd);
		        $lg = $config['LOG_DIR']. '/' .$video_id. '.log2';
		        run_in_background($cmd.' > '.$lg);
          		
				$add		= NULL;
				if ($config['multi_server'] == '1') {
              		require $config['BASE_DIR']. '/include/function_server.php';
                    $server = get_server();
                    update_server_used($server);
                    upload_video($config['FLVDO_DIR']. '/' .$vid. '.flv', $server['server_ip'], $server['ftp_username'], $server['ftp_password'], $server['ftp_root']);
                    update_server($server);
                    $add = ", server = " .$conn->qStr($server['url']). "";				
				}
          		$size = filesize($vdo_path);
         
			}
		}
		
		if (!$errors) {
            $vkey       = substr(md5($vid),11,20);
            $sql        = "UPDATE video SET duration = " .$conn->qStr($duration). ", vkey = '" .$vkey. "',
                                            vdoname = " .$conn->qStr($vdoname). ", flvdoname = " .$conn->qStr($flvdoname). ",
                                            space = " .$size. ", active = '1'".$sql_add.$add."
                           WHERE VID = " .intval($vid). " LIMIT 1";
            $conn->execute($sql);
            $sql        = "UPDATE channel SET total_videos = total_videos+1 WHERE CHID = " .$category. " LIMIT 1";
            $conn->execute($sql);
			$sql		= "UPDATE signup SET total_videos = total_videos+1 WHERE UID = ".$uid." LIMIT 1";
			$conn->execute($sql);
            $sql        = "INSERT INTO grab (site, id)
                           VALUES (" .$conn->qStr($video['site']). ", " .$conn->qStr($v_site_id). ")";
            $conn->execute($sql);
            $messages[] = 'Video was successfully added!';                                                                                            
        }
    }
}

function duration_to_seconds($duration)
{
	$dur_arr  = explode(':', $duration);
	if (!isset($dur_arr['1'])) {
		return FALSE;
	}
	
	$duration = 0;
	if (isset($dur_arr['2'])) {
		$duration = ((int) $dur_arr['2']*3600);
	}
	
	$duration = $duration + ((int)$dur_arr['0']*60);
	
	return ($duration + (int)$dur_arr['1']);
}

function seconds_to_duration($duration)
{
	return $duration;
}

$smarty->assign('embed', $embed);
$smarty->assign('video', $video);
$smarty->assign('sites', $sites);
$smarty->assign('categories', get_categories());
?>
