<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" >

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" ></script>
<html lang="en">
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
  <div style="width: 400px; height: 400px; align-content: center;" >
    <main role="main;">

      <section class="jumbotron text-center">
        <div class="container">
          <h1 class="jumbotron-heading">Open Chat</h1>
          <p class="lead text-muted">마음이 맞는 사람과 <br/>채팅을 해 보아요.</p>
          <p>
            <a href="${pageContext.servletContext.contextPath }/club/create.do" class="btn btn-primary">오픈채팅방 만들기</a>
            
          </p>
          <p>
            <a href="#" class="btn btn-secondary">내 오픈채팅방 조회</a>
        	</p>
        </div>
      </section>

<div style="width:200px; width: auto;height: 200px; height: auto; ">
 <c:forEach var="v" items="${clubAll }">
           <%-- <a href="${pageContext.servletContext.contextPath }/club/clubview.do?id=${v._id}"><img class="img" src="${v.attach }" alt="Card image cap"></a>
            <p class="card-text">▶  ${v._id}</p> --%>
            
            
               <div class="media">
  <img class="mr-3" src="${v.attach }" alt="Generic placeholder image">
  <div class="media-body">
    <a href="${pageContext.servletContext.contextPath }/club/clubview.do?id=${v._id}"> <h5 class="mt-0">▶  ${v._id}</h5></a>
   
  </div>
</div>
</div>
            
            
            
            
            <br/>
            </c:forEach>
    
    
    
  
    <script>
      Holder.addTheme('thumb', {
        bg: '#55595c',
        fg: '#eceeef',
        text: 'Thumbnail'
      });
    </script>
  </body>
</html>