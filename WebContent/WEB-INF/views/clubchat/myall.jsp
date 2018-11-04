<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
    <link rel="stylesheet" type="text/css"
	href="${pageContext.servletContext.contextPath}/semantic/semantic.css">
    
    
    
    
    <br/>
    <br/>
    <br/>
    <br/>
    
     <section class="text-center" style="height: 300px; width: auto; " >
        <div class="container" >
          <h1 class="jumbotron-heading">Open Chat</h1>
          <p class="lead text-muted">마음이 맞는 사람과 <br/>채팅을 해 보아요.</p>
          <p>
            <a href="${pageContext.servletContext.contextPath }/club/create.do" class="btn btn-primary">오픈채팅방 만들기</a>
            
          </p>
          <p>
            <a href="${pageContext.servletContext.contextPath }/chat/freechat.do?cluballon=on" class="btn btn-secondary">전체 오픈채팅</a>
        	</p>
        </div>
      </section>
    
    
    
    <div class="container">
<div style="overflow:scroll;overflow-x:hidden;max-height:300px;">




<hr/>

<c:forEach var="v" items="${clubmyAll }">
<ul class="list-unstyled" >
  <li class="media" >
   <a href="${pageContext.servletContext.contextPath }/club/clubview.do?id=${v._id}">  <img class="mr-3" style="height: 70px; width: auto;" src="${v.attach }" alt="Generic placeholder image"></a>
    <div class="media-body">
    <br/>
      <h5 class="mt-0 mb-1"> <b>▶ 방제목 : </b> ${v._id}  
  방 인원 : <span class="badge badge-pill badge-info"> ${fn:length(v.agency)} </span>    
 
       </h5>
   
     
    </div>
  </li><br/>
  </c:forEach>
  <hr/>

  </div>
  </div>