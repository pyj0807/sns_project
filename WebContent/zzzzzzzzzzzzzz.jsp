<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.servletContext.contextPath}/semantic/semantic.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"
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

	<i class="american sign language interpreting icon"
		style="font-size: medium;" id="aaa"></i>



	<script>
		$("#aaa").on("mouseover", function() {

			$("#aaa").attr("style", "font-size: xx-large")
		})

		$("#aaa").on("mouseout", function() {
			$("#aaa").attr("style", "font-size: medium")

		})
	</script>

	<table>

		<tr>
			<td class="table-active">...</td>
			<br />

			<td class="table-primary">...</td>
			<br />
			<td class="table-secondary">...</td>
			<br />
			<td class="table-success">...</td>
			<br />
			<td class="table-danger">...</td>
			<br />
			<td class="table-warning">...</td>
			<br />
			<td class="table-info">...</td>
			<br />
			<td class="table-light">...</td>
			<br />
			<td class="table-dark">...</td>
			<br />
		</tr>
	</table>

	<table class="table table-sm ">
		<thead>
			<tr class="table-primary">
 				 <th scope="col">#</th>
				<th scope="col">First</th>
				<th scope="col">Last</th>
				<th scope="col">Handle</th>
			</tr>
		</thead>
		<tbody>
			<tr class="table-primary">

				<td>Mark</td>

			</tr>
			<tr class="table-primary">

				<td>Jacob</td>

			</tr>
			<tr class="table-primary">

				<td colspan="2">Larry the Bird</td>

			</tr>
			
		</tbody>

	</table>
	
	
	<table class="table table-hover ">
  <thead>
    <tr>
	  <th scope="col">#</th>
      <th scope="col">First</th>
      <th scope="col">Last</th>
      <th scope="col" width="4%">Handle</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td>Mark</td>
      <td>Otto</td>
      <td>@mdo</td>
    </tr>
    <tr>
      <th scope="row">2</th>
      <td>Jacob</td>
      <td>Thornton</td>
      <td>@fat</td>
    </tr>
    <tr>
      <th scope="row">3</th>
      <td colspan="2">Larry the Bird</td>
      <td>@twitter</td>
    </tr>
  </tbody>
</table>

<div class="wrap">
	<h1 class="animated swing infinite">AMIATE</h1>
    <!--★여기에!! 원하는 애니메이션 이름을 씁니다. -->
	<input type="button" value="클릭" name="btName" class="bt">	
</div>

<style>
*{margin: 0;padding:0;}
.wrap{text-align: center;margin: 100px 0;}
h1{margin:50px 0;}
.bt{padding:10px 20px;}
.infinite{-webkit-animation-iteration-count:infinite;}

</style>
<div id="example-1">
  <button @click="show = !show">
    Toggle render
  </button>
  <transition name="slide-fade">
    <p v-if="show">hello</p>
  </transition>
</div>

<script >

new Vue({
  el: '#example-1',
  data: {
    show: true
  }
})
</script>
<style>

.slide-fade-enter-active {
  transition: all .3s ease;
}
.slide-fade-leave-active {
  transition: all .8s cubic-bezier(1.0, 0.5, 0.8, 1.0);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active below version 2.1.8 */ {
  transform: translateX(10px);
  opacity: 0;
}
</style>
/* 애니메이션 진입 및 진출은 다른 지속 시간 및  */
/* 타이밍 기능을 사용할 수 있습니다. */


</body>
</html>