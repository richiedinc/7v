<?php
defined('_VALID') or die('Restricted Access!');

Auth::checkAdmin();

require $config['BASE_DIR']. '/classes/pagination.class.php';

$game_dir           = $config['BASE_DIR']. '/media/games/swf';
$game_tmb_dir       = $config['BASE_DIR']. '/media/games/tmb';
$game_tmb_orig_dir  = $config['BASE_DIR']. '/media/games/tmb/orig';

if ( !file_exists($game_dir) or !is_dir($game_dir) or !is_writable($game_dir) ) {
    $errors[] = 'Games directory ' .$game_dir. ' does not exist or not writable!';
}
if ( !file_exists($game_tmb_dir) or !is_dir($game_tmb_dir) or !is_writable($game_tmb_dir) ) {
    $errrors[] = 'Game thumb directory ' .$game_tmb_dir. ' does not exist or not writable!';
}
if ( !file_exists($game_tmb_orig_dir) or !is_dir($game_tmb_orig_dir) or !is_writable($game_tmb_orig_dir) ) {
    $errors[] = 'Game thumb original directory ' .$game_tmb_orig_dir. ' does not exist or not writable!';
}

if (isset($_POST['delete_selected_games'])) {
    $index = 0;
    foreach ( $_POST as $key => $value ) {
        if ( $key != 'check_all_games' && substr($key, 0, 17) == 'game_id_checkbox_') {
            if ( $value == 'on' ) {
                deleteGame(str_replace('game_id_checkbox_', '', $key));
                ++$index;
            }
        }
    }
    
    if ( $index === 0 ) {
        $errors[]   = 'Please select games to be deleted!';
    } else {
        $messages[] = 'Successfully deleted ' .$index. ' (selected) games!';
    }
}

if (isset($_POST['suspend_selected_games']) || isset($_POST['approve_selected_games']) ) {
    $act        = 1;
    $act_name   = 'activated';
    $index      = 0;
    if ( isset($_POST['suspend_selected_games']) ) {
        $act        = 0;
        $act_name   = 'suspended';
    }

    foreach ( $_POST as $key => $value ) {
        if ( $key != 'check_all_games' && substr($key, 0, 17) == 'game_id_checkbox_') {
            if ( $value == 'on' ) {
                $gid = intval(str_replace('game_id_checkbox_', '', $key));
                $sql = "UPDATE game SET status = '" .$act. "' WHERE GID = " .$gid. " LIMIT 1";
                $conn->execute($sql);
				if ($act_name == 'activated') {
					send_game_approve_email($gid);
				}
                ++$index;
            }
        }
    }
    
    if ( $index === 0 ) {
        $errors[]   = 'Please select games to be ' .$act_name. '!';
    } else {    
        $messages[] = 'Successfully ' .$act_name. ' ' .$index. ' (selected) games!';
    }
}

$remove = NULL;
$page   = (isset($_GET['page'])) ? intval($_GET['page']) : 1;

$query          = constructQuery($module_keep);
$sql            = $query['count'];
$rs             = $conn->execute($sql);
$total_games    = $rs->fields['total_games'];
$pagination     = new Pagination($query['page_items']);
$limit          = $pagination->getLimit($total_games);
$paging         = $pagination->getAdminPagination($remove);
$sql            = $query['select']. " LIMIT " .$limit;
$rs             = $conn->execute($sql);
$games          = $rs->getrows();

