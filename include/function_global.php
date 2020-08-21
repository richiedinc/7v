<?php
defined('_VALID') or die('Restricted Access!');

function get_request()
{
    $request = ( isset($_SERVER['REQUEST_URI']) ) ? $_SERVER['REQUEST_URI'] : NULL;
    $request = ( isset($_SERVER['QUERY_STRING']) ) ? str_replace('?' .$_SERVER['QUERY_STRING'], '', $request) : $request;
	$request = urldecode($request);
    return ( isset($request) ) ? explode('/', $request) : array();
}

function get_request_arg($search, $type = 'INT')
{
    $arg    = NULL;
    $query  = get_request();
    foreach ($query as $key => $value) {
        if ( $value == $search ) {
            if ( isset($query[$key+1]) ) {
                $arg = $query[$key+1];
            }
        }
    }

    return ( $type == 'INT' ) ? intval($arg) : $arg;
}

function get_categories()
{
    global $conn;
    
    $sql        = "SELECT CHID, name, slug FROM channel ORDER BY name ASC";
    $rs         = $conn->execute($sql);
    $categories = $rs->getrows();
    
    return $categories;
}

function get_albums_categories()
{
    global $conn;
    
    $sql        = "SELECT CID, name, slug FROM album_categories ORDER BY name ASC";
    $rs         = $conn->execute($sql);
    $categories = $rs->getrows();
    
    return $categories;
}

function get_games_categories()
{
    global $conn;
    
    $sql        = "SELECT category_id, category_name, slug FROM game_categories ORDER BY category_name ASC";
    $rs         = $conn->execute($sql);
    $categories = $rs->getrows();
    
    return $categories;
}

function get_popular_tags()
{
    global $conn;
    
    $tags       = array();
    $sql        = "SELECT keyword FROM video ORDER BY viewnumber LIMIT 10";
    $rs         = $conn->execute($sql);
    $rows       = $rs->getrows();
    foreach ( $rows as $row ) {
        $tag_arr = explode(' ', $row['keyword']);
        foreach ( $tag_arr as $tag ) {
            if ( strlen($tag) > 3 && !in_array($tag, $tags) ) {
                $tags[] = $tag;
            }
        }
    }    
}


function prepare_string( $string, $url=true )
{
	if (preg_match('/^.$/u', 'ñ')) {
  		$string = preg_replace('/[^\pL\pN\pZ]/u', ' ', $string);
  		$string = preg_replace('/\s\s+/', ' ', $string);
	} else {
		$string = preg_replace('/[^ 0-9a-zA-Z]/', ' ', $string);
  		$string = preg_replace('/\s\s+/', ' ', $string);
	}
    $string = trim($string);
    if ( $url === true ) {
        $string = str_replace(' ', '-', $string);
        $string = mb_strtolower($string);
    }
    
    return $string;
}

function check_string($string)
{
	if (preg_match('/^.$/u', 'ñ')) {
		return (bool) preg_match('/^[-\pL\pN_]++$/uD', $string);
	} else {
		return (bool) preg_match('/^[a-zA-Z0-9_\-\s]+$/', $string);
	}
}

function truncate( $string, $length=80)
{
    if ( $length == 0 ) {
        return '';
    }

    if (mb_strlen($string) > $length) {
        $etc     = ' ...';
        $length -= min($length, mb_strlen($etc));
        return mb_substr($string, 0, $length) . $etc;
    } else {
        return $string;
    }
}   

