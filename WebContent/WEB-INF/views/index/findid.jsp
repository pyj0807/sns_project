<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous">

<link href="https://fonts.googleapis.com/css?family=East+Sea+Dokdo&amp;subset=korean" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
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

<title>Insert title here</title>

</head>
<body>
		<div class="container">
		  <div class="row">
		    <div class="col-sm">
		    </div>
		    
		    <span class="border" style="margin-top: 350px">
		    <div class="col-sm" >
		    <form class="form-signin" align="center" action="${pageContext.servletContext.contextPath }/findid.do" method="post">
				<div>
					<label>아이디 찾기</label><i class="fas fa-search"></i><br/>
					<label>이메일 인증</label><i class="far fa-envelope"></i><br/>
					<input type="text" name="email11" id="email11" class="form-control" style="width: 100px; display:inline-block;" 
					onkeyup="checkEmailID(this.value);" >
					@ 
					<input  type="text" name="email22" id="email22"
					onkeyup="checkEmailSubid(this.value);"  style="width: 100px; display:inline-block;"  class="form-control"
					value="naver.com" style="margin-bottom: 10px"> <select
					style="width: 100px; display:inline-block; margin-right: 10px; font-size: 18px;" name="subid"  class="form-control"
					id="subid">
					<option id="selectoption" value="1">직접입력</option>
					<option id="selectoption" value="naver.com" selected>naver.com</option>
					<option id="selectoption" value=daum.net>daum.net</option>
					<option id="selectoption" value="hanmail.net">hanmail.net</option>
					<option id="selectoption" value="nate.com">nate.com</option>
					<option id="selectoption" value="gmail.com">gmail.com</option>
					</select> <br />
					
								
					<button type="button" id="idemailauth" style="margin: 10px 10px">번호받기</button>
					<small id="ckmail1"></small> <input type="text" id="confirm" 
					class="form-control" name="confirm" placeholder="인증번호" style="margin-bottom: 10px; text-align: center; " >
					<button type="button" id="idconfirmok" 
					required style="margin-bottom: 20px" >인증하기</button>
					<small id="ckmail2"></small><br/>
					</div>
					<div>
					<input type="text" id="idview" 
					class="form-control" placeholder="당신의 ID" value="" style="margin-bottom: 10px; text-align: center; " >
					</div>
					<p style="text-align: center;">
					<a href="${pageContext.servletContext.contextPath }/login.do">로그인</a>|
					<a href="${pageContext.servletContext.contextPath }/login.do">비밀번호 찾기 </a>
					</p>	
				</form>
		    	</div>
		    </span>
		    
		    <div class="col-sm">
		    </div>
		  </div>
		</div>

</body>
</html>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

	//이메일 정규식
	var checkEmailID = function() {
		var emailid = document.getElementById("email11").value;
		var subid = document.getElementById("email22").value;
		var email = emailid + "@" + subid; 
		var r2 = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

		console.log("test : " + r2.test(email));

		if (r2.test(email)) {
			var req = new XMLHttpRequest();
			req.open("get", "idemailajax.do?email=" + email, true);
			console.log("옴? 왜 안옴?");
			req.onreadystatechange = function() {
				if (this.readyState == 4) {
					var m = JSON.parse(this.responseText);
					console.log("m =" + m);
					if (m.pass == "on") {
						console.log("on");
						document.getElementById("ckmail1").innerHTML = "인증 가능한 이메일 입니다.";
						document.getElementById("ckmail1").style.color = "green";
						$("#idview").attr("value",m.id);
						
						
					}else{
						document.getElementById("ckmail1").innerHTML = "없는 이메일 입니다.";
						document.getElementById("ckmail1").style.color = "red";
					}
				}
			}
			req.send();
		} else {
			document.getElementById("ckmail1").innerHTML = "사용 불가능한 이메일 형식입니다";
			document.getElementById("ckmail1").style.color = "red";
		}
	};
	
	
	//이메일 정규식
	$("#subid").on("click",function(){
							console.log($("#subid").val());
							var emailid = document.getElementById("email11").value;
							var subid = document.getElementById("email22").value;
							var email = emailid + "@" + subid;
							var r2 = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
						console.log(emailid+"골뱅이듀"+subid);
							console.log("test : " + r2.test(email));

							if (r2.test(email)) {
								var req = new XMLHttpRequest();
								req.open("get", "idemailajax.do?email=" + email, true);
								console.log("옴? 왜 안옴?");
								req.onreadystatechange = function() {
									if (this.readyState == 4) {
										var m = JSON.parse(this.responseText);
										console.log("m =" + m);
										if (m.pass == "on") {
											console.log("on");
											document.getElementById("ckmail1").innerHTML = "인증 가능한 이메일 입니다.";
											document.getElementById("ckmail1").style.color = "green";
										} else {
											console.log("off")
											document.getElementById("ckmail1").innerHTML = "없는 이메일 입니다.";
											document.getElementById("ckmail1").style.color = "red";
										}
									}
								}
								req.send();
							} else {
								document.getElementById("ckmail1").innerHTML = "사용 불가능한 이메일 형식입니다";
								document.getElementById("ckmail1").style.color = "red";
							}
						})
	//직접입력
	$('#subid').change(function() {
		$("#subid option:selected").each(function() {
			if ($(this).val() == '1') { //직접입력일 경우 
				$("#email22").val(''); //값 초기화
			} else { //직접입력이 아닐경우 
				$("#email22").val($(this).text()); //선택값 입력
			}
		});
	});

	

	//번호 받기
	$("#idemailauth").on("click",function() {
		var param = {
			"email11" : $("#email11").val(),
			"email22" : $("#email22").val()
		};
		$("#confirm").prop("disabled", false);
		$("#confirmok").prop("disabled", false);
		$.post("${pageContext.servletContext.contextPath}/findid.do",
				param).done(function(rst) {
			document.getElementById("ckmail1").innerHTML = "전송";
			document.getElementById("ckmail1").style.color = "green";
		});
	});

		//인증
		$("#idconfirmok").on("click",function() {
				console.log("오냐?")
				var param = {"confirmkey" : $("#confirm").val()};
				console.log($("#confirm").val());
				$.post("${pageContext.servletContext.contextPath}/idemailauth.do",param).done(function(rst) {
					console.log(rst);
					if (rst.includes("true") == true) {
						document.getElementById("ckmail2").innerHTML = "인증완료";
						document.getElementById("ckmail2").style.color = "green";
						$("#idemailauth").prop("disabled", true);
						$("#confirm").prop("disabled",true);
						$("#idconfirmok").prop("disabled", true);
						$("#email11").prop("readonly",true);
						$("#email12").prop("readonly",true);
					} else {
						document.getElementById("ckmail2").innerHTML = "인증실패";
						document.getElementById("ckmail2").style.color = "red";
						$("#confirm").prop("disabled",false);
						$("#idconfirmok").prop("disabled", false);
						document.getElementById("idemailauth").innerHTML = "재전송";
						document.getElementById("ckmail1").innerHTML = "";
					}
				});
			});
</script>