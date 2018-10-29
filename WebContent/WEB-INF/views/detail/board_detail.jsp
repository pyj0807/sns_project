<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
img {
	max-width: 100%;
	width: 700px;
	max-height: 100%;
	height: 500px;
}

video {
	max-width: 100%;
	width:700px;
	max-height: 100%;
	height: 500px;
}
</style>

<br/>
<br/>
<br/>

<div>
	<c:choose>
		<c:when test="${boardOne.type == 'video'}">
		<!-- 타입이비디오일경우 -->
			<video src="${boardOne.file_attach }" controls></video><br/>
		</c:when>
		<c:otherwise>
			<img src="${boardOne.file_attach }">
		</c:otherwise>	
	</c:choose>
	<br/>

	<c:choose>
		<c:when test="${boardOne.checked == true }">
			<input type="checkbox" id="like_button" onclick="like(this);" checked>좋아요</button>
		</c:when>
	<c:otherwise>
			<input type="checkbox" id="like_button" onclick="like(this);">좋아요</button>
	</c:otherwise>
	</c:choose>
	 
	<p>
		<a href="${pageContext.servletContext.contextPath }/board/likelist.do?num=${boardOne._id}"><b>좋아요:</b><span id="like_count">${fn:length(boardOne.liker) }</span></a><br/>
		<b>글쓴이:</b><a href="${pageContext.servletContext.contextPath }/account.do?id=${boardOne.writer }">${boardOne.writer }</a><br/>
		<%--<b>내용:</b>${boardOne.content }<br/> --%>
		<b>관심사:</b>${boardOne.interest }<br/>
		<b>내용:</b>${hashtag }		
	</p>

	<span id="replyList">
		<c:forEach var="i" items="${reply_list }">
			<a href="${pageContext.servletContext.contextPath }/account.do?id=${i.writer }">${i.writer }</a>${i.reply_content }
			<button  value="${i.key },${i.id}" onclick="delete_reply(this);">삭제</button><br/>
		</c:forEach>
	</span>
	
	<div style="margin-right: 10%; margin-left: 0%; text-align: left; margin-top: 	55px;">
		<p>
			<b>〔댓글달기〕</b><br/>
		</p>
		<p>
			<input type="text" id="reply" name="reply" style="width: 80%"/>
			<button type="button" id="add_reply" onclick="replyAjax();">등록하기</button>
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
					for(var i=0; i<obj.length; i++){
						html+="<a href=\"";
						html+="${pageContext.servletContext.contextPath }";
						html+="/account.do?id=";
						html+=obj[i].writer;
						html+="\">";		
						html+=obj[i].writer+"</a>";
						html+=obj[i].reply_content;
						
						//(등록후조회)
						html+="<button id=\"delete_reply\" value=\"";
						html+=obj[i].key+","+obj[i].id;
						html+="\"";
						html+="onclick=\"";
						html+="delete_reply(this);";
						html+="\"";
						html+=">삭제</button>";
						
						html+="<br/>";
					}				
					document.getElementById("replyList").innerHTML = html;
					document.getElementById("reply").value="";
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
				for(var i=0; i<obj.length; i++){
					html+="<a href=\"";
					html+="${pageContext.servletContext.contextPath }";
					html+="/account.do?id=";
					html+=obj[i].writer;
					html+="\">";		
					html+=obj[i].writer+"</a>";
					html+=obj[i].reply_content;
					
					//(삭제후조회)
					html+="<button id=\"delete_reply\" value=\"";
					html+=obj[i].key+","+obj[i].id;
					html+="\"";
					html+="onclick=\"";
					html+="delete_reply(this);";
					html+="\"";
					html+=">삭제</button>";
					
					html+="<br/>";
				}				
				document.getElementById("replyList").innerHTML = html;
				document.getElementById("reply").value="";
			}
		};
		xhr.send(JSON.stringify(param));	
	};
</script>