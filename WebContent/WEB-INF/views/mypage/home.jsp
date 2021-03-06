<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
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
<br/>
<div align="center">
	<a href="javascript:window.open('${pageContext.servletContext.contextPath }/changepic.do','','width=800 height=600');">
	<img src="${pageContext.servletContext.contextPath }/pic/${loginPic}"  class="photo" style="width: 200px; height: 200px;"></a>
	<br /><br /><br />
	<strong>${sessionScope.user.ID }</strong><br />
	관심사 :
	<c:forEach var="in" items="${myInter }">☆${in } </c:forEach>
	<p>
		게시물수 : <b>${msize }</b> 
		팔로워 : <a
			href="${pageContext.servletContext.contextPath}/follower.do?id=${sessionScope.user.ID }"
			data-remote="false" data-toggle="modal" data-target="#exampleModalCenter"
			name="${sessionScope.user.ID }"><b>${followerCnt }</b></a> 
		팔로잉 : <a 
			href="${pageContext.servletContext.contextPath}/following.do?id=${sessionScope.user.ID }"
			data-remote="false" data-toggle="modal" data-target="#exampleModalCenter"
			name="${sessionScope.user.ID }"><b>${followingCnt }</b></a>
	</p>
	<p>
		<a href="${pageContext.servletContext.contextPath }/write.do"><button
				type="button" class="btn btn-warning">글쓰기</button></a> <a
			href="${pageContext.servletContext.contextPath }/chat/freechat.do?cluballon=on"><button
				type="button" class="btn btn-primary">오픈채팅</button></a> <a
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
<br />
<br />
<span id="inte"></span>
<br />
<br />


<main role="main">
	<div class="container">
		<div class="row">
			<c:forEach var="i" items="${mylist }">
	          	<c:forEach var="p" begin="0" end="0" items="${i.type }">
				<c:choose>
					<c:when test="${p == 'video'}">
						<!-- 타입이비디오일경우 -->
						<div class="col-md-4">
							<div class="card mb-4 shadow-sm">
								<article>
									<div class="thumbImg" style="width: auto; height: 250px;" data-target="${i._id }">
			 							<c:forEach var="v" begin="0" end="0" items="${i.file_attach  }">
						           	    	<video class="card-img-top" src="${v }" controls></video>
						           	   </c:forEach>
									</div>
									<div class="links" style="text-align: center;"></div>
								</article>
								<div class="card-body">
									<p class="card-text">${i.content }</p>
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
										<div class="btn-group">
											<!-- Button trigger modal -->
											<a href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}" 
													data-remote="false" data-toggle="modal" data-target="#myModal">
												<button type="button" class="btn btn-primary"
												data-toggle="modal" data-target="#VideoModalCenter"
												data-con="${i.content}" data-vid="${i.file_attach }">
												View</button></a>
										</div>
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
					              		<c:forEach var="p" begin="0" end="0" items="${i.file_attach }">
											<a href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}" 
													data-remote="false" data-toggle="modal" data-target="#myModal" class="btn btn-default"
														><img class="card-img-top" src="${p }" alt="Card image cap"  style="width: 328px;"></a>
										</c:forEach>
									</div>
									<div class="links" style="text-align: center;">
					                	<span><img src="${pageContext.servletContext.contextPath }/img/heart1.png" class="icon">   ${fn:length(i.liker) }</span>   <span></span>
									</div>
								</article>
								<div class="card-body">
									<p class="card-text">${i.content }</p>
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
			</c:forEach>
			<script>
           	$(".thumbImg").on("mouseover", function(){
           		var target = $(this);
           		var t = $(this).data("target"); //글번호
           		console.log(t);
           		var param ={
           			"room_no":t	
           		};
           		$.post("${pageContext.servletContext.contextPath}/indexAjax.do",param,function(rst){
           			//this =<div class="thumbImg"> , .next 는 동일선상의 다음꺼(<div  class="links"), .children은 자식 (<span>). eq 는 자식을 배열로표시
           			target.next().children().eq(1).html("<img src=\"${pageContext.servletContext.contextPath }/img/comment.png\" class=\"icon\"> " +rst.length);
           		}); 	
           	});
			</script>
			</div>
	</div>
</main>
<!-- 사진이나 버튼을 클릭하면 보여지는 모달 뷰 - Default bootstrap modal example -->
<div class="modal fade  bd-example-modal-lg " id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog  modal-lg ">
    <div class="modal-content">
      <div class="modal-body">
        ...
      </div>
    </div>
  </div>
</div>
<!-- 팔로잉 팔로워 Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-body">
        ...
      </div>
	</div>
  </div>
</div>

<script>
	// 모달에 불러와지는 링크 JQuery
	$("#myModal").on("show.bs.modal", function(e) {
	    console.log("모달이 열림! 디스가뭐지"+this);
	    var link = $(e.relatedTarget);
	    $(this).find(".modal-body").load(link.attr("href"));
	});
 	$('#myModal').on('hidden.bs.modal', function (e) { 
		  $(this).removeData('.modal'); 
		 console.log("모달 gg");
	}); 
	// 모달에 불러와지는 링크 JQuery
	$("#exampleModalCenter").on("show.bs.modal", function(e) {
	    console.log("exampleModalCenter 모달이 열림! 디스가뭐지"+this);
	    var link = $(e.relatedTarget);
	    $(this).find(".modal-body").load(link.attr("href"));
	});
 	$('#exampleModalCenter').on('hidden.bs.modal', function (e) { 
		  $(this).removeData('.modal'); 
		 console.log("exampleModalCenter 모달 gg");
	}); 
</script>
<script>
	// #관심사 버튼을 누르면 같은 관심사를 가진 사람들을 추천해주는 Ajax. 랜덤으로 추천해줌. 계속 바뀜 
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
				console.log(obj.cnt); 
				var html = "";
				html += "<div class=\"ui horizontal list\">";
				if(obj.cnt<3){
					for (var i = 1; i <= obj.cnt; i++) {
						html += "<div class=\"item\">";
						html += "<img class=\"ui avatar image\" src=\"${pageContext.servletContext.contextPath }/pic/";
						html += obj[i].PROFILE_ATTACH;
						html += "\" class=\"photo\" style=\"width: 30px; height: 30px;\"> <div class=\"content\">";
						html += "<div><a href=\"${pageContext.servletContext.contextPath }/account.do?id=";
						html += obj[i].ID;
						html += "\">";
						html += obj[i].ID;
						html += "(";
						html += obj[i].NAME;
						html += ")</a></div>";
						html += obj[i].INTEREST;
						html += "</div></div>"; 
					}
				}else{
					for (var i = 1; i <= 3; i++) {
						html += "<div class=\"item\">";
						html += "<img class=\"ui avatar image\" src=\"${pageContext.servletContext.contextPath }/pic/";
						html += obj[i].PROFILE_ATTACH;
						html += "\" class=\"photo\" style=\"width: 30px; height: 30px;\"> <div class=\"content\">";
						html += "<div><a href=\"${pageContext.servletContext.contextPath }/account.do?id=";
						html += obj[i].ID;
						html += "\">";
						html += obj[i].ID;
						html += "(";
						html += obj[i].NAME;
						html += ")</a></div>";
						html += obj[i].INTEREST;
						html += "</div></div>"; 
					}
				}
				html += "</div>";
				document.getElementById("inte").innerHTML = html;
			}
		};
		xhr.send(JSON.stringify(param));
	}
</script>
<script>window.name="main"</script>
