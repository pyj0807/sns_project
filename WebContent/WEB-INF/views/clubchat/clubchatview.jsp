<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="modal fade  bd-example-modal-lg " id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog  modal-lg ">
    <div class="modal-content">
      <div class="modal-body">
        ...
      </div>
    </div>
  </div>
</div>
<script>
	// 모달에 불러와지는 링크 JQuery
	$("#myModal").on("show.bs.modal", function(e) {
	    console.log("모달이 열림! 디스가뭐지"+this);
	    var link = $(e.relatedTarget);
	    $(this).find(".modal-body").load(link.attr("href"));
	});
 	$('#myModal').on('hidden.bs.modal', function (e) { 
		  $(this).removeData('.modal'); 
		 console.log("모달 gg");
	}); 
	// 모달에 불러와지는 링크 JQuery
	$("#exampleModalCenter").on("show.bs.modal", function(e) {
	    console.log("exampleModalCenter 모달이 열림! 디스가뭐지"+this);
	    var link = $(e.relatedTarget);
	    $(this).find(".modal-body").load(link.attr("href"));
	});
 	$('#exampleModalCenter').on('hidden.bs.modal', function (e) { 
		  $(this).removeData('.modal'); 
		 console.log("exampleModalCenter 모달 gg");
	}); 
</script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.servletContext.contextPath}/semantic/semantic.css">
<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<%--  to .<h1 class="h5">${otherId }</h5> --%>
	<h5 class="h5"><b>방제목</b> : <small><b> ${contentid }</b></small></h5>
	<div class="btn-toolbar mb-2 mb-md-0">
		
<div class="btn-group" role="group">
    <button id="btnGroupDrop1" type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
     오픈채팅 목록
    </button>
     
    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
    
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
		<c:when test="${roommainid eq userId }">
				<div role="alert" style="padding: 10px; margin-bottom: 10px;"
					align="right">
			<a href="${pageContext.servletContext.contextPath}/account.do?id=${v.ID}">
			<span class="badge badge-pill badge-success">${v.userNAME}(${v.ID })</span><i class="chess queen icon"></i></a><br/>
			<span style="font-size: x-large;" class="badge badge-secondary">
			${v.content } / <small><b>${v.sendtime}</b></small></b>
					</span>
				</div>
		
		</c:when>
		<c:otherwise>
		<div role="alert" style="padding: 10px; margin-bottom: 10px;"
					align="right">
			<a href="${pageContext.servletContext.contextPath}/account.do?id=${v.ID}">
			<span class="badge badge-pill badge-success">${v.userNAME}(${v.ID })</span></a><br/>
			<span style="font-size: x-large;" class="badge badge-secondary">
			${v.content } / <small><b>${v.sendtime}</b></small></b>
				</span>
				</div>
		</c:otherwise>
		</c:choose>
</c:when>
	

	
		<c:otherwise>
		<c:choose>
		<c:when test="${v.ID eq roommainid}">
		<div role="alert" style="padding: 10px; margin-bottom: 10px;"
					align="left">
			<a href="${pageContext.servletContext.contextPath}/account.do?id=${v.ID}">
			<span class="badge badge-pill badge-warning">${v.userNAME}(${v.ID }) </span><i class="chess queen icon"></i></a><br/>
			<span style="font-size: x-large;" class="badge badge-secondary">
			${v.content } / <small><b>${v.sendtime}</b></small></b>
					</span>
				</div>
		
		</c:when>
		
		<c:otherwise>
		<div role="alert" style="padding: 10px; margin-bottom: 10px;"
					align="left">
			<a href="${pageContext.servletContext.contextPath}/account.do?id=${v.ID}">
			<span class="badge badge-pill badge-warning">${v.userNAME}(${v.ID }) </a><br/>
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
		<input type="hidden" name = "contentid" value="${contentid }" id="qqq">
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
	}else{
		var b=window.confirm("방에서 나가시겠습니까?");
		if(b==true){
			window.location.href ="${pageContext.servletContext.contextPath}/chat/freechat.do?"
		}
		
	}
});


