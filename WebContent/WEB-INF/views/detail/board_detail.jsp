<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<div>
	${boardOne }
	<%-- 
	<c:forEach var="i" items="${boardOne }">
		<c:choose>
			<c:when test="${i.type == 'video/mp4'}"> <!-- 타입이비디오일경우 -->
          		 <video src="${i.file_attach }" controls></video>
          	</c:when>
		</c:choose>
		<c:otherwise>
			<img src="${i.file_attach }" >
		</c:otherwise>
	</c:forEach>
	 --%>
</div>