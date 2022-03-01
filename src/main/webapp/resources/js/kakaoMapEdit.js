function createMap(address, lat, lng) {

	const container = document.getElementById('map');
	const options = {
//		center: new kakao.maps.LatLng(33.450701, 126.570667),
		center: new kakao.maps.LatLng(lat, lng),
		level: 1
	};

	window.map = new kakao.maps.Map(container, options);

	const ps = new kakao.maps.services.Places();
	ps.keywordSearch(address, placesSearchCB);
	
	window.geocoder = new kakao.maps.services.Geocoder();
	 var marker = new kakao.maps.Marker({
	 	position: map.getCenter()
	 });
	var marker = new kakao.maps.Marker({ position: map.getCenter() }), // 클릭한 위치를 표시할 마커입니다
		infowindow = new kakao.maps.InfoWindow({ zindex: 1 }); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	 marker.setMap(map);
	 searchAddrFromCoords(map.getCenter(), displayCenterInfo);

	kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
		searchDetailAddrFromCoords(mouseEvent.latLng, function (result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
				detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';

				var content = '<div class="bAddr">' +
					'<span class="title">법정동 주소정보</span>' +
					detailAddr +
					'</div>';

				marker.setPosition(mouseEvent.latLng);
				marker.setMap(map);

				infowindow.setContent(content);
				infowindow.open(map, marker);

			}
			// 클릭한 위도, 경도 정보를 가져옵니다 
			var latlng = mouseEvent.latLng;

			// 마커 위치를 클릭한 위치로 옮깁니다
			marker.setPosition(latlng);

			var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
			message += '경도는 ' + latlng.getLng() + ' 입니다';

			var resultDiv = document.getElementById('clickLatlng');
			//resultDiv.innerHTML = message;

		});
	});

	kakao.maps.event.addListener(map, 'idle', function () {
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	});

	document.getElementById('map').addEventListener('wheel', getInfo);
}

function placesSearchCB(data, status, pagination) {
	if (status === kakao.maps.services.Status.OK) {
		var bounds = new kakao.maps.LatLngBounds();

		for (let i = 0; i < data.length; i++) {
			// displayMarker(data[i]);
			bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		}
		map.setBounds(bounds);
		map.setLevel(2); // 지도 확대  레벨
	}
}



function searchAddrFromCoords(coords, callback) {
	// 좌표로 행정동 주소 정보를 요청합니다
	geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
}

function searchDetailAddrFromCoords(coords, callback) {
	// 좌표로 법정동 상세 주소 정보를 요청합니다
	geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
function displayCenterInfo(result, status) {
	if (status === kakao.maps.services.Status.OK) {
		var infoDiv = document.getElementById('centerAddr');

		for (var i = 0; i < result.length; i++) {
			// 행정동의 region_type 값은 'H' 이므로
			if (result[i].region_type === 'H') {
				infoDiv.innerHTML = result[i].address_name;
				break;
			}
		}
	}
}

function getInfo() {
	// 지도의 현재 중심좌표를 얻어옵니다
	var center = map.getCenter();

	// 지도의 현재 레벨을 얻어옵니다
	var level = map.getLevel();

	// 지도타입을 얻어옵니다
	var mapTypeId = map.getMapTypeId();

	// 지도의 현재 영역을 얻어옵니다
	var bounds = map.getBounds();

	// 영역의 남서쪽 좌표를 얻어옵니다
	var swLatLng = bounds.getSouthWest();

	// 영역의 북동쪽 좌표를 얻어옵니다
	var neLatLng = bounds.getNorthEast();

	// 영역정보를 문자열로 얻어옵니다. ((남,서), (북,동)) 형식입니다
	var boundsStr = bounds.toString();


	var message = '지도 중심좌표는 위도 ' + center.getLat() + ', <br>';
	message += '경도 ' + center.getLng() + ' 이고 <br>';
	message += '지도 레벨은 ' + level + ' 입니다 <br> <br>';
	message += '지도 타입은 ' + mapTypeId + ' 이고 <br> ';
	message += '지도의 남서쪽 좌표는 ' + swLatLng.getLat() + ', ' + swLatLng.getLng() + ' 이고 <br>';
	message += '북동쪽 좌표는 ' + neLatLng.getLat() + ', ' + neLatLng.getLng() + ' 입니다';

	// 개발자도구를 통해 직접 message 내용을 확인해 보세요.
	// ex) console.log(message);
	console.log(message);

//	document.getElementById('mapInfo').innerHTML = message;

}