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
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/signin.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<title>join</title>
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

<form class="form-signin"
	action="${pageContext.servletContext.contextPath }/join.do"
	method="post">
	<div class="container" style="margin-top: 150px">
		<div class="row">
			<div class="col"></div>
			<div class="col">

				<div style="position: relative;">
					<img alt="" src="img/phone.png">
				</div>
				<div style="position: relative; left: 148px; top: -522px;">
					<!-- <img alt="" src="img/main2.jpg"> -->
				</div>
			</div>
			<span class="border">
				<div class="col" align="center" style="margin-top: 80px">
					<div class="row-group">
						<div class="row">
							<div class="join">
								<h4>아이디</h4>
								<input name="id" id="id" type="text" style="width:100px;" maxlength="20"
									placeholder="이메일 " onkeyup="checkId(this.value);" required> 
								 <br/><span id="idspan"></span>	
								<h4>메일 인증</h4>
								<input name="id" id="id" type="text" style="width:100px;" maxlength="20"
									placeholder="아이디 " onkeyup="checkId(this.value);" required> 
									@
								<input type="text" name="str_email02" id="str_email02" style="width:100px;" disabled value="naver.com"> 
								 <select style="width:100px;margin-right:10px" name="subid" id="subid"> 
									 <option value="1">직접입력</option> 
									 <option value="naver.com" selected>naver.com</option> 
									 <option value="hanmail.net">hanmail.net</option> 
									 <option value="nate.com">nate.com</option> 
									 <option value="yahoo.co.kr">yahoo.co.kr</option> 
									 <option value="dreamwiz.com">dreamwiz.com</option> 
									 <option value="freechal.com">freechal.com</option> 
									 <option value="gmail.com">gmail.com</option> 
								 </select>								 
								<h4>비밀번호</h4>
								<input name="pass" id="pass" type="password" maxlength="20"
									placeholder="비밀번호" required> <br />
								<h4>이름</h4>
								<input name="name" id="name" type="text" maxlength="20"
									placeholder="이름" required> <br />
								<div class="join_row join_birthday">
									<h3 class="join_title">생년월일</h3>
									<div class="bir_wrap" required>
										<div class="bir_yy">
											<span class="ps_box"> <input type="text" name="yy"
												placeholder="년도(4자)" maxlength="4">
											</span> <span> <select name="mm" aria-label="월">
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
											</span> <span> <select name="dd" aria-label="일">
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

								<h3 class="join_title">성별</h3>
								<div class="ps_box gender_code" required>
									<select id="gender" name="gender" aria-label="성별">
										<option selected>성별</option>
										<option value="M">남자</option>
										<option value="F">여자</option>
									</select>
								</div>
								
								<c:forEach var="v" items="${interest }">
									${v }<input type="checkbox" name="interest" value="${v}"
										onchange="cksave(this)" />
								</c:forEach>
							</div>
						</div>

						<button type="submit">가입</button>
						<form action="${pageContext.servletContext.contextPath }/index.do"
							method="post">
							<button type="submit">로그인</button>
						</form>
					</div>

				</div>
			</span>

			<div class="col"></div>
		</div>

	</div>
</form>
</head>
</html>
<script>
	var checkId = function(){
		var id = document.getElementById("id").value;
		var r = new RegExp(/^[A-Za-z]{1}[0-9A-Za-z]{3,11}$/);
		
		console.log(r.test(id));
		
		if(r.test(id)){
			var req = new XMLHttpRequest();
			req.open("get","joinajax.do?id="+id,true);
			console.log("옴? 왜 안옴?")
			
			req.onreadystatechange = function() {
	            if(this.readyState==4) {
	                var m =JSON.parse(this.responseText);
					console.log("m="+m);
					if(m.pass == "on"){
						console.log("on")
						document.getElementById("idspan").innerHTML = "이미 사용중인 아이디입니다.";
						document.getElementById("idspan").style.color ="red";
					}else {
						console.log("off")
						document.getElementById("idspan").innerHTML = "아주 멋진 아이디에요.";
						document.getElementById("idspan").style.color ="green";
					}
				}	
			}
			req.send();
		}else{
			document.getElementById("idspan").innerHTML = "아이디는 영문숫자혼용 4~12자로 설정바랍니다.";
			document.getElementById("idspan").style.color ="red";
		}
	};

</script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script type="text/javascript">
$('#subid').change(function(){ 
	$("#subid option:selected").each(function () { 
		if($(this).val()== '1'){ //직접입력일 경우 
			$("#str_email02").val(''); //값 초기화
			$("#str_email02").attr("disabled",false); //활성화 
			}else{ //직접입력이 아닐경우 
				$("#str_email02").val($(this).text()); //선택값 입력
				$("#str_email02").attr("disabled",true); //비활성화
				} 
		}); 
	}); 
</script> 


