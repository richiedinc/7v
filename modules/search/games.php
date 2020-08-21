<?php
defined('_VALID') or die('Restricted Access!');

if ( $config['game_module'] == '0' ) {
    VRedirect::go($config['BASE_URL']. '/notfound/page_invalid');
}

$slug = get_request_arg('games', 'STRING');
if ($slug != '') {
	$sql            = "SELECT category_id FROM game_categories WHERE slug = '".$slug."' LIMIT 1";
	$rs             = $conn->execute($sql);
	if ($conn->Affected_Rows()) {
		$cat_id         = $rs->fields['category_id'];
	}
} else {
	$cat_id = NULL;
}

if ($cat_id) {
	$category  = $cat_id;
} else {
	$category       = ( isset($_GET['c']) ) ? intval($_GET['c']) : 0;
}

$type           = ( isset($_GET['type']) && ($_GET['type'] == 'private' or $_GET['type'] == 'public') ) ? $_GET['type'] : NULL;
$sql            = "SELECT category_id, category_name, slug FROM game_categories WHERE status = '1' ORDER BY category_name ASC";
$rs		= $conn->execute($sql);
$categories     = $rs->getrows();
$orders         = array('bp', 'mr', 'mp', 'tr', 'md', 'tf');
$order          = ( isset($_GET['o']) && in_array($_GET['o'], $orders) ) ? $_GET['o'] : 'mr';
$timeframes     = array('t', 'w', 'm', 'a');
$timeframe      = ( isset($_GET['t']) && in_array($_GET['t'], $timeframes) ) ? $_GET['t'] : 'a';

$sql_add        = NULL;
$sql_add_count  = NULL;
$sql_delim      = ' WHERE ';
$title_t        = NULL;
$title_c        = NULL;
$title_o        = NULL;
$title_p        = NULL;

if ( $type != '' ) {
    $title_p        = ucfirst($type);
    $sql_add        = $sql_delim. " type = '" .$type. "'";
    $sql_add_count  = $sql_delim. " type = '" .$type. "'";
    $sql_delim      = ' AND';
}

switch ( $timeframe ) {
    case 't':
        $title_t         = 'Todays';
        $sql_add        .= $sql_delim. " DATE_FORMAT(adddate, '%y-%m-%d') = DATE_FORMAT(NOW(), '%y-%m-%d')";
        $sql_add_count  .= $sql_delim. " DATE_FORMAT(adddate, '%y-%m-%d') = DATE_FORMAT(NOW(), '%y-%m-%d')";
        $sql_delim       = ' AND';
        break;
    case 'w':
        $title_t         = 'This Weeks';
        $sql_add        .= $sql_delim. " DATE_FORMAT(adddate, '%y-%u') = DATE_FORMAT(NOW(), '%y-%u')";
        $sql_add_count  .= $sql_delim. " DATE_FORMAT(adddate, '%y-%u') = DATE_FORMAT(NOW(), '%y-%u')";
        $sql_delim       = ' AND';
        break;
    case 'm':
        $title_t         = 'This Months';
        $sql_add        .= $sql_delim. " DATE_FORMAT(adddate, '%m') = DATE_FORMAT(NOW(), '%m')";
        $sql_add_count  .= $sql_delim. " DATE_FORMAT(adddate, '%m') = DATE_FORMAT(NOW(), '%m')";
        $sql_delim       = ' AND';
        break;
}

if ( $category ) {
    $sql_add        .= $sql_delim. " category = " .$category;
    $sql_add_count  .= $sql_delim. " category = " .$category;
    $sql_delim       = ' AND';
    foreach ( $categories as $gcategory ) {
        if ( $gcategory['category_id'] == $category ) {
            $title_c = ' ' .$gcategory['category_name'];
            break;
        }
    }
}

$sql_add       .= $sql_delim. " status = '1'";
$sql_add_count .= $sql_delim. " status = '1'";

if ( $search_query ) {
    $sql_add        .= " AND ( title LIKE '%" .trim($conn->qStr($search_query), "'"). "%' OR tags LIKE '%" .trim($conn->qStr($search_query), "'"). "%' )";
    $sql_add_count  .= " AND ( title LIKE '%" .trim($conn->qStr($search_query), "'"). "%' OR tags LIKE '%" .trim($conn->qStr($search_query), "'"). "%' )";
}

switch ( $order ) {
    case 'bp':
        $title_o  = ' Being Played';
        $sql_add .= ' ORDER BY playtime DESC';
        break;
    case 'mr':
        $title_o  = ' Most Recent';
        $sql_add .= ' ORDER BY playtime DESC';
        break;
    case 'mp':
        $title_o  = ' Most Played';
        $sql_add .= ' ORDER BY total_plays DESC';
        break;
    case 'tr':
        $title_o  = ' Top Rated';
        $sql_add .= ' ORDER BY rate DESC';
        break;
    case 'md':
        $title_o  = ' Most Commented';
        $sql_add .= ' ORDER BY total_comments DESC';
        break;
    case 'tf':
        $title_o  = ' Top Favorites';
        $sql_add .= ' ORDER BY total_favorites DESC';
        break;
}

$sql            = "SELECT count(GID) AS total_games FROM game" .$sql_add_count;
$rsc            = $conn->execute($sql);
$total          = $rsc->fields['total_games'];
$pagination     = new Pagination($config['games_per_page']);
$limit          = $pagination->getLimit($total);
$sql            = "SELECT * FROM game" .$sql_add. " LIMIT " .$limit;
$rs             = $conn->execute($sql);
$games          = $rs->getrows();

if ($slug) {
	$page_link      = $pagination->getPagination('search/games/'.$slug);	
	$smarty->assign('base', 'search/games/'.$slug);
} else {
	$page_link      = $pagination->getPagination('search/games');
	$smarty->assign('base', 'search/games');
}

$start_num      = $pagination->getStartItem();
$end_num        = $pagination->getEndItem();

$title              = $title_t . $title_o . $title_c . $title_p;
$self_title         = $title. ' Games - ' .$config['site_name'];
$self_description   = $title. ' Games - ' .$config['meta_description'];
$self_keywords      = $title. ' Games, ' .$config['meta_keywords'];

$smarty->assign('categories', $categories);
$smarty->assign('category', $category);
$smarty->assign('timeframe', $timeframe);
$smarty->assign('type', $type);
$smarty->assign('order', $order);
$smarty->assign('games', $games);
$smarty->assign('games_total', $total);
$smarty->assign('start_num', $start_num);
$smarty->assign('end_num', $end_num);
$smarty->assign('page_link', $page_link);
?>
