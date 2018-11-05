<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
 <link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
  <style>
    .btn{
      text-decoration: none;
      font-size:2rem;
      color:white;
      padding:10px 20px 10px 20px;
      margin:20px;
      display:inline-block;
      border-radius: 10px;
      transition:all 0.1s;
      text-shadow: 0px -2px rgba(0, 0, 0, 0.44);
      font-family: 'Lobster', cursive;
    }
    .btn:active{
      transform: translateY(3px);
    }
    .btn.blue{
      background-color: #1f75d9;
      border-bottom:5px solid #165195;
    }
    .btn.blue:active{
      border-bottom:2px solid #165195;
    }
    .btn.red{
      background-color: #ff521e;
      border-bottom:5px solid #c1370e;
    }
    .btn.red:active{
      border-bottom:2px solid #c1370e;
    }
   ul {
	padding-left: 0;
	list-style: none;
}
  </style>
</head>
<body>
<div class="container">
	<div class="card-deck mb-3 text-center">
		11
		<div class="card mb-4 shadow-sm">
			<div class="card-header">
				<h4 class="my-0 font-weight-normal">
					22
				</h4>
			</div>
			<div class="card-body">
				<h1 class="card-title pricing-card-title">
					33<small class="text-muted ml-1">44</small>55
				</h1>
				66
				{{#if link}}
				<a href="{{ link }}" class="btn btn-lg btn-block {{ buttonStyle }} mt-3">
					{{ buttonText }}
				</a>
				{{/if}}
			</div>
		</div>
		{{/each}}
	</div>
</div>
  <a class="btn blue" href="#blue">blue</a>
  <a class="btn red" href="#red">red</a>
</body>
</html>