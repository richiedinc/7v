<?php
defined('_VALID') or die('Restricted Access!');

Auth::checkAdmin();

require $config['BASE_DIR']. '/include/config.template.php';
if ( isset($_POST['submit_settings']) ) {
    $filter                 = new VFilter();
    $site_name              = $filter->get('site_name');
    $site_title             = $filter->get('site_title');
    $meta_description       = $filter->get('meta_description');
    $meta_keywords          = $filter->get('meta_keywords');
    $ads                    = $filter->get('ads', 'INTEGER');
    $approve                = $filter->get('approve', 'INTEGER');
    $approve_photos         = $filter->get('approve_photos', 'INTEGER');
    $approve_games          = $filter->get('approve_games', 'INTEGER');
    $approve_blogs          = $filter->get('approve_blogs', 'INTEGER');
    $downloads              = $filter->get('downloads', 'INTEGER');
    $videos_per_page        = $filter->get('videos_per_page', 'INTEGER');
    $albums_per_page        = $filter->get('albums_per_page', 'INTEGER');
    $users_per_page         = $filter->get('users_per_page', 'INTEGER');
    $blogs_per_page         = $filter->get('blogs_per_page', 'INTEGER');
    $watched_per_page       = $filter->get('watched_per_page', 'INTEGER');
    $recent_per_page        = $filter->get('recent_per_page', 'INTEGER');
    $games_per_page         = $filter->get('games_per_page', 'INTEGER');
    $del_original_video     = $filter->get('del_original_video', 'INTEGER');
	$splash					= $filter->get('splash', 'INTEGER');
	$language				= $filter->get('language');
	$multi_language			= $filter->get('multi_language', 'INTEGER');
	$multi_server			= $filter->get('multi_server', 'INTEGER');
    $template				= $filter->get('template');
	
    if ( $site_name == '' ) {
        $errors[]   = 'Site Name field cannot be blank!';
		$err['site_name'] = 1;
    }
    
    if ( $site_title == '' ) {
        $errors[]   = 'Site Title field cannot be blank!';
		$err['site_title'] = 1;
    }
    
    if ( $meta_description == '' ) {
        $errors[]   = 'Meta Description field cannot be blank!';
		$err['meta_description'] = 1;
    }
    
    if ( $meta_keywords == '' ) {
        $errors[]   = 'Meta Keywords field cannot be blank!';
		$err['meta_keywords'] = 1;
    }
    
    if ( $approve != '1' && $approve != '0' ) {
        $errors[]   = 'Video approve field can only be Enabled/Disabled!';
    }

    if ( $downloads != '1' && $downloads != '0' ) {
        $errors[]   = 'Video downloads field can only be Enabled/Disabled!';
    }
    
    if ( $videos_per_page == '' || $videos_per_page == '0' ) {
        $errors[]   = 'Video Per Page field must be a numeric value!';
		$err['videos_per_page'] = 1;
    }

    if ( $albums_per_page == '' || $albums_per_page == '0' ) {
        $errors[]   = 'Albums Per Page field must be a numeric value!';
		$err['albums_per_page'] = 1;
    }

    if ( $games_per_page == '' || $games_per_page == '0' ) {
        $errors[]   = 'Games Per Page field must be a numeric value!';
		$err['games_per_page'] = 1;
    }	
	
    if ( $users_per_page == '' || $users_per_page == '0' ) {
        $errors[]   = 'Users Per Page field must be a numeric value!';
		$err['users_per_page'] = 1;
    }

    if ( $blogs_per_page == '' || $blogs_per_page == '0' ) {
        $errors[]   = 'Blogs Per Page field must be a numeric value!';
		$err['blogs_per_page'] = 1;
    }

    if ( $watched_per_page == '' || $watched_per_page == '0' ) {
        $errors[]   = 'Watched Per Page field must be a numeric value!';
		$err['watched_per_page'] = 1;
    }

    if ( $recent_per_page == '' || $recent_per_page == '0' ) {
        $errors[]   = 'Recent Per Page field must be a numeric value!';
		$err['recent_per_page'] = 1;
    }
    
    if ( $del_original_video != '1' && $del_original_video != '0' ) {
        $errors[]   = 'Del original video field can only be Enabled/Disabled!';
    }
	
    if ( !$errors ) {
        $config['site_name']            = $site_name;
        $config['site_title']           = $site_title;
        $config['meta_description']     = $meta_description;
        $config['meta_keywords']        = $meta_keywords;
        $config['ads']                  = $ads;
        $config['approve']              = $approve;
        $config['approve_photos']       = $approve_photos;
        $config['approve_games']        = $approve_games;
        $config['approve_blogs']        = $approve_blogs;
        $config['downloads']            = $downloads;
        $config['videos_per_page']      = $videos_per_page;
        $config['albums_per_page']      = $albums_per_page;
        $config['users_per_page']       = $users_per_page;
        $config['blogs_per_page']       = $blogs_per_page;
        $config['watched_per_page']     = $watched_per_page;
        $config['recent_per_page']      = $recent_per_page;
        $config['games_per_page']       = $games_per_page;
        $config['del_original_video']   = $del_original_video;
		$config['language']				= $language;
		$config['multi_language']		= $multi_language;
		$config['splash']				= $splash;
		$config['multi_server']			= $multi_server;
		$config['template']				= $template;
        update_config($config);
        update_smarty();    
        $messages[] = 'System Settings Updated Successfuly!';
    }

	$smarty->assign('site_name', $site_name);
	$smarty->assign('site_title', $site_title);
	$smarty->assign('meta_description', $meta_description);
	$smarty->assign('meta_keywords', $meta_keywords);
	$smarty->assign('ads', $ads);
	$smarty->assign('approve', $approve);
	$smarty->assign('approve_photos', $approve_photos);
	$smarty->assign('approve_games', $approve_games);
	$smarty->assign('approve_blogs', $approve_blogs);
	$smarty->assign('downloads', $downloads);
	$smarty->assign('videos_per_page', $videos_per_page);
	$smarty->assign('albums_per_page', $albums_per_page);
	$smarty->assign('users_per_page', $users_per_page);
	$smarty->assign('blogs_per_page', $blogs_per_page);
	$smarty->assign('watched_per_page', $watched_per_page);
	$smarty->assign('recent_per_page', $recent_per_page);
	$smarty->assign('games_per_page', $games_per_page);
	$smarty->assign('del_original_video', $del_original_video);
	$smarty->assign('splash', $splash);
	$smarty->assign('language', $language);
	$smarty->assign('multi_language', $multi_language);
	$smarty->assign('multi_server', $multi_server);	
	$smarty->assign('template', $template);

}

$smarty->assign('templates', $templates);
$smarty->assign('err', $err);
?>
