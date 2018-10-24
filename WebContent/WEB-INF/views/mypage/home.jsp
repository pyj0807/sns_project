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
	<div align="center">
		<p>
			<img src="${pageContext.servletContext.contextPath }/pic/01.jpg">
			<br /> 프로필 사진 <br /> 아이디 : ${sessionScope.user.ID }<br /> 
			관심사 : 요리, 게임, IT
		</p>
		<p>
			<a href="${pageContext.servletContext.contextPath }/mypage/write.do">글쓰기</a>
		</p>
		<hr />
		<p>내가올린사진목록</p>
		<p>
		<c:forEach var="list" items="${list}">
		<a href="${pageContext.servletContext.contextPath }/mypage/home.do?num=${list._id }">
		<img src=" ${list.file_attach }"><br/>
		내용 : ${list.content }<br />
		<hr/>
		</a>
		</c:forEach>
<%-- 			<c:forEach var="list" items="${list}">
				글번호 : ${list._id}<br/>
				올린 사진 또는 영상 경로: ${list.file_attach }<br/>
				<img src=" ${list.file_attach }"><br/>
				내용 : ${list.content }<br />
				좋아요 :${list.like }<br/> 
				댓글창<br/>
				<hr/>
			</c:forEach> --%>

		</p>
	</div>

</body>
</html>