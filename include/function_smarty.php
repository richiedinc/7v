<?php
defined('_VALID') or die('Restricted Access!');

function insert_time_range( $options )
{
	global $lang;

    $range          = NULL;
    $time           = $options['time'];
    $current_time   = time();    
    $interval       = $current_time-$time;
    if ( $interval > 0 ) {
        $day    = $interval/(60*60*24);
        if ( $day >= 1 ) {
            $range      = floor($day).' '.$lang['global.days'];
            $interval   = $interval-(60*60*24*floor($day));            
        }
        if( $interval > 0 && $range == '' ) {
            $hour       = $interval/(60*60);
            if ( $hour >=1 ) {
                $range      = floor($hour). ' ' .$lang['global.hours'];
                $interval   = $interval-(60*60*floor($hour));
            }            
        }
        if ( $interval > 0 && $range == '' ) {
            $min        = $interval/(60);
            if ( $min >= 1 ) {
                $range=floor($min). ' '.$lang['global.minutes'];
                $interval=$interval-(60*floor($min));
            }
        }
        if ( $interval > 0 && $range == '' ) {
            $scn        = $interval;
            if ( $scn >= 1 ) {
                $range  = $scn. ' '.$lang['global.seconds'];
            }
        }
        
        return ( $range != '' ) ? $range. ' '.$lang['global.ago'] : $lang['global.just_now'];
    }
}

function insert_duration ( $options )
{
    $duration_formated  = NULL;
    $duration           = round($options['duration']);
    if ( $duration > 3600 ) {
        $hours              = floor($duration/3600);
        $duration_formated .= sprintf('%02d',$hours). ':';
        $duration           = round($duration-($hours*3600));
    }
    if ( $duration > 60 ) {
        $minutes            = floor($duration/60);
        $duration_formated .= sprintf('%02d', $minutes). ':';
        $duration           = round($duration-($minutes*60));
    } else {
        $duration_formated .= '00:';
    }
        
    return $duration_formated . sprintf('%02d', $duration);
}

function insert_uid_to_username( $options )
{
    global $conn;
    
    $uid        = intval($options['uid']);
    $sql        = "SELECT username FROM signup WHERE UID = " .$uid. " LIMIT 1";
    $rs         = $conn->execute($sql);
    
    return $rs->fields['username'];
}

function insert_rating_small($options)
{
    $rate       = $options['rating'];
    $class_1    = '';
    $class_2    = '';
    $class_3    = '';
    $class_4    = '';
    $class_5    = '';
    if ( $rate > 0.5 ) {
        $class_1 = ' class="half"';
        if ( $rate >= 1 ) {
            $class_1 = ' class="full"';
        }
        
        if ( $rate >= 2 ) {
            $class_2 = ' class="full"';            
        } elseif ( $rate >= 1.5 ) {
            $class_2 = ' class="half"';
        }

        if ( $rate >= 3 ) {
            $class_3 = ' class="full"';            
        } elseif ( $rate >= 2.5 ) {
            $class_3 = ' class="half"';
        }

        if ( $rate >= 4 ) {
            $class_4 = ' class="full"';
        } elseif ( $rate >= 3.5 ) {
            $class_4 = ' class="half"';
        }

        if ( $rate >= 5 ) {
            $class_5 = ' class="full"';            
        } elseif ( $rate >= 4.5 ) {
            $class_5 = ' class="half"';
        }
    }

    $output     = array();
    $output[]   = '<ul class="rating_small">';
    $output[]   = '<li><span' .$class_5. '>&nbsp;</span></li>';
    $output[]   = '<li><span' .$class_4. '>&nbsp;</span></li>';
    $output[]   = '<li><span' .$class_3. '>&nbsp;</span></li>';
    $output[]   = '<li><span' .$class_2. '>&nbsp;</span></li>';
    $output[]   = '<li><span' .$class_1. '>&nbsp;</span></li>';
    $output[]   = '</ul>';
    
    return implode("\n", $output);
}