function constructQuery($module)
{
    global $smarty, $conn;

    $query_module = '';

    $query              = array();
    $query_select       = "SELECT g.*,s.username FROM game AS g, signup AS s WHERE g.UID = s.UID" .$query_module;
    $query_count        = "SELECT count(g.GID) AS total_games FROM game AS g WHERE g.GID != ''" .$query_module;
    $query_add          = ( $query_module != '' ) ? " AND" : " WHERE";
    $query_option       = array();
    $option_orig             = array('username' => '', 'title' => '', 'keyword' => '', 'category' => '', 'status' => '',
                                'sort' => 'g.GID', 'order' => 'DESC', 'display' => 100);

	$all   = (isset($_GET['all'])) ? intval($_GET['all']) : 0;
	if ($all == 1) {
		unset ($_SESSION['search_games_option']);
	}
	
	$option             = ( isset($_SESSION['search_games_option']) ) ? $_SESSION['search_games_option'] : $option_orig;

	if ( isset($_GET['UID'] ) ) {
		unset ($_SESSION['search_games_option']);
		$UID = ( isset($_GET['UID']) && is_numeric($_GET['UID']) ) ? $_GET['UID'] : 0;
		$query_option[] = " AND g.UID = " .$conn->qStr($UID). "";
	}

	if ( isset($_GET['CID']) && is_numeric($_GET['CID']) && channelExists($_GET['CID'], 'game') ) {
		unset ($_SESSION['search_games_option']);
		$CID = $_GET['CID'];
		$query_option[] = " AND g.category = " .intval($CID);
		$option['category'] = $CID;
	}
	
	if ( isset($_GET['status'] ) ) {
		unset ($_SESSION['search_games_option']);
		$status = ( isset($_GET['status']) && is_numeric($_GET['status']) ) ? $_GET['status'] : 0;
		$query_option[] = " AND g.status = '" .$status. "'";
		$option['status'] = $status;
	}	
								
    if ( isset($_POST['search_games']) ) {
		$option['username']     = trim($_POST['username']);
        $option['title']        = trim($_POST['title']);
        $option['keyword']      = trim($_POST['keyword']);
        $option['category']     = intval(trim($_POST['category']));
        $option['status']       = trim($_POST['status']);
        $option['type']         = trim($_POST['type']);				
        $option['sort']         = trim($_POST['sort']);
        $option['order']        = trim($_POST['order']);
		$option['display']      = trim($_POST['display']);
    
		if ( $option['username'] != '' || isset($_GET['UID']) ) {
			if ( $option['username'] != '' ) {
				$UID            = getUserID($option['username']);
			} else {
				$UID            = ( isset($_GET['UID']) && is_numeric($_GET['UID']) ) ? $_GET['UID'] : 0;
			}
			$UID            = ( $UID ) ? $UID : 0;
			$query_option[] = " AND g.UID = " .$conn->qStr($UID). "";
		}

		if ( $option['title'] != '' ) {
			$query_option[] = " AND g.title LIKE '%" .trim($conn->qStr($option['title']), "'"). "%'";
		}

		if ( $option['keyword'] != '' ) {
			$query_option[] = " AND g.tags LIKE '%" .trim($conn->qStr($option['keyword']), "'"). "%'";
		}

		if ( $option['category'] != '' ) {
			$query_option[] = " AND g.category = " .intval($option['category']);
		}
		
		if ( $option['type'] != '' ) {
			$query_option[] = " AND g.type = " .$conn->qStr($option['type']). "";
		}		
		
		if ( $option['status'] == '0' || $option['status'] == '1' ) {
			$query_option[] = " AND g.status = '" .intval($option['status']). "'";
		}
		
		$_SESSION['search_games_option'] = $option;
		
	} elseif (isset($_SESSION['search_games_option'])) {
	
		$option = $_SESSION['search_games_option'];
	
		if ( $option['username'] != '' || isset($_GET['UID']) ) {
			if ( $option['username'] != '' ) {
				$UID            = getUserID($option['username']);
			} else {
				$UID            = ( isset($_GET['UID']) && is_numeric($_GET['UID']) ) ? $_GET['UID'] : 0;
			}
			$UID            = ( $UID ) ? $UID : 0;
			$query_option[] = " AND g.UID = " .$conn->qStr($UID). "";
		}

		if ( $option['title'] != '' ) {
			$query_option[] = " AND g.title LIKE '%" .trim($conn->qStr($option['title']), "'"). "%'";
		}

		if ( $option['keyword'] != '' ) {
			$query_option[] = " AND g.tags LIKE '%" .trim($conn->qStr($option['keyword']), "'"). "%'";
		}

		if ( $option['category'] != '' ) {
			$query_option[] = " AND g.category = " .intval($option['category']);
		}
		
		if ( $option['status'] == '0' || $option['status'] == '1' ) {
			$query_option[] = " AND g.status = '" .intval($option['status']). "'";
		}	
	
	}
	
    $query_option[]         = " ORDER BY " .$option['sort']. " " .$option['order'];    
    $query['select']        = $query_select .implode(' ', $query_option);
    $query['count']         = $query_count .implode(' ', $query_option);
    $query['page_items']    = $option['display'];
    
    $smarty->assign('option', $option);
    
    return $query;
}

function getUserID( $username )
{
    global $conn;
    
    $sql = "SELECT UID FROM signup WHERE username = " .$conn->qStr($username). " LIMIT 1";
    $rs  = $conn->execute($sql);
    if ( $conn->Affected_Rows() == 1 )
        return $rs->fields['UID'];
    
    return false;
}

$smarty->assign('games', $games);
$smarty->assign('total_games', $total_games);
$smarty->assign('paging', $paging);
$smarty->assign('page', $page);
$smarty->assign('categories', get_games_categories());
?>
