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
<div align="center">
	<img src="${pageContext.servletContext.contextPath }/pic/01.jpg"
		class="img-circle" style="width: 300px; height: 300px;"> <br />
	<strong>이메일 : ${sessionScope.user.EMAIL }</strong><br /> 관심사 : <c:forEach var="in" items="${sessionScope.user.INTEREST }">${in }</c:forEach> 
	<p>
		게시물수 : <b>${msize }</b> 팔로워 : <a
			href="${pageContext.servletContext.contextPath}/follower.do?id=${sessionScope.user.EMAIL }"
			name="${sessionScope.user.EMAIL }"><b>${followerCnt }</b></a> 팔로잉 : <a
			href="${pageContext.servletContext.contextPath}/following.do?id=${sessionScope.user.EMAIL }"
			name="${sessionScope.user.EMAIL }"><b>${followingCnt }</b></a>
	</p>
	<p>
		<a href="${pageContext.servletContext.contextPath }/write.do"><button
				type="button" class="btn btn-warning">글쓰기</button></a> <a
			href="${pageContext.servletContext.contextPath }/club/all.do"><button
				type="button" class="btn btn-primary">클럽</button></a> <a
			href="${pageContext.servletContext.contextPath }/change.do"><button
				type="button" class="btn btn-success">회원정보변경</button></a> <a
			href="${pageContext.servletContext.contextPath }/logout.do"><button
				type="button" class="btn btn-danger">로그아웃</button></a>
	</p>
</div>
<hr />
추천
<br />
<a
	href="${pageContext.servletContext.contextPath }/account.do?id=shpbbb@gmail.com">박소현(shpbbb)</a>
<br />
<a
	href="${pageContext.servletContext.contextPath }/account.do?id=wlsgud1990@naver.com">전진형(wlsgud1990)</a>
<br />
<a
	href="${pageContext.servletContext.contextPath }/account.do?id=rjsrl504@naver.com">박건기(rjsrl504)</a>
<br />
<a
	href="${pageContext.servletContext.contextPath }/account.do?id=joon920807@naver.com">박영준(joon920807)</a>
<br />
<hr />



<main role="main">
<div class="album py-5 bg-light">
	<div class="container">
		<div class="row">


			<c:forEach var="i" items="${mylist}">
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
										<div class="btn-group">
											<button type="button"
												class="btn btn-sm btn-outline-secondary" data-toggle="modal"
												data-target="#exampleModalLong">View</button>
											<button type="button"
												class="btn btn-sm btn-outline-secondary">Edit</button>
										</div>
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
										<div class="btn-group">
											<button type="button"
												class="btn btn-sm btn-outline-secondary" data-toggle="modal"
												data-target="#exampleModalLong">View</button>
											<button type="button"
												class="btn btn-sm btn-outline-secondary">Edit</button>
										</div>
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
