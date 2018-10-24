<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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


<form class="form-signin" action="${pageContext.servletContext.contextPath }/.do" method="post">
<div class="container">
	

	<div class="row">
	   <div class="col">
	   </div>
	    <div class="col">
			<img alt="" src="img/phone.png">
	    </div>
	    	<span class="border">
	   	<div class="col" align="center" style="margin-top: 80px">
		   		  <div class="row-group">
		   		  	<div class="row">
						<div class="join">
							<h4>아이디</h4>
							<input name="id" id="id" type="text" maxlength="20" placeholder="이메일 주소">
							@
							<input name="subid" id="subid" type="text" maxlength="30" >
							<h4>비밀번호</h4>
							<input name="pass" id="pass" type="password" maxlength="20" placeholder="비밀번호">
							<h4>비밀번호 재확인</h4>
							<input name="pass" id="repass" type="password" maxlength="20" placeholder="비밀번호">
							<h4>이름</h4>
							<input name="pass" id="name" type="password" maxlength="20" placeholder="이름">
							<div class="join_row join_birthday">
		                        <h3 class="join_title">생년월일</h3>
		                        <div class="bir_wrap">
		                            <div class="bir_yy">
										<span class="ps_box">
											<input type="text" id="yy" placeholder="년도(2자)"  class="int" maxlength="4">
											<label for="yy" class="lbl"></label>
										</span>
										<span>
											<select id="mm" class="sel" aria-label="월">
												<option>월</option>
												  	 			<option value="01">
		                                                            1
		                                                        </option>
												  	 			<option value="02">
		                                                            2
		                                                        </option>
												  	 			<option value="03">
		                                                            3
		                                                        </option>
												  	 			<option value="04">
		                                                            4
		                                                        </option>
												  	 			<option value="05">
		                                                            5
		                                                        </option>
												  	 			<option value="06">
		                                                            6
		                                                        </option>
												  	 			<option value="07">
		                                                            7
		                                                        </option>
												  	 			<option value="08">
		                                                            8
		                                                        </option>
												  	 			<option value="09">
		                                                            9
		                                                        </option>
												  	 			<option value="10">
		                                                            10
		                                                        </option>
												  	 			<option value="11">
		                                                            11
		                                                        </option>
												  	 			<option value="12">
		                                                            12
		                                                        </option>
											</select>
										</span>
										<span>
											<input type="text" id="dd" placeholder="일"class="int" maxlength="2">
											<label for="dd" class="lbl"></label>
										</span>
									 </div>
		                        </div>
                    		</div>
                    			
                    			<h3 class="join_title">성별</h3>
			                        <div class="ps_box gender_code">
			                            <select id="gender" name="gender" aria-label="성별">
			                                <option value="" selected>성별</option>
			                                <option value="m">남자</option>
			                                <option value="f">여자</option>
			                            </select>
			                        </div>
			                        <fieldset>
                					<legend>관심사</legend>
								                운동 <input type="checkbox" name="hobby" value="exercise"/>
								                영화 <input type="checkbox" name="hobby" value="movie" />
								                음악 <input type="checkbox" name="hobby" value="music" />
								                음식 <input type="checkbox" name="hobby" value="food" />
								                여행 <input type="checkbox" name="hobby" value="travel" />
								                패션 <input type="checkbox" name="hobby" value="fashion" />
								                기타 <input type="checkbox" name="hobby" value="ect" />
							         </fieldset>
								
			                        
                    		
						</div>
					</div>
					
				</div>
	    </div>
			</span>
		<div class="col">
	   </div>
  </div>
  </div>
  </form>
  
	
</html>