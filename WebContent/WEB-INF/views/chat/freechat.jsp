<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
		<br/>
		<br/>
		 <div class="btn-group" role="group" align="center">
    <button style="align-content: center;" id="btnGroupDrop1" type="button"  class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      팔로우 목록
    </button>
    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
    <c:forEach var="v" items="${frends}">
		<c:if test="${v.EMAIL != userId }">
      <a class="dropdown-item" href="${pageContext.servletContext.contextPath}/chat/freechatview.do?id=${v.EMAIL}">${v.EMAIL } : ${v.NAME }</a>
     </c:if>
	
		</c:forEach>
    </div>
  </div>
		
	
	
	
		<%-- <c:forEach var="v" items="${frends}">
		<c:if test="${v.EMAIL != userId }">
		<a href="${pageContext.servletContext.contextPath}/chat/freechatview.do?id=${v.EMAIL}">${v.EMAIL } : ${v.NAME }</a><br/>
		
		</c:if>
	
		</c:forEach> --%>
		
		
		
</body>
</html>