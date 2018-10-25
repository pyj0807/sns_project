<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">	
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/changepass.css">	


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="text-align: center;">
	
	<div class="guide">
	<div class="center-box">
	<h4>Change Password</h4>
	<form
		action="${pageContext.servletContext.contextPath }/changepass.do" method="post">
		<div class="form-group row">
			<label for="opass" class="col-sm-2 col-form-label"></label>
			<div class="col-sm-8">
				<input type="password" class="form-control" name="opass" id="opass" placeholder="현재 비밀번호" />
			</div>
		</div>
		<div class="form-group row">
			<label for="npass" class="col-sm-2 col-form-label"></label>
			<div class="col-sm-8">
				<input type="password" class="form-control" name="npass" id="npass" placeholder="새로운 비밀번호" />
			</div>
		</div>
		<div class="form-group row">
			<label for="npassC" class="col-sm-2 col-form-label"></label>
			<div class="col-sm-8">
				<input type="password" class="form-control" name="npassC" id="npassC" placeholder="새로운 비밀번호 확인" />
			</div>
		</div>
		<button type="submit" class="btn btn-primary">Submit</button>
	</form>
	</div>
	</div>
</body>
</html>