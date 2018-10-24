<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<title>글 작성</title>
</head>
<body>
	<Br />
	<Br />
	<Br />

	<form method="post"
		action="${pageContext.servletContext.contextPath}/mypage.do"
		enctype="multipart/form-data"> 
		<p>
			파일첨부<br /> 
			<input type="file" style="width: 320px; pa	dding: 5px;" name="file" id="file" />
		</p>
		<p>
			글내용(*)<br />
			<textarea name="content" 
				style="height: 170px; width: 320px; padding: 5px; resize: none; font-family: inherit;"
				placeholder="write a content"></textarea>
		</p>
		<p>장소태그 : <button type="button" name="place">장소태그</button></p>
		<p>사람태그 : <button type="button" name="account">사람태그</button></p>
		<button type="submit" style="width: 330px; padding: 5px;">글 공유</button>
	</form>



</body>
</html>