function duration( $duration)
{
    $duration_formated  = NULL;
    $duration           = round($duration);
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

function time_range( $time )
{
    $range          = NULL;
    $current_time   = time();
    $interval       = $current_time-$time;
    if ( $interval > 0 ) {
        $day    = $interval/(60*60*24);
        if ( $day >= 1 ) {
            $range      = floor($day). ' days';
            $interval   = $interval-(60*60*24*floor($day));
        }
        if( $interval > 0 && $range == '' ) {
            $hour       = $interval/(60*60);
            if ( $hour >=1 ) {
                $range      = floor($hour). ' hours';
                $interval   = $interval-(60*60*floor($hour));
            }
        }
        if ( $interval > 0 && $range == '' ) {
            $min        = $interval/(60);
            if ( $min >= 1 ) {
                $range=floor($min). ' minutes';
                $interval=$interval-(60*floor($min));
            }
        }
        if ( $interval > 0 && $range == '' ) {
            $scn        = $interval;
            if ( $scn >= 1 ) {
                $range  = $scn. ' seconds';
            }
        }
        return ( $range != '' ) ? $range. ' ago' : 'just now';
    }
}

function video_rating_small( $rate )
{
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

function translate($args)
{
	global $lang;
    if (!is_array($args)) {
        $args = func_get_args();
    }

    $code           = $args['0'];
    $translation	= FALSE;
    if (isset($lang[$code])) {
        $translation = $lang[$code];
    }

    if (isset($args['1']) && $translation) {
        $args   = array_slice($args, 1);
        return vsprintf($translation, $args);
    } else {
        return $translation;
    }

    return '';
}

function private_photo($type='video') {
	global $config;
	if (strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE 6') === FALSE) {
        return 'private-'.$type.'.png';
    } else {
        return 'private-'.$type.'.gif';
    }
}

function check_image($path, $ext)
{
	$check = FALSE;
    if ($ext == 'gif') {
        $check = imagecreatefromgif($path);
    } elseif ($ext == 'png') {
        $check = imagecreatefrompng($path);
    } elseif ($ext == 'jpeg' OR $ext = 'jpg') {
        $check = imagecreatefromjpeg($path);
    }

	if ($ext == 'gif' && $check) {
  		$contents = file_get_contents($path);
  		if (strpos($contents, 'php') !== FALSE) {
      		$check = FALSE;
  		}
	}

    return ($check) ? TRUE : FALSE;
}

function show_err ($exp)
{
	return '<div class="alert alert-dismissable alert-danger m-t-15 m-b-0"><button type="button" class="close" data-dismiss="alert">×</button>'.$exp.'</div>';
}

function show_msg ($exp)
{
	return '<div class="alert alert-dismissable alert-success m-t-15 m-b-0"><button type="button" class="close" data-dismiss="alert">×</button>'.$exp.'</div>';
}

function show_err_mb ($exp)
{
	return '<div class="alert alert-dismissable alert-danger m-b-15 m-b-0"><button type="button" class="close" data-dismiss="alert">×</button>'.$exp.'</div>';
}

function show_msg_mb ($exp)
{
	return '<div class="alert alert-dismissable alert-success m-b-15 m-b-0"><button type="button" class="close" data-dismiss="alert">×</button>'.$exp.'</div>';
}

function blog_output($content) 
{
	global $config;
	$search     = array('/\[b\](.*?)\[\/b\]/ms', '/\[i\](.*?)\[\/i\]/ms', '/\[u\](.*?)\[\/u\]/ms',
						'/\[img\](.*?)\[\/img\]/ms', '/\[email\](.*?)\[\/email\]/ms', '/\[url\="?(.*?)"?\](.*?)\[\/url\]/ms',
						'/\[size\="?(.*?)"?\](.*?)\[\/size\]/ms', '/\[color\="?(.*?)"?\](.*?)\[\/color\]/ms', '/\[quote](.*?)\[\/quote\]/ms',
						'/\[list\=(.*?)\](.*?)\[\/list\]/ms', '/\[list\](.*?)\[\/list\]/ms', '/\[\*\]\s?(.*?)\n/ms');
	$replace    = array('<strong>\1</strong>', '<em>\1</em>', '<u>\1</u>', '<img src="\1" alt="\1" />',
						'<a href="mailto:\1">\1</a>', '<a href="\1">\2</a>', '<span style="font-size:\1%">\2</span>',
						'<span style="color:\1">\2</span>', '<blockquote>\1</blockquote>', '<ol start="\1">\2</ol>',
						'<ul>\1</ul>', '<li>\1</li>');
	$content    = preg_replace($search, $replace, $content);
	$content    = preg_replace('/\[photo=(.*?)\]/ms', '<div class="row"><div class="col-md-8 col-md-offset-2"><center><img src="' .$config['BASE_URL']. '/media/photos/\1.jpg" alt="" class="blog_image" /></center></div></div>', $content);
	$content    = preg_replace('/\[video=(.*?)\]/ms', '<div class="row"><div class="col-md-8 col-md-offset-2"><div class="blog_video"><div id="blog_video_\1"><iframe src="' .$config['BASE_URL'].'/view.php?VID=\1" frameborder="0" allowfullscreen></iframe></div></div></div></div>', $content);
	$content    = str_replace("\r", "", $content);
	$content    = "<p>".preg_replace("/(\n)/", "</p><p>", $content)."</p>";
	
	return $content;
}

?>
