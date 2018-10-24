<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html lang="en">

<body>
	<div align="center">
		<p>
			<img src="${pageContext.servletContext.contextPath }/pic/01.jpg">
			<br /> 프로필 사진 <br /> 아이디 : ${sessionScope.user.ID }<br /> 관심사 :
			요리, 게임, IT
		</p>
		<p>
			<a href="${pageContext.servletContext.contextPath }/mypage/write.do">글쓰기</a>
		</p>
		<hr />


		<main role="main">
		<div class="album py-5 bg-light">
			<div class="container">
				<div class="row">
					<div class="col-md-4">
						<div class="card mb-4 shadow-sm">
							<c:forEach var="list" items="${list}">
								<c:if test="${list.type == 'image'}">
									<img src=" ${list.file_attach }">
									<br />
								</c:if>
								<c:if test="${list.type == 'video'}">
									<video src="${list.file_attach }" controls></video>
									<br />
								</c:if>
								<div class="card-body">
									<a
										href="${pageContext.servletContext.contextPath }/mypage/content.do?num=${list._id }">
										내용 : ${list.content }</a><br />
									<hr />
								</div>
							</c:forEach>
							<div class="d-flex justify-content-between align-items-center">
								<div class="btn-group">
									<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
									<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
								</div>
								<small class="text-muted">9 mins</small>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</main>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
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