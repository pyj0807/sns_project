<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.photo {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 50%;
}
</style>
<p>
	파일첨부<br /> <input type="file" style="width: 320px; pa dding: 5px;" name="file" id="file"/>
</p>
미리보기
<img src="${pageContext.servletContext.contextPath }/pic/${loginPic}"  class="photo" style="width: 200px; height: 200px;">