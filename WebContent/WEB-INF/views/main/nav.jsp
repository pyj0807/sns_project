<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>
		<!-- semantic 아이콘 사용위한 스크립트와 link  -->
 <script src="${pageContext.servletContext.contextPath }/semantic/semantic.js"></script>
 <link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/semantic/semantic.css">
		
<style>
.photoo {
	width: 40px;
	height: 40px;
	object-fit: cover;
	border-radius: 40%;
}
</style>
<link href="https://fonts.googleapis.com/css?family=Lobster"
	rel="stylesheet">

<div class="ui attached stackable menu" >
  <div class="ui container" >
    <a class="item" href="${pageContext.servletContext.contextPath}">

      <!-- <i class="home icon" onclick="selectt();" id="homeicon"></i> Home -->
      <img src="${pageContext.servletContext.contextPath}/clubimg/zzz.png" style="width: 70px; height: 50px">
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
 	 <div class="ui simple dropdown item" style="padding:10px; width: 120px;" id="navalert"">
		 <i class="github icon" id="iconccue"  style="font-size: x-large;" onmouseout="save();"></i>뀨? <span class="badge badge-pill badge-primary" id="ccueicon"></span>
   		<div class="menu" style="overflow:scroll; overflow-x:hidden; max-height:200px;" >
     		<span id="alert" > </span>
		<%-- <a role="alert" class="dropdown-item" href="${pageContext.servletContext.contextPath}/interest.do?theme="></a> --%>
       </div>
  </div>
 <!--   //== -->
	<div class="ui simple dropdown item"style="padding:10px; width: 120px;">
		<i class="hashtag icon"id="hashicon"></i>관심사
	      <div class="menu" style="overflow:scroll; overflow-x:hidden; max-height:200px;" >
	      <c:forEach var="v" items="${allInter}">
				<a class="dropdown-item" href="${pageContext.servletContext.contextPath}/interest.do?theme=${v}">${v}</a>

	      </c:forEach>
	      </div>
    </div>
    <div class="right item">
      <div class="ui input">
		<form class="form-inline my-2 my-md-0" action="${pageContext.servletContext.contextPath}/account.do"   id="sform">
			<input class="form-control" type="text" placeholder="Search" list="some"
				 autocomplete="off" id="searchlist" name="hashtag" onchange="dstChange();">
				<datalist id="some"></datalist>
		</form>
	</div>
    </div>
  </div>
</div>


<script>
//뀨 아이콘 크기 
$("#iconccue").on("mouseover",function(){
	
	$("#iconccue").attr("style", "font-size: xx-large")
})
$("#iconccue").on("mouseout", function() {
			$("#iconccue").attr("style", "font-size: x-large")

		})
//
$("#hashicon").on("mouseover",function(){
	
	$("#hashicon").attr("style", "font-size: xx-large")
})
$("#hashicon").on("mouseout", function() {
			$("#hashicon").attr("style", "font-size: x-large")

		})
//===========그거뭐냐 알림리셋하는거
	
		/* $("#navalert").on("mouseover",function(){
			
		var req = new XMLHttpRequest();
		console.log("유저아이디유"+"${userId}");
				req.open(
						"get",
						"${pageContext.servletContext.contextPath}/navalert.do",
						true);
	
		req.send();
		});
 */
 
 var save =function(){
	 var req = new XMLHttpRequest();
				req.open(
						"get",
						"${pageContext.servletContext.contextPath}/navalert.do?id=aa",
						true);
	
		req.send();
 }
	
	//=============



