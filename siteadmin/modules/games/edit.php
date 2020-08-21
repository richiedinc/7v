<?php
defined('_VALID') or die('Restricted Access!');

Auth::checkAdmin();

$game  = array();
$GID    = ( isset($_GET['GID']) && is_numeric($_GET['GID']) ) ? intval(trim($_GET['GID'])) : NULL;
if ( !$GID ) {
    $errors[] = 'Invalid video ID. This video does not exist!';
}

if ( !$errors ) {
    if ( isset($_POST['edit_game']) ) {
        $title              = trim($_POST['title']);
        $tags               = trim($_POST['tags']);
        $category           = intval(trim($_POST['category']));
        $type               = trim($_POST['type']);
        $be_commented       = trim($_POST['be_commented']);
        $be_rated           = trim($_POST['be_rated']);
        $rate               = floatval(trim($_POST['rate']));
        $ratedby            = intval(trim($_POST['ratedby']));
        $total_plays        = intval(trim($_POST['total_plays']));
        $total_comments     = intval(trim($_POST['total_comments']));
        $total_favorites    = intval(trim($_POST['total_favorites']));
        $status             = intval(trim($_POST['status']));
        
        if ( strlen($title) < 3 )
            $errors[] = 'Game title field cannot be blank!';
        elseif ( strlen($tags) < 3 )
            $errors[] = 'Game keyword(tags) field cannot be blank!';
        elseif ( $category === 0 )
            $errors[] = 'Select at least one category and no more then 3!';
        
        if ( !$errors ) {
            if ( $_FILES['thumb']['tmp_name'] != '' && is_uploaded_file($_FILES['thumb']['tmp_name']) ) {
                require $config['BASE_DIR']. '/classes/image.class.php';
                $src    = $_FILES['thumb']['tmp_name'];
                $dst    = $config['BASE_DIR']. '/media/games/tmb/' .$GID. '.jpg';
                $image  = new VImageConv();
                $image->process($src, $dst, 'MAX_WIDTH', 256, 144);
                $image->canvas(256, 144, '000000', true);                
            }
        
            $sql = "UPDATE game SET title = " .$conn->qStr($title). ", tags = " .$conn->qStr($tags). ",
                                    category = '" .$category. "', type = " .$conn->qStr($type). ",
                                    be_commented = " .$conn->qStr($be_commented). ",
                                    be_rated = " .$conn->qStr($be_rated). ", rate = " .$conn->qStr($rate). ",
                                    ratedby = " .$conn->qStr($ratedby). ", total_plays = " .$conn->qStr($total_plays). ",
                                    total_comments = " .$conn->qStr($total_comments). ", total_favorites = " .$conn->qStr($total_favorites). ",
                                    status = " .$conn->qStr($status). " WHERE GID = " .$conn->qStr($GID). " LIMIT 1";
            $conn->execute($sql);
            $messages[] = 'Game information updated successfuly!';
        }
    }

    $sql    = "SELECT * FROM game WHERE GID = '" .$GID. "' LIMIT 1";
    $rs     = $conn->execute($sql);
    if ( $conn->Affected_Rows() == 1 ) {
        $game = $rs->getrows();
    } else {
        $errors[]    = 'Invalid Game ID. This game does not exist!';
    }
}

$sql = "SELECT * FROM game_categories";
$rs  = $conn->execute($sql);

$smarty->assign('game', $game);
$smarty->assign('categories', $rs->getrows());
?>
