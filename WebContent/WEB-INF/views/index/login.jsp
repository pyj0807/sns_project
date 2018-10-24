<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <!-- Bootstrap core CSS -->
    <link href="../../../../dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="signin.css" rel="stylesheet">

<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/signin.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<title>login</title>
<%-- 
<body class="text-center">
	<form class="form-signin" action="${pageContext.servletContext.contextPath }/login.do" method="post">
		<h1 class="h3 mb-3 font-weight-normal">GROUP WARE</h1>
		
		<label for="inputEmail" class="sr-only">아이디</label> 
		<input type="id" id="inputEmail" class="form-control" placeholder="사원 아이디" required autofocus name="id"> 
		<label for="inputPassword" class="sr-only">비밀번호</label> 
		<input type="password" id="inputPassword" class="form-control" placeholder="사원 비밀번호" required name="pass">
	
		<div class="checkbox mb-3">
			<label> <input type="checkbox" value="remember-me">
				로그인 유지
			</label>
		</div>
		<button class="btn btn-lg btn-primary btn-block" type="submit">로그 인</button>
	</form>
</body>
 --%>

  <body>

    <div class="container">

      <form class="form-signin" action="${pageContext.servletContext.contextPath }/login.do" method="post">
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="inputEmail" class="sr-only">아이디</label>
        <input type="email" id="id" class="form-control" placeholder="Email address" name="id" required autofocus>
        <label for="inputPassword" class="sr-only">비밀번호</label>
        <input type="password" id="pass" class="form-control" placeholder="Password" name="pass" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>

    </div> <!-- /container -->
  </body>
</html>