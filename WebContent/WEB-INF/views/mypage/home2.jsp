<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
				type="button" class="btn btn-danger">로그아웃</button></a></a>
	</p>
</div>
<hr />
관심사가 같은 회원 추천
<br />
<br />
<c:forEach var="v" items="${myInter}">
	<button class="btn btn-outline-dark" value="${v }"
		onclick="myFunction(this);">#${v }</button>
</c:forEach>
<a href="${pageContext.servletContext.contextPath }/alluser.do"><button
		type="button" class="btn btn-Info">모든 유저 보기</button></a>
<br />
<br />
<span id="inte"></span>
<br />
<br />


<main role="main">
<div class="album py-5 bg-light">
	<div class="container">
		<div class="row">
			<c:forEach var="i" items="${mylist }">
				<c:choose>
					<c:when test="${i.type == 'video'}">
						<!-- 타입이비디오일경우 -->
						<div class="col-md-4">
							<div class="card mb-4 shadow-sm">
								<article>
									<div class="thumbImg" style="width: auto; height: 250px;"
									data-target="${i._id }">
										<video class="card-img-top" src="${i.file_attach }" controls/>
									</div>
									<div class="links" style="text-align: center;"></div>
								</article>
								<div class="card-body">
									<a
										href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}"><p
											class="card-text">${i.content }</p></a>
									<div class="d-flex justify-content-between align-items-center">
										<div class="btn-group">
											<!-- Button trigger modal -->
											<button type="button" class="btn btn-primary"
												data-toggle="modal" data-target="#VideoModalCenter"
												data-con="${i.content}" data-vid="${i.file_attach }">
												View</button>
										</div>
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
										<a href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}" data-remote="false"  data-toggle="modal" data-target="#exampleModalCenter"
											data-con="${i.content}" data-ima="${i.file_attach }"><img class="card-img-top" src="${i.file_attach }"
											alt="Card image cap"></a>
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
<!-- Modal Image-->
<div class="modal fade" id="exampleModalCenter" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">
					<img src="${pageContext.servletContext.contextPath }/pic/01.jpg"
						class="photo" style="width: 30px; height: 30px;"> <a
						href="${pageContext.servletContext.contextPath}/account.do?id=${sessionScope.user.ID }">${sessionScope.user.ID }</a>
				</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="modal-img"></div>
				<div class="modal-con"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal Video-->
<div class="modal fade" id="VideoModalCenter" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">
					<img src="${pageContext.servletContext.contextPath }/pic/01.jpg"
						class="photo" style="width: 30px; height: 30px;"> <a
						href="${pageContext.servletContext.contextPath}/account.do?id=${sessionScope.user.ID }">${sessionScope.user.ID }</a>
				</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="modal-vid"></div>
				<div class="modal-con"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
</main>
<!-- Link trigger modal -->
<a href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=125" data-remote="false" data-toggle="modal" data-target="#myModal" class="btn btn-default">
    Launch Modal
</a>
<!-- Default bootstrap modal example -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
<script>
	//Fill modal with content from link href
	$("#myModal").on("show.bs.modal", function(e) {
	    var link = $(e.relatedTarget);
	    $(this).find(".modal-body").load(link.attr("href"));
	});
	$('#exampleModalCenter').on('show.bs.modal',function(event) {
	    var link = $(e.relatedTarget);
	    $(this).find(".modal-body").load(link.attr("href"));
			})
	$('#VideoModalCenter').on('show.bs.modal',function(event) {
	    var link = $(e.relatedTarget);
	    $(this).find(".modal-body").load(link.attr("href"));
			})
/* 	$('#exampleModalCenter').on('show.bs.modal',function(event) {
				var button = $(event.relatedTarget);
				var ima = "<img src=\"" + button.data('ima')
						+ "\" width=\"300\" heigth=\"300\"" + ">";
				var con = button.data('con');
				var modal = $(this);

				modal.find('.modal-img').html(ima);
				modal.find('.modal-con').text(con);
			})
	$('#VideoModalCenter').on('show.bs.modal',function(event) {
				var button = $(event.relatedTarget);
				var con = button.data('con');
				var vid = "<video src=\"" + button.data('vid')
				+ "\" width=\"1280\" heigth=\"720\"" + "controls >";
				var modal = $(this);

				modal.find('.modal-vid').html(vid);
				modal.find('.modal-con').text(con);
			}) */
</script>
<script>
	function myFunction(target) {
		console.log("관심사 : " + target.value);
		var xhr = new XMLHttpRequest();
		xhr.open("post", "${pageContext.servletContext.contextPath}/inte.do",
				true);
		var param = {
			"inte" : target.value
		};
		xhr.onreadystatechange = function() {
			if (this.readyState == 4) {
				var obj = JSON.parse(this.responseText);
				console.log(obj);
				var html = "";
				for (var i = 1; i <= 3; i++) {
					html += "<a href=\"${pageContext.servletContext.contextPath }/account.do?id=";
					html += obj[i].ID;
					html += "\">";
					html += obj[i].ID;
					html += "(";
					html += obj[i].NAME;
					html += ")</a>";
					html += "<br/>";
				}
				document.getElementById("inte").innerHTML = html;
			}
		};
		xhr.send(JSON.stringify(param));
	}
</script>