<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
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
	<h4>Change Information</h4>
	<form
		action="${pageContext.servletContext.contextPath }/change.do" method="post">
		<div class="form-group row">
			<label for="opass" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" placeholder="${sessionScope.user.ID }" disabled="disabled" />
				</div>
		</div>
		<div class="form-group row">
			<label for="opass" class="col-sm-2 col-form-label">이름</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" placeholder="${sessionScope.user.NAME }" disabled="disabled" />
				</div>
		</div>
		<div class="form-group row">
			<label for="opass" class="col-sm-2 col-form-label">관심사</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" placeholder="${sessionScope.user.INTEREST }" disabled="disabled" />
				</div>
		</div>
		<div class="form-group row">
			<label for="opass" class="col-sm-2 col-form-label">현재 비밀번호</label>
			<div class="col-sm-8">
				<input type="password" class="form-control" name="opass" id="opass" placeholder="현재 비밀번호" />
			</div>
		</div>
		<div class="form-group row">
			<label for="npass" class="col-sm-2 col-form-label">새로운 비밀번호</label>
			<div class="col-sm-8">
				<input type="password" class="form-control" name="npass" id="npass" placeholder="새로운 비밀번호" />
			</div>
		</div>
		
		<button type="submit" class="btn btn-primary">변경</button>
	</form>
	</div>
	</div>
</body>
</html>