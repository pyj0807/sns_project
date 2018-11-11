<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<div class="container">
<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h5 class="h5">from . ${userId } ▶  to . ${otherId }</h5>	
	<div class="btn-toolbar mb-2 mb-md-0">

		<div class="btn-group" role="group">
			  <button id="btnGroupDrop1" type="button"
				class="btn btn-secondary dropdown-toggle" data-toggle="dropdown"
				aria-haspopup="true" aria-expanded="false">팔로우 목록</button>
			<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">

				<c:forEach var="v" items="${friends}">
					<c:if test="${v.OTHERID != otherid }">
						<a class="dropdown-item"
							href="${pageContext.servletContext.contextPath}/chat/freechatview.do?id=${v.OTHERID}">
							${v.OTHERID }</a>
					</c:if>
				</c:forEach>

			</div>
		</div>
	</div>
	</div>
	




<div style="overflow:scroll;overflow-x:hidden;height:600px;"
	id="chatView" >
	<c:forEach var="v" items="${allchat }">

		<c:choose>
			<c:when test="${userId eq v.id}">
				<div role="alert" style="padding: 10px; margin-bottom: 10px;"
					align="right">
					<a href="${pageContext.servletContext.contextPath}/account.do?id=${v.id}">
					<span class="badge badge-pill badge-success">${v.userNAME}(${v.id })</span></a><br/>
					
					<span style="font-size: x-large;" class="badge badge-secondary">
				
					${v.text } / <small><b>${v.sendtime}</b></small></b>

				</span>
			
				
				
				</div>
			</c:when>
			<c:otherwise>
				<div role="alert" style="padding: 10px; margin-bottom: 10px;" align="left">
						<a href="${pageContext.servletContext.contextPath}/account.do?id=${v.id}">
					<span class="badge badge-pill badge-warning">${v.userNAME}(${v.id })</span></a><br/>
				<span style="font-size: x-large;" class="badge badge-secondary">
					
					${v.text } / <small><b>${v.sendtime}</b></small></b>

				</span>
				
				</div>

			</c:otherwise>
		</c:choose>
	</c:forEach>


</div>


<hr />
<div class="input-group mb-3">
	<div class="input-group-prepend">
		<span class="input-group-text" id="basic-addon1">CHAT</span>
	</div>
	<input type="text" class="form-control" aria-describedby="basic-addon1"
		id="input">
</div>
</div>
<script>


$('#chatView').scrollTop($('#chatView')[0].scrollHeight - $('#chatView')[0].clientHeight);



	var chatws = new WebSocket("ws://" + location.host
			+ "${pageContext.servletContext.contextPath}/chating.do");

	chatws.onmessage = function(evt) {
		console.log(evt.data);
		var obj = JSON.parse(evt.data);
		console.log("시간이유" + obj.sendtime);

		switch (obj.mode) {
		case "${otherId}":
			otherchatHandler(obj);
			break;

		}

		switch (obj.id) {
		case "${otherId}":
			mychatHandler(obj);
			break;
		}

		switch (obj.receive) {
		case "${Id}":
			receiveHandler(obj);
			break;

		}

	}

	var receiveHandler = function(obj) {
		var req = new XMLHttpRequest();
		req
				.open(
						"get",
						"${pageContext.servletContext.contextPath}/chat/chatremovecontroller.do?id=${Id}&otherId=${otherId}",
						true);
		var param = {
			"id" : "${Id}",
			"otherid" : "${otherId}"
		}
		req.send();
	};

	var mychatHandler = function(obj) {
		var html = "<div role=\"alert\" style=\"padding: 10px; margin-bottom: 10px;\" align=\"left\">";
		html += 
				
				 "<a href=\"${pageContext.servletContext.contextPath}/account.do?id="+obj.id+"\">"
				+ "<span class=\"badge badge-pill badge-warning\">"+obj.userNAME+"("+obj.userId+")"+"</span></a><br/>"
				+"<span style=\"font-size: x-large;\" class=\"badge badge-secondary\">"
				+ obj.text+" / " + "<small><b>"+obj.sendtime+"</b></small></span></div></b> ";
		
		document.getElementById("chatView").innerHTML += html;
		document.getElementById("chatView").scrollTop = document
				.getElementById("chatView").scrollHeight;

	}

	var otherchatHandler = function(obj) {

		var html = "<div role=\"alert\" style=\"padding: 10px; margin-bottom: 10px;\" align=\"right\">";
		html += 
				
				 "<a href=\"${pageContext.servletContext.contextPath}/account.do?id="+obj.id+"\">"
				+ "<span class=\"badge badge-pill badge-success\">"+obj.userNAME+"("+obj.userId+")"+"</span></a><br/>"
				+"<span style=\"font-size: x-large;\" class=\"badge badge-secondary\">"
				+ obj.text+" / " + "<small><b>"+obj.sendtime+"</b></small></span></div></b> ";
		
		document.getElementById("chatView").innerHTML += html;
		document.getElementById("chatView").scrollTop = document
				.getElementById("chatView").scrollHeight;
	}

	document.getElementById("input").onchange = function() {
		console.log(this.value);
		var msg = null;

		msg = {
			"mode" : "${otherId}",
			"id" : "${Id}",
			"text" : this.value,
			"otherId" : "${otherId}"

		};
		chatws.send(JSON.stringify(msg));
		this.value = "";

	};
</script>

