<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html lang="en">
<head>
    <title>{if isset($self_title) && $self_title != ''}{$self_title|escape:'html'}{else}{$site_name}{/if}</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="robots" content="index, follow" />
    <meta name="revisit-after" content="1 days" />
    <meta name="keywords" content="{if isset($self_keywords) && $self_keywords != ''}{$self_keywords|escape:'html'}{else}{$meta_keywords}{/if}" />
    <meta name="description" content="{if isset($self_description) && $self_description != ''}{$self_description|escape:'html'}{else}{$meta_description}{/if}" />

	<link rel="Shortcut Icon" type="image/ico" href="/favicon.ico" />
	<link rel="apple-touch-icon" href="{$relative_tpl}/img/webapp-icon.png">

    <script type="text/javascript">
    var base_url = "{$baseurl}";
    var tpl_url = "{$relative_tpl}";
	</script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<link href="{$relative_tpl}/css/bootstrap.css" rel="stylesheet">
	<link href="{$relative_tpl}/css/colors.css" rel="stylesheet">
	<link href="{$relative_tpl}/css/enter.css" rel="stylesheet">	
	
</head>
<body>
	<div class="container">
	
	<table height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
	  <tbody>
	  <tr>
		<td valing="middle" align="center">
			<div class="enter">
				<img src="{$relative}/images/logo/logo.png" height="46" alt="{$site_name|escape:'html'}" title="{$site_name|escape:'html'}">
				<h3>
					WARNING: This website contains explicit adult material.
				</h3>
				<p>
					You may only enter this Website if you are at least
					18 years of age, or at least the age of majority in the jurisdiction
					where you reside or from which you access this Website.  If you do not
					meet these requirements, then you do not have permission to use the
					Website.
				</p>
				<a class="btn btn-primary" href="{$baseurl}">Enter</a>
				<a class="btn btn-default m-l-5" href="http://www.google.com">Leave</a>
			</div>		  
		</td>
	  </tr>
	  </tbody>
	</table>	
	</div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="{$relative_tpl}/js/bootstrap.min.js"></script>
	<script>
	{literal}
			if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
		  var msViewportStyle = document.createElement('style')
		  msViewportStyle.appendChild(
			document.createTextNode(
			  '@-ms-viewport{width:auto!important}'
			)
		  )
		  document.querySelector('head').appendChild(msViewportStyle)
		}
	{/literal}
	</script>
	
</body>
</html>