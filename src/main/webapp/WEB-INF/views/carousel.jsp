<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>

<script>
	/* 	$(document).ready(function(){
	 alert("jQuery시작하기1");		
	 }); */
</script>

<style>
/* Make the image fully responsive */
/* .carousel-inner img {
	width: auto;
	height: 600px;
} */

@media (min-width: 1200px) {
  /* line 306, /Applications/MAMP/htdocs/palash/cl/july 2019/191 Lifeleck Blog/191 Lifeleck Blog html/sass/_common.scss */
  .container2 {
    max-width: 100%;
  }
}

</style>
</head>
<body>
	<!-- header(nav) -->

	<div class="container2">
		<div id="demo" class="carousel slide" data-ride="carousel">
			<ul class="carousel-indicators">
				<li data-target="#demo" data-slide-to="0" class="active"></li>
				<li data-target="#demo" data-slide-to="1"></li>
				<li data-target="#demo" data-slide-to="2"></li>
			</ul>
			<div class="carousel-inner">

				<div class="carousel-item active">
					<img
						src="https://og-data.s3.amazonaws.com/media/event_banner/home/7/web_1594791175823.jpg"
						alt="Los Angeles">
					
					<div class="carousel-caption">
						<h3>Los Angeles</h3>
						<p>We had such a great time in LA!</p>
					</div>
				</div>
				<div class="carousel-item">
					<img
						src="https://og-data.s3.amazonaws.com/media/event_banner/home_web/2/2.jpg"
						alt="Chicago">
					<div class="carousel-caption">
						<h3>Chicago</h3>
						<p>Thank you, Chicago!</p>
					</div>
				</div>
				<div class="carousel-item">
					<img
						src="https://og-data.s3.amazonaws.com/media/event_banner/home/3/web_1563347352707.jpg"
						alt="New York">
					<div class="carousel-caption">
						<h3>New York</h3>
						<p>We love the Big Apple!</p>
					</div>
				</div>
			</div>
			<a class="carousel-control-prev" href="#demo" data-slide="prev">
				<span class="carousel-control-prev-icon"></span>
			</a> <a class="carousel-control-next" href="#demo" data-slide="next">
				<span class="carousel-control-next-icon"></span>
			</a>
		</div>

	</div>
	<!-- .container2 END -->

	<!-- social_connect_part part end-->
	<!-- footer -->

	<!-- footer part end-->
	<!-- jquery -->

</body>

</html>