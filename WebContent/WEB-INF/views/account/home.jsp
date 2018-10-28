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
<style>
.photo {
    width: 100px; height: 100px;
    object-fit: cover;
    border-radius: 50%;
}
</style>
<link href="https://fonts.googleapis.com/css?family=Lobster"
	rel="stylesheet">
<style>
.btn {
	text-decoration: none;
	font-size: 2rem;
	color: white;
	padding: 10px 20px 10px 20px;
	margin: 20px;
	display: inline-block;
	border-radius: 10px;
	transition: all 0.1s;
	text-shadow: 0px -2px rgba(0, 0, 0, 0.44);
	font-family: 'Lobster', cursive;
}

.btn:active {
	transform: translateY(3px);
}

.btn.blue {
	background-color: #1f75d9;
	border-bottom: 5px solid #165195;
}

.btn.blue:active {
	border-bottom: 2px solid #165195;
}

.btn.red {
	background-color: #ff521e;
	border-bottom: 5px solid #c1370e;
}

.btn.red:active {
	border-bottom: 2px solid #c1370e;
}
</style>

<div align="center">
	<img src="${pageContext.servletContext.contextPath }/pic/01.jpg"
		class="photo" style="width: 300px; height: 300px;"><br />
	<strong> ${id}</strong><br /> 관심사 :
	<c:forEach var="in" items="${otherInter }">☆${in } </c:forEach>
	<br />
	<p>
		게시물수 : <b>${size }</b> 팔로워 : <a
			href="${pageContext.servletContext.contextPath}/follower.do?id=${id}"
			name="${id}"><b id="cnt">${followerCnt }</b></a> 팔로잉 : <a
			href="${pageContext.servletContext.contextPath}/following.do?id=${id}"
			name="${id}"><b>${followingCnt }</b></a>
	</p>
	<c:choose>
		<c:when test="${ check!=null }">
			<!-- 	<button type="button" class="btn btn-outline-primary" id="follow"> 팔로잉</button> -->
			<a class="btn red" href="#red" id="follow">following</a>
		</c:when>
		<c:otherwise>
			<!-- 	<button type="button" class="btn btn-primary" id="follow">팔로우</button> -->
			<a class="btn blue" href="#blue" id="follow">follow</a>
		</c:otherwise>
	</c:choose>
</div>
<hr />
관심사가 같은 회원 추천
<br />
<a
	href="${pageContext.servletContext.contextPath }/account.do?id=shpbbb">박소현(shpbbb)</a>
<br />
<a
	href="${pageContext.servletContext.contextPath }/account.do?id=wlsgud1990">전진형(wlsgud1990)</a>
<br />
<a
	href="${pageContext.servletContext.contextPath }/account.do?id=rjsrl504">박건기(rjsrl504)</a>
<br />
<a
	href="${pageContext.servletContext.contextPath }/account.do?id=joon920807">박영준(joon920807)</a>
<br />
<hr />


<main role="main">
<div class="album py-5 bg-light">
	<div class="container">
		<div class="row">
			<c:forEach var="i" items="${accountlist }">
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
<script>
	$("#follow").on(
			"click",
			function() {
				console.log("start");
				var param = {
					"myid" : "${sessionScope.user.ID}",
					"otherid" : "${id}"
				};
				$.post("${pageContext.servletContext.contextPath }/follow.do",
						param, function(rst) {
							var obj = JSON.parse(rst);
							console.log(obj);
							switch (obj.mode) {
							case "on":
								onHandle(obj);
								break;
							case "off":
								offHandle(obj);
								break;
							case "err":
								break;
							}
						});
			});

	var onHandle = function(obj) {
		var cnt = obj.followerCnt;
		$("#follow").attr("class", "btn red");
		$("#follow").html("following");
		$("#cnt").html(cnt);
	}
	var offHandle = function(obj) {
		var cnt = obj.followerCnt;
		$("#follow").attr("class", "btn blue");
		$("#follow").html("follow");
		$("#cnt").html(cnt);
	}
</script>