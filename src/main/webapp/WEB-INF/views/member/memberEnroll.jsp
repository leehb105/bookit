<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 xss대비 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<link rel="stylesheet" href="${ pageContext.request.contextPath}/resources/css/member.css" />
<link rel="stylesheet" href="${ pageContext.request.contextPath}/resources/css/kakaoMap.css" />
<style>
	#map {
		width: 500px;
	}
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script src="https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrit6="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

<br /><br />



    <div class="container">
        <div class="row">
			<div class="col-md-5 mx-auto">
			
			<div id="second">
			      <div class="myform form">
                        <div class="logo mb-3">
                           <div class="col-md-12 text-center">
                              <h1 >회원가입</h1>
                           </div>
                        </div>                        
                        <form:form
                        	action="${pageContext.request.contextPath}/member/memberEnroll.do" 
                        	method="post" 
                        	name="registration">
                           <div class="form-group">
                              <label for="exampleInputEmail1">아이디</label>
                              <input type="text"  name="id" class="form-control" id="id" aria-describedby="emailHelp" placeholder="아이디를 입력하세요">
                              <span id="idHelp"></span>
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">비밀번호</label>
                              <input type="password" name="password" id="password" class="form-control" aria-describedby="idHelp" placeholder="비밀번호를 입력하세요">
                              <span id="passwordHelp"></span>
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">비밀번호 확인</label>
                              <input type="password" id="passwordCheck" class="form-control" aria-describedby="passwordHelp" placeholder="비밀번호를 한번 더 입력하세요">
                              <span id="passwordCheckHelp"></span>
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">이름</label>
                              <input type="text"  name="name" class="form-control" id="name" aria-describedby="emailHelp" placeholder="이름을 입력하세요">
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">닉네임</label>
                              <input type="text"  name="nickname" class="form-control" id="nickname" aria-describedby="emailHelp" placeholder="닉네임을 입력하세요">
                              <span id="nicknameHelp"></span>
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">이메일</label>
                              <input type="email" name="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="이메일을 입력하세요">
							  <span id="emailHelp"></span>                         
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">휴대폰</label>
                              <input type="tel" name="phone" id="phone" class="form-control" aria-describedby="emailHelp" placeholder="숫자만 입력하세요">
                           	  <span id="phoneHelp"></span>
                           </div>
                           
                           <!-- 시작  -->
	                   	<div> 

	                   		<div class="form-group">
	                   			<label for="jibunAddr">지번</label>
								<input type='text' id='jibunAddr' name='jibunAddress' class='form-control' size=35 readonly/>
							</div>
							<div class="form-group">
								<label for="detailRoadAddr">도로명</label>
								<input type='text' id='detailRoadAddr' name='detailRoadAddress' class='form-control' size=35 readonly />
							</div>
							<div class="form-group">
								<label for="searchAddr">주소 검색</label>
								<input type='text' id='searchAddr' name='searchAddr' class='form-control' />
								<input type='button' onclick="generateMap(false, 'addr')" class='form-control btn btn-success' value="검색">
							</div>

							<div id="map_wrapper">
								<div id="map"></div>
							</div>

								<!-- 아래 폼은 hidden 처리 예정 -->
							<div class='hidden'>
								<div>
									<input type='hidden' id='roadAddr' name='roadAddress' size=35 readonly/>
								</div>
								<div>
									<input type='hidden' id='extraAddr' name='extraAddress' size=35 readonly/>
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
									<input type='hidden' id='latitude' name='latitude' readonly required/>
								</div>
								<div>
									<input type='hidden' id='longitude' name='longitude' readonly required/>
								</div>
								<div>
									<input type='hidden' name='detailAddress'/>
								</div>
					
							</div>
						</div>
	                    <!-- 끝  -->
                           
                           <div class="col-md-12 text-center mb-3">
                              <button type="submit" class="btn roberto-btn w-100">가입하기</button>
                           </div>
                           <div class="col-md-12 ">
                              <div class="form-group">
                                 <p class="text-center"><a href="${pageContext.request.contextPath}/member/memberLogin.do" id="login">이미 Bookit 회원이신가요?</a></p>
                              </div>
                           </div>
                        </form:form>
                            </div>
                     </div>
			</div>
		</div>
      </div>   

<script src="${pageContext.request.contextPath}/resources/js/kakaoMap.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/kakaoPostcode.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
         

