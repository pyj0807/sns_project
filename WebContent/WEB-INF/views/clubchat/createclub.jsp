<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>


</head>
<body>

 <br/>

	<%-- 	<form action="${pageContext.servletContext.contextPath }/club/createon.do" method="post" enctype="multipart/form-data">
		제목 : <input type="text" name="info"/> <br/>
		메인 사진 : <input type="file" name="attach"> 
		<br/>
		<button type="submit">만들기</button>
	</form> --%>
	
	<form action="${pageContext.servletContext.contextPath }/club/createon.do" method="post" enctype="multipart/form-data">
	<div class="filebox bs3-primary " align="center">
	
							제목 : <input type="text" name="info"/> <br/>
                         메인 사진 :  <input class="upload-name" value="파일선택" disabled="disabled">

                            <label for="ex_filename">업로드</label> 
                          <input type="file" id="ex_filename" name="attach"class="upload-hidden"> <br/>
	<button type="submit" style="align-content: center;">만들기</button>
                        </div>
</form>

<style>

body {margin: 10px}
.where {
  display: block;
  margin: 25px 10px;
  font-size: 11px;
  color: #000;
  text-decoration: none;
  font-family: verdana;
  font-style: italic;
} 

.filebox input[type="file"] {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip:rect(0,0,0,0);
    border: 0;
}

.filebox label {
    display: inline-block;
    padding: .5em .75em;
    color: #999;
    font-size: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #fdfdfd;
    cursor: pointer;
    border: 1px solid #ebebeb;
    border-bottom-color: #e2e2e2;
    border-radius: .25em;
}

/* named upload */
.filebox .upload-name {
    display: inline-block;
    padding: .5em .75em;
    font-size: inherit;
    font-family: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
}

.filebox.bs3-primary label {
  color: #fff;
    background-color: #337ab7;
    border-color: #2e6da4;
}




</style>

<script>
$(document).ready(function(){
	  var fileTarget = $('.filebox .upload-hidden');

	    fileTarget.on('change', function(){
	        if(window.FileReader){
	            var filename = $(this)[0].files[0].name;
	        } else {
	            var filename = $(this).val().split('/').pop().split('\\').pop();
	        }

	        $(this).siblings('.upload-name').val(filename);
	    });
	}); 
</script>

</body>
</html>
