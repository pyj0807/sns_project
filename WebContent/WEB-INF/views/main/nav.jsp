<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="ui attached stackable menu">
  <div class="ui container">
    <a class="item" href="${pageContext.servletContext.contextPath}">
   	<span class="badge badge-pill badge-primary" id="countt"></span>
      <i class="home icon" onclick="selectt();"></i> Home
    </a>
    <a class="item" href="${pageContext.servletContext.contextPath }/mypage.do">
      <i class="user icon"></i> MyPage
    </a>
    <a class="item" href="${pageContext.servletContext.contextPath }/chat/freechat.do">
      <i class="comments outline icon"></i> Chat　<span class="badge badge-pill badge-primary" id="counttt"></span>
    </a>
    <a class="item" href="${pageContext.servletContext.contextPath }/newsfeed.do"">
      <i class="users icon"></i>NewsFeed
    </a>
    <!-- 알림 -->
 	 <div class="ui simple dropdown item">
		 <i class="github icon" ></i>뀨?
   		<div class="menu" style="overflow:scroll; overflow-x:hidden; max-height:200px;" >
     		<span id="alert" > </span>
		<a role="alert" class="dropdown-item" href="${pageContext.servletContext.contextPath}/interest.do?theme="></a>
       </div>
  </div>
 <!--   //== -->
	<div class="ui simple dropdown item">
		<i class="hashtag icon"></i>관심사
	      <div class="menu">
	      <c:forEach var="v" items="${allInter}">
				<a class="dropdown-item" href="${pageContext.servletContext.contextPath}/interest.do?theme=${v}">${v}</a>
	      </c:forEach>
	      </div>
    </div>
<%--     <div class="ui simple dropdown item">
      Chat
      <i class="dropdown icon"></i>
      <div class="menu">
        <a class="item" href="${pageContext.servletContext.contextPath}/chat/freechat.do">
        <i class="users icon"></i> 개인 채팅</a>
        <a class="item" href="${pageContext.servletContext.contextPath}/club/all.do">
        <i class="globe icon"></i> 오픈 채팅</a>
      </div>
    </div> --%>
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
	var ws = new WebSocket("ws://" + location.host+ "${pageContext.servletContext.contextPath}/all.do");
	ws.onmessage = function(evt) {
		/* console.log(evt.data); */
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
		
		case "followinglike":
			followHandler(obj);
			break;
		case "defaultalert":
			defaultalertHandler(obj);
			break;
		}
		
	}
	var defaultalertHandler=function(obj){
		var html="";
		var like="like";
		var follow="follow";
		var o=document.getElementById("alert").innerHTML;
		console.log("V팔루오"+follow);
		var s=obj.str;
		for(var i=0;i<s.length;i++){
			console.log("이게바로 그거입니다그거+"+s[i].senddatejsp);
			if(s[i].moded==follow){
				html+="<hr/><div role=\"alert\">";
				html+="<a  class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/account.do?id="+s[i].id+"\">"+s[i].id+s[i].content+"</a>";
				html+="<div align=\"right\"><small >"+s[i].senddatejsp+"</small></div>";			
				html+="</div><hr/>"+o;
			
			}else{
				html+="<hr/><div role=\"alert\">";
				html+="<a  class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/board/board_detail.do?num="+s[i].num+"\">"+s[i].id+s[i].content+"</a>";
				html+="<div align=\"right\"><small >"+s[i].senddatejsp+"</small></div>";	
				html+="</div><hr/>"+o;
			}
		}
		document.getElementById("alert").innerHTML = html; 
		
	}
	
	
	
	var followHandler=function(obj){
		console.log("꺄르르르르르르르르르르르르르르를="+obj.id);
		var html="";
		var o=document.getElementById("alert").innerHTML;
		if(obj.moded==follow){
		html+="<hr/><div role=\"alert\">";
		html+="<a  class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/account.do?id="+obj.id+"\">"+obj.id+obj.content+"</a>";
		html+="<div align=\"right\"><small >"+obj.senddatejsp+"</small></div>";
		html+="</div><hr/>"+o;
		}else{
			html+="<hr/><div role=\"alert\">";
			html+="<a  class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/board/board_detail.do?num="+obj.num+"\">"+obj.id+obj.content+"</a>";
			html+="<div align=\"right\"><small >"+obj.senddatejsp+"</small></div>";	
			html+="</div><hr/>"+o;
			
		}
		document.getElementById("alert").innerHTML = html; 
		
		/* console.log("꾜로로로ㅗ"+o); */
		
		
	};
	

	var countHandler = function(obj) {
		if (obj.defaultcnt > 0) {
			var html = "<b>new </b>    " + obj.defaultcnt;
			var htmll = "<small><b>new </b></small>";
		
			document.getElementById("counttt").innerHTML = html;
		}else{
			var html=""
				document.getElementById("counttt").innerHTML = html;
		}
	}
	var removeHandler=function(obj){
		var html = "<b>new </b>    " + obj.defaultcnt;
		document.getElementById("counttt").innerHTML =html ;
	}
	var errLoginHandle = function(obj) {
		window.alert(" 다른곳에서 로그인을 시도하였습니다.");
		window.location.href = "${pageContext.servletContext.contextPath}/index.do";
	}
</script>

<%-- 
<nav class="navbar navbar-light">
	<a class="navbar-brand"
		href="${pageContext.servletContext.contextPath}">Never expand</a>
		 <!-- <span class="badge badge-pill badge-primary" id="countt"></span> -->

	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarsExample01" aria-controls="navbarsExample01"
		aria-expanded="false" aria-label="Toggle navigation"
		onclick="selectt();">
		<span class="navbar-toggler-icon"></span>
	</button>

	<a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a> 
	<a class="nav-link" href="${pageContext.servletContext.contextPath }/mypage.do">MyPage</a>
	<a class="nav-link" href="${pageContext.servletContext.contextPath}/chat/freechat.do">개인채팅
	<span class="badge badge-pill badge-primary" id="counttt"></span> </a> 
	<form class="form-inline my-2 my-md-0" action="${pageContext.servletContext.contextPath}/account.do" onchange="pass();">
	<input class="form-control" type="text" placeholder="Search" list="some" autocomplete="off" id="searchlist" name="id">
	<datalist id="some"></datalist>
	</form>
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
=======
		var html = "<b>new </b>" + obj.defaultcnt
		var htmll = "<small><b>new </b></small>";
		document.getElementById("count").innerHTML = htmll;
		document.getElementById("countt").innerHTML = htmll;
		document.getElementById("counttt").innerHTML = html;
		
>>>>>>> refs/remotes/origin/pkk42
	}
	var slected = function() {
		document.getElementById("count").innerHTML = "";
	}
/* 	var selectt = function() {
		document.getElementById("countt").innerHTML = "";
	} */
	var countHandler = function(obj) {
		if (obj.defaultcnt > 0) {
			var html = "<b>new </b>" + obj.defaultcnt
			var htmll = "<small><b>new </b></small>";
			document.getElementById("counttt").innerHTML = html;
		}
	}
	var errLoginHandle = function(obj) {
		window.alert(" 다른곳에서 로그인을 시도하였습니다.");
		window.location.href = "${pageContext.servletContext.contextPath}/index.do";
	}
</script> --%>