<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<nav class="navbar navbar-dark bg-dark">
	<a class="navbar-brand"
		href="${pageContext.servletContext.contextPath}">Never expand <span
		class="badge badge-pill badge-primary" id="countt"></span></a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarsExample01" aria-controls="navbarsExample01"
		aria-expanded="false" aria-label="Toggle navigation"
		onclick="selectt();">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarsExample01">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="#">Home
					<span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.servletContext.contextPath }/mypage.do">MyPage</a>
			</li>
			<li class="nav-item dropdown"><a onclick="slected"
				class="nav-link dropdown-toggle" href="http://example.com"
				id="dropdown01" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false">채팅 <span
					class="badge badge-pill badge-primary" id="count"></span></a>
				<div class="dropdown-menu" aria-labelledby="dropdown01">
					<a class="dropdown-item"
						href="${pageContext.servletContext.contextPath}/chat/freechat.do">개인채팅
						<span class="badge badge-pill badge-primary" id="counttt"></span>
					</a> <a class="dropdown-item"
						href="${pageContext.servletContext.contextPath}/club/all.do">오픈채팅</a>
				</div></li>
		</ul>
		<form class="form-inline my-2 my-md-0" action="${pageContext.servletContext.contextPath}/account.do" onchange="pass();">
			<input class="form-control" type="text" placeholder="Search" list="some"
				 autocomplete="off" id="searchlist" name="id" >
				<!-- <input class="form-control" type="text" placeholder="Search" list="some"
				aria-label="Search" autocomplete="off" id="searchlist" name="id" > -->
				<datalist id="some">
				
			</datalist>
			
		</form>
	</div>
</nav>
<script>
$("#searchlist").on("keyup",function(){
	console.log($("#searchlist").val());
	var search=$("#searchlist").val();
	var param ={
			"value":search
			
	};
	
	$.post("${pageContext.servletContext.contextPath}/searchAjax.do",param,function(rst){
		var html="";
		/* var obj =JSON.parse(rst); */
		 /* c원onsole.log(obj); */ 
		 var id=rst.idlist;
		 var list =rst.taglist;
		 /* console.log(list); */
		 /* console.log("하하하하하="+id); */
		
		   for(var i=0;i<id.length;i++){
			html+="<option value=\""+id[i].ID+"\">"+id[i].ID+"("+id[i].NAME+")</option>";
		};   
		
		
		 
		 for(var ii=0;ii<list.length;ii++){
		
			html+= "<option value=\""+list[ii]+"\">"+"("+list[ii]+")</option>"
		}; 
	
		
			$("#some").html(html);
		
	});
	
});

/* $("#pass").on("change",function(){
	window.location.href="${pageContext.servletContext.contextPath}/mypage.do?id="+$("#id").val();
	
}) */

var pass=function(){
	var a=$("#searchlist").val();
	var r1= new RegExp(/^[#]/);

		
	
	
		/* window.location.href="${pageContext.servletContext.contextPath}/mypage.do?id="+a; */
		
	
	
}

</script>

<script>



	var ws = new WebSocket("ws://" + location.host
			+ "${pageContext.servletContext.contextPath}/all.do");

	ws.onmessage = function(evt) {
		console.log(evt.data);
		var obj = JSON.parse(evt.data);
		switch (obj.mode) {
		case "erlogin":
			errLoginHandle(obj);
			break;

		case "count":
			countHandler(obj);
			break;

		}

	}

	var slected = function() {
		document.getElementById("count").innerHTML = "";
	}

	var selectt = function() {
		document.getElementById("countt").innerHTML = "";
	}

	var countHandler = function(obj) {
		if (obj.defaultcnt > 0) {
			var html = "<b>new </b>" + obj.defaultcnt
			var htmll = "<small><b>new </b></small>";
			document.getElementById("count").innerHTML = htmll;
			document.getElementById("countt").innerHTML = htmll;
			document.getElementById("counttt").innerHTML = html;
		}
	}

	var errLoginHandle = function(obj) {
		window.alert(" 다른곳에서 로그인을 시도하였습니다.");
		window.location.href = "${pageContext.servletContext.contextPath}/index.do";

	}
</script>