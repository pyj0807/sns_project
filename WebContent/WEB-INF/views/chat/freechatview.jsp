<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<%--  to .<h1 class="h5">${otherId }</h5> --%>
	<h5 class="h5"> to . ${otherId }</h5>
	<div class="btn-toolbar mb-2 mb-md-0">
		
		
<!-- 		<button class="btn btn-sm btn-outline-secondary dropdown-toggle">
			<span data-feather="calendar">전체채팅</span> 
				<span data-feather="calendar">부서채팅</span> 
		</button> -->
		
<div class="btn-group" role="group">
    <button id="btnGroupDrop1" type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      팔로우 목록
    </button>
    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
    
  <%--   <c:forEach var="v" items="${chatlist }">
    ${v }
    </c:forEach> --%>
   <c:forEach var="v" items="${chatlist}">
   <c:if test="${v.EMAIL != userId }">
      <a class="dropdown-item" href="${pageContext.servletContext.contextPath}/chat/freechatview.do?id=${v.EMAIL}"> ${v.EMAIL }</a>
   </c:if>
    </c:forEach>	`
      
    </div>
  </div>
	</div>
	
	
</div>
 
 
<h4>Chat Room <small id="ho">(??)</small></h4>
<div style="height: 520px; overflow-y: scroll; width: 500px " id="chatView">
	<c:forEach var="v" items="${allchat }">
		
		<c:choose>
		<c:when test="${userId eq v.id}">
				<div class="alert alert-secondary" role="alert" style="padding:3px; margin-bottom:3px;">
		<b>${v.id }<a href="${pageContext.servletContext.contextPath}/mypage.do?"><small><b>(${v.userNAME})</b></small></a> : ${v.text }  / <small><b><fmt:formatDate value="${v.jspsendtime}" pattern="yyyy-MM-dd HH:mm"/></b></small></b>
		</div>
		</c:when>
		<c:otherwise>
		<div class="alert alert-secondary" role="alert" style="padding:3px; margin-bottom:3px;">
		<b>${v.id }<a href="${pageContext.servletContext.contextPath}/account.do?id=${v.id}"><small><b>(${v.userNAME})</b></small></a> : ${v.text }  / <small><b><fmt:formatDate value="${v.jspsendtime}" pattern="yyyy-MM-dd HH:mm"/></b></small></b>
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

<script>
var chatws = new WebSocket("ws://"+location.host+"${pageContext.servletContext.contextPath}/chating.do");

chatws.onmessage= function(evt) {
	console.log(evt.data);
	var obj = JSON.parse(evt.data);
	/* var html = "<div class=\"alert alert-secondary\" role=\"alert\" style=\"padding:3px; margin-bottom:3px;\">";
	html += obj.id+" : "+obj.text ;
	html +="</div>"; */
	console.log("시간이유"+obj.sendtime);
	
	/* switch(evt.mode){
	case "${otherId}":
		otherchatHandler(){
		
		
	}
	
	} */
	
	var html="<div class=\"alert alert-secondary\" role=\"alert\" style=\"padding:3px; margin-bottom:3px;\">";
	html += "<b>"+obj.id+"<a href=\"${pageContext.servletContext.contextPath}/mypage.do\">"+"<small><b>("+obj.userNAME+")</b></small></a> : "+obj.text+" / <small><b>"+obj.sendtime+"</b></small>"+"</b>"
	html +="</div>"; 
	document.getElementById("chatView").innerHTML += html;
	document.getElementById("chatView").scrollTop = 
		document.getElementById("chatView").scrollHeight; 
	
} 

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
			 	"mode" :"other",
				"id":"${userId}",
				"text":this.value,
				"otherId":"${otherId}"
				
			};
	 /* console.log(JSON.stringify(msg)); */
	 chatws.send(JSON.stringify(msg));
		 this.value=""; 
	
			

	
};

</script>

