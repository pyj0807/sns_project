<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&amp;subset=korean" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/semantic/semantic.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="${pageContext.servletContext.contextPath }/semantic/semantic.js"></script>	
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<title>우리들의 이야기</title>
<style >
div {
font-family: 'Nanum Pen Script', cursive ;
font-size: 20px;
}
</style> 
</head>
<body>
		<div>
			<tiles:insertAttribute name="nav" />
		</div>
		<div class="container">
			<div>
				<tiles:insertAttribute name="center"/>
			</div>
		</div>
</body>
</html>