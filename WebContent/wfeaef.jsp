<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<style>
img {
	max-width: 100%;
	width: 400px;
	max-height: 100%;
	height: 300px;
}

video {
	max-width: 100%;
	width: 400px;
	max-height: 100%;
	height: 300px;
}
</style>
<style>
.photo {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 50%;
}

.container {
	position: relative;
	width: 250%;
}

article {
	display: inline-block;
	position: relative;
}

article:hover .thumbImg img {
	opacity: 0.3;
}

article:hover .links {
	opacity: 1;
}

.thumbImg img {
	width: 350px;
	height: 250px;
	opacity: 1;
	transition: .5s ease;
}

.icon {
	width: 15px;
	height: 15px;
}

.links {
	opacity: 0;
	position: absolute;
	text-align: center;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	transition: .5s ease;
}
</style>
<!-- semantic 아이콘 사용위한 스크립트와 link  -->
<script src="semantic/semantic.js"></script>
<link rel="stylesheet" type="text/css" href="semantic/semantic.css">

<body>
	<div class="ui horizontal list">
		<div class="item">
			<div class="ui card">
				<div class="content">
					<div class="right floated meta">14h</div>
					<img class="ui avatar image"
						src="${pageContext.servletContext.contextPath }/pic/01.jpg">
					프사랑 이름
				</div>
				<div class="image">
					<img src="${pageContext.servletContext.contextPath }/pic/01.jpg">
				</div>
				<div class="content">내용내용</div>
			</div>
		</div>
		<div class="item">
			<div class="ui card">
				<div class="content">
					<div class="right floated meta">14h</div>
					<img class="ui avatar image"
						src="${pageContext.servletContext.contextPath }/pic/01.jpg">
					프사랑 이름
				</div>
				<div class="image">
					<img src="${pageContext.servletContext.contextPath }/pic/01.jpg">
				</div>
				<div class="content">내용내용</div>
			</div>
		</div>
		<div class="item">
			<div class="ui card">
				<div class="content">
					<div class="right floated meta">14h</div>
					<img class="ui avatar image"
						src="${pageContext.servletContext.contextPath }/pic/01.jpg">
					프사랑 이름
				</div>
				<div class="image">
					<img src="${pageContext.servletContext.contextPath }/pic/01.jpg">
				</div>
				<div class="content">내용내용</div>
			</div>
		</div>
		<div class="item">
			<div class="ui card">
				<div class="content">
					<div class="right floated meta">14h</div>
					<img class="ui avatar image"
						src="${pageContext.servletContext.contextPath }/pic/01.jpg">
					프사랑 이름
				</div>
				<div class="image">
					<img src="${pageContext.servletContext.contextPath }/pic/01.jpg">
				</div>
				<div class="content">내용내용</div>
			</div>
		</div>
		<div class="item">
			<div class="ui card">
				<div class="content">
					<div class="right floated meta">14h</div>
					<img class="ui avatar image"
						src="${pageContext.servletContext.contextPath }/pic/01.jpg">
					프사랑 이름
				</div>
				<div class="image">
					<img src="${pageContext.servletContext.contextPath }/pic/01.jpg">
				</div>
				<div class="content">내용내용</div>
			</div>
		</div>
	</div>


</body>
</html>