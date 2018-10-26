<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div>
	<c:choose>
		<c:when test="${boardOne.type == 'video'}">
		<!-- 타입이비디오일경우 -->
			<video src="${boardOne.file_attach }" controls></video><br/>
		</c:when>
		<c:otherwise>
			<img src="${boardOne.file_attach }">
		</c:otherwise>	
	</c:choose>
	<br/>

	<c:choose>
		<c:when test="${boardOne.checked == true }">
			<input type="checkbox" id="like_button" onclick="like(this);" checked>좋아요</button>
		</c:when>
	<c:otherwise>
			<input type="checkbox" id="like_button" onclick="like(this);">좋아요</button>
	</c:otherwise>
	</c:choose>
	 
	<p>
		<a href="${pageContext.servletContext.contextPath }/board/likelist.do?num=${boardOne._id}"><b>좋아요:</b><span id="like_count">${fn:length(boardOne.liker) }</span></a><br/>
		<b>글쓴이:</b><a href="${pageContext.servletContext.contextPath }/account.do?id=${boardOne.writer }">${boardOne.writer }</a><br/>
		<%--<b>내용:</b>${boardOne.content }<br/> --%>
		<b>내용:</b>${hashtag }<br/>		
	</p>

</div>
<script>
	//상세화면에서 좋아요 눌렀을때 ajax처리
	var like = function(target){
		var xhr = new XMLHttpRequest();
		//1.open
		xhr.open("post","${pageContext.servletContext.contextPath}/board/like.do",true);
		//2.param설정
		var param = {
			"_id" : ${boardOne._id}
			,"checked":target.checked
		};
		//3.아작스성공시 처리
		xhr.onreadystatechange = function(){
			if(this.readyState==4){
				var obj = JSON.parse(this.responseText);
				var like_count = obj.liker.length;
				document.getElementById("like_count").innerHTML=like_count;	
			}
		};
		//4.send (Map --> string)
		xhr.send(JSON.stringify(param));
	};
</script>