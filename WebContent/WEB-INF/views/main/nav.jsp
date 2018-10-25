<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav class="navbar navbar-dark bg-dark">
	<a class="navbar-brand"
		href="${pageContext.servletContext.contextPath}">Never expand</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarsExample01" aria-controls="navbarsExample01"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarsExample01">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="#">Home
					<span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.servletContext.contextPath }/mypage/home.do">MyPage</a>
			</li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="http://example.com"
				id="dropdown01" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false">채팅</a>
				<div class="dropdown-menu" aria-labelledby="dropdown01">
					<a class="dropdown-item"
						href="${pageContext.servletContext.contextPath}/chat/freechat.do">개인채팅</a>
					<a class="dropdown-item"
						href="${pageContext.servletContext.contextPath}/club/all.do">클럽</a>
				</div></li>
		</ul>
		<form class="form-inline my-2 my-md-0">
			<input class="form-control" type="text" placeholder="Search"
				aria-label="Search">
		</form>
	</div>
</nav>

<script>
	var ws = new WebSocket("ws://" + location.host
			+ "${pageContext.servletContext.contextPath}/all.do");
</script>