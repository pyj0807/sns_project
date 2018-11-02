<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
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
	<c:forEach var="i" items="${boardOne.type }" varStatus="status">
		<c:choose>
			<c:when test="${i  == 'image'}">
				<img src="${boardOne.file_attach[status.index] }">
			</c:when>
			<c:otherwise>
				<video src="${boardOne.file_attach[status.index] }" controls></video><br/>
			</c:otherwise>
		</c:choose>	
	</c:forEach>
	<br/>

	</p>
	</div>
	
	<!-- 오른쪽 표시할것 : 프사 / 아이디 / (장소태그) / 관심사 -->
 	<div class="column">
	<p>
		<a href="${pageContext.servletContext.contextPath }/account.do?id=${boardOne.writer }">
		<img src="${pageContext.servletContext.contextPath }/pic/01.jpg" class="photo" style="width: 30px; height: 30px;">
		<b>${boardOne.writer }</b></a> 
		<a href=""><h6>${boardOne.area }</h6></a>
		<span class="badge badge-pill badge-info"> ${boardOne.interest }</span>
	</p>
	<hr/>
	<!-- 내용표시 -->
	<p>
		${hashtag }
	</p>
	
	<!-- 지도 스크립트 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=77b82b2024c179d6b907274cd249b2c4"></script>						
	<!-- db에 위치값이 저장되어있을경우에만 지도보여줌 -->
	<c:choose>
		<c:when test="${boardOne.area !=null }">
			<div id="map" style="width:100% ;height:100px;"></div>
		</c:when>
	</c:choose>
	<p>
		<c:choose>
			<c:when test="${boardOne.area!=null }">
			</c:when>
		</c:choose>
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
		<span id="replyList">
			<c:forEach var="i" items="${reply_list }">
				<a href="${pageContext.servletContext.contextPath }/account.do?id=${i.writer }">${i.writer }	</a>	${i.reply_content }  
				<c:choose>
					<c:when test="${Id==i.writer || boardOne.writer==Id }"><%--작성자와 로그인한사람이 같으면, 글글쓴이와 로그인한사람 --%>
						<button  value="${i.key },${i.id}" onclick="delete_reply(this);">삭제</button><br/>
					</c:when>
					<c:otherwise>
						<button  value="${i.key },${i.id}" onclick="delete_reply(this);" style="visibility: hidden">삭제</button><br/>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</span>
		<br/>
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
					var len="";
					for(var i=0; i<obj.length; i++){
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
							html+=">삭제</button>";
						}else{
							html+=" <button id=\"delete_reply\" value=\"";
							html+=obj[i].key+","+obj[i].id;
							html+="\"";
							html+="onclick=\"";
							html+="delete_reply(this);";
							html+="\"";
							html+="style=\"visibility:hidden\"";
							html+=">삭제</button>";
						}
						html+="<br/>";
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
						html+=">삭제</button>";
					}else{
						html+=" <button id=\"delete_reply\" value=\"";
						html+=obj[i].key+","+obj[i].id;
						html+="\"";
						html+="onclick=\"";
						html+="delete_reply(this);";
						html+="\"";
						html+="style=\"visibility:hidden\"";
						html+=">삭제</button>";
					}
					html+="<br/>";
				}				
				document.getElementById("replyList").innerHTML = html;
				document.getElementById("reply").value="";
				document.getElementById("replyLength").innerHTML = len;
			}
		};
		xhr.send(JSON.stringify(param));	
	};

	 var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	   mapOption = { 
	       center: new daum.maps.LatLng(${boardOne.lat},${boardOne.longi}), // 지도의 중심좌표
	       level: 3 // 지도의 확대 레벨
	   };
	 
	 var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	 /*
	 	BoardController 에서  lat,longi,area값이없을경우에
	 	초기값으로 lat=33.450701, longi=126.570667을 주고
	 	area 는 "" 값으로 주어서  area가 ""일경우 마커를 찍어주지않음.
	 */
	 if(${boardOne.area != ""}){
		// 마커가 표시될 위치입니다 
		var markerPosition  = new daum.maps.LatLng(${boardOne.lat}, ${boardOne.longi}); 		
		// 마커를 생성합니다
		var marker = new daum.maps.Marker({
		    position: markerPosition
		});
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
	 }	
</script>