$("#searchlist").on("keyup",function(){
	
	var search=$("#searchlist").val();
	var param ={
			"value":search
	};
	$.post("${pageContext.servletContext.contextPath}/searchAjax.do",param,function(rst){
		var html="";
		 var id=rst.idlist;
		 var list =rst.taglist;
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
var dstChange=function(){
	var a= $("#searchlist").val();
	console.log(a + " /  " +(a.startsWith("#")));
	if(a.startsWith("#")) {
		$("#sform").attr("action", "${pageContext.servletContext.contextPath}/board/board_search.do");
		$("#searchlist").attr("name","hashtag");
	}else {
		$("#sform").attr("action", "${pageContext.servletContext.contextPath}/account.do");
	 	$("#searchlist").attr("name","id");
	}
}
</script>

<script>
	var ws = new WebSocket("ws://" + location.host+ "${pageContext.servletContext.contextPath}/all.do");
	ws.onmessage = function(evt) {
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
			
		case "defaultalertremov":
			defaultalertremovHandler(obj);
			break;
		}
		
	}
	var defaultalertremovHandler=function(obj){
		var html="";
		var like="like";
		var follow="follow";
		var s=obj.str;
		for(var i=0;i<s.length;i++){
			var iconnew = "<small><b>new </b></small>";
			if(s[i].moded==follow){
				if(s[i].pass=="on"){
				html+="<div role=\"alert\">";
				html+="<div align=\"center\"><small >"+"▼"+s[i].senddatejsp+"</small></div>";			
				html+="<a  style=\"background-color: highlight;font-size: 15px;\" class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/account.do?id="+s[i].id+"\">"+"<img class=\"photoo\" src=\"${pageContext.servletContext.contextPath}"+s[i].attach+"\" />"+s[i].id+s[i].content+"</a>";
				html+="</div>";
				}else{
					html+="<div role=\"alert\">";
					html+="<div align=\"center\"><small >"+"▼"+s[i].senddatejsp+"</small></div>";			
					html+="<a  style=\"font-size: 15px;\" class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/account.do?id="+s[i].id+"\">"+"<img class=\"photoo\" src=\"${pageContext.servletContext.contextPath}"+s[i].attach+"\" />"+s[i].id+s[i].content+"</a>";
					html+="</div>";
				}
			
			}else{
				if(s[i].pass=="on"){
				html+="<div role=\"alert\">";
				html+="<div align=\"center\"><small >"+"▼"+s[i].senddatejsp+"</small></div>";	
				html+="<a data-remote=\"false\" data-toggle=\"modal\" data-target=\"#myModal\" style=\"background-color: highlight;font-size: 15px;\" class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/board/board_detail.do?num="+s[i].num+"\">"+"<img class=\"photoo\" src=\"${pageContext.servletContext.contextPath}"+s[i].attach+"\" />"+s[i].id+s[i].content+"</a>";
				html+="</div>";
				}else{
					html+="<div role=\"alert\">";
					html+="<div align=\"center\"><small >"+"▼"+s[i].senddatejsp+"</small></div>";	
					html+="<a data-remote=\"false\" data-toggle=\"modal\" data-target=\"#myModal\" style=\"font-size: 15px;\" class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/board/board_detail.do?num="+s[i].num+"\">"+"<img class=\"photoo\" src=\"${pageContext.servletContext.contextPath}"+s[i].attach+"\" />"+s[i].id+s[i].content+"</a>";
					html+="</div>";
				}
			}
			
				document.getElementById("ccueicon").innerHTML =""; 
			
		}
		document.getElementById("alert").innerHTML = html; 
	}
	
	
	var defaultalertHandler=function(obj){
		var html="";
		var like="like";
		var follow="follow";
		var o=document.getElementById("alert").innerHTML;
		var s=obj.str;
		for(var i=0;i<s.length;i++){
			var iconnew = "<small><b>new </b></small>";
			if(s[i].moded==follow){
				if(s[i].pass=="on"){
				html+="<div role=\"alert\">";
				html+="<div align=\"center\"><small >"+"▼"+s[i].senddatejsp+"</small></div>";			
				html+="<a  style=\"background-color: highlight;font-size: 15px;\" class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/account.do?id="+s[i].id+"\">"+"<img class=\"photoo\" src=\"${pageContext.servletContext.contextPath}"+s[i].attach+"\" />"+s[i].id+s[i].content+"</a>";
				html+="</div>"+o;
				}else{
					html+="<div role=\"alert\">";
					html+="<div align=\"center\"><small >"+"▼"+s[i].senddatejsp+"</small></div>";			
					html+="<a  style=\"font-size: 15px;\" class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/account.do?id="+s[i].id+"\">"+"<img class=\"photoo\" src=\"${pageContext.servletContext.contextPath}"+s[i].attach+"\" />"+s[i].id+s[i].content+"</a>";
					html+="</div>"+o;
				}
			
			}else{

				if(s[i].pass=="on"){
				html+="<div role=\"alert\">";
				html+="<div align=\"center\"><small >"+"▼"+s[i].senddatejsp+"</small></div>";	
				html+="<a data-remote=\"false\" data-toggle=\"modal\" data-target=\"#myModal\" style=\"background-color: highlight;font-size: 15px;\" class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/board/board_detail.do?num="+s[i].num+"\">"+"<img class=\"photoo\" src=\"${pageContext.servletContext.contextPath}"+s[i].attach+"\" />"+s[i].id+s[i].content+"</a>";
				html+="</div>"+o;
				}else{
					html+="<div role=\"alert\">";
					html+="<div align=\"center\"><small >"+"▼"+s[i].senddatejsp+"</small></div>";	
					html+="<a data-remote=\"false\" data-toggle=\"modal\" data-target=\"#myModal\" style=\"font-size: 15px;\" class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/board/board_detail.do?num="+s[i].num+"\">"+"<img class=\"photoo\" src=\"${pageContext.servletContext.contextPath}"+s[i].attach+"\" />"+s[i].id+s[i].content+"</a>";
					html+="</div>"+o;
				}
			}
			if(s[i].pass=="on"){
				document.getElementById("ccueicon").innerHTML = iconnew; 

			}
		}
		document.getElementById("alert").innerHTML = html; 
		
	}
	
	
	
	var followHandler=function(obj){
		var follow="follow";
		var html="";
		var iconnew = "<small><b>new </b></small>";
		var o=document.getElementById("alert").innerHTML;
		if(obj.moded==follow){
			if(obj.pass=="on"){
		html+="<div role=\"alert\">";
		html+="<div align=\"center\"><small >"+"▼"+obj.senddatejsp+"</small></div>";
		html+="<a style=\"background-color: highlight;font-size: 15px;\" class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/account.do?id="+obj.id+"\">"+"<img class=\"photoo\" src=\"${pageContext.servletContext.contextPath}"+obj.attach+"\" />"+obj.id+obj.content+"</a>";
		html+="</div>"+o;
			}else{
				html+="<div role=\"alert\">";
				html+="<div align=\"center\"><small >"+"▼"+obj.senddatejsp+"</small></div>";
				html+="<a style=\"font-size: 15px;\" class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/account.do?id="+obj.id+"\">"+"<img class=\"photoo\" src=\"${pageContext.servletContext.contextPath}"+obj.attach+"\" />"+obj.id+obj.content+"</a>";
				html+="</div>"+o;
				
			}
			document.getElementById("ccueicon").innerHTML = iconnew; 
		}else{

			if(obj.pass=="on"){
			html+="<div role=\"alert\">";
			html+="<div align=\"center\"><small >"+"▼"+obj.senddatejsp+"</small></div>";	
			html+="<a data-remote=\"false\" data-toggle=\"modal\" data-target=\"#myModal\" style=\"background-color: highlight;font-size: 15px;\" class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/board/board_detail.do?num="+obj.num+"\">"+"<img class=\"photoo\" src=\"${pageContext.servletContext.contextPath}"+obj.attach+"\" />"+obj.id+obj.content+"</a>";
			html+="</div>"+o;
			}else{
				html+="<div role=\"alert\">";
				html+="<div align=\"center\"><small >"+"▼"+obj.senddatejsp+"</small></div>";	
				html+="<a data-remote=\"false\" data-toggle=\"modal\" data-target=\"#myModal\" style=\"font-size: 15px;\" class=\"dropdown-item\" href=\"${pageContext.servletContext.contextPath}/board/board_detail.do?num="+obj.num+"\">"+"<img class=\"photoo\" src=\"${pageContext.servletContext.contextPath}"+obj.attach+"\" />"+obj.id+obj.content+"</a>";
				html+="</div>"+o;
			}
			
				document.getElementById("ccueicon").innerHTML = iconnew; 

			
		}
		document.getElementById("alert").innerHTML = html; 
		
		
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

