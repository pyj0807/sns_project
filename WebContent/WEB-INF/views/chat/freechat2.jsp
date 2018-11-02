<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
		<br/>
		<br/>
		 <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
      <a class="nav-link active" data-toggle="tab" href="#home">개인채팅</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu1" id="open">오픈채팅</a>
    </li>
   
  </ul>
  
  
  <div class="tab-content"> <!-- 탭 컨텐트 시작 -->
		<div id="home" class="container tab-pane active">
		
			<div class="btn-group" role="group" align="center">
				<button style="align-content: center;" id="btnGroupDrop1"
					type="button" class="btn btn-secondary dropdown-toggle"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					팔로우 목록</button>
				<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
					<c:forEach var="v" items="${frends}">

						<a class="dropdown-item"
							href="${pageContext.servletContext.contextPath}/chat/freechatview.do?id=${v.OTHERID}">${v.OTHERID }</a>


					</c:forEach>
				</div>
			</div>


			<div style="height: 520px; overflow-y: scroll;">
				<table class="table table-hover ">
					<thead>
						<tr>

							<th scope="col" width="15%">이름</th>
							<th scope="col">내용</th>
							<th scope="col" width="30%" align="center">시간</th>
							<th scope="col" width="7%">알림</th>
						</tr>
					</thead>

					<tbody>

						<c:forEach var="v" items="${freelist}">

							<c:if test="${!empty v }">
								<c:forEach var="e" items="${v.modeId }">


									<c:if test="${e ne Id}">
										<c:choose>

											<c:when test="${v.num<1 }">

												<tr>
													<td class="table-secondary"><small><b>${e }</b></small>
													</td>
													<td class="table-secondary"><small><b>${v.sendid }
																님 : </b></small><a
														href="${pageContext.servletContext.contextPath}/chat/freechatview.do?id=${e}">${v.cont }</a>
													</td>
													<td class="table-secondary"><small>시간 :<b>${v.lastformat }
														</b></small></td>
													<td class="table-secondary"></td>
												</tr>
											</c:when>
											<c:otherwise>


												<tr>
													<td class="table-success"><small><b>${e }</b></small></td>
													<td class="table-success"><small><b>${v.sendid }
																님 : </b></small><a
														href="${pageContext.servletContext.contextPath}/chat/freechatview.do?id=${e}">${v.cont }</a>
													</td>
													<td class="table-success"><small>시간 :<b>${v.lastformat }
														</b></small></td>
													<td class="table-success "><span
														class="badge badge-danger"> ${v.num }</span></td>
												</tr>

											</c:otherwise>

										</c:choose>


									</c:if>


								</c:forEach>
							</c:if>
						</c:forEach>
					</tbody>

				</table>
			</div>

		</div>
		
		
		
		
		<div id="menu1" class="container tab-pane fade"><br>  <!-- 오픈채팅 시작 -->
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
   

    <title>Open Chat</title>

    <!-- Bootstrap core CSS -->
    <link href="http://bootstrap4.kr/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/album.css" rel="stylesheet">
  </head>

  <body>

   
 
 <br/>
  <br/>
  <!-- <div style="width: 400px; height: 400px; align-content: center;" >
    <main role="main;"> -->

     <!--  <section class="jumbotron text-center" style="height: 300px; width: auto; " > -->
        <div class="container" style="height: 300px; width: auto; ">
          <h1 class="jumbotron-heading">Open Chat</h1>
          <p class="lead text-muted">마음이 맞는 사람과 <br/>채팅을 해 보아요.</p>
          <p>
            <a href="${pageContext.servletContext.contextPath }/club/create.do" class="btn btn-primary">오픈채팅방 만들기</a>
            
          </p>
          <p>
            <a href="#" class="btn btn-secondary">내 오픈채팅방 조회</a>
        	</p>
        </div>
  <!--     </section> -->

<%-- <div style="width:200px; width: auto;height: 200px; height: auto; ">
 <c:forEach var="v" items="${clubAll }">
           <a href="${pageContext.servletContext.contextPath }/club/clubview.do?id=${v._id}"><img class="img" src="${v.attach }" alt="Card image cap"></a>
            <p class="card-text">▶  ${v._id}</p>
            
            
               <div class="media">
  <img class="mr-3" src="${v.attach }" alt="Generic placeholder image">
  <div class="media-body">
    <a href="${pageContext.servletContext.contextPath }/club/clubview.do?id=${v._id}"> <h5 class="mt-0">▶  ${v._id}</h5></a>
   
  </div>
</div>
  
            <br/>
            </c:forEach>

</div>  --%>
<ul class="list-unstyled" >
  <li class="media" >
    <img class="mr-3" style="height: 70px; width: auto;" src="${pageContext.servletContext.contextPath }/clubimg/im.jpg" alt="Generic placeholder image">
    <div class="media-body">
      <h5 class="mt-0 mb-1">List-based media object</h5>
      Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
    </div>
  </li>
  
  
  <!-- <li class="media my-4">
    <img class="mr-3" src=".../64x64" alt="Generic placeholder image">
    <div class="media-body">
      <h5 class="mt-0 mb-1">List-based media object</h5>
      Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
    </div>
  </li>
  <li class="media">
    <img class="mr-3" src=".../64x64" alt="Generic placeholder image">
    <div class="media-body">
      <h5 class="mt-0 mb-1">List-based media object</h5>
      Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
    </div>
  </li> -->
</ul>




    </body>
    
    </div> <!-- 오픈채팅 끝 -->
	</div><!--탭 컨텐트 마지막  -->
    

    
  
    <script>

      Holder.addTheme('thumb', {
        bg: '#55595c',
        fg: '#eceeef',
        text: 'Thumbnail'
      });
    </script>
	
	<script>
	if(${cluballon eq "on"}){
	$("#open").click();
	};
	</script>
		
	
	
	
		<%-- <c:forEach var="v" items="${frends}">
		<c:if test="${v.EMAIL != userId }">
		<a href="${pageContext.servletContext.contextPath}/chat/freechatview.do?id=${v.EMAIL}">${v.EMAIL } : ${v.NAME }</a><br/>
		
		</c:if>
	
		</c:forEach> --%>
		
		
		
</body>
</html>


 <%--      <c:if test = "${fn:contains(theString, 'test')}" --%>