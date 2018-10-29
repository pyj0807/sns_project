<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<%--  to .<h1 class="h5">${otherId }</h5> --%>
	<h5 class="h5"><b>방제목</b> : <small><b> ${contentid }</b></small></h5>
	<div class="btn-toolbar mb-2 mb-md-0">
		
		
<!-- 		<button class="btn btn-sm btn-outline-secondary dropdown-toggle">
			<span data-feather="calendar">전체채팅</span> 
				<span data-feather="calendar">부서채팅</span> 
		</button> -->
		
<div class="btn-group" role="group">
    <button id="btnGroupDrop1" type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
     오픈채팅 목록
    </button>
     
    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
    
    
  
  <%--   <c:forEach var="v" items="${chatlist }">
    ${v }
    </c:forEach> --%>
   <c:forEach var="v" items="${allclub}">
   
      <a class="dropdown-item" href="${pageContext.servletContext.contextPath}/club/clubview.do?id=${v._id}"> ${v._id }</a>
 
    </c:forEach>
      
    </div>
  </div>
	</div>
	
	
</div>
 
 
<h4>Open Chat Room <small id="ho"></small></h4>
<div style="height: 520px; overflow-y: scroll; width: 500px " id="chatView">
	<c:forEach var="v" items="${clubchating }">
		
		<c:choose>
		<c:when test="${userId eq v.ID}">
				<div class="alert alert-secondary" role="alert" style="padding:3px; margin-bottom:3px;">
		<b>${v.ID }<a href="${pageContext.servletContext.contextPath}/mypage.do?"><small><b>(${v.userNAME})</b></small></a> : ${v.content }  / <small><b>${v.sendtime}</b></small></b>
		</div>
		</c:when>
		<c:otherwise>
		<div class="alert alert-secondary" role="alert" style="padding:3px; margin-bottom:3px;">
		<b>${v.ID }<a href="${pageContext.servletContext.contextPath}/account.do?id=${v.ID}"><small><b>(${v.userNAME})</b></small></a> : ${v.content }  / <small><b>${v.sendtime}</b></small></b>
		</div>
		
		</c:otherwise>
		</c:choose>
	</c:forEach>


</div>

<hr/>
<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">CHAT</span>
  </div>
  <input type="text" class="form-control" aria-describedby="basic-addon1"
  	id="input" >
</div>

	<c:choose>
		<c:when test="${!empty best }">
		<form action="${pageContext.servletContext.contextPath}/club/remove.do">
		<input type="hidden" name = "contentid" value="${contentid }">
  <button type="submit" class="btn btn-secondary btn-lg btn-block" >방 없애기</button>
		</form>
		</c:when>
		<c:otherwise>
		<form action="${pageContext.servletContext.contextPath}/club/all.do">
		 <button type="submit" class="btn btn-secondary btn-lg btn-block">방 나가기</button>
		
		</form>
		</c:otherwise>
	</c:choose>

<script>
	var clubchatws= new WebSocket("ws://"+location.host+"${pageContext.servletContext.contextPath}/clubchating.do");

	clubchatws.onmessage= function(evt) {
		console.log(evt.data);
		var obj = JSON.parse(evt.data);
		
		switch(obj.mode){
		case "${contentid}":
			conhandle(obj);
		break;
		};
		
		
	}
	var conhandle=function(obj){
		var html="<div class=\"alert alert-secondary\" role=\"alert\" style=\"padding:3px; margin-bottom:3px;\">";
		html += "<b>"+obj.ID+"<a href=\"${pageContext.servletContext.contextPath}/mypage.do\">"+"<small><b>("+obj.userNAME+")</b></small></a> : "+obj.content+" / <small><b>"+obj.sendtime+"</b></small>"+"</b>"
		html +="</div>"; 
		document.getElementById("chatView").innerHTML += html;
		document.getElementById("chatView").scrollTop = 
			document.getElementById("chatView").scrollHeight; 
	}
	
	

/* var chatws = new WebSocket("ws://"+location.host+"${pageContext.servletContext.contextPath}/chating.do");

chatws.onmessage= function(evt) {
	console.log(evt.data);
	var obj = JSON.parse(evt.data);
	
	console.log("시간이유"+obj.sendtime);
	
	
	
	var html="<div class=\"alert alert-secondary\" role=\"alert\" style=\"padding:3px; margin-bottom:3px;\">";
	html += "<b>"+obj.id+"<a href=\"${pageContext.servletContext.contextPath}/mypage.do\">"+"<small><b>("+obj.userNAME+")</b></small></a> : "+obj.text+" / <small><b>"+obj.sendtime+"</b></small>"+"</b>"
	html +="</div>"; 
	document.getElementById("chatView").innerHTML += html;
	document.getElementById("chatView").scrollTop = 
		document.getElementById("chatView").scrollHeight; 
	
}  */

document.getElementById("input").onchange= function() {
	console.log(this.value);
	var msg=null;
	/* var aa="HumanResources";
	var bb="${depart}";
	var cc="public"; */
	
	/* console.log(aa==bb);
	console.log(bb==cc);
	console.log(aa);
	console.log(cc);
	 */
	
		 
		 msg = {
			 	"mode" :"${contentid}",
				"id":"${userId}",
				"content":this.value,
				"contentid":"${contentid}"
				
			};
	 /* console.log(JSON.stringify(msg)); */
	 clubchatws.send(JSON.stringify(msg));
		 this.value=""; 
	
			

	
};

</script>

