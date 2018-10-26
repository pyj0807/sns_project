<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<div>
	좋아요한 사람들<br/>
	<c:forEach var="i" items="${likes }">
		<li>
			<a href="${pageContext.servletContext.contextPath }/account.do?id=${i }">${i }</a><br/>
		</li>	
	</c:forEach>
</div>