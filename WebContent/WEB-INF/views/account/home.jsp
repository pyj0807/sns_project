<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE HTML>
<html>
	<head>
		<title>My Page</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
	</head>
	<body>

						<h1>아이디 : <strong>Visualize</strong><br />
						내 소개 : 안녕하세요</h1>
						
						
						<a href="${pageContext.servletContext.contextPath }/mypage/write.do" >글쓰기</a>


	</body>
</html>