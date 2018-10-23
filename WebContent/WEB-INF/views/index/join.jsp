<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
<title>join</title>
<div class="container">
	
	<div class="row align-items-start">
    <div class="col">
    </div>
    <div class="col">
    </div>
    <div class="col">
    </div>
    </div>
  
	<div class="row">
	   <div class="col">
	   </div>
	    <div class="col">
			<img alt="" src="img/phone.png">
	    </div>
	    	<span class="border">
	   	<div class="col">
		   		  <div class="row-group">
		   		  	<div class="row">
						<div class="join">
							<h4>아이디</h4>
							<input name="id" id="id" type="text" maxlength="20" placeholder="ID">
							@
							<input name="subid" id="subid" type="text" maxlength="30" >
							<h4>비밀번호</h4>
							<input name="pass" id="pass" type="password" maxlength="20" placeholder="PASS">
						</div>
					</div>
					
				</div>
	    </div>
			</span>
		<div class="col">
	   </div>
  </div>
	
</html>