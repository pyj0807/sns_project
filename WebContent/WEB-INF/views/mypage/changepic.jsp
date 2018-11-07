<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.photo {
   width: 100px;
   height: 100px;
   object-fit: cover;
   border-radius: 50%;
}
</style>
<div align="center">
<h1>프로필 사진 바꾸기</h1>
   <c:if test="${!empty err}">
      <div class="alert alert-danger" role="alert">Image 파일만 업로드 가능합니다.</div>
   </c:if>
</div>
<div align="center">
   <form method="post" action="${pageContext.servletContext.contextPath}/changepic.do" enctype="multipart/form-data" target="main">
      <p>파일첨부</p>
      <article>
        <p id="status"></p>
        <p><input type=file name="file" accept="image/*" ></p>
        <div id="holder"></div>
      </article><br/>
      <img src="${pageContext.servletContext.contextPath}/pic/${profile.PROFILE_ATTACH}" style="width: 350px;height: 350px;" id="pr"/><br/>
      <!--성공했을때만 -->
     	<input type=submit value="전송" onclick="gogo();" id="submit">
   </form>
</div>

<script>
var upload = document.getElementsByTagName('input')[0],
    holder = document.getElementById('holder'),
    state = document.getElementById('status');
if (typeof window.FileReader === 'undefined') {
  state.className = 'fail';
} else {
  state.className = 'success';
}
 
upload.onchange = function (e) {
  e.preventDefault();
  var file = upload.files[0],
      reader = new FileReader();
  reader.onload = function (event) {
	  $("#submit").attr("disabled",false); //초기화
	  if(event.target.result.startsWith("data:image")){
	    var img = new Image();
	    $("#pr").attr("src",event.target.result);		  
	  }else{
		  $("#submit").attr("disabled",true);
	  }
  };
  reader.readAsDataURL(file);
  return false;
};

var gogo = function(){
	self.close();
} 
</script>