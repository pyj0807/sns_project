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
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 50%;
}
</style>
<div align="center">
	<img src="${pageContext.servletContext.contextPath }/pic/01.jpg"
		class="photo" style="width: 300px; height: 300px;"> <br /> <strong>${sessionScope.user.ID }</strong><br />
	관심사 :
	<c:forEach var="in" items="${myInter }">☆${in } </c:forEach>
	<p>
		게시물수 : <b>${msize }</b> 팔로워 : <a
			href="${pageContext.servletContext.contextPath}/follower.do?id=${sessionScope.user.ID }"
			name="${sessionScope.user.ID }"><b>${followerCnt }</b></a> 팔로잉 : <a
			href="${pageContext.servletContext.contextPath}/following.do?id=${sessionScope.user.ID }"
			name="${sessionScope.user.ID }"><b>${followingCnt }</b></a>
	</p>
	<p>
		<a href="${pageContext.servletContext.contextPath }/write.do"><button
				type="button" class="btn btn-warning">글쓰기</button></a> <a
			href="${pageContext.servletContext.contextPath }/club/all.do"><button
				type="button" class="btn btn-primary">클럽</button></a> <a
			href="${pageContext.servletContext.contextPath }/change.do"><button
				type="button" class="btn btn-success">회원정보변경</button></a> <a
			href="${pageContext.servletContext.contextPath }/liked.do"><button
				type="button" class="btn btn-light">내가좋아요한게시물</button></a> <a
			href="${pageContext.servletContext.contextPath }/logout.do"><button
				type="button" class="btn btn-danger">로그아웃</button></a>
	</p>
</div>
<hr />
관심사가 같은 회원 추천
<br />
<br />
	<c:forEach var="v" items="${myInter}">
 			<button class="btn btn-outline-dark"  value="${v }" onclick="myFunction(this);" >#${v } </button>
	</c:forEach>
<br/>
<br/>
<span id="inte"></span>
<br/>
<br/>

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

<script> 
function myFunction(target) {
	console.log("관심사 : "+ target.value);
	var xhr = new XMLHttpRequest();
	xhr.open("post","${pageContext.servletContext.contextPath}/inte.do",true);
	var param={                   
			"inte":target.value
	};  
	xhr.onreadystatechange = function(){
		if(this.readyState==4){
			var obj = JSON.parse(this.responseText);
			console.log(obj);
			var html = ""; 
 			for(var i=1; i<=3; i++){
				html += "<a href=\"${pageContext.servletContext.contextPath }/account.do?id=";
				html += obj[i].ID;
				html += "\">";
				html += obj[i].NAME;
				html += "(";
				html += obj[i].ID;
				html += ")</a>";
				html += "<br/>";
			}
			document.getElementById("inte").innerHTML = html;
		}
	};
 	xhr.send(JSON.stringify(param)); 
}
</script>