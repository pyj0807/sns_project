<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/semantic/semantic.css">
<script
  src="https://code.jquery.com/jquery-3.1.1.min.js"
  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
  crossorigin="anonymous"></script>
<script src="semantic/semantic.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<!-- <input type="text"list="somee" onkeyup="location.href=this.value" >
<datalist id="somee" >


<option  value="http://www.webmadang.net" label="by Adobe">웹마당넷</option>
<option value="http://www.naver.com" >네이버</option>
<option  value="http://www.daum.net">다음</option>
</datalist> -->

<i class="american sign language interpreting icon" style="font-size: medium;" id="aaa" ></i>



<script >
$("#aaa").on("mouseover",function(){
	
	$("#aaa").attr("style","font-size: xx-large")
})

$("#aaa").on("mouseout",function(){
	$("#aaa").attr("style","font-size: medium")
	
})

</script>


</body>
</html>