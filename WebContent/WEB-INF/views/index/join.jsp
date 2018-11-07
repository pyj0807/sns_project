<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<title>join</title>
<body>
	<div class="container" style="margin-top: 80px; margin-bottom: 80px;">
  	<div class="row">
    <div class="col-sm">
    </div>
    
	<span class="border">
    <div class="col-sm" style="margin-top: 60px; margin-bottom: 60px;">
		<form class="form-signin" align="center" action="${pageContext.servletContext.contextPath }/join.do" method="post">
			<div class="join">
				<label>아이디</label><i class="far fa-user-circle fa-2x"></i><br/>
					<input name="id" id="id" type="text" style="margin-bottom: 10px; text-align: center; font-size: 25px; " placeholder="아이디 " class="form-control"
									onkeyup="checkId(this.value);" required><span
									id="idspan" style="margin-bottom: 20px; text-align: center;" ></span><br/>
								
								<label>비밀번호</label><i class="fas fa-unlock-alt fa-2x"></i><br/>
								<input name="pass" id="pass" type="password" maxlength="20" class="form-control"
									placeholder="비밀번호" required style="margin-bottom: 20px; text-align: center;"  > <br />
								<label>이름</label><i class="fas fa-user-circle fa-2x"></i><br/>
								<input name="name" id="name" type="text" maxlength="20" class="form-control"
									placeholder="이름" required style="margin-bottom: 20px; text-align: center; font-size: 25px;" > <br />
								
								<div>
								<label>이메일 인증</label><i class="far fa-envelope fa-2x"></i><br/>
								<input type="text" name="email01" id="email01" class="form-control" style="width: 100px; display:inline-block;" 
									onkeyup="checkEmailID(this.value);" >
									@ 
									<input  type="text" name="email22" id="email02"
									onchange="checkEmailSubid(this.value);"  style="width: 100px; display:inline-block;"  class="form-control"
									value="naver.com" style="margin-bottom: 10px"> <select
									style="width: 100px; display:inline-block; margin-right: 10px; font-size: 18px;" name="subid"  class="form-control"
									id="subid">
									<option value="1">직접입력</option>
									<option value="naver.com" selected>naver.com</option>
									<option value=daum.net>daum.net</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="nate.com">nate.com</option>
									<option value="gmail.com">gmail.com</option>
								</select> <br />

								
								<button type="button" id="emailauth" style="margin: 10px 10px">번호받기</button>
								<small id="ckmail1"></small> <input type="text" id="confirm"
									class="form-control" name="confirm" placeholder="인증번호" style="margin-bottom: 10px; text-align: center; " >
								<button type="button" id="confirmok" disabled="disabled"
									required style="margin-bottom: 20px" >인증하기</button>
								<small id="ckmail2"></small><br/>
								</div>

								
								<div class="join_row join_birthday">
									<label>생년월인</label><i class="fas fa-birthday-cake fa-2x"></i>
									<div class="bir_wrap" required>
										<div class="bir_yy" style="font-size: 30px; text-align: center;">
											<span class="ps_box"> <input type="text" name="yy" class="form-control" style="width: 100px; display:inline-block; text-align: center;"
												placeholder="년도(4자)" maxlength="4"> <select
												name="mm" aria-label="월" class="form-control" style="width: 100px; display:inline-block; text-align: center; font-size: 18px;" >
													<option>월</option>
													<option value="01">01</option>
													<option value="02">02</option>
													<option value="03">03</option>
													<option value="04">04</option>
													<option value="05">05</option>
													<option value="06">06</option>
													<option value="07">07</option>
													<option value="08">08</option>
													<option value="09">09</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
											</select>
											</span> <span> <select name="dd" aria-label="일" class="form-control" style="margin-bottom: 20px; width: 100px; display:inline-block; text-align: center; font-size: 18px;">
													<option>일</option>
													<option value="01">01</option>
													<option value="02">02</option>
													<option value="03">03</option>
													<option value="04">04</option>
													<option value="05">05</option>
													<option value="06">06</option>
													<option value="07">07</option>
													<option value="08">08</option>
													<option value="09">09</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
													<option value="13">13</option>
													<option value="14">14</option>
													<option value="15">15</option>
													<option value="16">16</option>
													<option value="17">17</option>
													<option value="18">18</option>
													<option value="19">19</option>
													<option value="20">20</option>
													<option value="21">21</option>
													<option value="22">22</option>
													<option value="23">23</option>
													<option value="24">24</option>
													<option value="25">25</option>
													<option value="26">26</option>
													<option value="27">27</option>
													<option value="28">28</option>
													<option value="29">29</option>
													<option value="30">30</option>
													<option value="31">31</option>
											</select>
											</span>
										</div>
									</div>
								</div>

								<label>성별</label><i class="fas fa-venus-mars fa-2x"></i>
								<!-- 
								<div class="ps_box gender_code" style="margin-bottom: 20px"
									required>
									<select id="gender" name="gender" aria-label="성별">
										<option value="M"><i class="fas fa-male"></i></option>
										<option value="F"><i class="fas fa-female"></i></option>
									</select>
								</div>
								 -->
								<div  style="margin-bottom: 20px">
								<input type=radio id="gender" name="gender" value=M> <i class="fas fa-male fa-2x"></i> 
								<input type=radio id="gender" name="gender" value=F> <i class="fas fa-female fa-2x"></i> 
								</div>
							<div style="margin-bottom: 20px; font-size: 25px;"><label>관심사</label><i class="fas fa-heart"></i><br/>
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
							<button type="submit" id="btnsubmit">가입</button>
						</form>
					</div>
					<p style="text-align: center;">
					이미 계정이 있으십니까?   <a href="${pageContext.servletContext.contextPath }/login.do">로그인</a>
					</p>
				</span>
    
    <div class="col-sm">
    </div>
    </div>
  </div>

