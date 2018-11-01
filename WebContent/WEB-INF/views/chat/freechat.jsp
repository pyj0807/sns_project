<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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
		
      <a class="dropdown-item" href="${pageContext.servletContext.contextPath}/chat/freechatview.do?id=${v.OTHERID}">${v.OTHERID }</a>
   
	
		</c:forEach>
    </div>
  </div>
  <div align="center">

  </div>
  
  
  <div style=" height: 520px; overflow-y: scroll;">
  	<table class="table table-hover ">
  <thead>
    <tr>
	 
      <th scope="col">이름</th>
      <th scope="col">시간</th>
      <th scope="col" width="7%">알림</th>
    </tr>
  </thead>
  
  <tbody>
  
     <c:forEach var ="v" items="${freelist}">
    
  <c:if test="${!empty v }">
 	<c:forEach var ="e" items="${v.modeId }">
 	
 	
 	<c:if test="${e ne Id}">
 	<c:choose>
 	
 	<c:when test="${v.num<1 }">
 	 		
 	 		    <tr>
      <td class="table-secondary"><a href="${pageContext.servletContext.contextPath}/chat/freechatview.do?id=${e}">${e }</a> </td>
      <td class="table-secondary"><small>시간 :<b>${v.lastformat } </b></small></td>
      <td class="table-secondary"></td>
    </tr>
 	</c:when>
 	<c:otherwise>
 	
 		 
 		<tr>
      <td class="table-success"><a href="${pageContext.servletContext.contextPath}/chat/freechatview.do?id=${e}">${e }</a></td>
      <td class="table-success" ><small>시간 :<b>${v.lastformat } </b></small></td>
      <td class="table-success ">  <span class="badge badge-danger">    ${v.num }</span></td>
    </tr>
 	
 	</c:otherwise>
 	
 	</c:choose>
 	
 	
 	</c:if>
 	
 
 	</c:forEach> 
 	</c:if>
  </c:forEach>
  </tbody>
  </div>
</table>
		
	
	
	
		<%-- <c:forEach var="v" items="${frends}">
		<c:if test="${v.EMAIL != userId }">
		<a href="${pageContext.servletContext.contextPath}/chat/freechatview.do?id=${v.EMAIL}">${v.EMAIL } : ${v.NAME }</a><br/>
		
		</c:if>
	
		</c:forEach> --%>
		
		
		
</body>
</html>


 <%--      <c:if test = "${fn:contains(theString, 'test')}" --%>