function insert_rating( $options )
{
    $rate       = $options['rating'];
    $ratedby    = $options['ratedby'];
    $type       = $options['type'];
    $item_id    = $options['item_id'];
    $class_1    = '';
    $class_2    = '';
    $class_3    = '';
    $class_4    = '';
    $class_5    = '';
    
    if ( $rate > 0.5 ) {
        if ( $rate >= 1 ) {
            $class_1 = ' class="full"';
        } elseif ( $rate >= 0.5 ) {
            $class_1 = ' class="half"';
        }
        
        if ( $rate >= 2 ) {
            $class_2 = ' class="full"';
        } elseif ( $rate >= 1.5 ) {
            $class_2 = ' class="half"';
        }

        if ( $rate >= 3 ) {
            $class_3 = ' class="full"';
        } elseif ( $rate >= 2.5 ) {
            $class_3 = ' class="half"';
        }

        if ( $rate >= 4 ) {
            $class_4 = ' class="full"';
        } elseif ( $rate >= 3.5 ) {
            $class_4 = ' class="half"';
        }

        if ( $rate >= 5 ) {
            $class_5 = ' class="full"';
        } elseif ( $rate >= 4.5 ) {
            $class_5 = ' class="half"';
        }
    }
    
    $output     = array();
    $output[]   = '<ul id="rating_container_' .$type. '">';
    $output[]   = '<li><a href="#" title="1 Star" id="star_' .$type. '_1_' .$item_id. '"' .$class_1. '>&nbsp;</a></li>';
    $output[]   = '<li><a href="#" title="2 Stars" id="star_' .$type. '_2_' .$item_id. '"' .$class_2. '>&nbsp;</a></li>';
    $output[]   = '<li><a href="#" title="3 Stars" id="star_' .$type. '_3_' .$item_id. '"' .$class_3. '>&nbsp;</a></li>';
    $output[]   = '<li><a href="#" title="4 Stars" id="star_' .$type. '_4_' .$item_id. '"' .$class_4. '>&nbsp;</a></li>';
    $output[]   = '<li><a href="#" title="5 Stars" id="star_' .$type. '_5_' .$item_id. '"' .$class_5. '>&nbsp;</a></li>';
    $output[]   = '</ul>';  
    
    return implode("\n", $output);
}

function insert_adv( $options )
{
    global $conn, $config;
    
    if ( $config['ads'] == '0' ) {
        return false;
    }
    
    $adv        = NULL;
    $adv_group  = $options['group'];    
    $sql        = "SELECT advgrp_id, advgrp_rotate FROM adv_group
                   WHERE advgrp_name = " .$conn->qStr($adv_group). " AND advgrp_status = '1' LIMIT 1";
    $rs         = $conn->execute($sql);
    if ( $conn->Affected_Rows() == 1 ) {
        $adv_rotate = $rs->fields['advgrp_rotate'];
        $adv_group  = $rs->fields['advgrp_id'];
        if ( $adv_rotate == '1' ) {
            $sql    = "SELECT adv_id, adv_text FROM adv WHERE adv_group = " .intval($adv_group). "
                       AND adv_status = '1' ORDER BY adv_addtime ASC";
        } else {
            $sql    = "SELECT adv_id, adv_text FROM adv WHERE adv_group = " .intval($adv_group). "
                       AND adv_status = '1' LIMIT 1";
        }
        
        $rs     = $conn->execute($sql);
        if ( $conn->Affected_Rows() > 0 ) {
            if ( $adv_rotate == '1' ) {
                $advs       = $rs->getrows();
                $adv_count  = count($advs)-1;
                $random     = rand(0, $adv_count);
                $adv        = $advs[$random]['adv_text'];
                $adv_id     = $advs[$random]['adv_id'];
            } else {
                $adv        = $rs->fields['adv_text'];
                $adv_id     = $rs->fields['adv_id'];
            }
            
            $sql    = "UPDATE adv SET adv_views = adv_views+1 WHERE adv_id = " .$adv_id. " LIMIT 1";
            $conn->execute($sql);
        }
    }
    
    return $adv;
}

function insert_age( $options )
{
    $birth_date = $options['bdate'];
    $birth_expl = explode('-', $birth_date);
    $year       = $birth_expl['0'];
    if ( $year != '0000' ) {
        return date('Y')-$year;
    }
    
    return '';
}

