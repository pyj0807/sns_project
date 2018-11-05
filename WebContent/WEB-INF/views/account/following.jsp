<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- semantic 아이콘 사용위한 스크립트와 link  -->
 <script src="${pageContext.servletContext.contextPath }/semantic/semantic.js"></script>
 <link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/semantic/semantic.css">

<div class="ui middle aligned selection list">
	<c:forEach var="f" items="${requestScope.list }">
		<div class="item">
			<img class="ui avatar image" src="${pageContext.servletContext.contextPath }/pic/${f.PROFILE_ATTACH}">
				<div class="content">
					<div class="header">
						<a href="${pageContext.servletContext.contextPath }/account.do?id=${f.ID}">${f.ID	}</a>
					</div>
			</div>
		</div>
	</c:forEach>
</div>