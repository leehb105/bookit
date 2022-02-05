<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${ pageContext.request.contextPath}/resources/css/member.css" />
<link rel="stylesheet" href="${ pageContext.request.contextPath}/resources/css/kakaoMap.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6572b946baab53e064d0fc558f5af389&libraries=services,clusterer,drawing"></script>

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
                        <form action="${pageContext.request.contextPath}/member/memberEnroll.do" method="post" name="registration">
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
                           <div class="form-group">
							  <label for="postcode">주소</label>
							  <div class="row">
								<input type="text" name="postcode" id="postcode" class="form-control col-6" placeholder="우편번호" readonly>
								<input type="button" onclick="execKakaoPostcode()" class="btn roberto-btn w-10 col-4" value="우편번호 찾기"><br>
							  </div>
							  <div class="row">
							    <input type="text" name="roadAddress" id="roadAddress" class="form-control col-9" placeholder="도로명주소" readonly>
						 	    <input type="text" name="extraAddress" id="extraAddress" class="form-control col-3" placeholder="건물명" readonly>
							  </div>
							  <div class="row">
							    <input type="text" name="jibunAddress" id="jibunAddress" class="form-control col-12" placeholder="지번주소" readonly required>
							    <!--
							    	depth1 = 광역시/도,
							    	depth2 = 시/군 + 구
							    	depth3 = 동/읍/면 + 리
							     -->
							    <input type="hidden" name="depth1" id="region_1depth" readonly> 
							    <input type="hidden" name="depth2" id="region_2depth" readonly>
							    <input type="hidden" name="depth3" id="region_3depth" readonly>
							    <input type="hidden" name="bunji1" id="main_address" readonly>
							    <input type="hidden" name="bunji2" id="sub_address" readonly>
							  </div>
							  <span id="guide" style="color:#999;display:none"></span>
						      <div class="row">
						  	    <input type="hidden" name="detailAddress" id="detailAddress" class="form-control col-8" placeholder="상세주소">
						 	    <input type="hidden" name="latitude" id="latitude" readonly>
						 	    <input type="hidden" name="longitude" id="longitude" readonly>
						      </div>
						      <div class="map_wrapper">
								<div id="map" style="width:600px;height:300px;margin-top:10px;display:none"></div>
									<span id="centerAddr"></span>
						      </div>

                           </div>
                           <div class="col-md-12 text-center mb-3">
                              <button type="submit" class="btn roberto-btn w-100">가입하기</button>
                           </div>
                           <div class="col-md-12 ">
                              <div class="form-group">
                                 <p class="text-center"><a href="${pageContext.request.contextPath}/member/memberLogin.do" id="login">이미 Bookit 회원이신가요?</a></p>
                              </div>
                           </div>
                        </form>
                            </div>
                     </div>
			</div>
		</div>
      </div>   

<script src="${pageContext.request.contextPath}/resources/js/kakaoMap.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/kakaoPostcode.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6572b946baab53e064d0fc558f5af389&libraries=services,clusterer,drawing"></script>
         

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
	/* $(function() {
	  
	  $("form[name='registration']").validate({
	    rules: {
	      id: "required",
	      name: "required",
	      nickname: "required",
	      email: {
	        required: true,
	        email: true
	      },
	      password: {
	        required: true
	      }
	    },
	    
	    messages: {
	      id: "아이디를 입력하세요",
	      name: "이름을 입력하세요",
	      nickname: "닉네임을 입력하세요",
	      password: {
	        required: "비밀번호를 입력하세요"
	      },
	      email: "이메일을 입력하세요"
	    },
	  
	    submitHandler: function(form) {
	      form.submit();
	    }
	  });
	});
 */
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