<br /><br /><br /><br /><br /><br />
<script>
$("#id").focusout(function() {
	var id = $("#id").val();
	var advice = $("#idHelp");
	var idRegExp = /^[a-z0-9]{4,12}$/;
	var checkEng = /[a-z]/;
	var checkNum = /[0-9]/;

	if(id == "") {
		idHelp.innerText = "필수 입력사항입니다";
		advice.css({"color": "red","font-size": "12px"});
		return false;
	}
	else if(!checkEng.test(id)) {
		idHelp.innerText = "영문자를 포함해주세요.";
		advice.css({"color": "red", "font-size": "12px"});
		return false;
	}
	else if(!checkNum.test(id)) {
		idHelp.innerText = "숫자를 포함해주세요.";
		advice.css({"color": "red", "font-size": "12px"});
		return false;
	}
	else if(!idRegExp.test(id)) {
		idHelp.innerText = "영문 숫자 포함 4~12자리로 입력하세요.";
		advice.css({"color": "red", "font-size": "12px"});
		return false;
	}
	else if(idRegExp.test(id)) {
		$.ajax({
			url: `${pageContext.request.contextPath}/member/checkDuplicateId.do`,
			type: "POST",
			data: {
				id : id
			},
			dataType: "json",
			success: function(data){
				if(data == 0) {
					idHelp.innerText = "사용가능한 아이디입니다.";
					advice.css({"color": "blue", "font-size": "12px"});
					return true;
				} 
				else {
					idHelp.innerText = "사용중인 아이디입니다.";
					advice.css({"color": "red", "font-size": "12px"});
					return false;
				}
			},
			error: console.log
		});
	}
});
$("#password").focusout(function() {
	var password = $("#password").val();
	var advice = $("#passwordHelp");
	var passwordRegExp = /^[a-z0-9]{8,16}$/;
	var checkEng = /[a-z]/;
	var checkNum = /[0-9]/;
	
	if (password == "") {
		passwordHelp.innerText = "비밀번호를 입력해 주세요.";
		advice.css({"color": "red", "font-size": "12px"});
		return false;
	}
	else if(!checkEng.test(password)) {
		passwordHelp.innerText = "영문자를 포함해주세요.";
		advice.css({"color": "red", "font-size": "12px"});
		return false;
	}
	else if(!checkNum.test(password)) {
		passwordHelp.innerText = "숫자를 포함해주세요.";
		advice.css({"color": "red", "font-size": "12px"});
		return false;
	}
	else if(!passwordRegExp.test(password)) {
		passwordHelp.innerText = "영문 숫자 포함 8~16자리로 입력하세요.";
		advice.css({"color": "red", "font-size": "12px"});
		return false;
	}
	else if(passwordRegExp.test(password)) {
		passwordHelp.innerText = "사용 가능합니다.";
		advice.css({"color": "blue", "font-size": "12px"});
		return true;
	}
});
$("#passwordCheck").focusout(function() {
	var password = $("#password").val();
	var passwordCheck = $("#passwordCheck").val();
	var advice = $("#passwordCheckHelp");
	
	if (password == "") {
		passwordCheckHelp.innerText = "비밀번호를 입력해 주세요.";
		advice.css({"color": "red", "font-size": "12px"});
		return false;
	}
	else if (password != passwordCheck) {
		passwordCheckHelp.innerText = "비밀번호가 일치하지 않습니다.";
		advice.css({"color": "red", "font-size": "12px"});
		return false;
	}
	else if (password == passwordCheck) {
		passwordCheckHelp.innerText = "비밀번호가 일치합니다.";
		advice.css({"color": "blue", "font-size": "12px"});
		return true;
	}
});
$("#nickname").focusout(function() {
	var nickname = $("#nickname").val();
	var advice = $("#nicknameHelp");
	var nicknameRegExp = /^[가-힣|a-z|A-Z]{2,}$/;

	if(nickname == "") {
		nicknameHelp.innerText = "필수 입력사항입니다";
		advice.css({"color": "red","font-size": "12px"});
		return false;
	}
	else if(!nicknameRegExp.test(nickname)) {
		nicknameHelp.innerText = "한글 또는 영문으로 2글자 이상 입력해주세요.";
		advice.css({"color": "red", "font-size": "12px"});
		return false;
	}
	else if(nicknameRegExp.test(nickname)) {
		$.ajax({
			url: `${pageContext.request.contextPath}/member/checkDuplicateNickname.do`,
			type: "POST",
			data: {
				nickname : nickname
			},
			dataType: "json",
			success: function(data){
				if(data == 0) {
					nicknameHelp.innerText = "사용가능한 닉네임입니다.";
					advice.css({"color": "blue", "font-size": "12px"});
					return true;
				} 
				else {
					nicknameHelp.innerText = "사용중인 닉네임입니다.";
					advice.css({"color": "red", "font-size": "12px"});
					return false;
				}
			},
			error: console.log
		});
	}
});
$("#email").focusout(function() {
	var email = $("#email").val();
	var advice = $("#emailHelp");
	var emailRegExp = /^[\w]{2,}@[\w]+(\.[\w]+){1,3}$/;
	
	if (!emailRegExp.test(email)) {
		emailHelp.innerText = "올바르지 않은 이메일 형식입니다.";
		advice.css({"color": "red", "font-size": "12px"});
		return false;
	}
	else if(emailRegExp.test(email)) {
		emailHelp.innerText = "사용 가능합니다.";
		advice.css({"color": "blue", "font-size": "12px"});
		return true;
	}
});
$("#phone").focusout(function() {
	var phone = $("#phone").val();
	var advice = $("#phoneHelp");
	var phoneRegExp = /^010[0-9]{8}$/;
	
	if (!phoneRegExp.test(phone)) {
		phoneHelp.innerText = "올바르지 않은 전화번호입니다.";
		advice.css({"color": "red", "font-size": "12px"});
		return false;
	}
	else if(phoneRegExp.test(phone)) {
		phoneHelp.innerText = "사용 가능합니다.";
		advice.css({"color": "blue", "font-size": "12px"});
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
