<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<link rel="stylesheet" type="text/css"
	href="${pageContext.servletContext.contextPath}/semantic/semantic.css">
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
<div style="overflow:scroll;height:600px;"
	id="chatView" >
	<c:forEach var="v" items="${clubchating }">
		
		<c:choose>
		<c:when test="${userId eq v.ID}">
		<c:choose>
		<c:when test="${v.mainid eq userId }">
				<div role="alert" style="padding: 10px; margin-bottom: 10px;"
					align="right">
			<a href="${pageContext.servletContext.contextPath}/account.do?id=${v.ID}">
			<span class="badge badge-pill badge-success">${v.userNAME} </span><i class="chess queen icon"></i></a><br/>
			<span style="font-size: x-large;" class="badge badge-secondary">
			${v.content } / <small><b>${v.sendtime}</b></small></b>
					</span>
				</div>
		
		</c:when>
		<c:otherwise>
		<div role="alert" style="padding: 10px; margin-bottom: 10px;"
					align="right">
			<a href="${pageContext.servletContext.contextPath}/account.do?id=${v.ID}">
			<span class="badge badge-pill badge-success">${v.userNAME} </span></a><br/>
			<span style="font-size: x-large;" class="badge badge-secondary">
			${v.content } / <small><b>${v.sendtime}</b></small></b>
				</span>
				</div>
		</c:otherwise>
		</c:choose>
</c:when>
	

	
		<c:otherwise>
		<c:choose>
		<c:when test="${v.ID eq v.mainid}">
		<div role="alert" style="padding: 10px; margin-bottom: 10px;"
					align="left">
			<a href="${pageContext.servletContext.contextPath}/account.do?id=${v.ID}">
			<span class="badge badge-pill badge-warning">${v.userNAME} </span><i class="chess queen icon"></i></a><br/>
			<span style="font-size: x-large;" class="badge badge-secondary">
			${v.content } / <small><b>${v.sendtime}</b></small></b>
					</span>
				</div>
		
		</c:when>
		
		<c:otherwise>
		<div role="alert" style="padding: 10px; margin-bottom: 10px;"
					align="left">
			<a href="${pageContext.servletContext.contextPath}/account.do?id=${v.ID}">
			<span class="badge badge-pill badge-warning">${v.userNAME} </a><br/>
			<span style="font-size: x-large;" class="badge badge-secondary">
			${v.content } / <small><b>${v.sendtime}</b></small></b>
					</span>
				</div>
		
		</c:otherwise>
		</c:choose>
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
		<input type="hidden" name = "contentid" value="${contentid }" id="qqq">
  <!-- <button type="submit" class="btn btn-secondary btn-lg btn-block" >방 없애기</button> -->
  <button type="button" class="btn btn-secondary btn-lg btn-block" id="abcd">방 없애기</button>
		</form>
		</c:when>
		<c:otherwise>
		<form>
		<!--  <button type="submit" class="btn btn-secondary btn-lg btn-block">방 나가기</button> -->
		 <button type="button" class="btn btn-secondary btn-lg btn-block" id="abcde">방 나가기</button>
		
		</form>
		</c:otherwise>
	</c:choose>

<script>
$('#chatView').scrollTop($('#chatView')[0].scrollHeight - $('#chatView')[0].clientHeight);

$("#abcd").on("click",function(){
	var d=window.confirm("방을 없애시겠습니까?");
	console.log(d);
	if(d==true){
		window.location.href ="${pageContext.servletContext.contextPath}/club/remove.do?contentid="+$("#qqq").val();
	}
});







	var clubchatws= new WebSocket("ws://"+location.host+"${pageContext.servletContext.contextPath}/clubchating.do");
var html="";
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
		
		if(obj.ID == "${Id}"){
			if(obj.mainid=="${Id}"){
				 html="<div class=\"alert alert-secondary\" role=\"alert\" style=\"padding:3px; margin-bottom:3px;\">";
					html += "<b>"+obj.ID+"<a href=\"${pageContext.servletContext.contextPath}/mypage.do\">"+"<small><b>("+obj.userNAME+")</b></small></a> : "+obj.content+" / <small><b>"+obj.sendtime+"</b></small>"+"</b>"
					html +="</div>"; 
					document.getElementById("chatView").innerHTML += html;
					document.getElementById("chatView").scrollTop = 
						document.getElementById("chatView").scrollHeight; 
				
				
				
			}else{
		 html="<div class=\"alert alert-secondary\" role=\"alert\" style=\"padding:3px; margin-bottom:3px;\">";
		html += "<b>"+obj.ID+"<a href=\"${pageContext.servletContext.contextPath}/mypage.do\">"+"<small><b>("+obj.userNAME+")</b></small></a> : "+obj.content+" / <small><b>"+obj.sendtime+"</b></small>"+"</b>"
		html +="</div>"; 
		document.getElementById("chatView").innerHTML += html;
		document.getElementById("chatView").scrollTop = 
			document.getElementById("chatView").scrollHeight; 
			}
			
	}else{
		 html="<div class=\"alert alert-secondary\" role=\"alert\" style=\"padding:3px; margin-bottom:3px;\">";
			html += "<b>"+obj.ID+"<a href=\"${pageContext.servletContext.contextPath}/mypage.do\">"+"<small><b>("+obj.userNAME+")</b></small></a> : "+obj.content+" / <small><b>"+obj.sendtime+"</b></small>"+"</b>"
			html +="</div>"; 
			document.getElementById("chatView").innerHTML += html;
			document.getElementById("chatView").scrollTop = 
				document.getElementById("chatView").scrollHeight; 
		
		
	}
		
		
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

