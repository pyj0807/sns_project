<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:forEach var="i" items="${board_list }">
	<c:forEach var="p" begin="0" end="0" items="${i.type }">
		<c:choose>
			<c:when test="${p == 'video'}">
				<!-- 타입이비디오일경우 -->
				<div class="col-md-4">
					<div class="card mb-4 shadow-sm"> 
						<article>
							<div class="thumbImg" style="width: auto; height: 250px;">
								<c:forEach var="v" begin="0" end="0" items="${i.file_attach  }">
									<video class="card-img-top" src="${v }" controls></video>
								</c:forEach>
							</div>
							<div class="links" style="text-align: center;"></div>
						</article>
						<div class="card-body">
							<%--  <a href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}"> --%>
							<p class="card-text">${i.content }</p>
							<%-- </a> --%>
							<div class="d-flex justify-content-between align-items-center">
								<small class="text-muted"> <c:choose>
										<c:when test="${i.lasttime <60}">
		                    			${i.lasttime }초전
		                    		</c:when>
										<c:when test="${i.lasttime >=60 && i.lasttime <3600}">
											<fmt:formatNumber type="number" value="${i.lasttime/60 }"
												pattern="#" />분전
		                    		</c:when>
										<c:when test="${i.lasttime >=3600 && i.lasttime <86400}">
											<fmt:formatNumber type="number"
												value="${i.lasttime/(60*60) }" pattern="#" />시간전
		                    		</c:when>
										<c:when test="${i.lasttime >=86400 && i.lasttime <604800}">
											<fmt:formatNumber type="number"
												value="${i.lasttime/(60*60*24) }" pattern="#" />일전
		                    		</c:when>
										<c:otherwise>
											<fmt:formatNumber type="number"
												value="${i.lasttime/(60*60*24*7) }" pattern="#" />주전
		                    		</c:otherwise>
									</c:choose>
								</small>
								<div class="btn-group">
									<!-- Button trigger modal -->
									<a
										href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}"
										data-remote="false" data-toggle="modal" data-target="#myModal">
										<button type="button" class="btn btn-primary"
											data-toggle="modal" data-target="#VideoModalCenter"
											data-con="${i.content}" data-vid="${i.file_attach }">
											View</button>
									</a>
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
									<a
										href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}"
										data-remote="false" data-toggle="modal" data-target="#myModal"
										class="btn btn-default"><img class="card-img-top"
										src="${p }" alt="Card image cap" style="width: 328px;"></a>
								</c:forEach>
							</div>
							<div class="links" style="text-align: center;">
								<span><img
									src="${pageContext.servletContext.contextPath }/img/heart1.png"
									class="icon"> ${fn:length(i.liker) }</span> <span></span>
							</div>
						</article>
						<div class="card-body">
							<%-- <a href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}"> --%>
							<p class="card-text">${i.content }</p>
							<%-- </a> --%>
							<div class="d-flex justify-content-between align-items-center">
								<small class="text-muted"> <c:choose>
										<c:when test="${i.lasttime <60}">
		                    			${i.lasttime }초전
		                    		</c:when>
										<c:when test="${i.lasttime >=60 && i.lasttime <3600}">
											<fmt:formatNumber type="number" value="${i.lasttime/60 }"
												pattern="#" />분전
		                    		</c:when>
										<c:when test="${i.lasttime >=3600 && i.lasttime <86400}">
											<fmt:formatNumber type="number"
												value="${i.lasttime/(60*60) }" pattern="#" />시간전
		                    		</c:when>
										<c:when test="${i.lasttime >=86400 && i.lasttime <604800}">
											<fmt:formatNumber type="number"
												value="${i.lasttime/(60*60*24) }" pattern="#" />일전
		                    		</c:when>
										<c:otherwise>
											<fmt:formatNumber type="number"
												value="${i.lasttime/(60*60*24*7) }" pattern="#" />주전
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
	$(".thumbImg").on("mouseover",function() {
		var target = $(this);
		var t = $(this).data("target"); //글번호
		//console.log(t);
		var param = {
			"room_no" : t
		};
		$.post("${pageContext.servletContext.contextPath}/indexAjax.do",
				param,function(rst) {
			//this =<div class="thumbImg"> , .next 는 동일선상의 다음꺼(<div  class="links"), .children은 자식 (<span>). eq 는 자식을 배열로표시
					target
					.next()
					.children()
					.eq(1)
					.html("<img src=\"${pageContext.servletContext.contextPath }/img/comment.png\" class=\"icon\"> "
						+ rst.length);
		});
	});
	flag=${more};
</script>