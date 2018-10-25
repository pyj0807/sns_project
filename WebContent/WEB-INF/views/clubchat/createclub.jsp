<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <br/>

		<form action="${pageContext.servletContext.contextPath }/club/createon.do" method="post" enctype="multipart/form-data">
		제목 : <input type="text" name="info"/> <br/>
		메인 사진 : <input type="file" name="attach"> 
		<br/>
		<button type="submit">만들기</button>
	</form>

</body>
</html>