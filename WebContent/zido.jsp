<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ㅎㅇ</title>
</head>
<body>

   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=77b82b2024c179d6b907274cd249b2c4"></script>
	 
	 <div id="map" style="width:100%;height:350px;"></div>
	<p><em>지도 중심좌표가 변경되면 지도 정보가 표출됩니다</em></p>
	<p id="result"></p>
	   
   <script>
   
   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
   mapOption = { 
       center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
       level: 3 // 지도의 확대 레벨
   };
   var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

   //파라미터
   daum.maps.event.addListener(map, 'center_changed', function() {
	
    // 지도의  레벨을 얻어옵니다
    var level = map.getLevel();

    // 지도의 중심좌표를 얻어옵니다 
    var latlng = map.getCenter(); 

    var message = '<p>지도 레벨은 ' + level + ' 이고</p>';
    message += '<p>중심 좌표는 위도 ' + latlng.getLat() + ', 경도 ' + latlng.getLng() + '입니다</p>';

    var resultDiv = document.getElementById('result');
    resultDiv.innerHTML = message;

	});
   
	// 마커가 표시될 위치입니다 
	var markerPosition  = new daum.maps.LatLng(33.450701, 126.570667); 
	
	// 마커를 생성합니다
	var marker = new daum.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
	// marker.setMap(null); 
	
   </script>
   
</body>
</html>