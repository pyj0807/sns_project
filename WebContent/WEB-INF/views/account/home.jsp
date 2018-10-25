<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div align="center">
	<img src="${pageContext.servletContext.contextPath }/pic/01.jpg"
		class="img-circle" style="width: 300px; height: 300px;"><br />
	<strong>아이디 : ${id}</strong><br /> 관심사 : 게임, IT<br />
		<p>
		게시물수 : <b>0 </b> 팔로워 : <a
			href="${pageContext.servletContext.contextPath}/follower.do?id=${id}"
			name="${id}"><b>${followerCnt }</b></a>
		팔로잉 : <a href="${pageContext.servletContext.contextPath}/following.do?id=${id}"
			name="${id}"><b>${followingCnt }</b></a>
	</p>
	<c:choose>
		<c:when test="${ check!=null }">
		<button type="button" class="btn btn-outline-primary" id="following"> 팔로잉</button>
		</c:when>
		<c:otherwise>
	<button type="button" class="btn btn-primary" id="follow">팔로우</button>
		
		</c:otherwise>
	</c:choose>
	
</div>
<hr />
추천
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
										href="${pageContext.servletContext.contextPath }/content.do?num=${i._id}"><p
											class="card-text">${i.content }</p></a>
									<div class="d-flex justify-content-between align-items-center">
										<div class="btn-group">
											<button type="button"
												class="btn btn-sm btn-outline-secondary">View</button>
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
										href="${pageContext.servletContext.contextPath }/content.do?num=${i._id}"><p
											class="card-text">${i.content }</p></a>
									<div class="d-flex justify-content-between align-items-center">
										<div class="btn-group">
											<button type="button"
												class="btn btn-sm btn-outline-secondary">View</button>
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
<script>
	$("#follow").on(	"click",function() {
				console.log("start");
				var param = {
					"myid" : "${sessionScope.user.ID}",
					"otherid" : "${id}"
				};
				$.post("${pageContext.servletContext.contextPath }/follow.do",
						param, function(rst) {
							var obj = JSON.parse(rst);
							console.log(obj.mode);
							switch(obj.mode){
							case "on":
								onHandle();
								break;
							case "err":
								break;
							}
						});
			});
	
	var onHandle = function(){
		$("#follow").attr("class","btn btn-outline-primary");
		$("#follow").html("팔로잉");	
	}
	
	$("#following").on("click",function() {
				console.log("start");
				var param = {
					"myid" : "${sessionScope.user.ID}",
					"otherid" : "${id}"
				};
				$.post("${pageContext.servletContext.contextPath }/follow.do",
						param, function(rst) {
							var obj = JSON.parse(rst);
							console.log(obj.mode);
							switch(obj.mode){
							case "off":
								offHandle();
								break;
							case "err":
								break;
							}
						});
			});
	
	var offHandle = function(){
		$("#following").attr("class","btn btn-primary");
		$("#following").html("팔로우");	
	}
	
	
	
</script>