<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=East+Sea+Dokdo&amp;subset=korean"
	rel="stylesheet">
	<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<style>
form {
	font-family: 'East Sea Dokdo', cursive;
}

label {
	font-size: 38px;
}

input::placeholder {
	font-size: 25px;
}

input {
	font-size: 25px;
}
p{
	font-size: 25px;
}

button {
	font-size: 25px;
}
</style>
<!DOCTYPE html>
<html>
<head>
<link href="../../../../dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/login.css">

<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/signin.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.4.2/css/all.css"
	integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns"
	crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<title>login</title>

<body style="text-align: center;">

	<div class="guide" align="center" style="padding-top: 150px; display: "id="zz" >
	<c:if test="${!empty nopass}">
	<div class="alert alert-danger" role="alert"  style="width: 300px">
	아이디 또는 비밀번호가 틀렸습니다.
	</div>
	</c:if>
	
	<c:if test="${!empty newpass}">
	<div class="alert alert-success" role="alert"  style="width: 300px">
	비밀번호 변경 완료
	</div>
	</c:if>
	</div>

		<div class="center-box">
			<div class="container" align="center">
				<form class="form-signin"
					action="${pageContext.servletContext.contextPath }/login.do"
					method="post">
					<label>Login</label><i class="fas fa-sign-in-alt fa-2x"></i> <label
						for="inputEmail" class="sr-only">아이디</label> <input type="text"
						id="id" class="form-control"    style="  text-align: center; font-size: 25px; width: 300px;"
						placeholder="아이디" name="id" required autofocus> <label
						for="inputPassword" class="sr-only"style="padding-top: 20px">비밀번호</label> <input
						type="password" id="pass" class="form-control"
						style="text-align: center; font-size: 25px; width: 300px; margin-top: 10px" placeholder="비밀번호" name="pass"
						required>
					<div class="checkbox">
						<label> </label>
					</div>
					<div>
					<input type="checkbox"  name="dd" value="d"><b>로그인유지</b>
					</div>
					<button class="btn btn-lg btn-primary btn-block" type="submit" style="width: 300px;">Sign
						in</button>
				<p style="text-align: center;">
					계정이 없으십니까?  <a href="${pageContext.servletContext.contextPath }/join.do">가입</a>
				</p>
				<p style="text-align: center;">
					아이디를 잊어버리셨습니까? <a href="${pageContext.servletContext.contextPath }/findid.do">ID</a> | <a href="${pageContext.servletContext.contextPath }/find.do">PASS</a>
				</p>
				</form>
			</div>
		
	</div>
	
	<script >
	$("#id").on("keyup",function(){
		$("#zz").attr("style","display:none");
		
	})
	</script>

</body>
</html>