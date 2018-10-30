<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
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

article{
	display: inline-block;
	position:relative;
}
article:hover .thumbImg img{
	opacity:0.3;
}
article:hover .links{
	opacity: 1;
}
.thumbImg img{
	width:350px;
	height:250px;
	opacity:1;
	transition:.5s ease;
}
.icon{
	width:15px;
	height:15px;
}
.links{
	opacity: 0;
	position: absolute;
	text-align: center;
	top: 50%;
	left: 50%;
	transform: translate(-50%,-50%);
	-ms-transform:translate(-50%,-50%);
	transition:.5s ease;
}
</style>
<!doctype html>
<html lang="en">
  <body>
    <main role="main">
      <div class="album py-5 bg-light">
        <div class="container">
          <div class="row">    
          <c:forEach var="i" items="${board_list }">
          	<c:choose>
          		<c:when test="${i.type == 'video'}"> <!-- 타입이비디오일경우 -->
          			<div class="col-md-4">
		              <div class="card mb-4 shadow-sm">
		              <article>
			              <div class="thumbImg" style="width: auto; height:250px;">
			               	<video class="card-img-top" src="${i.file_attach }" controls></video>
			               </div>
			               <div class="links" style="text-align:center;">
		                		
		                	</div>
		                </article>         
		                <div class="card-body">
		                   <a href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}"><p class="card-text">${i.content }</p></a>
		                  <div class="d-flex justify-content-between align-items-center">
		                    <small class="text-muted">9 mins</small>
		                  </div>
		                </div>
		              </div>
		            </div>
          		</c:when>
          		<c:otherwise>
	         		<div class="col-md-4"><!-- 배열 -->
		              <div class="card mb-4 shadow-sm"><!-- 그림자 -->
		              	<article>
		              		<div class="thumbImg" style="width: auto; height:250px;" data-target="${i._id }">
		                		<img class="card-img-top" src="${i.file_attach }" alt="Card image cap" >
		                	</div>
		                	<div  class="links" style="text-align:center;"> <!--내일댓글수처리 -->
			                	<span>♡:${fn:length(i.liker) }</span> <span>ss</span>
		                	</div>	
		                </article>
		                <div class="card-body">
		                  <a href="${pageContext.servletContext.contextPath }/board/board_detail.do?num=${i._id}"><p class="card-text">${i.content }</p></a>
		                  <div class="d-flex justify-content-between align-items-center">
		                    <small class="text-muted">9 mins</small>
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

    <footer class="text-muted">
      <div class="container">
        <p class="float-right">
          <a href="#">Back to top</a>
        </p>
      </div>
    </footer>
  </body>
</html>