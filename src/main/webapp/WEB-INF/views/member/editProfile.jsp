<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<link rel="stylesheet" href="${ pageContext.request.contextPath}/resources/css/member.css" />
<link rel="stylesheet" href="${ pageContext.request.contextPath}/resources/css/kakaoMap.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/kakaoMapEdit.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/kakaoPostcodeEdit.js"></script>

<script>
$(() => {
	$(memberUpdateFrm).submit((e) => {
    	// nickname
    	if(!/^[가-힣|a-z|A-Z]{2,}$/.test($(nickname).val())){
    		alert("닉네임은 한글 또는 영문으로 2글자 이상 입력해주세요.");
    		return false;
    	}
    	/* // password
    	if(!/^[a-zA-Z0-9]{8,16}$/.test($(password).val())){
    		alert("비밀번호는 숫자와 영문 조합으로 8~16자리만 사용 가능합니다.")
    		return false;
    	} */
    	// email
    	if(!/^[\w]{3,}@[\w]+(\.[\w]+){1,3}$/.test($(email).val())){
    		alert("올바르지 않은 이메일 형식입니다.")
    		return false;
    	}
    	// phone
    	if(!/^010[0-9]{8}$/.test($(phone).val())){
    		alert("유효한 전화번호가 아닙니다.");
    		return false;
    	}
    	return true;
    });
});
</script>

	<div class="container member-profile">
    	<form name="memberUpdateFrm" method="POST" action="${pageContext.request.contextPath}/member/memberUpdate.do">
               <!-- <div class="row">
				<div class="col-2">
				</div>
				<div class="col-9">
				<br /><br />
				마이페이지 > 정보수정
				</div>
               </div> -->
       		<div class="row">
               <div class="col-2">
                   <div class="profile-work">
                       <a href="${pageContext.request.contextPath}/member/mypageMain.do"><p>마이페이지HOME</p></a>
                       <a href="${pageContext.request.contextPath}/member/editProfile.do">정보 수정</a><br/>
                       <p>북토리 관리</p>
                       <a href="">결제 내역</a><br/>
                       <a href="">거래 내역</a><br/>
                       <a href="">북토리 충전</a>
                       <p>나의 게시글</p>
                       <a href="">게시글 작성목록</a><br/>
                       <a href="">리뷰 작성목록</a><br/>
                       <p>1:1 문의</p>
                       <a href="${pageContext.request.contextPath}/inquire/inquireForm.do">1:1 문의하기</a><br/>
                       <a href="${pageContext.request.contextPath}/inquire/inquireList.do">1:1 문의내역</a><br/>
                       <p>신고내역</p>
                       <a href="">나의 신고목록</a><br/>
                   </div>
               </div>
               <div class="col-1">
               </div>
                    <div class="col-3">
                       	<a href="${pageContext.request.contextPath}/member/memberProfile.do">마이페이지</a> > 정보수정
                        <div class="profile-img"><br /><br />
                            <img src="${pageContext.request.contextPath}/resources/img/default_profile.png" alt=""/>
                       		<div class="file btn btn-lg">
                          		사진 변경<input type="file" name="file"/>
                       		</div>
                        </div>
                    </div>
                    
	                        
	                <div class="col-6">
	                	<div class="row">
	                        <div class="col-md-4"><br /><br />
	                            <label>이름</label>
	                        </div>
	                        <div class="col-md-4"><br /><br />
	                            <p>${loginMember.name}</p>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>아이디</label>
	                        </div>
	                        <div class="col-md-4">
	                            <p>${loginMember.id}</p>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>닉네임</label>
	                        </div>
	                        <div class="col-md-4">
	                            <input type="text" name="nickname" id="nickname" value="${loginMember.nickname}" required>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>비밀번호</label>
	                        </div>
	                        <div class="col-md-4">
	                            <input type="password" name="password" id="password" value="${loginMember.password}" required>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>비밀번호 확인</label>
	                        </div>
	                        <div class="col-md-4">
	                            <input type="password" name="passwordCheck" id="passwordCheck" value="${loginMember.password}" required>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>이메일</label>
	                        </div>
	                        <div class="col-md-4">
	                            <input type="email" name="email" id="email" value="${loginMember.email}" required>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>연락처</label>
	                        </div>
	                        <div class="col-md-4">
	                            <input type="tel" name="phone" id="phone" maxlength="11" value="${loginMember.phone}">
	                        </div>
	                    </div>
	                    <!-- 시작  -->
							<div>
								지번: <input type='text' id='jibunAddr' name='jibunAddress' size=50 value='${loginMember.jibunAddress}' readonly/>
							</div>
							<div>
								도로명: <input type='text' id='detailRoadAddr' name='detailRoadAddress' size=50 value='${loginMember.roadAddress}' readonly />
							</div>
							<div>
								<input type='text' id='searchAddr' name='searchAddr' />
								<input type='button' onclick="generateMap(false, 'addr')" value="검색">
									</div>
							<div>
							<div id="map_wrapper">
								<div id="map"></div>
							</div>

							<!-- 아래 폼은 hidden 처리 예정 -->
							<div>
								도로명: <input type='text' id='roadAddr' name='roadAddress' size=50 readonly/>
							</div>
							<div>
								건물명: <input type='text' id='extraAddr' name='extraAddress' size=50 readonly/>
							</div>
							<div>
								시/도: <input type='text' id='region_1depth_name' name='depth1' readonly/>
							</div>
							<div>
								시/군/구: <input type='text' id='region_2depth_name' name='depth2' readonly/>
							</div>
							<div>
								동/읍/면: <input type='text' id='region_3depth_name' name='depth3' readonly/>
							</div>
							<div>
								번지1:<input type='text' id='main_address_no' name='bunji1' readonly/>
							</div>
							<div>
								번지2:<input type='text' id='sub_address_no' name='bunji2' readonly/>
							</div>
					
							<div>
								위도:<input type='text' id='latitude' name='latitude' readonly/>
							</div>
							<div>
								경도:<input type='text' id='longitude' name='longitude' readonly/>
							</div>
							<div>
								<input type='text' name='detailAddress'/>
							</div>
					
						</div>
	                    <!-- 끝  -->
                            <input type="submit" class="btn roberto-btn w-10 mt-30" value="수정">
                    </div>
                            
                </div>
            </form>           
        </div>

<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6572b946baab53e064d0fc558f5af389&libraries=services,clusterer,drawing"></script>
<script src="${pageContext.request.contextPath}/resources/js/kakaoMap_v2.js"></script>
	

<script>
	generateMap(true, "coord", '${loginMember.latitude}', '${loginMember.longitude}');
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
