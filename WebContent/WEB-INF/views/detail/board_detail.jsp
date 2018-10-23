<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Feed | Instaclone</title>
		<meta charset = "utf-8">
		<meta description = "Instaclone Login">
		<link href = "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
		<link rel="stylesheet" href="css/style.css">
		<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
		<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	</head>

	<body>

	<!-- the left logo column -->

	<nav class="navigation">
		<div class="navigation__column">
			<a href="feed.html">
				<img
				src="/sns_project/upload/test.png"
				alt="feed_logo"
				title="feed_logo"
				/>
			</a>
		</div>

	<!-- search -->

		<div class="navigation__column">
			<i class="fa fa-search"></i>
			<input type="text" placeholder="Search">
		</div>

	<!-- the right three columns -->
		<div class="navigation__column">
			<a href="explore.html" class="navigation__link">
				<i class="fa fa-compass"></i>
			</a>

			<a href="#" class="navigation__link">
				<i class="fa fa-heart-o"></i>
			</a>

			<a href="profile.html" class="navigation__link">
				<i class="fa fa-user-o"></i>
			</a>

		</div>
	</nav>
<!-- main: photo feed display -->

	<main id="feed">
		<article class="photo__container">
			<header class="photo__header">
				<img
				class="photo__avatar"
				src="images/avatar.jpg" 
				alt="avatar__image"
				/>

				<div class="photo__info">
					<span class="photo__author">Jihyo</span>
					<span class="photo__location">Jeju-do</span>
				</div>
			</header>

			<img
				class="insta__image"
				src="images/twice.jpg" 
				alt="main__feedphoto"
				title="main__feedphoto"
				class="photo__image"
			/>
		
			<div class="photo__main">

				<div class="photo__actions">
					<i class="fa heart fa-heart-o fa-2x"></i>
					<i class="fa fa-comment-o fa-2x"></i>
				</div>

				<span class="photo__likes"><span class="photo__likes-number">2989</span> Likes</span>

				<ul class="comments">
					<li class="photo__comment">
						<span class="photo__comment--author">Serranoarevalo</span> omg this is great
					</li>

					<li class="photo__comment">
						<span class="photo__comment--author">Jihyo_twice</span> TT
					</li>
				</ul>

				<span class="photo__date">13 hours ago</span>

				<div class="photo__addcomment-container">
					<textarea class="photo__addcomment-area" name="comment" placeholder="Add a comment..."></textarea>
					<i class="fa fa-ellipsis-h"></i>
				</div>
                

			</div>
		</article>
	</main>
		
<!-- footer: under sidebar-->
		<footer>
			<nav class="footer__nav">
				<ul class="footer__list">
					<li class="footer__item"><a href="#" class="footer_link">about us</a></li>
					<li class="footer__item"><a href="#" class="footer_link">support</a></li>
					<li class="footer__item"><a href="#" class="footer_link">blog</a></li>
					<li class="footer__item"><a href="#" class="footer_link">press</a></li>
					<li class="footer__item"><a href="#" class="footer_link">api</a></li>
					<li class="footer__item"><a href="#" class="footer_link">jobs</a></li>
					<li class="footer__item"><a href="#" class="footer_link">privacy</a></li>
					<li class="footer__item"><a href="#" class="footer_link">terms</a></li>
					<li class="footer__item"><a href="#" class="footer_link">directory</a></li>
					<li class="footer__item"><a href="#" class="footer_link">langage</a></li>
				</ul>
			</nav>
			<span class="footer__copyright">© 2017 Instagram</span>

		</footer>
		<div class="popUp">
			<i class="fa fa-times fa-2x"></i>
			<div class="popUpContainer">
				<a href="#" class="popUpLink">Report inappropriate</a>
				<a href="#" class="popUpLink">Embed</a>
				<a href="http://google.com" class="popUpLink closePopUpBtn">Cancel</a>
			</div>
		</div>

		<script
		  src="https://code.jquery.com/jquery-3.2.1.min.js"
		  integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
		  crossorigin="anonymous"></script>
		<script src="js/app.js"></script>
	</body>
</html>