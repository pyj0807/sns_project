<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<c:choose>
		<c:when test="${boardOne.type == 'video'}">
			<!-- 타입이비디오일경우 -->
			<video src="${boardOne.file_attach }" controls></video>
			<button type="submit" id="like_button" onclick="like();">좋아요</button>
			<p>
				<b>좋아요:</b>${boardOne.like }<br/>
				<b>글쓴이:</b>${boardOne.writer }<br/>
				<b>내용:</b>${boardOne.content }
			</p>
		</c:when>
		<c:otherwise>
			<img src="${boardOne.file_attach }">
			<p>
				<b>좋아요:</b>${boardOne.like }<br/>
				<b>글쓴이:</b>${boardOne.writer }<br/>
				<b>내용:</b>${boardOne.content }
			</p>
		</c:otherwise>
	</c:choose>
</div>
<script>
	//상세화면에서 좋아요 눌렀을때 ajax처리
	var like = function(){
		var xhr = new XMLHttpRequest();
		//1.open
		xhr.open("post","${pageContext.servletContext.contextPath}/board/like.do",true);
		//2.param설정
		var param = {
			"_id" : ${boardOne._id}
		};
		//4.send (Map --> string)
		xhr.send(JSON.stringify(param));
	};

</script>