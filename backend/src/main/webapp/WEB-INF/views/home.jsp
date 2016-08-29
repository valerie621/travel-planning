<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Welcome to Trip4U, we can make a personal travel plan for you.">
    <meta name="author" content="">
    <title>Log in with your account</title>
    <link href="${contextPath}/resources/css/homepage.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
	<body>
		<!--nav bar-->
		<div class="navbar navbar-inverse navbar-fixed-top opaque-navbar">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navMain">
						<span class="glyphicon glyphicon-chevron-right" style="color:white;border:none;"></span>

					</button>
					<a class="navbar-brand" href="#" style="font-family: Papyrus, fantasy;">Trip4U</a>
				</div>
				<div class="collapse navbar-collapse" id="navMain">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#"><span class="glyphicon glyphicon-log-in">Login</span></a></li>
						<li><a href="#"><span class="glyphicon glyphicon-user">SignUp</span></a></li>
					</ul>
				</div>
			</div>
		</div>

		<!--background-->
		<div class="background-wrap">
			<video id="video-bg-elem" preload="auto" autoplay="true" loop="loop" muted="muted" poster="${contextPath}/resources/static/video/bgpic_video.jpg">
				<source src="${contextPath}/resources/static/video/bgvideo_final.mp4" type="video/mp4">
			</video>
		</div>

		<!--content-->
		<div class="content">
			<h1>Customize Perfect Trips</h1>
			<form>
				<input type="text" id="destination" placeholder="Enter your destination" required>
				<input type="text" id="day" placeholder="Enter travel days">
				<p>
					<button type="submit">
						<svg version="1.1" class="send-icn" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="60px" height="36px" viewBox="0 0 100 36" enable-background="new 0 0 100 36" xml:space="preserve">
        <path d="M100,0L100,0 M23.8,7.1L100,0L40.9,36l-4.7-7.5L22,34.8l-4-11L0,30.5L16.4,8.7l5.4,15L23,7L23.8,7.1z M16.8,20.4l-1.5-4.3
	l-5.1,6.7L16.8,20.4z M34.4,25.4l-8.1-13.1L25,29.6L34.4,25.4z M35.2,13.2l8.1,13.1L70,9.9L35.2,13.2z" />
      </svg>
						<small>start</small>
					</button>
				</p>
			</form>
		</div>
</body>
</html>
