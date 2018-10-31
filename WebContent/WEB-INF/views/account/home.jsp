<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
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
<style>
.photo {
	width: 100px;
	height: 100px;
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
		class="photo" style="width: 300px; height: 300px;"><br /> <strong>
		${id}</strong><br /> 관심사 :
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
								<article>
									<div class="thumbImg" style="width: auto; height: 250px;">
										<video class="card-img-top" src="${i.file_attach }" controls></video>
									</div>
									<div class="links" style="text-align: center;"></div>
								</article>
								<div class="card-body">
									<a
										href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}"><p
											class="card-text">${i.content }</p></a>
									<div class="d-flex justify-content-between align-items-center">
										<small class="text-muted">
											<c:choose>
					                    		<c:when test="${i.lasttime <60}">
					                    			${i.lasttime }초전
					                    		</c:when>
					                    		<c:when test="${i.lasttime >=60 && i.lasttime <3600}">
					                    			<fmt:formatNumber type="number" value="${i.lasttime/60 }" pattern="#" />분전
					                    		</c:when>
					                    		<c:when test="${i.lasttime >=3600 && i.lasttime <86400}">
					                    			<fmt:formatNumber type="number" value="${i.lasttime/(60*60) }" pattern="#" />시간전
					                    		</c:when>
					                    		<c:when test="${i.lasttime >=86400 && i.lasttime <604800}">
					                    			<fmt:formatNumber type="number" value="${i.lasttime/(60*60*24) }" pattern="#" />일전
					                    		</c:when>
					                    		<c:otherwise>
					                    			<fmt:formatNumber type="number" value="${i.lasttime/(60*60*24*7) }" pattern="#" />주전
					                    		</c:otherwise>
				                    		</c:choose>
										</small>
									</div>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="col-md-4">
							<!-- 배열 -->
							<div class="card mb-4 shadow-sm">
								<!-- 그림자 -->
								<article>
									<div class="thumbImg" style="width: auto; height: 250px;"
										data-target="${i._id }">
										<img class="card-img-top" src="${i.file_attach }"
											alt="Card image cap">
									</div>
									<div class="links" style="text-align: center;">
										<!--내일댓글수처리 -->
										<span>♡:${fn:length(i.liker) }</span> <span>ss</span>
									</div>
								</article>
								<div class="card-body">
									<a
										href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}"><p
											class="card-text">${i.content }</p></a>
									<div class="d-flex justify-content-between align-items-center">
										<small class="text-muted">
											<c:choose>
					                    		<c:when test="${i.lasttime <60}">
					                    			${i.lasttime }초전
					                    		</c:when>
					                    		<c:when test="${i.lasttime >=60 && i.lasttime <3600}">
					                    			<fmt:formatNumber type="number" value="${i.lasttime/60 }" pattern="#" />분전
					                    		</c:when>
					                    		<c:when test="${i.lasttime >=3600 && i.lasttime <86400}">
					                    			<fmt:formatNumber type="number" value="${i.lasttime/(60*60) }" pattern="#" />시간전
					                    		</c:when>
					                    		<c:when test="${i.lasttime >=86400 && i.lasttime <604800}">
					                    			<fmt:formatNumber type="number" value="${i.lasttime/(60*60*24) }" pattern="#" />일전
					                    		</c:when>
					                    		<c:otherwise>
					                    			<fmt:formatNumber type="number" value="${i.lasttime/(60*60*24*7) }" pattern="#" />주전
					                    		</c:otherwise>
				                    		</c:choose>
										</small>
									</div>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		 <script>
           	$(".thumbImg").on("mouseover", function(){
           		var target = $(this);
           		var t = $(this).data("target"); //글번호
           		var param ={
           			"room_no":t	
           		};
           		$.post("${pageContext.servletContext.contextPath}/indexAjax.do",param,function(rst){
           			//this =<div class="thumbImg"> , .next 는 동일선상의 다음꺼(<div  class="links"), .children은 자식 (<span>). eq 는 자식을 배열로표시
           			target.next().children().eq(1).html("♧:" +rst.length);
           		}); 	
           	});
         </script>
		</div>
	</div>
</div>
</main>

<script>
	$("#follow").on("click",function() {
				console.log("start");
				var param = {
					"myid" : "${sessionScope.user.ID}",
					"otherid" : "${id}"
				};
				$.post("${pageContext.servletContext.contextPath }/follow.do",param, function(rst) {
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

