<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">


<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous">

<link href="https://fonts.googleapis.com/css?family=East+Sea+Dokdo&amp;subset=korean" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

<style>


body {
	font-family: 'East Sea Dokdo', cursive;
	background-color: #FBFBFB;

}
span{
	width:400px;
	/* width: 350px; */
	background-color: #FFFFFF;
	font-size: 25px;
}
label{
	font-size: 38px;
}
input::placeholder{
	font-size: 25px;
}
input::value{
	font-size: 25px;
}
p{
	font-size: 25px;
}

select { 
	width: 60px; /* 원하는 너비설정 */ 
	padding: .3em .7em; /* 여백으로 높이 설정 */ 
	font-family: inherit; /* 폰트 상속 */ 
	background: url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg) no-repeat 95% 50%; /* 네이티브 화살표 대체 */
	border: 1px solid #999; 
	border-radius: 0px; /* iOS 둥근모서리 제거 */ 
	-webkit-appearance: none; /* 네이티브 외형 감추기 */ 
	-moz-appearance: none; 
	appearance: none; 
	font-size: 25px;
}

button{
  font-size: 25px;	
  background:#1AAB8A;
  color:#fff;
  border:none;
  position:relative;
  height:40px;
  font-size:0.8em;
  padding:0 1em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  border-radius:10px;
}
button:hover{
  background:#fff;
  color:#1AAB8A;
  border-radius:10px;
  font-size: 25px;
}
button:before,button:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #1AAB8A;
  transition:400ms ease all;
  border-radius:10px;
  font-size: 25px;
}
button:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
  border-radius:10px;
  font-size: 25px;
}
button:hover:before,button:hover:after{
  width:100%;
  transition:800ms ease all;
  border-radius:10px;
  font-size: 25px;
}
</style>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
</head>
<body>
<div class="guide" align="center" style="padding-top: 150px; display: "id="zz" >
<c:if test="${ faill eq 'on' }">
<div class="alert alert-danger" role="alert" id="alertt" style=" width: 200px;padding-top: 10px;" align="center">
비밀번호를 입력 안하셨거나<br/> 틀리셨습니다.
</div>
</c:if>
</div>


<form action="${pageContext.servletContext.contextPath }/newchangepass.do" method="post">

<div style="margin-bottom: 20px; font-size: 25px;padding-top: 50px" align="center">

<label style="padding-top: 50px; " >새로운 비밀번호 변경</label><br/>
	
	<h3><span class="badge badge-info">변경할 비밀번호</span></h3>	 <input type="password" name="pass1"> 
	<h3 style="padding-top: 10px"><span class="badge badge-info">재입력 비밀번호</span></h3>	 <input type="password" name="pass2">
	<div style="padding-top: 10px;padding-bottom: 10px">
	</div>



<input type="hidden" name="findid" value="${mainid }">
	<button type="submit" id="IDfind" >확인</button>
</div>

</form>








</body>
</html>