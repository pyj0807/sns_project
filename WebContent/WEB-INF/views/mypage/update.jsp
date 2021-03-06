<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<h2 class="ui header">
  <i class="edit icon"></i>
  <div class="content">
    글 수정
    <div class="sub header">Edit Post...</div>
  </div>
</h2>

<div align="center" >
<br/>
	<div align="center" style="float: left; width: 500px;" >
	<form method="post"
		action="${pageContext.servletContext.contextPath}/update_install.do?num=${Oneboard._id}"
		enctype="multipart/form-data">
		<p>
			글내용(<span style="color: blue;">*</span>) <small>200자 제한</small><br />
			<textarea name="content"
				style="height: 170px; width: 320px; padding: 5px; resize: none; font-family: inherit;"
				placeholder="write a content">${Oneboard.content }</textarea>
		</p>
		<p>
			관심사(<span style="color: blue;">*</span>)<br/>
			<c:forEach var="v" items="${interest }">
				<input type="radio" name="interest" value="${v }" ${v==Oneboard.interest ? 'checked' :'' }>${v }
		 </c:forEach>
		</p>
		<br/>
</div> 
	<div align="center" style="float:left; width: 500px;">
		<!-- 지도 -->
		<input type="hidden" name="lat" value="" id="lat" />
		<input type="hidden" name="longi" value="" id="longi" />
				장소 태그 <i  class="map icon"></i><br/>
				<div style="width: 370px;" align="center" >
					<div  style="float: left; ">
						<input type="text" class="form-control" id="address1"  value="${Oneboard.area }" placeholder="간편 주소" readonly="readonly" onchange="address(this);" name="area"  style="width: 305px;" >   
					</div>		
					<div  style="float: left; ">   
						<button type="button" class="btn btn-secondary" onclick="addressPopUp();">검색</button>
					</div>
				</div><Br/><Br/>
				<div style="width: 370px;">
					<div id="map" style=" height: 350px;" ></div>
				</div><br/>
			<button type="submit" style="width: 330px;" class="btn btn-outline-primary">글 공유</button>
		</form>
	</div>
</div>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=77b82b2024c179d6b907274cd249b2c4&libraries=services,clusterer,drawing"></script>
<script>
	//default 값지정 , 안해주면 처음 수정시 click된 체크박스가 배열에없어서 인식이안됨
	var checkbox = ["${Oneboard.interest}"]; //default
	var cksave = function(target) {
		if (target.checked) {
			if (checkbox.length < 1) {
				checkbox.push(target.value);
			} else {
				window.alert("한개만 선택가능");
				target.checked = false;
			}
		}else {
			var idx = checkbox.indexOf(target.value);
			checkbox.splice(idx, 1);
		}
	}
	//위도,경도
	var input_lat=${Oneboard.lat};
	var input_longi=${Oneboard.longi};

	//================================================
	
	var mapContainer = document.getElementById("map"), // 지도를 표시할 div 
	mapOption = {
		//center : new daum.maps.LatLng(${Oneboard.lat}, ${Oneboard.lat}), // 지도의 중심좌표
		center : new daum.maps.LatLng(input_lat, input_longi), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨address1
	};
	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption);
	//========================================원래저장되어있던 마커 가져오기==================
	// 마커가 표시될 위치입니다 
	//var markerPosition  = new daum.maps.LatLng(${Oneboard.lat}, ${Oneboard.longi}); 
	var markerPosition  = new daum.maps.LatLng(input_lat, input_longi); 
	// 마커를 생성합니다
	var marker = new daum.maps.Marker({
	    position: markerPosition
	});
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	//=================================================================================
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	
	var address = function(target) {
		// 주소 작성 값 추출
		var area = $("#address1").val();
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(area, function(result, status) {
		// 정상적으로 검색이 완료됐으면 
			if (status === daum.maps.services.Status.OK) {
		
				var coords = new daum.maps.LatLng(result[0].y, result[0].x);
				console.log(coords);
				var lat = new daum.maps.LatLng(result[0].y);
				console.log(lat);
				var longi = new daum.maps.LatLng(result[0].x);
				console.log(longi);
				console.log(lat + " , " + longi);
					
				// 결과값으로 받은 위치를 마커로 표시합니다
				var marker = new daum.maps.Marker({
					map : map,
					position : coords
				});
				// 인포윈도우로 장소에 대한 설명을 표시합니다
				var infowindow = new daum.maps.InfoWindow(
						{
							content : '<div style="width:150px;text-align:center;padding:6px 0;">현재위치</div>'
						});
				infowindow.open(map, marker);
		
				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);
				
				var data = {"lat" : result[0].y,"longi" : result[0].x}
				console.log(data);
				$("#lat").val(result[0].y);
				$("#longi").val(result[0].x);
			}
		});
	}
	
	var addressPopUp = function(){
		new daum.Postcode({
	        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            var fullAddr = ''; // 최종 주소 변수
		            var extraAddr = ''; // 조합형 주소 변수
		
		            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                fullAddr = data.roadAddress;
		
		            } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                fullAddr = data.jibunAddress;
		            }
		
		            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
		            if(data.userSelectedType === 'R'){
		                //법정동명이 있을 경우 추가한다.
		                if(data.bname !== ''){
		                    extraAddr += data.bname;
		                }
		                // 건물명이 있을 경우 추가한다.
		                if(data.buildingName !== ''){
		                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
		                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		            }
		
		            // 우편번호와 주소 정보를 해당 필드에 넣는다.		            
		            document.getElementById('address1').value = fullAddr;
		            
		            //
		            address();
		
		            // 커서를 상세주소 필드로 이동한다.
		            document.getElementById('address1').focus();
		        }
	   		}).open();
		}
</script>
