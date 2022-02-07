var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
		center: new kakao.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
		level: 5 // 지도의 확대 레벨
	};

//지도를 미리 생성
var map = new kakao.maps.Map(mapContainer, mapOption);

const ps = new kakao.maps.services.Places();
ps.keywordSearch('카카오', placesSearchCB);

function placesSearchCB(data, status, pagination) {
	if (status === kakao.maps.services.Status.OK) {
		var bounds = new kakao.maps.LatLngBounds();
		
		for(let i = 0; i < data.length; i++) {
			bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		}
		map.setBounds(bounds);
		map.setLevel(2);
//		marker.setPosition(new kakao.maps.LatLng(data[0].y, data[0].x));
//		marker.setMap(map);
	}	
}

//주소-좌표 변환 객체를 생성
var geocoder = new kakao.maps.services.Geocoder();
//마커를 미리 생성
var marker = new kakao.maps.Marker({
	position: map.getCenter(),
	map: map
});
var infowindow = new kakao.maps.InfoWindow({ zindex: 1 });

kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
	searchDetailAddrFromCoords(mouseEvent.latLng, function (result, status) {
		if (status === kakao.maps.services.Status.OK) {
			var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
			detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';

			var content = '<div class="bAddr">' +
				'<span class="title">내 주소</span>' +
				detailAddr +
				'</div>';
			
			const jibun_address = result[0].address;
			const road_address = result[0].road_address;
			if(road_address) {
				document.querySelector('#postcode').value = !!road_address.zone_no ? road_address.zone_no : ''; // 
				document.querySelector('#roadAddress').value = road_address.address_name;
				document.querySelector('#extraAddress').value = road_address.building_name;
			} else {
				document.querySelector('#postcode').value = '';
				document.querySelector('#roadAddress').value = '';
				document.querySelector('#extraAddress').value = '';
			}
			document.querySelector('#jibunAddress').value = jibun_address.address_name;
//			document.querySelector('#jibunAddress').value = jibun_address.region_1depth_name + ' ' + jibun_address.region_2depth_name + ' ' + jibun_address.region_3depth_name + ' ' + jibun_address.main_address_no + (!!jibun_address.sub_address_no ? '-' + jibun_address.sub_address_no : '');
			document.querySelector('#region_1depth').value = jibun_address.region_1depth_name;
			document.querySelector('#region_2depth').value = jibun_address.region_2depth_name;
			document.querySelector('#region_3depth').value = jibun_address.region_3depth_name;
			document.querySelector('#main_address').value = jibun_address.main_address_no;
			document.querySelector('#sub_address').value = jibun_address.sub_address_no;

			//console.log(map.getCenter()); // 이거는 마커의 위치좌표가 아니라 지도 상의 중심좌표다.
				
			marker.setPosition(mouseEvent.latLng);
			marker.setMap(map);		

			infowindow.setContent(content);
			infowindow.open(map, marker);

		}
		// 클릭한 위도, 경도 정보를 가져옵니다 
		var latlng = mouseEvent.latLng;

		// 마커 위치를 클릭한 위치로 옮깁니다
		marker.setPosition(latlng);

		document.querySelector('#latitude').value = latlng.getLat(); // 위도 약 33~37
		document.querySelector('#longitude').value = latlng.getLng(); // 경도 약 126~129
		
	});
});

kakao.maps.event.addListener(map, 'idle', function () {
//	searchAddrFromCoords(map.getCenter(), displayCenterInfo);
});

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

}

document.getElementById('map').addEventListener('wheel', getInfo);