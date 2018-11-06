<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<style>
* {
    box-sizing: border-box;
}
body {
  margin: 0;
}
/* Create three equal columns that floats next to each other */
.column {
    float: left;
    width: 50%;
    padding: 15px;
}
/* Clear floats after the columns */
.row:after {
    content: "";
    display: table;
    clear: both;
}
img {
	width: 354px;
	height: auto;
	}
video {
	max-width: 100%;
	width:700px;
	max-height: 100%;
	height: auto;
}
input[type=checkbox] { display:none; }
input[type=checkbox] + label { 
display: inline-block; 
cursor: pointer; 
line-height: 22px; 
padding-left: 22px; 
background: url('${pageContext.servletContext.contextPath}/img/heart2.png') left/22px no-repeat; 
}
input[type=checkbox]:checked + label { background-image: url('${pageContext.servletContext.contextPath}/img/heart1.png'); }
.photo {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 50%;
}
	  button {
	    background-color: #ffffff;
	    opacity: 0.5;
	  }
</style>
<br/>
<!-- semantic 아이콘 사용위한 스크립트와 link  -->
 <script src="semantic/semantic.js"></script>
 <link rel="stylesheet" type="text/css" href="semantic/semantic.css">

<div class="row">
  <div class="column">
	<!-- 왼쪽에 표시할것 :  사진(영상) -->
	<p>
		<!-- 타입 비디오,사진 구분 -->
		<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
			<!-- 0 -->
			<div class="carousel-inner">
				<!-- 1 -->
				<c:forEach var="i" items="${boardOne.type }" varStatus="status">
					<c:choose>
						<c:when test="${status.index==0 }">
							<div class="carousel-item active">
								<!-- 2 -->
								<c:choose>
									<c:when test="${i  == 'image'}">
										<img class="d-block w-100" src="${boardOne.file_attach[status.index] }" style="width: 300px; height: 500px;">
									</c:when>
									<c:otherwise>
										<video src="${boardOne.file_attach[status.index] }" controls></video>
										<br />
									</c:otherwise>
								</c:choose>
								<!-- 2 -->
							</div>
						</c:when>
						<c:otherwise>
							<div class="carousel-item">
								<!-- 2 -->
								<c:choose>
									<c:when test="${i  == 'image'}">
										<img class="d-block w-100" src="${boardOne.file_attach[status.index] }" style="width: 300px; height: 500px;">
									</c:when>
									<c:otherwise>
										<video src="${boardOne.file_attach[status.index] }" controls></video>
										<br />
									</c:otherwise>
								</c:choose>
								<!-- 2 -->
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
				<c:choose>
					<c:when test="${fn:length(boardOne.file_attach)>1 }">
						<!-- 1 -->
						<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev"> 
							<span class="carousel-control-prev-icon" aria-hidden="true"></span> 
							<span class="sr-only">이전</span>
						</a> 
						<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next"> 
							<span class="carousel-control-next-icon" aria-hidden="true"></span> 
							<span class="sr-only">다음</span>
						</a>
					</c:when>
				</c:choose>
		</div>
		<!-- 0 -->
		<br />
		</p>
	</div>
	
	<!-- 오른쪽 표시할것 : 프사 / 아이디 / (장소태그) / 관심사 -->
 	<div class="column">
	<div class="ui horizontal list">
		<div class="item">
			<h3><a href="${pageContext.servletContext.contextPath }/account.do?id=${boardOne.writer }">
			<img src="${pageContext.servletContext.contextPath }/pic/${writerMap.PROFILE_ATTACH }" class="photo" style="width: 30px; height: 30px;">
			<b>${boardOne.writer }</b></a></h3>
		</div>
		<div class="item">
			<h3><a href="${pageContext.servletContext.contextPath}/interest.do?theme=${boardOne.interest }"><span class="badge badge-pill badge-info"> ${boardOne.interest }</span></a></h3>
		</div>
	</div>
	<p>
		<a href="${pageContext.servletContext.contextPath }/board/map.do?location=${boardOne.area }"><h6>${boardOne.area }</h6></a>
	</p>
	<hr/>
	<!-- 내용표시 -->
	<p>
		${hashtag }
	</p>		
	<!-- 좋아요 버튼 / 글 수정 삭제 버튼 -->
		<c:choose>
			<c:when test="${boardOne.checked == true }">
				<input type="checkbox" id="like_button" onclick="like(this);" checked><label for="like_button">　</label>
			</c:when>
		<c:otherwise>
				<input type="checkbox" id="like_button" onclick="like(this);"><label for="like_button">　</label>
		</c:otherwise>
		</c:choose>
		<a href="${pageContext.servletContext.contextPath }/board/likelist.do?num=${boardOne._id}"><b>좋아요 </b><span id="like_count">${fn:length(boardOne.liker) }</span>명　　</a>
		<c:choose>
			<c:when test="${Id==boardOne.writer}">
				<a href="${pageContext.servletContext.contextPath }/update.do?num=${boardOne._id}"><i class="edit icon"></i></a>
				<a href="${pageContext.servletContext.contextPath }/delete.do?num=${boardOne._id}"><i class="trash alternate outline icon"></i></a>
			</c:when>
		</c:choose>
		<hr/>	
	<!-- 댓글 -->
	<i class="comments outline icon"></i><span id=replyLength>${fn:length(reply_list) }</span> Comment<br/>	
		<div id="scroll" style="overflow-y: scroll; height: 100px;">
			<span id="replyList">
				<c:forEach var="i" items="${reply_list }">
					<img src="${pageContext.servletContext.contextPath }/pic/${i.pic }" class="photo" style="width: 25px; height: 25px;">
					<a href="${pageContext.servletContext.contextPath }/account.do?id=${i.writer }">${i.writer }</a>
					${i.reply_content }
					<c:choose>
						<c:when test="${Id==i.writer || boardOne.writer==Id }"><%--작성자와 로그인한사람이 같으면, 글글쓴이와 로그인한사람 --%>
							<button  value="${i.key },${i.id}" onclick="delete_reply(this);" style="border:solid 0px#FFFFFF;">&times;</button><br/>
						</c:when>
						<c:otherwise>
							<button  value="${i.key },${i.id}" onclick="delete_reply(this);" style="visibility: hidden">&times;</button><br/>
						</c:otherwise>
					</c:choose>
					<!-- 댓글시간 -->
					<small class="text-muted">
                    	<c:choose>
                    		<c:when test="${i.lasttime <60}">
                    			${i.lasttime }초전<br/>
                    		</c:when>
                    		<c:when test="${i.lasttime >=60 && i.lasttime <3600}">
                    			<fmt:formatNumber type="number" value="${i.lasttime/60 }" pattern="#" />분전<br/>
                    		</c:when>
                    		<c:when test="${i.lasttime >=3600 && i.lasttime <86400}">
                    			<fmt:formatNumber type="number" value="${i.lasttime/(60*60) }" pattern="#" />시간전<br/>
                    		</c:when>
                    		<c:when test="${i.lasttime >=86400 && i.lasttime <604800}">
                    			<fmt:formatNumber type="number" value="${i.lasttime/(60*60*24) }" pattern="#" />일전<br/>
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber type="number" value="${i.lasttime/(60*60*24*7) }" pattern="#" />주전<br/>
                    		</c:otherwise>
                    	</c:choose>
		             </small>
				</c:forEach>
			</span>
		</div>
		<br/>
			<p>
				<input type="text" id="reply" name="reply" style="width: 80%"/>
				<i class="pencil alternate icon" id="add_reply" onclick="replyAjax();" style="color: gray"></i>
			</p>
	</div>