</body>
</head>
</html>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	//아이디 중복
	var checkId = function() {
		var id = document.getElementById("id").value;
		var r = new RegExp(/^[A-Za-z]{1}[0-9A-Za-z]{3,11}$/);

		console.log(r.test(id));

		if (r.test(id)) {
			var req = new XMLHttpRequest();
			req.open("get", "joinajax.do?id=" + id, true);
			console.log("옴? 왜 안옴?")

			req.onreadystatechange = function() {
				if (this.readyState == 4) {
					var m = JSON.parse(this.responseText);
					console.log("m=" + m);
					if (m.pass == "on") {
						console.log("on")
						document.getElementById("idspan").innerHTML = "이미 사용중인 아이디입니다.";
						document.getElementById("idspan").style.color = "red";
					} else {
						console.log("off")
						document.getElementById("idspan").innerHTML = "아주 멋진 아이디에요.";
						document.getElementById("idspan").style.color = "green";
					}
				}
			}
			req.send();
		} else {
			document.getElementById("idspan").innerHTML = "아이디는 영문숫자혼용 4~12자로 설정바랍니다.";
			document.getElementById("idspan").style.color = "red";
		}
	};

	//이메일 중복
	var checkEmailID = function() {
		var emailid = document.getElementById("email01").value;
		var subid = document.getElementById("email02").value;
		var email = emailid + "@" + subid; 
		var r2 = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

		console.log("test : " + r2.test(email));

		if (r2.test(email)) {
			var req = new XMLHttpRequest();
			req.open("get", "emailajax.do?email=" + email, true);
			console.log("옴? 왜 안옴?");
			req.onreadystatechange = function() {
				if (this.readyState == 4) {
					var m = JSON.parse(this.responseText);
					console.log("m =" + m);
					if (m.pass == "on") {
						console.log("on");
						document.getElementById("ckmail1").innerHTML = "이미 인증을 한 이메일입니다.";
						document.getElementById("ckmail1").style.color = "red";
					} else {
						console.log("off")
						document.getElementById("ckmail1").innerHTML = "인증 가능한 이메일입니다";
						document.getElementById("ckmail1").style.color = "green";
					}
				}
			}
			req.send();
		} else {
			document.getElementById("ckmail1").innerHTML = "사용 불가능한 이메일 형식입니다";
			document.getElementById("ckmail1").style.color = "red";
		}
	};
	
	var checkEmailSubid = function() {
		var emailid = document.getElementById("email01").value;
		var subid = document.getElementById("email02").value;
		var email = emailid + "@" + subid;
		var r2 = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

		console.log("test : " + r2.test(email));

		if (r2.test(email)) {
			var req = new XMLHttpRequest();
			req.open("get", "emailajax.do?email=" + email, true);
			console.log("옴? 왜 안옴?");
			req.onreadystatechange = function() {
				if (this.readyState == 4) {
					var m = JSON.parse(this.responseText);
					console.log("m =" + m);
					if (m.pass == "on") {
						console.log("on");
						document.getElementById("ckmail1").innerHTML = "이미 인증을 한 이메일입니다.";
						document.getElementById("ckmail1").style.color = "red";
					} else {
						console.log("off")
						document.getElementById("ckmail1").innerHTML = "인증 가능한 이메일입니다";
						document.getElementById("ckmail1").style.color = "green";
					}
				}
			}
			req.send();
		} else {
			document.getElementById("ckmail1").innerHTML = "사용 불가능한 이메일 형식입니다";
			document.getElementById("ckmail1").style.color = "red";
		}
	};
	// 관심사
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

	//이메일 직접입력
	$('#subid').change(function() {
		$("#subid option:selected").each(function() {
			if ($(this).val() == '1') { //직접입력일 경우 
				$("#email02").val(''); //값 초기화
				//$("#email02").attr("disabled", false); //활성화
			} else { //직접입력이 아닐경우 
				$("#email02").val($(this).text()); //선택값 입력
				//$("#email02").attr("disabled", true); //비활성화
			}
		});
	});

	$("#emailauth").on("click",function() {
				var param = {
					"email01" : $("#email01").val(),
					"email02" : $("#email02").val()
				};
				$("#confirm").prop("disabled", false);
				$("#confirmok").prop("disabled", false);
				$.post("${pageContext.servletContext.contextPath}/email.do",
						param).done(function(rst) {
					document.getElementById("ckmail1").innerHTML = "전송";
					document.getElementById("ckmail1").style.color = "green";
				});
			});

	$("#confirmok")
			.on(
					"click",
					function() {
						var param = {
							"confirmkey" : $("#confirm").val()
						};
						console.log($("#confirm").val());
						$
								.post(
										"${pageContext.servletContext.contextPath}/emailauth.do",
										param)
								.done(
										function(rst) {
											console.log(rst);
											if (rst.includes("true") == true) {
												document
														.getElementById("ckmail2").innerHTML = "인증완료";
												document
														.getElementById("ckmail2").style.color = "green";
												$("#inputEmail").prop(
														"readonly", true);
												$("#emailauth").prop(
														"disabled", true);
												$("#confirm").prop("disabled",
														true);
												$("#confirmok").prop(
														"disabled", true);
												$("#btnsubmit").prop(
														"disabled", false);
												$("#email01").prop("readonly",true);
												$("#email02").prop("readonly",true);
												
											} else {
												document
														.getElementById("ckmail2").innerHTML = "인증실패";
												document
														.getElementById("ckmail2").style.color = "red";
												$("#confirm").prop("disabled",
														false);
												$("#confirmok").prop(
														"disabled", false);
												document
														.getElementById("emailauth").innerHTML = "재전송";
												document
														.getElementById("ckmail1").innerHTML = "";
											}
										});
					});
</script>