function insert_is_subscribed( $options )
{
    global $conn;

    $uid    = intval($options['UID']);
    $suid   = intval($options['SUID']);    
    $sql    = "SELECT UID FROM video_subscribe WHERE UID = " .$uid. " AND SUID = " .$suid. " LIMIT 1";
    $conn->execute($sql);
    if ( $conn->Affected_Rows() == 1 ) {
        return true;
    }
    
    return false;
}

function insert_is_friend( $options )
{
    global $conn;

    $uid    = intval($options['UID']);
    $fid    = intval($options['FID']);    
    $sql    = "SELECT UID FROM friends WHERE UID = " .$uid. " AND FID = " .$fid. "
               AND status = 'Confirmed' LIMIT 1";
    $conn->execute($sql);
    if ( $conn->Affected_Rows() == 1 ) {
        return true;
    }

    $sql    = "SELECT UID FROM friends WHERE UID = " .$fid. " AND FID = " .$uid. "
               AND status = 'Confirmed' LIMIT 1";
    $conn->execute($sql);
    if ( $conn->Affected_Rows() == 1 ) {
        return true;
    }
    
    return false;
}

function insert_requests_count( $options )
{
    global $conn;
    
    $uid    = intval($options['UID']);
    $sql    = "SELECT COUNT(UID) AS total_requests FROM friends WHERE UID = " .$uid;
    $rs     = $conn->execute($sql);
    
    return $rs->fields['total_requests'];
}

function insert_mails_count( $options )
{
    global $conn;
    
    $username   = $options['username'];
    $sql        = "SELECT COUNT(mail_id) AS total_mails FROM mail
                   WHERE receiver = " .$conn->qStr($username). " AND status = '1' AND readed = '0'";
    $rs     = $conn->execute($sql);
    
    return $rs->fields['total_mails'];
}

function insert_is_blocked( $options )
{
    global $conn;
    
    $uid    = intval($options['UID']);
    $bid    = intval($options['BID']);
    $sql    = "SELECT UID FROM users_blocks WHERE UID = " .$uid. " AND BID = " .$bid. " LIMIT 1";
    $conn->execute($sql);    
    if ( $conn->Affected_Rows() == 1 ) {
        return true;
    }
    
    return false;
}

function insert_user_rating( $options )
{
    $rate       = $options['rating'];
    $ratedby    = $options['ratedby'];
    $user_id    = $options['UID'];
    $class_1    = '';
    $class_2    = '';
    $class_3    = '';
    $class_4    = '';
    $class_5    = '';
    
    if ( $rate > 0.5 ) {
        if ( $rate >= 1 ) {
            $class_1 = ' class="full"';
        } elseif ( $rate >= 0.5 ) {
            $class_1 = ' class="half"';
        }
        
        if ( $rate >= 2 ) {
            $class_2 = ' class="full"';
        } elseif ( $rate >= 1.5 ) {
            $class_2 = ' class="half"';
        }

        if ( $rate >= 3 ) {
            $class_3 = ' class="full"';
        } elseif ( $rate >= 2.5 ) {
            $class_3 = ' class="half"';
        }

        if ( $rate >= 4 ) {
            $class_4 = ' class="full"';
        } elseif ( $rate >= 3.5 ) {
            $class_4 = ' class="half"';
        }

        if ( $rate >= 5 ) {
            $class_5 = ' class="full"';
        } elseif ( $rate >= 4.5 ) {
            $class_5 = ' class="half"';
        }
    }
    
    $output     = array();
    $output[]   = '<ul id="rating_container_user">';
    $output[]   = '<li><a href="#" title="1 Star" id="utar_user_1_' .$user_id. '"' .$class_1. '>&nbsp;</a></li>';
    $output[]   = '<li><a href="#" title="2 Stars" id="utar_user_2_' .$user_id. '"' .$class_2. '>&nbsp;</a></li>';
    $output[]   = '<li><a href="#" title="3 Stars" id="utar_user_3_' .$user_id. '"' .$class_3. '>&nbsp;</a></li>';
    $output[]   = '<li><a href="#" title="4 Stars" id="utar_user_4_' .$user_id. '"' .$class_4. '>&nbsp;</a></li>';
    $output[]   = '<li><a href="#" title="5 Stars" id="utar_user_5_' .$user_id. '"' .$class_5. '>&nbsp;</a></li>';
    $output[]   = '</ul>';  
    
    return implode("\n", $output);
}

