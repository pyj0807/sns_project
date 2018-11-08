<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">   
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link rel="stylesheet"
   href="${pageContext.servletContext.contextPath }/css/changepass.css">   

<link
	href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&amp;subset=korean"
	rel="stylesheet">

<style>
div {
	font-family: 'Nanum Pen Script', cursive;
	font-size: 20px;
}
</style>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="text-align: center;">
   <div class="guide">
   <c:if test="${!empty intererr}">
   <div class="alert alert-danger" role="alert">
   관심사를 설정 안하셨습니다.
</div>
   </c:if>
      <c:if test="${!empty passno}">
   <div class="alert alert-danger" role="alert">
   현재비밀번호가 틀리셨거나 입력하지 않으셨습니다.
</div>
   </c:if>
   <div class="center-box">
   <h4>Change Information</h4>
   
   
   <form
      action="${pageContext.servletContext.contextPath }/change.do" method="post">
      <div class="form-group row">
         <label for="opass" class="col-sm-2 col-form-label">아이디</label>
            <div class="col-sm-8">
               <input type="text" class="form-control" placeholder="${sessionScope.user.ID }" disabled="disabled" />
            </div>
      </div>
      <div class="form-group row">
         <label for="opass" class="col-sm-2 col-form-label">이름</label>
            <div class="col-sm-8">
               <input type="text" class="form-control" placeholder="${sessionScope.user.NAME }" disabled="disabled" />
            </div>
      </div>
      <div class="form-group row">
         <label for="opass" class="col-sm-2 col-form-label">관심사</label>
            <div class="col-sm-8">
               <input type="text" class="form-control" placeholder="${intermy }" disabled="disabled" />
            </div>
      </div><div class="form-group row">
         <label for="opass" class="col-sm-2 col-form-label">관심사<br/> 변경</label>
            <div class="col-sm-8">
               <c:forEach var="v" items="${interest }">
                              <c:choose>
                                 <c:when test="${ v eq '연애' }">
                                       ${v }<input type="checkbox" name="interest" value="${v}"
                                       onchange="cksave(this)" />
                                    <br />
                                 </c:when>
                                 <c:otherwise>
                                       ${v }<input type="checkbox" name="interest" value="${v}"
                                       onchange="cksave(this)" />
                                 </c:otherwise>
                              </c:choose>
                           </c:forEach>
            </div>
      </div>
      <div class="form-group row">
         <label for="opass" class="col-sm-2 col-form-label">현재<br/> 비밀번호</label>
         <div class="col-sm-8">
            <input type="password" class="form-control" name="opass" id="opass" placeholder="현재 비밀번호" />
         </div>
      </div>
      <div class="form-group row">
         <label for="npass" class="col-sm-2 col-form-label">새로운 <br/>비밀번호</label>
         <div class="col-sm-8">
            <input type="password" class="form-control" name="npass" id="npass" placeholder="새로운 비밀번호" />
         </div>
      </div>
      
      <button type="submit" class="btn btn-primary">변경</button>
   </form>
   </div>
   </div>
</body>
</html>

<script>
var checkbox = new Array();
var cksave = function(target) {
   if (target.checked) {
      if (checkbox.length < 3) {
         checkbox.push(target.value);
      } else {
         window.alert("최대 3개 까지 선택 가능합니다");
         target.checked = false;
      }
   } else {
      var idx = checkbox.indexOf(target.value);
      checkbox.splice(idx, 1);
   }
}
</script>