$("#abcde").on("click",function(){
	var d=window.confirm("탈퇴 하시겠습니까?");
	
	if(d==true){
		window.location.href ="${pageContext.servletContext.contextPath}/club/removeroomagency.do?contentid="+$("#qqq").val();
	}else{
		var bb=window.confirm("방에서 나가시겠습니까?");
		if(bb==true){
			window.location.href ="${pageContext.servletContext.contextPath}/chat/freechat.do?zz=dd"
		}
	}
	
})







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
		var html="";
		if(obj.ID == "${Id}"){
			if("${roommainid}"=="${Id}"){
				
				html+="<div role=\"alert\" style=\"padding: 10px; margin-bottom: 10px;\"align=\"right\">"
					+"<a href=\"${pageContext.servletContext.contextPath}/account.do?id="+obj.ID+"\">"
					+"<span class=\"badge badge-pill badge-success\">"+obj.userNAME+"("+obj.ID+")"+"</span><i class=\"chess queen icon\"></i></a><br/>"
					+"	<span style=\"font-size: x-large;\" class=\"badge badge-secondary\">"
					+obj.content+" / <small><b>"+obj.sendtime+"</b></small></b>";
					document.getElementById("chatView").innerHTML += html;
					document.getElementById("chatView").scrollTop = 
						document.getElementById("chatView").scrollHeight; 
				
				
				
			}else{
				html+="<div role=\"alert\" style=\"padding: 10px; margin-bottom: 10px;\"align=\"right\">"
					+"<a href=\"${pageContext.servletContext.contextPath}/account.do?id="+obj.ID+"\">"
					+"<span class=\"badge badge-pill badge-success\">"+obj.userNAME+"("+obj.ID+")"+"</span></a><br/>"
					+"	<span style=\"font-size: x-large;\" class=\"badge badge-secondary\">"
					+obj.content+" / <small><b>"+obj.sendtime+"</b></small></b>";
					document.getElementById("chatView").innerHTML += html;
					document.getElementById("chatView").scrollTop = 
						document.getElementById("chatView").scrollHeight;  
			}
			
	}else{
		if("${roommainid}"==obj.ID){
			html+="<div role=\"alert\" style=\"padding: 10px; margin-bottom: 10px;\"align=\"left\">"
				+"<a href=\"${pageContext.servletContext.contextPath}/account.do?id="+obj.ID+"\">"
				+"<span class=\"badge badge-pill badge-warning\">"+obj.userNAME+"("+obj.ID+")"+"</span><i class=\"chess queen icon\"></i></a><br/>"
				+"	<span style=\"font-size: x-large;\" class=\"badge badge-secondary\">"
				+obj.content+" / <small><b>"+obj.sendtime+"</b></small></b>";
				document.getElementById("chatView").innerHTML += html;
				document.getElementById("chatView").scrollTop = 
					document.getElementById("chatView").scrollHeight; 
		}else{
			html+="<div role=\"alert\" style=\"padding: 10px; margin-bottom: 10px;\"align=\"left\">"
				+"<a href=\"${pageContext.servletContext.contextPath}/account.do?id="+obj.ID+"\">"
				+"<span class=\"badge badge-pill badge-warning\">"+obj.userNAME+"("+obj.ID+")"+"</span></a><br/>"
				+"	<span style=\"font-size: x-large;\" class=\"badge badge-secondary\">"
				+obj.content+" / <small><b>"+obj.sendtime+"</b></small></b>";
				document.getElementById("chatView").innerHTML += html;
				document.getElementById("chatView").scrollTop = 
					document.getElementById("chatView").scrollHeight; 
			
		}
		
		
	}
		
		
	}
	

document.getElementById("input").onchange= function() {
	console.log(this.value);
	var msg=null;
		 
		 msg = {
			 	"mode" :"${contentid}",
				"id":"${userId}",
				"content":this.value,
				"contentid":"${contentid}"
				
			};
	 clubchatws.send(JSON.stringify(msg));
		 this.value=""; 
	
			

	
};

</script>