function insert_timer( $options )
{
    $timer  = VTimer::get($options['magic']);
    return 'Rendered in ' .$timer['time']. ', using ' .bytes($timer['memory']). ' memory!';
}

function bytes($bytes)
{
    $names  = array('B', 'KB', 'MB', 'GB', 'TB', 'PB');
    $count  = 0;
    while($bytes >= 1024) {
        $bytes = $bytes/1024;
        ++$count;
    }

    return number_format($bytes, ($count ? 2 : 0), ',', '.'). ' ' .$names[$count];
}

function insert_load_plugin( $options )
{
	global $config;

	$page		= $options['page'];
	$plugin		= $options['plugin'];
	
	if ( isset($config['plugin_' .$plugin]) && $config['plugin_' .$plugin] == '1' ) {
		$plugin_file = $config['BASE_DIR']. '/plugins/'. $page. '_' .$plugin. '/' .$plugin. '.php';
		if ( file_exists($plugin_file) ) {
			$plugin_call = 'plugin_' .$page. '_' .$plugin;
			if ( !function_exists($plugin_call) ) {
				require $plugin_file;
			}
			
			$plugin_call();
		}
	}
}

function insert_thumb($options)
{
	global $config;
	
	$vid 	= $options['vid'];
	$thumb	= $options['thumb'];
	$thumbs = ($options['thumbs'] === 0) ? 20 : (int) $options['thumbs'];

	$index = intval( ($vid - 1) / $config['max_thumb_folders'] );
	$tmb_folder = 'tmb';
	if ($index !== 0) {
		$tmb_folder = 'tmb'.$index;
	}	

	$path = $config['BASE_URL'].'/media/videos/'.$tmb_folder.'/'.$vid;
	$path_dir = $config['BASE_DIR'].'/media/videos/'.$tmb_folder.'/'.$vid;
	
	$output = array();
	$output[] = '<div class="row">';	
	for ($i=1; $i<=$thumbs; $i++) {
		$tmb = $path_dir.'/'.$i.'.jpg';
		if (file_exists($tmb) && is_file($tmb)) {
			$class    = ($thumb == $i) ? 'tmb-active img-responsive' : 'tmb img-responsive';
			$output[] = '<div class="col-xs-6 col-sm-3  m-b-10">';
			$output[] = '<img src="'.$path.'/'.$i.'.jpg" id="select_tmb_' .$vid. '_' .$i. '" class="' .$class. '">';
			$output[] = '</div>';
		}
	}
	$output[] = '</div>';	
	return implode("\n", $output);
}

function insert_thumb_path($options)
{
	global $config;
	
	$vid   = $options['vid'];
	$index = intval( ($vid - 1) / $config['max_thumb_folders'] );
	$tmb_folder = 'tmb';
	if ($index !== 0) {
		$tmb_folder = 'tmb'.$index;
	}

	$output = $config['BASE_URL'].'/media/videos/'.$tmb_folder.'/'.$vid;

	return $output;
}

function insert_thumb_adm($options)
{
	global $config;
	
	$vid 	= $options['vid'];
	$thumb	= $options['thumb'];

	$index = intval( ($vid - 1) / $config['max_thumb_folders'] );
	$tmb_folder = 'tmb';
	if ($index !== 0) {
		$tmb_folder = 'tmb'.$index;
	}	

	$path = $config['BASE_URL'].'/media/videos/'.$tmb_folder.'/'.$vid;
	$path_dir = $config['BASE_DIR'].'/media/videos/'.$tmb_folder.'/'.$vid;
	
	$output = array();

	$tmb = $path_dir.'/'.$thumb.'.jpg';
	$tmb_url = $path.'/'.$thumb.'.jpg';
	$tmb_url_def = $config['BASE_URL'].'/media/videos/tmb/default.jpg';
	if (file_exists($tmb) && is_file($tmb)) {
		return $tmb_url;	
	} else {
		return $tmb_url_def;
	}
}

?>
