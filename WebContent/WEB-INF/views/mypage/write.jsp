<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center">
	<c:if test="${!empty err}">
		<div class="alert alert-danger" role="alert">Image 나 Video 파일만
			업로드 가능합니다.</div>
	</c:if>
	<form method="post"
		action="${pageContext.servletContext.contextPath}/mypage.do"
		enctype="multipart/form-data">
		<p>
			파일첨부<br /> <input type="file" style="width: 320px; pa dding: 5px;"
				name="file" id="file" />
		</p>
		<p>
			글내용(*)<br />
			<textarea name="content"
				style="height: 170px; width: 320px; padding: 5px; resize: none; font-family: inherit;"
				placeholder="write a content"></textarea>
		</p>
		<p>
			<c:forEach var="v" items="${interest }">
				<input type="checkbox" name="interest" value="${v}"
					onchange="cksave(this)" />${v }
		 </c:forEach>
		</p>
		<p>
			장소태그 :
			<button type="button" name="place">장소태그</button>
		</p>
		<p>
			사람태그 :
			<button type="button" name="account">사람태그</button>
		</p>
		<button type="submit" style="width: 330px; padding: 5px;">글
			공유</button>
	</form>
</div>
<script>
	var checkbox = new Array();
	var cksave = function(target) {
		if (target.checked) {
			if (checkbox.length < 1) {
				checkbox.push(target.value);
			} else {
				window.alert("한개만 선택가능");
				target.checked = false;
			}
		}else {
			var idx = checkbox.indexOf(target.value);
			checkbox.splice(idx, 1);
		}
	}
</script>
