<?php
defined('_VALID') or die('Restricted Access!');

if ( $config['game_module'] == '0' ) {
    die();
}

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/compat/json.php';
require $config['BASE_DIR']. '/include/dbconn.php';

function construct_vote( $likes, $dislikes )
{
	$output     = array();
    $output[]   = '<div class="pull-left">';
    $output[]   = '<i class="glyphicon glyphicon-thumbs-up"></i> <span id="game_likes" class="text-white">' .$likes. '</span>';
    $output[]   = '</div>';
    $output[]   = '<div class="pull-right">';
    $output[]   = '<i class="glyphicon glyphicon-thumbs-down"></i> <span id="game_dislikes" class="text-white">' .$dislikes. '</span>';
    $output[]   = '</div>';
    $output[]   = '<div class="clearfix"></div>';
    
    return implode("\n", $output);
}

$data           = array('msg' => '', 'rate' => 0, 'likes' => 0, 'dislikes' => 0, 'debug' => '');
if ( isset($_POST['item_id']) && isset($_POST['vote']) ) {
    $allowed        = false;
    $filter         = new VFilter();
    $game_id        = $filter->get('item_id', 'INTEGER');
    $vote           = $filter->get('vote', 'STRING');
    
    $sql            = "SELECT rate, likes, dislikes FROM game WHERE GID = " .$game_id. " LIMIT 1";
	
    $rs             = $conn->execute($sql);
    $rate           = $rs->fields['rate'];
    $likes          = $rs->fields['likes'];
    $dislikes       = $rs->fields['dislikes'];

    
    if ( $config['game_rate'] == 'user' ) {
        if ( isset($_SESSION['uid']) ) {
            $uid        = intval($_SESSION['uid']);
            $allowed    = true;
        }
    } else {
        $allowed        = true;
    }

    if ( $allowed ) {
        if ( $config['game_rate'] == 'user' ) {
            $sql    = "SELECT GID FROM game_rating_id WHERE GID = " .$game_id. " AND UID = " .$uid. " LIMIT 1";
            $data['debug'] = $sql;
        } else {
            $sql    = "SELECT GID FROM game_rating_ip WHERE GID = " .$game_id. " AND ip = " .ip2long($_SERVER['REMOTE_ADDR']). " LIMIT 1";
            $data['debug'] = $sql;
        }
        
        $conn->execute($sql);
        if ( $conn->Affected_Rows() == 1 ) {
            $data['msg']    = $lang['ajax.rate_already'];
        } else {

			if ($vote == 'like') {
				$likes++;
				$rate = round(($likes * 100)/($likes + $dislikes));
			}
			else {
				$dislikes++;
				$rate = round(($likes * 100)/($likes + $dislikes));
			}
				
            $sql            = "UPDATE game SET rate = " .$rate. ", likes = " .$likes. ", dislikes = " .$dislikes. " WHERE GID = " .$game_id. " LIMIT 1";
			
            $data['debug'] = $sql;
            $conn->execute($sql);
			
            if ( $config['game_rate'] == 'user' ) {
                $sql    = "INSERT INTO game_rating_id SET GID = " .$game_id. ", UID = " .$uid;
            } else {
                $sql    = "INSERT INTO game_rating_ip SET GID = " .$game_id. ", ip = " .ip2long($_SERVER['REMOTE_ADDR']);
            }
            $conn->execute($sql);
        }
    
    } else {
        $data['msg']            = '<a data-toggle="modal" href="#login-modal">'.$lang['ajax.rate_login'].'</a>';
    }

    $data['rate']        = $rate;
    $data['likes']       = $likes;
	$data['dislikes']    = $dislikes;	
	$data['construct']   = construct_vote($likes, $dislikes);
}

echo json_encode($data);
die();
?>
