<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>My Page</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body>
	<br />
	<br />
	<br />
	<p>
		<img src="${pageContext.servletContext.contextPath }/pic/01.jpg">
		<br /> 프로필 사진 <br /> 아이디 : 세션에서 뽑아올거에요<br /> 관심사 : 요리, 게임, IT
	</p>
	<p>
		<a href="${pageContext.servletContext.contextPath }/mypage/write.do">글쓰기</a>
	</p>
	<hr />
	<p>내가올린사진목록</p>
	<p>
	<c:forEach var="list" items="${list}" >
		${list }<br/>
	</c:forEach>

	</p>


</body>
</html>