function execKakaoPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			
			var roadAddr = data.roadAddress;
			var extraRoadAddr = ''; // 참고 항목 변수

			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				extraRoadAddr += data.bname;
			}
			// 건물명이 있고, 공동주택일 경우 추가한다.
//			if(data.buildingName !== '' && data.apartment === 'Y'){
			if(data.buildingName !== ''){
			   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('postcode').value = data.zonecode;
			document.getElementById("roadAddress").value = data.roadAddress;
			document.getElementById("jibunAddress").value = data.jibunAddress;
			

			// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
			if(roadAddr !== ''){
				document.getElementById("extraAddress").value = extraRoadAddr;
			} else {
				document.getElementById("extraAddress").value = '';
			}

			// 주소로 상세 정보를 검색
			geocoder.addressSearch(data.address, function(results, status) {
				// 정상적으로 검색이 완료됐으면
				if (status === kakao.maps.services.Status.OK) {

					var result = results[0]; //첫번째 결과의 값을 활용
					console.log(result);

					// 해당 주소에 대한 좌표를 받아서
					var coords = new kakao.maps.LatLng(result.y, result.x);
					// 지도를 보여준다.
					mapContainer.style.display = "block";
					map.relayout();
					// 지도 중심을 변경한다.
					map.setCenter(coords);
					// 마커를 결과값으로 받은 위치로 옮긴다.
					marker.setPosition(coords)
				}
			});
		}
	}).open();
}