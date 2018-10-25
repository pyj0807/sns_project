<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<h3>Follower Page</h3>
<br />
<br />
<h5>Follower List</h5>
<br />
<br />
<ul>
	<c:forEach var="f" items="${requestScope.list }">
		<li><a href="${pageContext.servletContext.contextPath }/account.do?id=${f}">${f }</a></li>
	</c:forEach>
</ul>