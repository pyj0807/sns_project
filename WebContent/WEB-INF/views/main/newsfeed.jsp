<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<body>
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