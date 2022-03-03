<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 xss대비 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 인증객체의 principal속성을 pageContext 속성으로 저장 -->
<sec:authentication property="principal" var="loginMember"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<link rel="stylesheet" href="${ pageContext.request.contextPath}/resources/css/member.css" />
<link rel="stylesheet" href="${ pageContext.request.contextPath}/resources/css/kakaoMap.css" />


<jsp:include page="/WEB-INF/views/member/common/sidebar.jsp"/>    
               <div class="col-1"></div>
	               <div class="col-3">
                        <form name="memberUpdateFrm" method="POST" action="${pageContext.request.contextPath}/member/memberUpdate.do?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
	                       	<a href="${pageContext.request.contextPath}/member/mypageMain.do">마이페이지</a> > 정보수정
	                        <div class="profile-img"><br /><br />
	                            <img class="mb-3" src="${pageContext.request.contextPath}/resources/img/profile/${loginMember.profileImage}" onerror="this.src='${pageContext.request.contextPath}/resources/img/profile/default_profile.png'" alt=""/>
	                       		<div class="file btn btn-lg">
	                          		사진 변경<input type="file" id="profileImg" name="profileImg"/>
	                       		</div> 
	                        </div>
	                        <script type="text/javascript">
	                         $("#profileImg").change(function(){
	                        	  if(this.files && this.files[0]) {
	                        	   var reader = new FileReader;
	                        	   reader.onload = function(data) {
	                        	    $(".profile-img img").attr("src", data.target.result);        
	                        	   }
	                        	   reader.readAsDataURL(this.files[0]);
	                        	  }
	                        	 });
	                        </script>
	                    </div>
		                <div class="col-6">
		                	<c:if test="${!empty loginMember}">
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
			                            <label>현재 비밀번호</label>
			                        </div>
			                        <div class="col-md-4">
			                            <input type="password" name="password" id="password" value="" required>
			                        </div>
			                    </div>
			                    <div class="row">
			                        <div class="col-md-4">
			                            <label>새 비밀번호</label>
			                        </div>
			                        <div class="col-md-4">
			                            <input type="password" name="newPassword" id="newPassword" value="">
			                        </div>
			                    </div>
			                    <div class="row">
			                        <div class="col-md-4">
			                            <label>비밀번호 확인</label>
			                        </div>
			                        <div class="col-md-4">
			                            <input type="password" name="newPasswordCheck" id="newPasswordCheck" value="">
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

									<div class="row">
									  <div class="col-md-4">
										<label>지번</label>
									  </div>
									  <div class="col-md-4">
										<input type='text' id='jibunAddr' name='jibunAddress' size=35 value='${loginMember.jibunAddress}' readonly/>
									  </div>
									</div>

									<div class="row">
									  <div class="col-md-4">
										<label>도로명</label>
									  </div>
									  <div class="col-md-4">
										<input type='text' id='detailRoadAddr' name='detailRoadAddress' size=35 value='${loginMember.roadAddress}' readonly />
									  </div>
									</div>

									<div class="row">
										<div class="col-md-4">
											<label>주소 검색</label>
										</div>
										<div class="col-md-4">
											<input type='text' id='searchAddr' name='searchAddr' />
										</div>
										<div class="col-md-2">
											<input type='button' onclick="generateMap(false, 'addr')" value="검색">
										</div>
									</div>
		
									<div id="map_wrapper">
										<div id="map"></div>
									</div>
		
									<!-- 아래 폼은 hidden 처리 예정 -->
									<div class='hidden'>
										<div>
											<input type='hidden' id='roadAddr' name='roadAddress' size=50 readonly/>
										</div>
										<div>
											<input type='hidden' id='extraAddr' name='extraAddress' size=50 readonly/>
										</div>
										<div>
											<input type='hidden' id='region_1depth_name' name='depth1' readonly/>
										</div>
										<div>
											<input type='hidden' id='region_2depth_name' name='depth2' readonly/>
										</div>
										<div>
											<input type='hidden' id='region_3depth_name' name='depth3' readonly/>
										</div>
										<div>
											<input type='hidden' id='main_address_no' name='bunji1' readonly/>
										</div>
										<div>
											<input type='hidden' id='sub_address_no' name='bunji2' readonly/>
										</div>
								
										<div>
											<input type='hidden' id='latitude' name='latitude' readonly/>
										</div>
										<div>
											<input type='hidden' id='longitude' name='longitude' readonly/>
										</div>
										<div>
											<input type='hidden' name='detailAddress'/>
										</div>
							
									</div>
								</div>
			                    <!-- 끝  -->
	                            <input type="submit" class="btn roberto-btn w-10 mt-30" value="수정">
							</c:if>
							<c:if test="${!empty sessionScope.kakaoE}">
							<p>SNS 계정으로 로그인한 회원입니다.</p>
							</c:if>
							
						</form>
	               </div> 
               </div>          
        </div>
        
<script>
// 현재 비밀번호 일치 여부는 컨트롤러에서 비교.
$(memberUpdateFrm).submit((e) => {
	// nickname
	if(!/^[가-힣|a-z|A-Z]{2,}$/.test($(nickname).val())){
		alert("닉네임은 한글 또는 영문으로 2글자 이상 입력해주세요.");
		return false;
	}
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
// 새로운 비밀번호 유효성 검사. 정보 수정할때마다 필수 요소 아님.
$("#newPassword").focusout(function() {
	if(!/^[a-zA-Z0-9]{8,16}$/.test($(newPassword).val())){
		alert("비밀번호는 숫자와 영문 조합으로 8~16자리만 사용 가능합니다.")
		return false;
	}
	else{
		alert("사용가능한 비밀번호입니다.")
	}
});
// 비밀번호 일치 여부 확인
$("#newPasswordCheck").focusout(function() {
	var newPassword = $("#newPassword").val();
	var newPasswordCheck = $("#newPasswordCheck").val();
	
	if (newPassword == "") {
		alert("새로운 비밀번호를 입력해주세요.")
		return false;
	}
	else if (newPassword != newPasswordCheck) {
		alert("비밀번호가 일치하지 않습니다.")
		return false;
	}
	else if (newPassword == newPasswordCheck) {
		alert("비밀번호가 일치합니다.")
		return true;
	}
});
</script>

<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6572b946baab53e064d0fc558f5af389&libraries=services,clusterer,drawing"></script>
<script src="${pageContext.request.contextPath}/resources/js/kakaoMap_v2.js"></script>
	

<script>
	generateMap(true, "coord", '${loginMember.latitude}', '${loginMember.longitude}');
	$(document).ready(function() {
		  $(window).keydown(function(event){
		    if(event.keyCode == 13) {
		      event.preventDefault();
		      return false;
		    }
		  });
		});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>