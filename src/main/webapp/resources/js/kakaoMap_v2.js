function regenerateMap() {
	var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
	mapContainer.parentNode.removeChild(mapContainer);

	const mapBody = document.createElement('div');
	mapBody.id = "map";
	map_wrapper.appendChild(mapBody);

}
function generateMap(isInitial, searchType, lat, lng) {
	// 초기주소
	var address = '서울';

	var message = '내 위치를 선택해주세요';
	var textColor = 'color:red;'
	var popupWidth = 200;
	if (!isInitial) {
		popupWidth = 200;
		address = document.querySelector('#searchAddr').value;
		regenerateMap();
	}

	var mapContainer = document.getElementById('map'); // 지도를 표시할 div 

	var mapOption = {
		center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		level: 2 // 지도의 확대 레벨
	};

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	var marker = new kakao.maps.Marker();
	var infowindow = new kakao.maps.InfoWindow({ zindex: 1 });

	kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
		searchDetailAddrFromCoords(mouseEvent.latLng, function (result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + (result[0].road_address.building_name ? ' (' + result[0].road_address.building_name + ')' : '') + '</div>' : '';
				detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';

				var content = '<div class="bAddr">' +
					'<span class="title">법정동 주소정보</span>' +
					detailAddr +
					'</div>';

				marker.setPosition(mouseEvent.latLng);
				marker.setMap(map);

				infowindow.setContent(content);
				infowindow.open(map, marker);
				// 검색한 위치의 정보
				console.log(result[0]);
				// 클릭한 위치의 x, y 좌표
				console.log(mouseEvent.latLng);

				var jibunInfo = result[0].address;
				document.querySelector('#jibunAddr').value = jibunInfo.address_name;
				document.querySelector('#region_1depth_name').value = jibunInfo.region_1depth_name;
				document.querySelector('#region_2depth_name').value = jibunInfo.region_2depth_name;
				document.querySelector('#region_3depth_name').value = jibunInfo.region_3depth_name + (jibunInfo.mountain_yn === 'N' ? '' : ' 산');
				document.querySelector('#main_address_no').value = jibunInfo.main_address_no;
				document.querySelector('#sub_address_no').value = jibunInfo.sub_address_no;

				var roadInfo = result[0].road_address;
				if (roadInfo) {
					var roadAddr = roadInfo.address_name;
					var extraAddr = roadInfo.building_name;
					document.querySelector('#detailRoadAddr').value = roadAddr + (extraAddr ? ' (' + extraAddr + ')' : '');
					document.querySelector('#roadAddr').value = roadAddr;
					document.querySelector('#extraAddr').value = extraAddr;
				} else {
					document.querySelector('#detailRoadAddr').value = '';
					document.querySelector('#roadAddr').value = '';
					document.querySelector('#extraAddr').value = '';
				}


				document.querySelector('#latitude').value = mouseEvent.latLng.Ma;
				document.querySelector('#longitude').value = mouseEvent.latLng.La;


			}
		});

	});


	function searchAddressFromCoords(coords, callback) {

		searchDetailAddrFromCoords(coords, function (result, status) {
			if (status === kakao.maps.services.Status.OK) {
				console.log("+++++++++")
				console.log(result[0]);
				console.log("+++++++++")

				marker = new kakao.maps.Marker({
					map: map,
					position: coords
				});
				// 인포윈도우로 장소에 대한 설명을 표시합니다
				// infowindow는 위에서 쓴 infowindow를 재활용해서 기존 마커를 없애준다.
				infowindow = new kakao.maps.InfoWindow({
					content: '<div style="width:' + popupWidth + 'px;text-align:center;padding:6px 0;' + textColor + '">' + message + '</div>'
				});
				infowindow.open(map, marker);

				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);

			}
		});
	}

	if(!lat && !lng) searchType='addr';
	var coords = new kakao.maps.LatLng(lat, lng);
	if (searchType === 'addr') {
		searchAddrFromAddress(address);
		$('.hidden input').each((i, e) => {e.value = ''});
	} else if (searchType === 'coord') {
		searchDetailAddrFromCoords(coords, function (result, status) {
		if (status === kakao.maps.services.Status.OK) {
			var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + (result[0].road_address.building_name ? ' (' + result[0].road_address.building_name + ')' : '') + '</div>' : '';
			detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';

			var content = '<div class="bAddr">' +
				'<span class="title">법정동 주소정보</span>' +
				detailAddr +
				'</div>';

			marker.setPosition(coords);
			marker.setMap(map);

			infowindow.setContent(content);
			infowindow.open(map, marker);
			// 검색한 위치의 정보
			console.log(result[0]);

			var jibunInfo = result[0].address;
			document.querySelector('#jibunAddr').value = jibunInfo.address_name;
			document.querySelector('#region_1depth_name').value = jibunInfo.region_1depth_name;
			document.querySelector('#region_2depth_name').value = jibunInfo.region_2depth_name;
			document.querySelector('#region_3depth_name').value = jibunInfo.region_3depth_name + (jibunInfo.mountain_yn === 'N' ? '' : ' 산');
			document.querySelector('#main_address_no').value = jibunInfo.main_address_no;
			document.querySelector('#sub_address_no').value = jibunInfo.sub_address_no;

			var roadInfo = result[0].road_address;
			if (roadInfo) {
				var roadAddr = roadInfo.address_name;
				var extraAddr = roadInfo.building_name;
				document.querySelector('#detailRoadAddr').value = roadAddr + (extraAddr ? ' (' + extraAddr + ')' : '');
				document.querySelector('#roadAddr').value = roadAddr;
				document.querySelector('#extraAddr').value = extraAddr;
			} else {
				document.querySelector('#detailRoadAddr').value = '';
				document.querySelector('#roadAddr').value = '';
				document.querySelector('#extraAddr').value = '';
			}


			document.querySelector('#latitude').value = coords.getLat();
			document.querySelector('#longitude').value = coords.getLng(); 
			
			map.setCenter(coords);

		}
	}); 
	}



	function searchAddrFromAddress(address, callback) {

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(address, function (result, status) {

			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {

				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

				// 결과값으로 받은 위치를 마커로 표시합니다
				// marker는 위에서 쓴 marker 재활용해서 기존 마커를 없애준다.
				marker = new kakao.maps.Marker({
					map: map,
					position: coords
				});

				// 인포윈도우로 장소에 대한 설명을 표시합니다
				// infowindow는 위에서 쓴 infowindow를 재활용해서 기존 마커를 없애준다.
				infowindow = new kakao.maps.InfoWindow({
					content: '<div style="width:' + popupWidth + 'px;text-align:center;padding:6px 0;' + textColor + '">' + message + '</div>'
				});
				//					infowindow.open(map, marker);

				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);

				infowindow.open(map, marker);
			}
		});
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
}