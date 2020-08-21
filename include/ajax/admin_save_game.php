<?php
defined('_VALID') or die('Restricted Access!');

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/compat/json.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/dbconn.php';
require $config['BASE_DIR']. '/classes/auth.class.php';
Auth::checkAdmin();

$response = array('status' => 0);

$data = (array) $_POST['data'];

$gid            = trim($data['id']);
$title          = trim($data['title']);
$tags           = trim($data['tags']);
$category       = trim($data['category']);
$type           = trim($data['type']);
$be_commented   = trim($data['be_commented']);
$be_rated       = trim($data['be_rated']);
$embed          = trim($data['embed']);      
$likes          = trim($data['likes']);
$dislikes       = trim($data['dislikes']);
$viewnumber     = trim($data['viewnumber']);
$active         = trim($data['active']);

settype($gid, 'integer');
settype($viewnumber, 'integer');
settype($likes, 'integer');
settype($dislikes, 'integer');
settype($category, 'integer');
if ( $likes != 0 || $dislikes !=0)
	$rate = round(($likes * 100)/($likes + $dislikes));
else
	$rate = 0;

$sql = "UPDATE game SET title = " .$conn->qStr($title). ", 
						tags = " .$conn->qStr($tags). ", category = " .$category. ", type = " .$conn->qStr($type). ",
						be_commented = " .$conn->qStr($be_commented). ",
						be_rated = " .$conn->qStr($be_rated). ", 
						likes = " .$conn->qStr($likes). ", dislikes = " .$conn->qStr($dislikes). ", 
						rate = " .$conn->qStr($rate). ", total_plays = " .$conn->qStr($viewnumber). ",
						status  = " .$conn->qStr($active). " 
		WHERE GID = " .$conn->qStr($gid). " LIMIT 1";
$conn->execute($sql);
$response['status'] = 1;

echo json_encode($response);
die();
?>
