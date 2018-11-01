<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" >
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" ></script>
<html lang="en">
<style>
img {
	max-width: 100%;
	width: 400px;
	max-height: 100%;
	height: 300px;
}
</style>
<style>
.max-small {
    width: auto; height: auto;
    max-width: 500px;
    max-height: 400px;
}
</style>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
   

    <title>Open Chat</title>

    <!-- Bootstrap core CSS -->
    <link href="http://bootstrap4.kr/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
<div class="w3-container w3-teal">
      <div class="album text-muted">
        <div class="container">

          <div class="row">
            <%-- <div class="card"  >
              <img class="max-small" src="${pageContext.servletContext.contextPath }/img/clubmain.png" alt="Card image cap">
              <p class="card-text">즐거운 싸커.</p>
            </div>
            <br/> --%>
            <c:forEach var="v" items="${clubAll }">
           <a href="${pageContext.servletContext.contextPath }/club/clubview.do?id=${v._id}"><img class="img" src="${v.attach }" alt="Card image cap"></a>
            <p class="card-text">▶  ${v._id}</p>
            <br/>
            </c:forEach>
            <div class="card">
              <img data-src="holder.js/100px280?theme=thumb" alt="Card image cap">
              <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            </div>
            <div class="card">
              <img data-src="holder.js/100px280?theme=thumb" alt="Card image cap">
              <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            </div>
<!-- 
            <div class="card">
              <img data-src="holder.js/100px280?theme=thumb" alt="Card image cap">
              <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            </div>
            <div class="card">
              <img data-src="holder.js/100px280?theme=thumb" alt="Card image cap">
              <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            </div>
            <div class="card">
              <img data-src="holder.js/100px280?theme=thumb" alt="Card image cap">
              <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            </div>

            <div class="card">
              <img data-src="holder.js/100px280?theme=thumb" alt="Card image cap">
              <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            </div>
            <div class="card">
              <img data-src="holder.js/100px280?theme=thumb" alt="Card image cap">
              <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            </div>
            <div class="card">
              <img data-src="holder.js/100px280?theme=thumb" alt="Card image cap">
              <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            </div> -->
          </div>

        </div>
      </div>

    </main>

    <footer class="text-muted">
      <div class="container">
        <p class="float-right">
          <a href="#">Back to top</a>
        </p>
        <!-- <p>Album example is &copy; Bootstrap, but please download and customize it for yourself!</p>
        <p>New to Bootstrap? <a href="../../">Visit the homepage</a> or read our <a href="../../getting-started/">getting started guide</a>.</p> -->
      </div>
    </footer>

    </div>
    
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
   <!--  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="http://bootstrap4.kr/assets/js/vendor/popper.min.js"></script>
    <script src="http://bootstrap4.kr/dist/js/bootstrap.min.js"></script>
    <script src="http://bootstrap4.kr/assets/js/vendor/holder.min.js"></script> -->
    <script>
      Holder.addTheme('thumb', {
        bg: '#55595c',
        fg: '#eceeef',
        text: 'Thumbnail'
      });
    </script>
  </body>
</html>