</div>



<script>
	//상세화면에서 좋아요 눌렀을때 ajax처리
	var like = function(target){
		var xhr = new XMLHttpRequest();
		//1.open
		xhr.open("post","${pageContext.servletContext.contextPath}/board/like.do",true);
		//2.param설정
		var param = {
			"_id" : ${boardOne._id}
			,"checked":target.checked
		};
		//3.아작스성공시 처리
		xhr.onreadystatechange = function(){
			if(this.readyState==4){
				var obj = JSON.parse(this.responseText);
				var like_count = obj.liker.length;
				document.getElementById("like_count").innerHTML=like_count;	
			}
		};
		//4.send (Map --> string)
		xhr.send(JSON.stringify(param));
	};
	
	//댓글등록하기
	var replyAjax = function(){
		//1글자라도 입력했을경우
		if(document.getElementById("reply").value.trim().length>0){
			var xhr = new XMLHttpRequest();
			xhr.open("post","${pageContext.servletContext.contextPath}/board/reply.do",true);
			//파람설정
			var param = {
				"id":${boardOne._id} //방번호
				,"reply_content":document.getElementById("reply").value //댓글내용
			};
			//아작스 성공시처리
			xhr.onreadystatechange = function(){
				if(this.readyState==4){
					var obj = JSON.parse(this.responseText);
					console.log(obj);
					var html="";
					var len="";
					for(var i=0; i<obj.length; i++){
						html+="<img src=\"${pageContext.servletContext.contextPath }/pic/";
						html+=obj[i].pic;
						html+= "\" class=\"photo\" style=\"width: 25px; height: 25px;\"> ";
						html+="<a href=\"";
						html+="${pageContext.servletContext.contextPath }";
						html+="/account.do?id=";
						html+=obj[i].writer;
						html+="\">";		
						html+=obj[i].writer+" </a> ";
						html+=obj[i].reply_content;
						
						len = obj.length;
						
						if(obj[i].writer=="${Id}" || "${Id}"=="${boardOne.writer}"){ //등록한아이디와 세션아이디가같거나, 글작성자와 세션이같으면
							//(등록후조회)
							html+=" <button id=\"delete_reply\" value=\"";
							html+=obj[i].key+","+obj[i].id;
							html+="\"";
							html+="onclick=\"";
							html+="delete_reply(this);";
							html+="\"";
							html+=" style=\"border:solid 0px#FFFFFF;\">&times;</button>";
						}else{
							html+=" <button id=\"delete_reply\" value=\"";
							html+=obj[i].key+","+obj[i].id;
							html+="\"";
							html+="onclick=\"";
							html+="delete_reply(this);";
							html+="\"";
							html+="style=\"visibility:hidden\"";
							html+=">&times;</button>";
						}
						html+="<br/>";	
						html+="<small class=\"text-muted\">";
						if(obj[i].lasttime<60){
							html+=obj[i].lasttime+"초전";							
						}else if(obj[i].lasttime>=60 && obj[i].lasttime<3600){
							html+=parseInt(obj[i].lasttime/60)+"분전";
						}else if(obj[i].lasttime>=3600 && obj[i].lasttime<86400){
							html+=parseInt(obj[i].lasttime/(60*60))+"시간전";
						}else if(obj[i].lasttime>=86400 && obj[i].lasttime<604800){
							html+=parseInt(obj[i].lasttime/(60*60*24))+"일전";
						}else{
							html+=parseInt(obj[i].lasttime/(60*60*24*7))+"주전";
						}
						html+="<br/>";
						html+="</small>";
					}				
					document.getElementById("replyList").innerHTML = html;
					document.getElementById("reply").value="";
					document.getElementById("replyLength").innerHTML = len;
				}
			};
			//send
			xhr.send(JSON.stringify(param));
		}
	};
	
	var delete_reply = function(target){
		console.log("삭제버튼클릭함"+target.value);
		var xhr = new XMLHttpRequest();
		xhr.open("post","${pageContext.servletContext.contextPath}/board/delete_reply.do",true);
		//파람설정
		var param = {
			"key":target.value // 키값,방번호
		};
		//아작스성공시처리
		xhr.onreadystatechange = function(){
			if(this.readyState==4){
				var obj = JSON.parse(this.responseText);
				console.log(obj);
				var html="";
				var len="";
				for(var i=0; i<obj.length; i++){	
					html+="<img src=\"${pageContext.servletContext.contextPath }/pic/";
					html+=obj[i].pic;
					html+= "\" class=\"photo\" style=\"width: 25px; height: 25px;\"> ";
					html+="<a href=\"";
					html+="${pageContext.servletContext.contextPath }";
					html+="/account.do?id=";
					html+=obj[i].writer;
					html+="\">";		
					html+=obj[i].writer+" </a> ";
					html+=obj[i].reply_content;
					
					len = obj.length; // 댓글 개수
					console.log(len);
					
					if(obj[i].writer=="${Id}" || "${Id}"=="${boardOne.writer}"){ //등록한아이디와 세션아이디가같거나, 글작성자와 세션이같으면
						//(삭제후조회)
						html+=" <button id=\"delete_reply\" value=\"";
						html+=obj[i].key+","+obj[i].id;
						html+="\"";
						html+="onclick=\"";
						html+="delete_reply(this);";
						html+="\"";
						html+=" style=\"border:solid 0px#FFFFFF;\">&times;</button>";
					}else{
						html+=" <button id=\"delete_reply\" value=\"";
						html+=obj[i].key+","+obj[i].id;
						html+="\"";
						html+="onclick=\"";
						html+="delete_reply(this);";
						html+="\"";
						html+="style=\"visibility:hidden\"";
						html+=">&times;</button>";
					}
					html+="<br/>";
					html+="<small class=\"text-muted\">";
					if(obj[i].lasttime<60){
						html+=obj[i].lasttime+"초전";							
					}else if(obj[i].lasttime>=60 && obj[i].lasttime<3600){
						html+=parseInt(obj[i].lasttime/60)+"분전";
					}else if(obj[i].lasttime>=3600 && obj[i].lasttime<86400){
						html+=parseInt(obj[i].lasttime/(60*60))+"시간전";
					}else if(obj[i].lasttime>=86400 && obj[i].lasttime<604800){
						html+=parseInt(obj[i].lasttime/(60*60*24))+"일전";
					}else{
						html+=parseInt(obj[i].lasttime/(60*60*24*7))+"주전";
					}
					html+="<br/>";
					html+="</small>";
					
				}				
				document.getElementById("replyList").innerHTML = html;
				document.getElementById("reply").value="";
				document.getElementById("replyLength").innerHTML = len;
			}
		};
		xhr.send(JSON.stringify(param));	
	};
</script>
