<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
/* img {
	max-width: 100%;
	width: 400px;
	max-height: 100%;
	height: 300px;
} */

img {
	;
	width: 400px;
	
	height: auto;
	height: 300px;
}
video {
	max-width: 100%;
	width: 400px;
	max-height: 100%;
	height: 300px;
}
</style>
<body>
	<h2>모든 회원 글보기</h2>
	<div class="btn-group" role="group" align="center">
		<button style="align-content: center;" id="btnGroupDrop1"
			type="button" class="btn btn-secondary
			dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false">글 보기</button>
		<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
			<a class="dropdown-item"
				href="${pageContext.servletContext.contextPath }/index.do">모든 회원 글 보기</a>
			<a class="dropdown-item"
				href="${pageContext.servletContext.contextPath }/newsfeed.do">뉴스피드</a>
		</div>
	</div>
	<div class="btn-group" role="group" align="center">
	<button style="align-content: center;" id="btnGroupDrop1" type="button"
		class="btn btn-secondary dropdown-toggle" data-toggle="dropdown"
		aria-haspopup="true" aria-expanded="false">관심사</button>
	<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
		<c:forEach var="v" items="${allInter}">
				<a class="dropdown-item"
					href="${pageContext.servletContext.contextPath}/interest.do?theme=${v}">${v}</a>
		</c:forEach>
	</div>
</div>
	
	<main role="main">
	<div class="album py-5 bg-light">
		<div class="container">
			<div class="row">
				<c:forEach var="i" items="${board_list }">
					<c:choose>
						<c:when test="${i.type == 'video'}">
							<!-- 타입이비디오일경우 -->
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<video class="card-img-top" src="${i.file_attach }" controls></video>
									<div class="card-body">
										<a
											href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}"><p
												class="card-text">${i.content }</p></a>
										<div class="d-flex justify-content-between align-items-center">
											<small class="text-muted">9 mins</small>
										</div>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<img class="card-img-top" src="${i.file_attach }"
										alt="Card image cap">
									<div class="card-body">
										<a
											href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}"><p
												class="card-text">${i.content }</p></a>
										<div class="d-flex justify-content-between align-items-center">
											<small class="text-muted">9 mins</small>
										</div>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>

			</div>
		</div>
	</div>
	</main>

	<footer class="text-muted">
		<div class="container">
			<p class="float-right">
				<a href="#">Back to top</a>
			</p>
			<p>Album example is &copy; Bootstrap, but please download and
				customize it for yourself!</p>
			<p>
				New to Bootstrap? <a href="../../">Visit the homepage</a> or read
				our <a href="../../getting-started/">getting started guide</a>.
			</p>
		</div>
	</footer>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script> -->
	<script>
		window.jQuery
				|| document
						.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')
	</script>
	<script src="../../assets/js/vendor/popper.min.js"></script>
	<script src="../../dist/js/bootstrap.min.js"></script>
	<script src="../../assets/js/vendor/holder.min.js"></script>
</body>
</html>