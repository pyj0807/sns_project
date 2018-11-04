<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>

<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon"
	href="https://static.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico">

<link rel="mask-icon" type=""
	href="https://static.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg"
	color="#111">
	
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous">
<title>CodePen - Meterialize Register Form + jquery validation
	example</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">

<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">

<style>
body {
	display: table-cell;
	vertical-align: middle; 
	<!--
	background-color: #e0f2f1 !important;
	-->
}
html {
	display: table;
	margin: auto;
}
html, body {
	height: 100%;
}
.medium-small {
	font-size: 0.9rem;
	margin: 0;
	padding: 0;
}
.login-form {
	width: 280px;
}
.login-form-text {
	text-transform: uppercase;
	letter-spacing: 2px;
	font-size: 0.8rem;
}
.login-text {
	margin-top: -6px;
	margin-left: -6px !important;
}

.margin {
	margin: 0 !important;
}

.pointer-events {
	pointer-events: auto !important;
}

.input-field>.material-icons {
	padding-top: 10px;
}

.input-field div.error {
	position: relative;
	top: -1rem;
	left: 3rem;
	font-size: 0.8rem;
	color: #FF4081;
	-webkit-transform: translateY(0%);
	-ms-transform: translateY(0%);
	-o-transform: translateY(0%);
	transform: translateY(0%);
}
/* 버튼 */
input {
        vertical-align: middle;
      }
      input.form-text {
        border: 1px solid #bcbcbc;
        height: 28px;
      }
      input.img-button1 {
        background: url( "img/male.png" ) no-repeat;
        border: none;
        width: 32px;
        height: 32px;
        cursor: pointer;
      }
      input.img-button2 {
        background: url( "img/female.png" ) no-repeat;
        border: none;
        width: 32px;
        height: 32px;
        cursor: pointer;
      }


</style>

</head>

<body translate="no">	<!-- 창처럼 분리 -->
	<div id="login-page" class="row">
		<div class="col s12 z-depth-4 card-panel">
			<form class="login-form" novalidate="novalidate">
				<div class="row">
					<div class="input-field col s12 center">
						<h4>회원가입</h4>
					</div>
				</div>
				<div class="row margin"><!-- 가로줄 -->
					<div class="input-field col s12">	<!-- 초록줄 -->
						<!-- <i class="mdi-social-person-outline prefix"></i> -->
						<i class="material-icons prefix">account_circle</i> <input
							id="id" name="id" type="text"> <label
							for="username">아이디</label>
					</div>
				</div>
				<div class="row margin">
					<div class="input-field col s12">
						<!-- <i class="mdi-action-lock-outline prefix"></i> -->
						<i class="material-icons prefix">vpn_key</i> <input id="password"
							name="password" type="password"> <label for="password">비밀번호</label>
					</div>
				</div>
				<div class="row margin">
					<div class="input-field col s12">
						<!-- <i class="mdi-social-person-outline prefix"></i> -->
						<i class="material-icons prefix">account_circle</i> 
						<input id="name" name="name" type="text"> <label
							for="username">이름</label>
					</div>
				</div>
				<div class="row margin">
					<div class="input-field col s12">
						<!-- <i class="mdi-social-person-outline prefix"></i> -->
						<i class="fas fa-calendar-alt fa-2x"></i><input
							id="name" name="name" type="text"> <label
							for="username">생년월일</label>
					</div>
				</div>
				
				 <div class="row margin">
					<div class="input-field col s12">
						<!-- <i class="mdi-action-lock-outline prefix"></i> -->
						<i class="material-icons prefix">man</i> 
						<input type="button" class="img-button1">
						<input type="button" class="img-button2">
					
					</div>
				</div>
				
				<div class="input-field col s12 center">
						<h5>이메일 인증</h5>
				</div>
				<div class="row margin">
					<div class="input-field col s12">
						<!-- <i class="mdi-social-person-outline prefix"></i> -->
						<i class="material-icons prefix">email</i> <input id="email"
							name="email" type="text" style="cursor: auto;"> <label
							for="email">이메일</label>
							<button type="button" style="position: absolute; right: 0;">전송</button>
							<!-- <button type="button">인증</button> -->
					</div>
				</div>
				
				<div class="row margin">
					<div class="input-field col s12">
						<!-- <i class="mdi-social-person-outline prefix"></i> -->
						<i class="material-icons prefix">email</i> <input id="email"
							name="email" type="text" style="cursor: auto;"> <label
							for="email">이메일 인증</label>
							<button type="button" style="position: absolute; right: 0;">인증확인</button>
					</div>
				</div>
				
				
				<!-- 
				<div class="row margin">
					<div class="input-field col s12">
						<i class="mdi-action-lock-outline prefix"></i>
						<i class="material-icons prefix">vpn_key</i> <input
							id="password_a" name="cpassword" type="password"> <label
							for="password_a">Password again</label>
					</div>
				</div>
				 -->
				 
				
				
				<div class="row margin">
					<div class="input-field col s12">
						<c:forEach var="v" items="${interest }">
							<c:choose>
								<c:when test="${ v eq '연애' }">
								${v }<input type="checkbox" name="interest" value="${v}" onchange="cksave(this)" /><br/>
								</c:when>
								<c:otherwise>
								${v }<input type="checkbox" name="interest" value="${v}" onchange="cksave(this)" />
								</c:otherwise>
							</c:choose>
						</c:forEach> 
					</div>
				</div>
				
				<div class="row">
					<div class="input-field col s12">
						<button type="submit" class="btn waves-effect waves-light col s12">가입</button>
					</div>
					<div class="input-field col s12">
						<p class="margin center medium-small sign-up">
							Already have an account? <a href="./login">Login</a>
						</p>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script
		src="//static.codepen.io/assets/common/stopExecutionOnTimeout-41c52890748cd7143004e05d3c5f786c66b19939c4500ce446314d1748483e13.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>

	<script>
		window.console = window.console || function(t) {
		};
	</script>
	<script>
		if (document.location.search.match(/type=embed/gi)) {

			window.parent.postMessage("resize", "*");

		}
	</script>
	<script>
		$(".login-form").validate({
			rules : {
				username : {
					required : true,
					minlength : 4
				},
				email : {
					required : true,
					email : true
				},
				password : {
					required : true,
					minlength : 5
				},
				cpassword : {
					required : true,
					minlength : 5,
					equalTo : "#password"
				}
			},
			//For custom messages
			messages : {
				username : {
					required : "Enter a username",
					minlength : "Enter at least 4 characters"
				}
			},
			errorElement : 'div',
			errorPlacement : function(error, element) {
				var placement = $(element).data('error');
				if (placement) {
					$(placement).append(error)
				} else {
					error.insertAfter(element);
				}
			}

		});

		//# sourceURL=pen.js
	</script>
	<script
		src="https://static.codepen.io/assets/editor/live/css_reload-2a5c7ad0fe826f66e054c6020c99c1e1c63210256b6ba07eb41d7a4cb0d0adab.js"></script>
	<div class="hiddendiv common"></div>
</body>
</html>