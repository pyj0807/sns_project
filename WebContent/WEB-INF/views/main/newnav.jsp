<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

     <link rel="stylesheet" type="text/css" href="semantic/semantic.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
    <script src="semantic/semantic.js"></script>

<div class="ui attached stackable menu">
  <div class="ui container">
    <a class="item" href="${pageContext.servletContext.contextPath}">
   	<span class="badge badge-pill badge-primary" id="countt"></span>
      <i class="home icon"></i> Home
    </a>
    <a class="item" href="${pageContext.servletContext.contextPath }/mypage.do">
      <i class="user icon"></i> MyPage
    </a>
    <a class="item" href="${pageContext.servletContext.contextPath }/liked.do">
      <i class="heart icon"></i> Liked
    </a>
    <div class="ui simple dropdown item">
      Chat
      <i class="dropdown icon"></i>
      <div class="menu">
        <a class="item" href="${pageContext.servletContext.contextPath}/chat/freechat.do">
        <i class="users icon"></i> 개인 채팅</a>
        <a class="item" href="${pageContext.servletContext.contextPath}/club/all.do">
        <i class="globe icon"></i> 오픈 채팅</a>
      </div>
    </div>
    <div class="right item">
      <div class="ui input">
		<form class="form-inline my-2 my-md-0" action="${pageContext.servletContext.contextPath}/account.do" onchange="pass();">
			<input class="form-control" type="text" placeholder="Search" list="some"
				 autocomplete="off" id="searchlist" name="id" >
				<!-- <input class="form-control" type="text" placeholder="Search" list="some"
				aria-label="Search" autocomplete="off" id="searchlist" name="id" > -->
				<datalist id="some"></datalist>
		</form>
	</div>
    </div>
  </div>
</div>


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
	if(id.length<15){
		   for(var i=0;i<id.length;i++){
			html+="<option value=\""+id[i].ID+"\">"+id[i].ID+"("+id[i].NAME+")</option>";
	};
	}
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
		case "zzz":
			removeHandler(obj);
		break;
		}
	}
	var removeHandler=function(){
		document.getElementById("count").innerHTML = "";
		document.getElementById("countt").innerHTML = "";
		document.getElementById("counttt").innerHTML = "";
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